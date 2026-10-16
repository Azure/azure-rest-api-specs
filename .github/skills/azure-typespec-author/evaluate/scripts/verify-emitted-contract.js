import assert from "node:assert/strict";
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const httpMethods = new Set(["delete", "get", "head", "options", "patch", "post", "put", "trace"]);

function walkJson(directory) {
  if (!fs.existsSync(directory)) {
    return [];
  }
  const files = [];
  for (const entry of fs.readdirSync(directory, { withFileTypes: true })) {
    const entryPath = path.join(directory, entry.name);
    if (entry.isDirectory()) {
      files.push(...walkJson(entryPath));
    } else if (entry.name.endsWith(".json")) {
      files.push(entryPath);
    }
  }
  return files;
}

export function loadOpenApiDocuments(root = process.cwd()) {
  const files = ["stable", "preview"].flatMap((directory) => walkJson(path.join(root, directory)));
  return files.map((file) => ({
    document: JSON.parse(fs.readFileSync(file, "utf8")),
    file,
  }));
}

function operations(document) {
  const result = [];
  for (const [route, pathItem] of Object.entries(document.paths ?? {})) {
    for (const [method, operation] of Object.entries(pathItem ?? {})) {
      if (httpMethods.has(method.toLowerCase())) {
        result.push({ method: method.toLowerCase(), operation, route });
      }
    }
  }
  return result;
}

function localRefName(ref) {
  const match = ref?.match(/^#\/(?:definitions|components\/schemas)\/(.+)$/);
  return match?.[1];
}

function schemas(document) {
  return document.definitions ?? document.components?.schemas ?? {};
}

function resolveLocalSchema(document, schema) {
  const name = localRefName(schema?.$ref);
  return name ? schemas(document)[name] : schema;
}

function schemaProperties(document, schema, seen = new Set()) {
  const resolved = resolveLocalSchema(document, schema);
  if (!resolved || seen.has(resolved)) {
    return {};
  }
  seen.add(resolved);
  return Object.assign(
    {},
    ...(resolved.allOf ?? []).map((part) => schemaProperties(document, part, seen)),
    resolved.properties ?? {},
  );
}

function latestDocument(documents) {
  assert.ok(documents.length, "expected emitted OpenAPI documents");
  return [...documents]
    .sort((left, right) =>
      String(left.document.info?.version ?? "").localeCompare(
        String(right.document.info?.version ?? ""),
      ),
    )
    .at(-1);
}

function operationParameters(document, route, operation) {
  const pathParameters = document.paths?.[route]?.parameters ?? [];
  const all = [...pathParameters, ...(operation.parameters ?? [])];
  const parameterDefinitions = document.parameters ?? document.components?.parameters ?? {};
  return all.map((parameter) => {
    const name = parameter?.$ref?.match(/^#\/(?:parameters|components\/parameters)\/(.+)$/)?.[1];
    return name ? parameterDefinitions[name] : parameter;
  });
}

function parameterType(parameter) {
  return parameter?.type ?? parameter?.schema?.type;
}

function parameterFormat(parameter) {
  return parameter?.format ?? parameter?.schema?.format;
}

export function verifyArmListTopSkip(documents) {
  const { document, file } = latestDocument(documents);
  const match = operations(document).find(
    ({ method, operation }) =>
      method === "get" &&
      /list.*subscription|subscription.*list/i.test(operation.operationId ?? ""),
  );
  assert.ok(match, `expected a subscription list operation in ${file}`);
  const parameters = operationParameters(document, match.route, match.operation);
  for (const name of ["$top", "$skip"]) {
    const parameter = parameters.find((candidate) => candidate?.name === name);
    assert.ok(parameter, `expected ${name} on ${match.operation.operationId}`);
    assert.notEqual(parameter.required, true, `${name} must be optional`);
    assert.equal(parameterType(parameter), "integer", `${name} must be integer`);
    assert.equal(parameterFormat(parameter), "int32", `${name} must be int32`);
  }
}

function responseSchema(response) {
  return response?.schema ?? response?.content?.["application/json"]?.schema;
}

function requestBodySchema(operation) {
  const body = (operation.parameters ?? []).find((parameter) => parameter?.in === "body");
  return body?.schema ?? operation.requestBody?.content?.["application/json"]?.schema;
}

export function verifyArmPatchSync(documents) {
  const { document, file } = latestDocument(documents);
  const match = operations(document).find(
    ({ method, operation }) =>
      method === "patch" && /employee.*update|update.*employee/i.test(operation.operationId ?? ""),
  );
  assert.ok(match, `expected the Employee PATCH operation in ${file}`);
  assert.notEqual(
    match.operation["x-ms-long-running-operation"],
    true,
    "PATCH must complete synchronously",
  );

  const body = requestBodySchema(match.operation);
  assert.ok(body, "PATCH must have a request body");
  const updateSchema = resolveLocalSchema(document, body);
  assert.ok(updateSchema, "PATCH body must resolve to a local update model");
  assert.ok(
    (updateSchema.allOf ?? []).some((part) => /TrackedResourceUpdate$/.test(part?.$ref ?? "")) ||
      Object.hasOwn(updateSchema.properties ?? {}, "tags"),
    "PATCH update model must include tracked-resource tags",
  );

  const updateProperties = schemaProperties(document, updateSchema.properties?.properties);
  assert.ok(
    Object.keys(updateProperties).length,
    "PATCH update model must include mutable Employee properties",
  );
  assert.ok(
    !Object.hasOwn(updateProperties, "provisioningState"),
    "PATCH update model must exclude read-only provisioningState",
  );
  assert.ok(
    !(updateSchema.required ?? []).includes("properties"),
    "PATCH properties bag must be optional",
  );
}

export function verifyArmActionLro(documents) {
  const { document, file } = latestDocument(documents);
  const match = operations(document).find(
    ({ method, operation }) => method === "post" && /move/i.test(operation.operationId ?? ""),
  );
  assert.ok(match, `expected a move POST operation in ${file}`);
  assert.equal(
    match.operation["x-ms-long-running-operation"],
    true,
    "move must be a long-running operation",
  );
  assert.match(
    requestBodySchema(match.operation)?.$ref ?? "",
    /MoveRequest$/,
    "move request body must be MoveRequest",
  );

  const accepted = match.operation.responses?.["202"];
  assert.ok(accepted, "move LRO must return 202 Accepted");
  const headerNames = Object.keys(accepted.headers ?? {}).map((name) => name.toLowerCase());
  for (const header of ["azure-asyncoperation", "location", "retry-after"]) {
    assert.ok(headerNames.includes(header), `202 response must include ${header}`);
  }

  const finalResponses = Object.entries(match.operation.responses ?? {}).filter(([status]) =>
    /^20[01]$/.test(status),
  );
  assert.ok(
    finalResponses.some(([, response]) =>
      /MoveResponse$/.test(responseSchema(response)?.$ref ?? ""),
    ),
    "move LRO final response must be MoveResponse",
  );
}

function documentForVersion(documents, version) {
  return documents.find(({ document }) => document.info?.version === version)?.document;
}

function employeeProperties(document) {
  const employee =
    schemas(document).EmployeeProperties ??
    Object.values(schemas(document)).find((schema) =>
      /Employee properties/i.test(schema?.description ?? ""),
    );
  assert.ok(employee, `expected EmployeeProperties in ${document.info?.version}`);
  return schemaProperties(document, employee);
}

function widgetProperties(document) {
  const widget =
    schemas(document).WidgetSuite ??
    Object.values(schemas(document)).find((schema) => /widget/i.test(schema?.description ?? ""));
  assert.ok(widget, `expected WidgetSuite in ${document.info?.version}`);
  return schemaProperties(document, widget);
}

function assertExampleVersion(root, version) {
  const directory = path.join(root, "examples", version);
  assert.ok(fs.existsSync(directory), `expected examples/${version}`);
  const examples = walkJson(directory);
  assert.ok(examples.length, `expected JSON examples for ${version}`);
  for (const examplePath of examples) {
    const text = fs.readFileSync(examplePath, "utf8");
    assert.match(
      text,
      new RegExp(`"api-version"\\s*:\\s*"${version}"`),
      `${examplePath} must use ${version}`,
    );
  }
}

export function verifyVersion001005(documents, root = process.cwd()) {
  const stable = documentForVersion(documents, "2021-10-01");
  const preview = documentForVersion(documents, "2025-05-04-preview");
  assert.ok(stable, "expected retained stable 2021-10-01 output");
  assert.ok(preview, "expected new preview 2025-05-04-preview output");
  assert.ok(
    !documentForVersion(documents, "2024-10-01-preview"),
    "superseded 2024-10-01-preview output must be removed",
  );

  const stableProperties = employeeProperties(stable);
  const previewProperties = employeeProperties(preview);
  assert.ok(stableProperties.age, "stable wire name age must be preserved");
  assert.ok(!stableProperties.oldAge, "stable output must not expose oldAge");
  assert.ok(previewProperties.age, "new preview must expose age");
  assert.equal(
    previewProperties.age.default,
    undefined,
    "excluded age default must not be reintroduced",
  );
  assert.ok(previewProperties.workLocation, "carried workLocation must exist in the new preview");
  assertExampleVersion(root, "2025-05-04-preview");
  assert.ok(
    !fs.existsSync(path.join(root, "examples", "2024-10-01-preview")),
    "superseded preview examples must be removed",
  );
}

export function verifyVersion001007(documents, root = process.cwd()) {
  const stable = documentForVersion(documents, "2021-10-01");
  const promoted = documentForVersion(documents, "2025-01-01");
  assert.ok(stable, "expected retained stable 2021-10-01 output");
  assert.ok(promoted, "expected promoted stable 2025-01-01 output");
  assert.ok(
    !documentForVersion(documents, "2024-10-01-preview"),
    "superseded 2024-10-01-preview output must be removed",
  );

  const stableProperties = employeeProperties(stable);
  const promotedProperties = employeeProperties(promoted);
  assert.ok(stableProperties.age, "released stable wire name age must remain");
  assert.ok(!stableProperties.oldAge, "released stable must not expose oldAge");
  assert.equal(
    promotedProperties.age?.default,
    21,
    "carried age default must exist in the promoted stable version",
  );
  assert.ok(
    !promotedProperties.workLocation,
    "excluded workLocation must not exist in the promoted stable version",
  );
  assertExampleVersion(root, "2025-01-01");
  assert.ok(
    !fs.existsSync(path.join(root, "examples", "2024-10-01-preview")),
    "superseded preview examples must be removed",
  );
}

export function verifyVersion001002(documents) {
  const target = documentForVersion(documents, "2025-11-01");
  assert.ok(target, "expected new 2025-11-01 output");
  for (const { document } of documents) {
    const properties = employeeProperties(document);
    assert.ok(properties.age, `${document.info?.version} must expose age`);
    assert.ok(!properties.oldAge, `${document.info?.version} must preserve the age wire name`);
    if (document.info?.version === "2025-11-01") {
      assert.equal(properties.age.default, 21, "new version must default age to 21");
    } else {
      assert.equal(
        properties.age.default,
        undefined,
        `${document.info?.version} must not gain the new age default`,
      );
    }
  }
}

export function verifyArmTrackedResource(documents) {
  const { document, file } = latestDocument(documents);
  const definitions = schemas(document);
  const employee = definitions.Employee;
  assert.ok(employee, `expected Employee resource in ${file}`);
  assert.ok(
    (employee.allOf ?? []).some((part) => /TrackedResource$/.test(part?.$ref ?? "")),
    "Employee must inherit the tracked ARM resource contract",
  );
  const properties = employeeProperties(document);
  for (const name of ["age", "city", "profile", "provisioningState"]) {
    assert.ok(properties[name], `EmployeeProperties must contain ${name}`);
  }
  for (const name of ["age", "city", "profile", "provisioningState"]) {
    assert.ok(
      !(definitions.EmployeeProperties?.required ?? []).includes(name),
      `${name} must be optional`,
    );
  }
  assert.equal(properties.profile.type, "string");
  assert.equal(properties.profile.format, "base64url");
  assert.equal(properties.provisioningState.readOnly, true, "provisioningState must be read-only");

  const employeeOperations = operations(document).filter(({ operation }) =>
    /^Employees_/i.test(operation.operationId ?? ""),
  );
  const operationIds = employeeOperations.map(({ operation }) => operation.operationId);
  for (const suffix of [
    "CreateOrUpdate",
    "Delete",
    "Get",
    "ListByResourceGroup",
    "ListBySubscription",
    "Update",
  ]) {
    assert.ok(
      operationIds.some((id) => new RegExp(`${suffix}$`, "i").test(id)),
      `expected Employees_${suffix}`,
    );
  }
}

export function verifyArmNotifyAction(documents) {
  const { document, file } = latestDocument(documents);
  const match = operations(document).find(
    ({ method, operation }) => method === "post" && /notify/i.test(operation.operationId ?? ""),
  );
  assert.ok(match, `expected notify POST action in ${file}`);
  assert.notEqual(
    match.operation["x-ms-long-running-operation"],
    true,
    "notify must complete synchronously",
  );
  const requestProperties = schemaProperties(document, requestBodySchema(match.operation));
  const message = requestProperties.message ?? requestProperties.content;
  assert.equal(message?.type, "string", "request must contain string message content");
  const priority = resolveLocalSchema(document, requestProperties.priority);
  assert.deepEqual(
    [...(priority?.enum ?? [])].sort(),
    ["High", "Low", "Medium"],
    "priority must be the closed Low/Medium/High enum",
  );

  const success = Object.entries(match.operation.responses ?? {}).find(
    ([status]) => /^20\d$/.test(status) && status !== "202",
  )?.[1];
  const responseProperties = schemaProperties(document, responseSchema(success));
  const identifier = responseProperties.notificationId ?? responseProperties.identifier;
  assert.equal(
    identifier?.type,
    "string",
    "response must contain a string notification identifier",
  );
  assert.equal(responseProperties.status?.type, "string", "response must contain string status");
}

function containsArray(document, schema, seen = new Set()) {
  const resolved = resolveLocalSchema(document, schema);
  if (!resolved || seen.has(resolved)) {
    return false;
  }
  seen.add(resolved);
  if (resolved.type === "array") {
    return true;
  }
  return [...(resolved.allOf ?? []), ...Object.values(resolved.properties ?? {})].some((child) =>
    containsArray(document, child, seen),
  );
}

export function verifyDataPlaneList(documents) {
  assert.ok(documents.length, "expected emitted data-plane documents");
  for (const { document, file } of documents) {
    const match = operations(document).find(
      ({ method, operation }) => method === "get" && /list/i.test(operation.operationId ?? ""),
    );
    assert.ok(match, `expected list operation in ${file}`);
    const success = Object.entries(match.operation.responses ?? {}).find(([status]) =>
      /^20\d$/.test(status),
    )?.[1];
    assert.ok(
      containsArray(document, responseSchema(success)),
      `list response in ${file} must contain an array of resources`,
    );
  }
}

export function verifyVersion006008(documents) {
  const target = documentForVersion(documents, "2023-06-01-preview");
  assert.ok(target, "expected 2023-06-01-preview output");
  for (const { document } of documents) {
    const properties = widgetProperties(document);
    if (document.info?.version === "2023-06-01-preview") {
      assert.ok(!properties.color, "target preview must remove color");
    } else {
      assert.ok(properties.color, `${document.info?.version} must retain color`);
    }
  }
}

export function verifyVersion006009(documents) {
  const target = documentForVersion(documents, "2023-06-01-preview");
  assert.ok(target, "expected 2023-06-01-preview output");
  for (const { document } of documents) {
    const properties = widgetProperties(document);
    if (document.info?.version === "2023-06-01-preview") {
      assert.ok(properties.widgetColor, "target preview must expose widgetColor");
      assert.ok(!properties.color, "target preview must not expose color");
    } else {
      assert.ok(properties.color, `${document.info?.version} must retain color`);
      assert.ok(!properties.widgetColor, `${document.info?.version} must not expose widgetColor`);
    }
  }
}

const modes = {
  "arm-action-lro": verifyArmActionLro,
  "arm-list-top-skip": verifyArmListTopSkip,
  "arm-notify-action": verifyArmNotifyAction,
  "arm-patch-sync": verifyArmPatchSync,
  "arm-tracked-resource": verifyArmTrackedResource,
  "data-plane-list": verifyDataPlaneList,
  "version-001002": verifyVersion001002,
  "version-001005": verifyVersion001005,
  "version-001007": verifyVersion001007,
  "version-006008": verifyVersion006008,
  "version-006009": verifyVersion006009,
};

const isMain =
  process.argv[1] && path.resolve(process.argv[1]) === path.resolve(fileURLToPath(import.meta.url));
if (isMain) {
  const mode = process.argv[2];
  if (!Object.hasOwn(modes, mode)) {
    console.error(`usage: node verify-emitted-contract.js <${Object.keys(modes).join("|")}>`);
    process.exit(2);
  }
  modes[mode](loadOpenApiDocuments());
  console.log(`[emitted-contract:${mode}] ok`);
}
