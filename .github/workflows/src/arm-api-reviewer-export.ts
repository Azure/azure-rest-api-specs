import { createHash } from "node:crypto";
import {
  copyFile,
  lstat,
  mkdir,
  readFile,
  readdir,
  realpath,
  stat,
  writeFile,
} from "node:fs/promises";
import { dirname, isAbsolute, parse, relative, resolve, sep } from "node:path";

const GENERATED_MANIFEST_NAME = "arm-api-reviewer.export-manifest.json";
const GENERATED_MANIFEST_SCHEMA_VERSION = 1;
const SHA256_PATTERN = /^[0-9a-f]{64}$/;
const FULL_COMMIT_PATTERN = /^[0-9a-f]{40}$/;

export interface ArmApiReviewerExportDefinition {
  schemaVersion: number;
  packageName: string;
  compatibilityVersion: number;
  sourceRepository: string;
  entrypoints: {
    reviewer: string;
    critic: string;
    skill: string;
  };
  files: string[];
  directories: string[];
  runtimeReferenceRoots: string[];
  validation: {
    vallyVersion: string;
    releaseSmokeSuite: string;
    reviewerModel: string;
    judgeModel: string;
  };
}

export interface ArmApiReviewerExportFile {
  path: string;
  sha256: string;
  size: number;
}

export interface ArmApiReviewerExportManifest {
  schemaVersion: number;
  packageName: string;
  compatibilityVersion: number;
  sourceRepository: string;
  sourceCommit: string;
  contentDigest: string;
  entrypoints: ArmApiReviewerExportDefinition["entrypoints"];
  validation: ArmApiReviewerExportDefinition["validation"];
  files: ArmApiReviewerExportFile[];
}

export interface ExportArmApiReviewerOptions {
  repoRoot: string;
  sourceCommit: string;
  outputDir?: string;
  definitionPath?: string;
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

function requireString(value: unknown, field: string): string {
  if (typeof value !== "string" || value.trim() === "") {
    throw new Error(`${field} must be a non-empty string.`);
  }
  return value;
}

function requirePositiveInteger(value: unknown, field: string): number {
  if (!Number.isInteger(value) || Number(value) < 1) {
    throw new Error(`${field} must be a positive integer.`);
  }
  return Number(value);
}

function requireStringArray(value: unknown, field: string): string[] {
  if (!Array.isArray(value)) {
    throw new Error(`${field} must be an array.`);
  }
  return value.map((entry, index) => requireString(entry, `${field}[${index}]`));
}

function normalizeRepositoryPath(value: string, field: string): string {
  if (
    value.includes("\\") ||
    value.startsWith("/") ||
    isAbsolute(value) ||
    /^[A-Za-z]:[/\\]/.test(value)
  ) {
    throw new Error(`${field} must be a repository-relative path using forward slashes.`);
  }

  const parts = value.split("/");
  if (parts.some((part) => part === "" || part === "." || part === "..")) {
    throw new Error(`${field} contains an empty, current-directory, or parent segment.`);
  }

  return parts.join("/");
}

function toRepositoryPath(value: string): string {
  return value.split(sep).join("/");
}

function isWithinOrEqual(basePath: string, candidatePath: string): boolean {
  const relativePath = relative(basePath, candidatePath);
  return (
    relativePath === "" ||
    (!isAbsolute(relativePath) && relativePath !== ".." && !relativePath.startsWith(`..${sep}`))
  );
}

function resolveRepositoryPath(repoRoot: string, repositoryPath: string): string {
  const resolved = resolve(repoRoot, ...repositoryPath.split("/"));
  if (!isWithinOrEqual(repoRoot, resolved)) {
    throw new Error(`Path escapes the repository root: ${repositoryPath}`);
  }
  return resolved;
}

async function assertNoSymbolicLinks(repoRoot: string, repositoryPath: string): Promise<void> {
  let current = repoRoot;
  for (const part of repositoryPath.split("/")) {
    current = resolve(current, part);
    const metadata = await lstat(current);
    if (metadata.isSymbolicLink()) {
      throw new Error(`Symbolic links are not allowed in the export: ${repositoryPath}`);
    }
  }
}

function parseDefinition(value: unknown): ArmApiReviewerExportDefinition {
  if (!isRecord(value)) {
    throw new Error("The ARM API Reviewer export definition must be a JSON object.");
  }

  const entrypoints = value.entrypoints;
  const validation = value.validation;
  if (!isRecord(entrypoints)) {
    throw new Error("entrypoints must be an object.");
  }
  if (!isRecord(validation)) {
    throw new Error("validation must be an object.");
  }

  const definition: ArmApiReviewerExportDefinition = {
    schemaVersion: requirePositiveInteger(value.schemaVersion, "schemaVersion"),
    packageName: requireString(value.packageName, "packageName"),
    compatibilityVersion: requirePositiveInteger(
      value.compatibilityVersion,
      "compatibilityVersion",
    ),
    sourceRepository: requireString(value.sourceRepository, "sourceRepository"),
    entrypoints: {
      reviewer: requireString(entrypoints.reviewer, "entrypoints.reviewer"),
      critic: requireString(entrypoints.critic, "entrypoints.critic"),
      skill: requireString(entrypoints.skill, "entrypoints.skill"),
    },
    files: requireStringArray(value.files, "files"),
    directories: requireStringArray(value.directories, "directories"),
    runtimeReferenceRoots: requireStringArray(value.runtimeReferenceRoots, "runtimeReferenceRoots"),
    validation: {
      vallyVersion: requireString(validation.vallyVersion, "validation.vallyVersion"),
      releaseSmokeSuite: requireString(
        validation.releaseSmokeSuite,
        "validation.releaseSmokeSuite",
      ),
      reviewerModel: requireString(validation.reviewerModel, "validation.reviewerModel"),
      judgeModel: requireString(validation.judgeModel, "validation.judgeModel"),
    },
  };

  if (definition.schemaVersion !== 1) {
    throw new Error(`Unsupported export definition schema version: ${definition.schemaVersion}`);
  }

  definition.files = definition.files.map((path, index) =>
    normalizeRepositoryPath(path, `files[${index}]`),
  );
  definition.directories = definition.directories.map((path, index) =>
    normalizeRepositoryPath(path, `directories[${index}]`),
  );
  definition.runtimeReferenceRoots = definition.runtimeReferenceRoots.map((path, index) =>
    normalizeRepositoryPath(path, `runtimeReferenceRoots[${index}]`),
  );
  definition.entrypoints = {
    reviewer: normalizeRepositoryPath(definition.entrypoints.reviewer, "entrypoints.reviewer"),
    critic: normalizeRepositoryPath(definition.entrypoints.critic, "entrypoints.critic"),
    skill: normalizeRepositoryPath(definition.entrypoints.skill, "entrypoints.skill"),
  };

  return definition;
}

async function collectDirectoryFiles(repoRoot: string, directoryPath: string): Promise<string[]> {
  await assertNoSymbolicLinks(repoRoot, directoryPath);
  const absoluteDirectory = resolveRepositoryPath(repoRoot, directoryPath);
  const metadata = await stat(absoluteDirectory);
  if (!metadata.isDirectory()) {
    throw new Error(`Configured directory is not a directory: ${directoryPath}`);
  }

  const files: string[] = [];
  async function visit(currentAbsolute: string, currentRelative: string): Promise<void> {
    const entries = await readdir(currentAbsolute, { withFileTypes: true });
    entries.sort((left, right) => left.name.localeCompare(right.name, "en"));

    for (const entry of entries) {
      const childRelative = `${currentRelative}/${entry.name}`;
      const childAbsolute = resolve(currentAbsolute, entry.name);
      const childMetadata = await lstat(childAbsolute);
      if (childMetadata.isSymbolicLink()) {
        throw new Error(`Symbolic links are not allowed in the export: ${childRelative}`);
      }
      if (childMetadata.isDirectory()) {
        await visit(childAbsolute, childRelative);
      } else if (childMetadata.isFile()) {
        files.push(childRelative);
      } else {
        throw new Error(`Unsupported filesystem entry in export: ${childRelative}`);
      }
    }
  }

  await visit(absoluteDirectory, directoryPath);
  return files;
}

async function collectExportPaths(
  repoRoot: string,
  definition: ArmApiReviewerExportDefinition,
): Promise<string[]> {
  const paths = new Set<string>();

  for (const filePath of definition.files) {
    await assertNoSymbolicLinks(repoRoot, filePath);
    const metadata = await stat(resolveRepositoryPath(repoRoot, filePath));
    if (!metadata.isFile()) {
      throw new Error(`Configured file is not a regular file: ${filePath}`);
    }
    if (paths.has(filePath)) {
      throw new Error(`Duplicate export path: ${filePath}`);
    }
    paths.add(filePath);
  }

  for (const directoryPath of definition.directories) {
    for (const filePath of await collectDirectoryFiles(repoRoot, directoryPath)) {
      if (paths.has(filePath)) {
        throw new Error(`Duplicate export path: ${filePath}`);
      }
      paths.add(filePath);
    }
  }

  for (const [name, entrypoint] of Object.entries(definition.entrypoints)) {
    if (!paths.has(entrypoint)) {
      throw new Error(`Export entrypoint ${name} is not included: ${entrypoint}`);
    }
  }

  return [...paths].sort((left, right) => left.localeCompare(right, "en"));
}

function parseMarkdownLinkTarget(rawTarget: string): string | undefined {
  let target = rawTarget.trim();
  if (target.startsWith("<")) {
    const end = target.indexOf(">");
    if (end === -1) {
      return undefined;
    }
    target = target.slice(1, end);
  } else {
    target = target.split(/\s+/, 1)[0];
  }

  if (
    !target ||
    target === "..." ||
    target.startsWith("#") ||
    /^[a-z][a-z0-9+.-]*:/i.test(target)
  ) {
    return undefined;
  }

  target = target.split("#", 1)[0].split("?", 1)[0];
  if (!target) {
    return undefined;
  }

  try {
    return decodeURIComponent(target);
  } catch {
    throw new Error(`Invalid percent-encoding in Markdown link target: ${target}`);
  }
}

function isRuntimeReference(path: string, roots: string[]): boolean {
  return roots.some((root) => path === root || path.startsWith(`${root}/`));
}

async function validateRuntimeReferences(
  repoRoot: string,
  paths: string[],
  runtimeReferenceRoots: string[],
): Promise<void> {
  const includedPaths = new Set(paths);
  const linkPattern = /\]\((?<target>[^)]+)\)/g;
  const errors: string[] = [];

  for (const sourcePath of paths.filter((path) => path.endsWith(".md"))) {
    const sourceAbsolute = resolveRepositoryPath(repoRoot, sourcePath);
    const content = await readFile(sourceAbsolute, "utf8");
    for (const match of content.matchAll(linkPattern)) {
      const target = parseMarkdownLinkTarget(match.groups?.target ?? "");
      if (!target) {
        continue;
      }

      const targetAbsolute = target.startsWith("/")
        ? resolve(repoRoot, ...target.slice(1).split("/"))
        : resolve(dirname(sourceAbsolute), ...target.split("/"));
      if (!isWithinOrEqual(repoRoot, targetAbsolute)) {
        errors.push(`${sourcePath} -> ${target} (outside repository)`);
        continue;
      }

      const targetPath = toRepositoryPath(relative(repoRoot, targetAbsolute));
      if (!isRuntimeReference(targetPath, runtimeReferenceRoots)) {
        continue;
      }

      try {
        const targetMetadata = await stat(targetAbsolute);
        if (targetMetadata.isDirectory()) {
          continue;
        }
      } catch {
        errors.push(`${sourcePath} -> ${targetPath} (missing)`);
        continue;
      }

      if (!includedPaths.has(targetPath)) {
        errors.push(`${sourcePath} -> ${targetPath} (not exported)`);
      }
    }
  }

  if (errors.length > 0) {
    throw new Error(`Runtime reference closure is incomplete:\n${errors.join("\n")}`);
  }
}

async function hashFile(path: string): Promise<{ sha256: string; size: number }> {
  const content = await readFile(path);
  return {
    sha256: createHash("sha256").update(content).digest("hex"),
    size: content.byteLength,
  };
}

function computeContentDigest(
  definition: ArmApiReviewerExportDefinition,
  files: ArmApiReviewerExportFile[],
): string {
  const lines = [
    `manifest-schema:${GENERATED_MANIFEST_SCHEMA_VERSION}`,
    `definition-schema:${definition.schemaVersion}`,
    `package:${definition.packageName}`,
    `compatibility:${definition.compatibilityVersion}`,
    `entrypoint:reviewer:${definition.entrypoints.reviewer}`,
    `entrypoint:critic:${definition.entrypoints.critic}`,
    `entrypoint:skill:${definition.entrypoints.skill}`,
    `validation:vally-version:${definition.validation.vallyVersion}`,
    `validation:release-smoke-suite:${definition.validation.releaseSmokeSuite}`,
    `validation:reviewer-model:${definition.validation.reviewerModel}`,
    `validation:judge-model:${definition.validation.judgeModel}`,
    ...files.map((file) => `file:${file.path}\0${file.sha256}\0${file.size}`),
  ];
  return createHash("sha256")
    .update(`${lines.join("\n")}\n`)
    .digest("hex");
}

async function prepareOutputDirectory(repoRoot: string, outputDir: string): Promise<string> {
  const absoluteOutput = resolve(outputDir);
  if (absoluteOutput === parse(absoluteOutput).root) {
    throw new Error("The export output directory cannot be a filesystem root.");
  }
  if (isWithinOrEqual(repoRoot, absoluteOutput)) {
    throw new Error("The export output directory must be outside the source repository.");
  }

  await mkdir(absoluteOutput, { recursive: true });
  const entries = await readdir(absoluteOutput);
  if (entries.length > 0) {
    throw new Error(`The export output directory must be empty: ${absoluteOutput}`);
  }
  return absoluteOutput;
}

export async function exportArmApiReviewer({
  repoRoot,
  sourceCommit,
  outputDir,
  definitionPath,
}: ExportArmApiReviewerOptions): Promise<ArmApiReviewerExportManifest> {
  if (!FULL_COMMIT_PATTERN.test(sourceCommit)) {
    throw new Error("sourceCommit must be a full 40-character lowercase Git commit SHA.");
  }

  const canonicalRepoRoot = await realpath(repoRoot);
  const resolvedDefinitionPath = definitionPath
    ? resolve(definitionPath)
    : resolve(canonicalRepoRoot, ".github/agents/arm-api-reviewer.export.json");
  if (!isWithinOrEqual(canonicalRepoRoot, resolvedDefinitionPath)) {
    throw new Error("The export definition must be inside the source repository.");
  }

  const definition = parseDefinition(
    JSON.parse(await readFile(resolvedDefinitionPath, "utf8")) as unknown,
  );
  const paths = await collectExportPaths(canonicalRepoRoot, definition);
  await validateRuntimeReferences(canonicalRepoRoot, paths, definition.runtimeReferenceRoots);

  const files: ArmApiReviewerExportFile[] = [];
  for (const path of paths) {
    const digest = await hashFile(resolveRepositoryPath(canonicalRepoRoot, path));
    if (!SHA256_PATTERN.test(digest.sha256)) {
      throw new Error(`Invalid SHA-256 generated for ${path}`);
    }
    files.push({ path, ...digest });
  }

  const manifest: ArmApiReviewerExportManifest = {
    schemaVersion: GENERATED_MANIFEST_SCHEMA_VERSION,
    packageName: definition.packageName,
    compatibilityVersion: definition.compatibilityVersion,
    sourceRepository: definition.sourceRepository,
    sourceCommit,
    contentDigest: computeContentDigest(definition, files),
    entrypoints: definition.entrypoints,
    validation: definition.validation,
    files,
  };

  if (outputDir) {
    const absoluteOutput = await prepareOutputDirectory(canonicalRepoRoot, outputDir);
    for (const file of files) {
      const destination = resolveRepositoryPath(absoluteOutput, file.path);
      await mkdir(dirname(destination), { recursive: true });
      await copyFile(resolveRepositoryPath(canonicalRepoRoot, file.path), destination);
    }
    await writeFile(
      resolve(absoluteOutput, GENERATED_MANIFEST_NAME),
      `${JSON.stringify(manifest, null, 2)}\n`,
      "utf8",
    );
  }

  return manifest;
}

export { GENERATED_MANIFEST_NAME };
