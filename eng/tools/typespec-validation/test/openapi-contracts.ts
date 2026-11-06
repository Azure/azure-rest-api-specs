import { readFileSync } from "node:fs";
import { dirname, resolve } from "node:path";

export type Lifecycle = "read" | "create" | "update";

export interface Schema {
  $ref?: string;
  type?: string;
  properties?: Record<string, Schema>;
  allOf?: Schema[];
  items?: Schema;
  required?: string[];
  readOnly?: boolean;
  "x-ms-mutability"?: Lifecycle[];
}

export interface Operation {
  operationId: string;
  parameters?: (Schema & { in?: string; name?: string; schema?: Schema })[];
  responses: Record<string, { schema?: Schema; headers?: Record<string, Schema> }>;
  "x-ms-long-running-operation"?: boolean;
  "x-ms-long-running-operation-options"?: { "final-state-via"?: string };
  "x-ms-examples"?: Record<string, { $ref: string }>;
}

export interface Swagger {
  info: { version: string };
  definitions: Record<string, Schema>;
  paths: Record<string, Partial<Record<"get" | "put" | "patch" | "post" | "delete", Operation>>>;
}

export function readSwagger(file: string): Swagger {
  return JSON.parse(readFileSync(file, "utf8")) as Swagger;
}

interface LocatedSchema {
  schema: Schema;
  file: string;
}

export function resolveSchema(schema: Schema, file: string): LocatedSchema {
  if (!schema.$ref) return { schema, file };
  const [relative, pointer] = schema.$ref.split("#");
  const targetFile = relative ? resolve(dirname(file), relative) : file;
  let target: unknown = readSwagger(targetFile);
  for (const segment of pointer.slice(1).split("/")) {
    if (typeof target !== "object" || target === null || !(segment in target)) {
      throw new Error(`Unresolved schema reference: ${schema.$ref} in ${file}`);
    }
    target = (target as Record<string, unknown>)[segment];
  }
  const resolved = resolveSchema(target as Schema, targetFile);
  const { $ref: _ref, ...overrides } = schema;
  return { schema: { ...resolved.schema, ...overrides }, file: resolved.file };
}

export function schemaProperties(schema: Schema, file: string): Record<string, LocatedSchema> {
  const located = resolveSchema(schema, file);
  const inherited = Object.assign(
    {},
    ...(located.schema.allOf ?? []).map((base) => schemaProperties(base, located.file)),
  ) as Record<string, LocatedSchema>;
  for (const [name, property] of Object.entries(located.schema.properties ?? {})) {
    inherited[name] = { schema: property, file: located.file };
  }
  return inherited;
}

export function requestBody(operation: Operation): Schema {
  const body = operation.parameters?.find((parameter) => parameter.in === "body")?.schema;
  if (!body) throw new Error(`${operation.operationId} has no request body schema`);
  return body;
}

export function writablePaths(
  schema: Schema,
  file: string,
  lifecycle: "create" | "update",
  prefix = "",
  ancestors = new Set<string>(),
): string[] {
  const key = `${file}:${schema.$ref ?? prefix}`;
  if (ancestors.has(key)) return [];
  const next = new Set([...ancestors, key]);
  const located = resolveSchema(schema, file);
  if (
    located.schema.readOnly ||
    (located.schema["x-ms-mutability"] && !located.schema["x-ms-mutability"].includes(lifecycle))
  ) {
    return [];
  }
  return Object.entries(schemaProperties(located.schema, located.file)).flatMap(([name, child]) => {
    const childPath = prefix ? `${prefix}.${name}` : name;
    const value = resolveSchema(child.schema, child.file).schema;
    if (
      value.readOnly ||
      (value["x-ms-mutability"] && !value["x-ms-mutability"].includes(lifecycle))
    )
      return [];
    return [childPath, ...writablePaths(child.schema, child.file, lifecycle, childPath, next)];
  });
}

export function mutabilityConflicts(
  schema: Schema,
  file: string,
  prefix = "",
  allowed: Lifecycle[] = ["read", "create", "update"],
  ancestors = new Set<string>(),
): string[] {
  const key = `${file}:${schema.$ref ?? prefix}`;
  if (ancestors.has(key)) return [];
  const next = new Set([...ancestors, key]);
  const located = resolveSchema(schema, file);
  const declared = located.schema.readOnly ? ["read"] : located.schema["x-ms-mutability"];
  const conflicts = (declared ?? [])
    .filter((value) => !allowed.includes(value as Lifecycle))
    .map((value) => `${prefix}: ${value} blocked by ancestor`);
  const effective = allowed.filter((value) => !declared || declared.includes(value));
  for (const [name, child] of Object.entries(schemaProperties(located.schema, located.file))) {
    conflicts.push(
      ...mutabilityConflicts(
        child.schema,
        child.file,
        prefix ? `${prefix}.${name}` : name,
        effective,
        next,
      ),
    );
  }
  return conflicts;
}
