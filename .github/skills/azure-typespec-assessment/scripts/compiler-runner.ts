import { spawnSync } from "node:child_process";
import { pathToFileURL } from "node:url";
import crypto from "node:crypto";
import fs from "node:fs";
import path from "node:path";
import { isRecord, readJsonObject } from "./cli.ts";

type OpenApiArtifact = {
  path: string;
  apiVersion?: string;
  documentRole: "common" | "primary" | "feature";
  contentHash: string;
};
type EmitterRun = {
  status: "succeeded" | "failed";
  command: {
    executable: string;
    args: string[];
  };
  exitCode: number | null;
  durationMs: number;
  configPath: string;
  configHash: string;
  logPath: string;
};
type CompilerCommand = {
  executable: string;
  args: string[];
  displayExecutable: string;
};

const TCGC_EMITTER = "@azure-tools/typespec-client-generator-core";
const TCGC_PROVENANCE_EMITTER = "@azure-tools/assessment-tcgc-provenance";
const TCGC_PROVENANCE_FILE = "tcgc-provenance.json";

function hashFile(file: string): string {
  return crypto.createHash("sha256").update(fs.readFileSync(file)).digest("hex");
}

function findFiles(root: string, predicate: (file: string) => boolean): string[] {
  if (!fs.existsSync(root)) return [];

  const files: string[] = [];

  const visit = (directory: string) => {
    for (const entry of fs.readdirSync(directory, { withFileTypes: true })) {
      const fullPath = path.join(directory, entry.name);
      if (entry.isDirectory()) visit(fullPath);
      else if (predicate(fullPath)) files.push(fullPath);
    }
  };
  visit(root);
  return files.sort();
}

function packageEntry(worktree: string, packageName: string) {
  const manifestPath = path.join(
    worktree,
    "node_modules",
    ...packageName.split("/"),
    "package.json",
  );
  if (!fs.existsSync(manifestPath)) {
    throw new Error(`Package manifest not found at ${manifestPath}.`);
  }
  const manifest = readJsonObject(manifestPath);
  const exports = isRecord(manifest.exports) ? manifest.exports : undefined;
  const rootExport = exports?.["."];
  const entry =
    typeof rootExport === "string"
      ? rootExport
      : isRecord(rootExport) && typeof rootExport.default === "string"
        ? rootExport.default
        : typeof manifest.main === "string"
          ? manifest.main
          : undefined;
  if (!entry) throw new Error(`Package ${packageName} has no JavaScript entry point.`);
  const resolved = path.resolve(path.dirname(manifestPath), entry);
  if (!fs.existsSync(resolved)) {
    throw new Error(`Package ${packageName} entry point does not exist at ${resolved}.`);
  }
  return resolved;
}

export function writeTcgcProvenanceEmitter(worktree: string, workRoot: string) {
  const directory = path.join(workRoot, "inputs", "tcgc-provenance-emitter");
  fs.mkdirSync(directory, { recursive: true });
  const tcgcEntry = pathToFileURL(packageEntry(worktree, TCGC_EMITTER)).href;
  const compilerEntry = pathToFileURL(packageEntry(worktree, "@typespec/compiler")).href;
  fs.writeFileSync(
    path.join(directory, "package.json"),
    `${JSON.stringify(
      {
        name: TCGC_PROVENANCE_EMITTER,
        private: true,
        type: "module",
        main: "./index.mjs",
      },
      null,
      2,
    )}\n`,
  );
  fs.writeFileSync(
    path.join(directory, "index.mjs"),
    `import { emitFile, getNamespaceFullName } from ${JSON.stringify(compilerEntry)};
import { $lib, createSdkContext } from ${JSON.stringify(tcgcEntry)};

export { $lib };

function compactObject(record) {
  return Object.fromEntries(Object.entries(record).filter(([, item]) => item !== undefined));
}

function mapEntries(collection) {
  if (!collection) return [];
  if (typeof collection.entries === "function") return [...collection.entries()];
  if (typeof collection === "object") return Object.entries(collection);
  return [];
}

function sanitizeValue(entity, seen) {
  if (entity === undefined || entity === null || typeof entity !== "object") return entity;
  if (seen.has(entity)) {
    return compactObject({
      cycle: true,
      entityKind: "Value",
      valueKind: entity.valueKind,
    });
  }
  seen.add(entity);
  try {
    const valueKind = entity.valueKind;
    let payload;
    switch (valueKind) {
      case "StringValue":
      case "BooleanValue":
        payload = entity.value;
        break;
      case "NullValue":
        payload = null;
        break;
      case "NumericValue":
        payload =
          entity.value && typeof entity.value.toString === "function"
            ? entity.value.toString()
            : entity.value !== undefined
              ? String(entity.value)
              : undefined;
        break;
      case "EnumValue":
        payload = typeIdentity(entity.value, seen);
        break;
      case "ScalarValue":
        payload = compactObject({
          name: typeof entity.value?.name === "string" ? entity.value.name : undefined,
          args: Array.isArray(entity.value?.args)
            ? entity.value.args.map((arg) => typeIdentity(arg, seen))
            : undefined,
        });
        break;
      case "ArrayValue":
        payload = Array.isArray(entity.values)
          ? entity.values.map((item) => typeIdentity(item, seen))
          : [];
        break;
      case "ObjectValue":
        payload = mapEntries(entity.properties)
          .sort(([left], [right]) => String(left).localeCompare(String(right)))
          .map(([key, descriptor]) =>
            compactObject({
              name: String(key),
              value: typeIdentity(
                descriptor && typeof descriptor === "object" && "value" in descriptor
                  ? descriptor.value
                  : descriptor,
                seen,
              ),
            }),
          );
        break;
      default:
        if (
          typeof entity.value === "string" ||
          typeof entity.value === "number" ||
          typeof entity.value === "boolean" ||
          entity.value === null
        ) {
          payload = entity.value;
        } else if (typeof entity.name === "string" && entity.name.length > 0) {
          payload = entity.name;
        }
        break;
    }
    return compactObject({
      entityKind: "Value",
      valueKind,
      scalar: entity.scalar ? typeIdentity(entity.scalar, seen) : undefined,
      type: entity.type ? typeIdentity(entity.type, seen) : undefined,
      value: payload,
    });
  } finally {
    seen.delete(entity);
  }
}

function typeIdentity(rawValue, seen = new Set()) {
  if (rawValue === undefined || rawValue === null) return rawValue;
  if (typeof rawValue !== "object") return rawValue;
  let value = rawValue;
  while (
    value &&
    typeof value === "object" &&
    value.entityKind === "Indeterminate" &&
    value.type
  ) {
    value = value.type;
  }
  if (value === undefined || value === null || typeof value !== "object") return value;
  if (value.entityKind === "Value") {
    return sanitizeValue(value, seen);
  }
  const namespace =
    value.namespace && typeof getNamespaceFullName === "function"
      ? getNamespaceFullName(value.namespace) || undefined
      : undefined;
  const name = typeof value.name === "string" && value.name.length > 0 ? value.name : undefined;
  if (seen.has(value)) {
    return compactObject({
      cycle: true,
      kind: value.kind ?? value.entityKind ?? "cycle",
      name,
      namespace,
    });
  }
  seen.add(value);
  try {
    const primitiveValue =
      typeof value.value === "string" ||
      typeof value.value === "number" ||
      typeof value.value === "boolean" ||
      value.value === null
        ? value.value
        : undefined;
    const valueAsString =
      value.kind === "Number" &&
      typeof value.valueAsString === "string" &&
      String(primitiveValue) !== value.valueAsString
        ? value.valueAsString
        : undefined;
    const isAnonymousModel = value.kind === "Model" && !name;
    const isUnnamedUnion = value.kind === "Union" && !name;
    return compactObject({
      kind: value.kind ?? value.entityKind,
      name,
      namespace,
      value: primitiveValue,
      valueAsString,
      stringValue:
        value.kind === "StringTemplate" && typeof value.stringValue === "string"
          ? value.stringValue
          : undefined,
      spans:
        value.kind === "StringTemplate" &&
        typeof value.stringValue !== "string" &&
        Array.isArray(value.spans)
          ? value.spans.map((span) =>
              compactObject({
                isInterpolated: Boolean(span?.isInterpolated),
                type: typeIdentity(span?.type, seen),
              }),
            )
          : undefined,
      templateArguments:
        Array.isArray(value.templateMapper?.args) && value.templateMapper.args.length > 0
          ? value.templateMapper.args.map((item) => typeIdentity(item, seen))
          : undefined,
      properties: isAnonymousModel
        ? mapEntries(value.properties).map(([propKey, prop]) =>
            compactObject({
              name: typeof prop?.name === "string" ? prop.name : String(propKey),
              optional: typeof prop?.optional === "boolean" ? prop.optional : undefined,
              type: typeIdentity(prop?.type, seen),
            }),
          )
        : undefined,
      indexer:
        isAnonymousModel && value.indexer
          ? compactObject({
              key: typeIdentity(value.indexer.key, seen),
              value: typeIdentity(value.indexer.value, seen),
            })
          : undefined,
      variants: isUnnamedUnion
        ? mapEntries(value.variants).map(([variantKey, variant]) =>
            compactObject({
              name:
                typeof variant?.name === "string"
                  ? variant.name
                  : typeof variantKey === "string"
                    ? variantKey
                    : undefined,
              type: typeIdentity(variant?.type ?? variant, seen),
            }),
          )
        : undefined,
      values:
        value.kind === "Tuple" && Array.isArray(value.values)
          ? value.values.map((item) => typeIdentity(item, seen))
          : undefined,
      type:
        (value.kind === "ModelProperty" || value.kind === "UnionVariant") && value.type
          ? typeIdentity(value.type, seen)
          : undefined,
      model:
        value.kind === "ModelProperty" && value.model
          ? typeIdentity(value.model, seen)
          : undefined,
      enum:
        value.kind === "EnumMember" && value.enum
          ? typeIdentity(value.enum, seen)
          : undefined,
      union:
        value.kind === "UnionVariant" && value.union
          ? typeIdentity(value.union, seen)
          : undefined,
    });
  } finally {
    seen.delete(value);
  }
}

function collectModels(sdkPackage) {
  const models = [];
  const seen = new Set();
  const collect = (values, fallbackNamespace) => {
    for (const model of values ?? []) {
      if (!model || seen.has(model)) continue;
      seen.add(model);
      const args = model.__raw?.templateMapper?.args;
      if (!Array.isArray(args) || args.length === 0 || !model.crossLanguageDefinitionId) continue;
      const namespace =
        (typeof model.namespace === "string" && model.namespace.length > 0
          ? model.namespace
          : undefined) ??
        fallbackNamespace ??
        (model.__raw?.namespace && typeof getNamespaceFullName === "function"
          ? getNamespaceFullName(model.__raw.namespace) || undefined
          : undefined);
      models.push({
        crossLanguageDefinitionId: model.crossLanguageDefinitionId,
        name: model.name,
        ...(namespace ? { namespace } : {}),
        templateArguments: args.map((item) => typeIdentity(item)),
      });
    }
  };
  const visitNamespace = (namespace) => {
    const namespaceName =
      typeof namespace?.fullName === "string" && namespace.fullName.length > 0
        ? namespace.fullName
        : undefined;
    collect(namespace?.models, namespaceName);
    for (const child of namespace?.namespaces ?? []) visitNamespace(child);
  };
  for (const namespace of sdkPackage.namespaces ?? []) visitNamespace(namespace);
  collect(sdkPackage.models, undefined);
  return models;
}

export async function $onEmit(context) {
  if (context.program.compilerOptions.noEmit) return;
  const sdkContext = await createSdkContext(context, ${JSON.stringify(TCGC_EMITTER)}, {
    exportTCGCoutput: true,
  });
  context.program.reportDiagnostics(sdkContext.diagnostics);
  await emitFile(context.program, {
    path: context.emitterOutputDir + "/${TCGC_PROVENANCE_FILE}",
    content:
      JSON.stringify({ schemaVersion: 1, models: collectModels(sdkContext.sdkPackage) }, null, 2) +
      "\\n",
  });
}
`,
  );
  return directory;
}

export function resolveTsp(
  worktree: string,
  { platform = process.platform, execPath = process.execPath } = {},
): CompilerCommand {
  const candidates = [
    ...(platform === "win32" ? [path.join(worktree, "node_modules", ".bin", "tsp.cmd")] : []),
    path.join(worktree, "node_modules", ".bin", "tsp"),
  ];
  const displayExecutable = candidates.find(fs.existsSync);
  if (!displayExecutable) {
    throw new Error(`TypeSpec compiler not found under ${worktree}\\node_modules\\.bin.`);
  }
  if (platform !== "win32") {
    return { executable: displayExecutable, args: [], displayExecutable };
  }
  const packageRoot = path.join(worktree, "node_modules", "@typespec", "compiler");
  const manifestPath = path.join(packageRoot, "package.json");
  if (!fs.existsSync(manifestPath)) {
    throw new Error(`TypeSpec compiler package manifest not found at ${manifestPath}.`);
  }
  const manifest = readJsonObject(manifestPath);
  const binValue = manifest.bin;
  const bin =
    typeof binValue === "string"
      ? binValue
      : isRecord(binValue) && typeof binValue.tsp === "string"
        ? binValue.tsp
        : undefined;
  const cli = bin && path.resolve(packageRoot, bin);
  if (!cli || !fs.existsSync(cli)) {
    throw new Error(`TypeSpec compiler CLI is unavailable in ${manifestPath}.`);
  }
  return { executable: execPath, args: [cli], displayExecutable };
}

function runEmitter({
  worktree,
  project,
  emitter,
  output,
  log,
  apiVersion,
  workRoot,
}: {
  worktree: string;
  project: string;
  emitter: string;
  output: string;
  log: string;
  apiVersion?: string;
  workRoot: string;
}): EmitterRun {
  fs.mkdirSync(output, { recursive: true });
  fs.mkdirSync(path.dirname(log), { recursive: true });
  const command = resolveTsp(worktree);
  const emittedPackage =
    emitter === TCGC_EMITTER ? writeTcgcProvenanceEmitter(worktree, workRoot) : emitter;
  const emitterOptionName = emitter === TCGC_EMITTER ? TCGC_PROVENANCE_EMITTER : emitter;
  const args = [
    "compile",
    path.join(worktree, project),
    `--emit=${emittedPackage}`,
    `--option=${emitterOptionName}.emitter-output-dir=${output}`,
    "--warn-as-error",
  ];
  if (emitter === TCGC_EMITTER) {
    const emptyExamples = path.join(workRoot, "inputs", "empty-examples");
    fs.mkdirSync(emptyExamples, { recursive: true });
    const projectExamples = path.join(worktree, project, "examples");
    if (fs.existsSync(projectExamples)) {
      for (const entry of fs.readdirSync(projectExamples, { withFileTypes: true })) {
        if (entry.isDirectory())
          fs.mkdirSync(path.join(emptyExamples, entry.name), { recursive: true });
      }
    }
    if (apiVersion) fs.mkdirSync(path.join(emptyExamples, apiVersion), { recursive: true });
    args.push(`--option=${emitterOptionName}.examples-dir=${emptyExamples}`);
  }
  if (apiVersion) {
    const option = emitter === TCGC_EMITTER ? "api-version" : "version";
    args.push(`--option=${emitterOptionName}.${option}=${apiVersion}`);
  }
  const started = performance.now();
  const result = spawnSync(command.executable, [...command.args, ...args], {
    cwd: worktree,
    encoding: "utf8",
    maxBuffer: 64 * 1024 * 1024,
  });
  const durationMs = Math.round(performance.now() - started);
  fs.writeFileSync(
    log,
    [`> ${command.displayExecutable} ${args.join(" ")}`, result.stdout, result.stderr]
      .filter(Boolean)
      .join("\n"),
  );
  return {
    status: result.status === 0 ? "succeeded" : "failed",
    command: { executable: path.relative(worktree, command.displayExecutable), args },
    exitCode: result.status,
    durationMs,
    configPath: path.relative(workRoot, path.join(worktree, project, "tspconfig.yaml")),
    configHash: hashFile(path.join(worktree, project, "tspconfig.yaml")),
    logPath: path.relative(workRoot, log),
  };
}

function describeAutorest(output: string, workRoot: string): OpenApiArtifact[] {
  return findFiles(output, (file) => file.endsWith(".json"))
    .map((file): OpenApiArtifact | null => {
      try {
        const document = readJsonObject(file);
        if (document.swagger !== "2.0") return null;
        const info = isRecord(document.info) ? document.info : undefined;
        const name = path.basename(file).toLowerCase();
        return {
          path: path.relative(workRoot, file),
          ...(typeof info?.version === "string" ? { apiVersion: info.version } : {}),
          documentRole: name.includes("common")
            ? "common"
            : name === "openapi.json"
              ? "primary"
              : "feature",
          contentHash: hashFile(file),
        };
      } catch {
        return null;
      }
    })
    .filter((value) => value !== null);
}

export function runProjectCompilers({
  worktree,
  project,
  projectId,
  comparisonRole,
  sourceRevision,
  sourceCommit,
  workRoot,
  apiVersion,
}: {
  worktree: string;
  project: string;
  projectId: string;
  comparisonRole: string;
  sourceRevision: string;
  sourceCommit: string;
  workRoot: string;
  apiVersion?: string;
}) {
  const base = path.join(workRoot, "projects", projectId, comparisonRole);
  const autorestOutput = path.join(base, "autorest");
  const tcgcOutput = path.join(base, "tcgc");
  const autorest = runEmitter({
    worktree,
    project,
    emitter: "@azure-tools/typespec-autorest",
    output: autorestOutput,
    log: path.join(workRoot, "logs", `${projectId}-${comparisonRole}-autorest.log`),
    apiVersion,
    workRoot,
  });
  const tcgc = runEmitter({
    worktree,
    project,
    emitter: "@azure-tools/typespec-client-generator-core",
    output: tcgcOutput,
    log: path.join(workRoot, "logs", `${projectId}-${comparisonRole}-tcgc.log`),
    apiVersion,
    workRoot,
  });
  return {
    comparisonRole,
    sourceRevision,
    sourceCommit,
    apiVersion,
    autorest: {
      ...autorest,
      comparisonRole,
      sourceRevision,
      sourceCommit,
      selectedApiVersion: apiVersion,
      format: "swagger-2.0",
      files: describeAutorest(base, workRoot).filter(
        (file) => !apiVersion || file.apiVersion === apiVersion,
      ),
      serviceManifestPath: findFiles(base, (file) => path.basename(file) === "service.yaml").map(
        (file) => path.relative(workRoot, file),
      )[0],
    },
    tcgc: {
      ...tcgc,
      comparisonRole,
      sourceRevision,
      sourceCommit,
      selectedApiVersion: apiVersion,
      format: "tcgc-yaml",
      files: findFiles(tcgcOutput, (file) => path.basename(file) === "tcgc-output.yaml").map(
        (file) => ({ path: path.relative(workRoot, file), contentHash: hashFile(file) }),
      ),
      provenanceFile: findFiles(
        tcgcOutput,
        (file) => path.basename(file) === TCGC_PROVENANCE_FILE,
      ).map((file) => ({ path: path.relative(workRoot, file), contentHash: hashFile(file) }))[0],
    },
  };
}
