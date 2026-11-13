import path from "node:path";
import { isSafeRelativePosixPath } from "../../shared/src/sdk-types.ts";
import type { Context, GitHub } from "./github.ts";

export const TYPESPEC_REVIEW_CONTEXT_FILE_NAME = "typespec-review-context.json";
export const MAX_TYPESPEC_CONTEXT_FILES = 512;
export const MAX_TYPESPEC_CONTEXT_FILE_BYTES = 1024 * 1024;
export const MAX_TYPESPEC_CONTEXT_TOTAL_BYTES = 8 * 1024 * 1024;
export const MAX_TYPESPEC_CONTEXT_PATCH_BYTES = 512 * 1024;
export const MAX_TYPESPEC_CONTEXT_API_REQUESTS = 500;

const GITHUB_COMPARE_FILES_LIMIT = 300;
const MAX_TYPESPEC_CONTEXT_DIFF_BYTES = 32 * 1024 * 1024;
const TYPESPEC_FILE_PATTERN = /\.tsp$/i;
const TYPESPEC_CONFIG_FILE_NAME = "tspconfig.yaml";
const PROJECT_CONTEXT_FILE_NAMES = [TYPESPEC_CONFIG_FILE_NAME, "main.tsp", "client.tsp"];

export type TypeSpecContextFileRole = "changed" | "client" | "config" | "entrypoint";

export type TypeSpecContextFile = {
  path: string;
  roles: TypeSpecContextFileRole[];
  status?: string;
  previousPath?: string;
  renamedTo?: string;
  patch?: string;
  content?: string;
};

export type TypeSpecReviewContext = {
  schemaVersion: 1;
  source: {
    specPrNumber: number;
    specHeadSha: string;
    specBaseSha: string;
  };
  projects: Array<{
    root: string;
    files: string[];
  }>;
  files: TypeSpecContextFile[];
};

type MutableTypeSpecContextFile = Omit<TypeSpecContextFile, "roles"> & {
  roles: Set<TypeSpecContextFileRole>;
};

type ChangedFile = {
  filename: string;
  previous_filename?: string;
  status: string;
  patch?: string;
};

function isNotFoundError(error: unknown): boolean {
  return (
    typeof error === "object" &&
    error !== null &&
    "status" in error &&
    (error as { status?: unknown }).status === 404
  );
}

function isTypeSpecContextPath(filePath: string | undefined): boolean {
  return (
    typeof filePath === "string" &&
    filePath.startsWith("specification/") &&
    (TYPESPEC_FILE_PATTERN.test(filePath) ||
      path.posix.basename(filePath) === TYPESPEC_CONFIG_FILE_NAME)
  );
}

function requireSafeContextPath(filePath: string): string {
  if (!isSafeRelativePosixPath(filePath) || !filePath.startsWith("specification/")) {
    throw new Error(`Invalid TypeSpec context path '${filePath}'`);
  }
  return filePath;
}

function requireSafePreviousPath(filePath: string): string {
  if (!isSafeRelativePosixPath(filePath)) {
    throw new Error(`Invalid previous TypeSpec context path '${filePath}'`);
  }
  return filePath;
}

function getFileRole(filePath: string): TypeSpecContextFileRole {
  const fileName = path.posix.basename(filePath);
  if (fileName === TYPESPEC_CONFIG_FILE_NAME) {
    return "config";
  }
  if (fileName === "client.tsp") {
    return "client";
  }
  return "entrypoint";
}

function getChangedTypeSpecPath(file: {
  filename: string;
  previous_filename?: string;
}): string | undefined {
  if (isTypeSpecContextPath(file.filename)) {
    return file.filename;
  }
  if (isTypeSpecContextPath(file.previous_filename)) {
    return file.previous_filename;
  }
  return undefined;
}

function decodeGitPath(value: string): string {
  if (!value.startsWith('"')) {
    return value;
  }
  if (!value.endsWith('"')) {
    throw new Error(`Invalid quoted path in immutable comparison: ${value}`);
  }

  const bytes: number[] = [];
  const content = value.slice(1, -1);
  const escapes: Record<string, number> = {
    a: 0x07,
    b: 0x08,
    t: 0x09,
    n: 0x0a,
    v: 0x0b,
    f: 0x0c,
    r: 0x0d,
    '"': 0x22,
    "\\": 0x5c,
  };
  for (let index = 0; index < content.length; index += 1) {
    const character = content[index];
    if (character !== "\\") {
      const codePoint = content.codePointAt(index)!;
      bytes.push(...Buffer.from(String.fromCodePoint(codePoint)));
      if (codePoint > 0xffff) {
        index += 1;
      }
      continue;
    }

    const escaped = content[++index];
    if (escaped === undefined) {
      throw new Error(`Invalid escape in immutable comparison path: ${value}`);
    }
    if (/[0-7]/.test(escaped)) {
      let octal = escaped;
      while (octal.length < 3 && /[0-7]/.test(content[index + 1] ?? "")) {
        octal += content[++index];
      }
      const byte = Number.parseInt(octal, 8);
      if (byte > 0xff) {
        throw new Error(`Invalid octal escape in immutable comparison path: ${value}`);
      }
      bytes.push(byte);
      continue;
    }
    const decoded = escapes[escaped];
    if (decoded === undefined) {
      throw new Error(`Unsupported escape in immutable comparison path: ${value}`);
    }
    bytes.push(decoded);
  }
  return Buffer.from(bytes).toString("utf8");
}

function parseDiffPath(value: string, prefix?: "a/" | "b/"): string | undefined {
  if (value === "/dev/null") {
    return undefined;
  }
  const decoded = decodeGitPath(value);
  if (prefix && !decoded.startsWith(prefix)) {
    throw new Error(`Expected immutable comparison path '${decoded}' to start with '${prefix}'`);
  }
  return prefix ? decoded.slice(prefix.length) : decoded;
}

function getDiffPathValue(value: string): string {
  if (!value.startsWith('"')) {
    return value.split("\t", 1)[0];
  }
  let escaped = false;
  for (let index = 1; index < value.length; index += 1) {
    const character = value[index];
    if (character === '"' && !escaped) {
      return value.slice(0, index + 1);
    }
    escaped = character === "\\" && !escaped;
    if (character !== "\\") {
      escaped = false;
    }
  }
  throw new Error(`Invalid quoted path in immutable comparison: ${value}`);
}

function getDiffMetadataPath(
  section: string,
  marker: string,
  prefix?: "a/" | "b/",
): string | undefined {
  const line = section.split(/\r?\n/).find((candidate) => candidate.startsWith(marker));
  return line === undefined
    ? undefined
    : parseDiffPath(getDiffPathValue(line.slice(marker.length)), prefix);
}

function parseChangedFilesFromDiff(diff: string, expectedFileCount: number): ChangedFile[] {
  if (Buffer.byteLength(diff) > MAX_TYPESPEC_CONTEXT_DIFF_BYTES) {
    throw new Error(`Immutable comparison exceeds ${MAX_TYPESPEC_CONTEXT_DIFF_BYTES} bytes`);
  }
  const sections = diff.split(/(?=^diff --git )/m).filter((section) => section.length > 0);
  if (sections.length !== expectedFileCount) {
    throw new Error(
      `The immutable comparison returned ${sections.length} of ${expectedFileCount} changed files`,
    );
  }

  const changedFiles: ChangedFile[] = [];
  for (const section of sections) {
    const renamedFrom = getDiffMetadataPath(section, "rename from ");
    const renamedTo = getDiffMetadataPath(section, "rename to ");
    const previousPath = renamedFrom ?? getDiffMetadataPath(section, "--- ", "a/");
    const currentPath = renamedTo ?? getDiffMetadataPath(section, "+++ ", "b/");
    const filename = currentPath ?? previousPath;
    if (!isTypeSpecContextPath(previousPath) && !isTypeSpecContextPath(currentPath)) {
      continue;
    }
    if (filename === undefined) {
      throw new Error("TypeSpec comparison entry is missing both file paths");
    }

    const status =
      previousPath === undefined
        ? "added"
        : currentPath === undefined
          ? "removed"
          : previousPath !== currentPath
            ? "renamed"
            : "modified";
    const patchStart = section.search(/^@@ /m);
    changedFiles.push({
      filename,
      previous_filename: status === "renamed" ? previousPath : undefined,
      status,
      patch: patchStart < 0 ? undefined : section.slice(patchStart).trimEnd(),
    });
  }
  return changedFiles;
}

async function getChangedFiles(params: {
  github: GitHub;
  context: Context;
  baseSha: string;
  headSha: string;
  changedFileCount: number;
}): Promise<ChangedFile[]> {
  const { github, context, baseSha, headSha, changedFileCount } = params;
  const basehead = `${baseSha}...${headSha}`;
  if (changedFileCount > GITHUB_COMPARE_FILES_LIMIT) {
    const { data } = await github.request("GET /repos/{owner}/{repo}/compare/{basehead}", {
      owner: context.repo.owner,
      repo: context.repo.repo,
      basehead,
      headers: { accept: "application/vnd.github.diff" },
    });
    if (typeof data !== "string") {
      throw new Error("Expected immutable comparison to return a unified diff");
    }
    return parseChangedFilesFromDiff(data, changedFileCount);
  }

  const { data: comparison } = await github.rest.repos.compareCommitsWithBasehead({
    owner: context.repo.owner,
    repo: context.repo.repo,
    basehead,
  });
  const changedFiles = comparison.files ?? [];
  if (changedFiles.length !== changedFileCount) {
    throw new Error(
      `The exact ${basehead} comparison returned ${changedFiles.length} of ${changedFileCount} changed files`,
    );
  }
  return changedFiles;
}

function calculateContentRequests(
  changedFiles: ChangedFile[],
  projectRoots: readonly string[],
): number {
  const contentPaths = new Set<string>();
  for (const changedFile of changedFiles) {
    if (isTypeSpecContextPath(changedFile.filename) && changedFile.status !== "removed") {
      contentPaths.add(requireSafeContextPath(changedFile.filename));
    }
  }
  for (const projectRoot of projectRoots) {
    for (const fileName of PROJECT_CONTEXT_FILE_NAMES) {
      contentPaths.add(requireSafeContextPath(path.posix.join(projectRoot, fileName)));
    }
  }
  return contentPaths.size;
}

async function fetchRepositoryFile(params: {
  github: GitHub;
  context: Context;
  headSha: string;
  filePath: string;
  requestCount: { value: number };
}): Promise<string | undefined> {
  const { github, context, headSha, filePath, requestCount } = params;
  requestCount.value += 1;
  if (requestCount.value > MAX_TYPESPEC_CONTEXT_API_REQUESTS) {
    throw new Error(
      `TypeSpec context exceeded ${MAX_TYPESPEC_CONTEXT_API_REQUESTS} GitHub content requests`,
    );
  }
  try {
    const { data } = await github.rest.repos.getContent({
      owner: context.repo.owner,
      repo: context.repo.repo,
      path: requireSafeContextPath(filePath),
      ref: headSha,
    });
    if (
      Array.isArray(data) ||
      data.type !== "file" ||
      data.encoding !== "base64" ||
      typeof data.content !== "string"
    ) {
      throw new Error(`Expected '${filePath}' to be a base64-encoded repository file`);
    }
    const content = Buffer.from(data.content.replaceAll("\n", ""), "base64").toString("utf8");
    const contentBytes = Buffer.byteLength(content);
    if (contentBytes > MAX_TYPESPEC_CONTEXT_FILE_BYTES) {
      throw new Error(
        `TypeSpec context file '${filePath}' exceeds ${MAX_TYPESPEC_CONTEXT_FILE_BYTES} bytes`,
      );
    }
    return content;
  } catch (error) {
    if (isNotFoundError(error)) {
      return undefined;
    }
    throw error;
  }
}

/**
 * Collects the reviewed TypeSpec diff and the minimal project files needed to
 * translate generated SDK findings back to TypeSpec or client.tsp guidance.
 */
export async function collectTypeSpecReviewContext(params: {
  github: GitHub;
  context: Context;
  prNumber: number;
  headSha: string;
  baseSha: string;
  changedFileCount: number;
  projectRoots: readonly string[];
}): Promise<TypeSpecReviewContext> {
  const { github, context, prNumber, headSha, baseSha, changedFileCount, projectRoots } = params;
  // Compare immutable commits so patches and file contents describe the same revision.
  const changedFiles = (
    await getChangedFiles({ github, context, baseSha, headSha, changedFileCount })
  ).filter((file) => getChangedTypeSpecPath(file) !== undefined);
  if (changedFiles.length > MAX_TYPESPEC_CONTEXT_FILES) {
    throw new Error(
      `TypeSpec context has ${changedFiles.length} changed files; maximum is ${MAX_TYPESPEC_CONTEXT_FILES}`,
    );
  }
  const safeProjectRoots = [...new Set(projectRoots.map(requireSafeContextPath))].sort();
  const contentRequests = calculateContentRequests(changedFiles, safeProjectRoots);
  if (contentRequests > MAX_TYPESPEC_CONTEXT_API_REQUESTS) {
    throw new Error(
      `TypeSpec context requires ${contentRequests} GitHub content requests; maximum is ${MAX_TYPESPEC_CONTEXT_API_REQUESTS}`,
    );
  }

  const files = new Map<string, MutableTypeSpecContextFile>();
  const contentCache = new Map<string, Promise<string | undefined>>();
  const requestCount = { value: 0 };

  const getContent = (filePath: string): Promise<string | undefined> => {
    const safePath = requireSafeContextPath(filePath);
    const cached = contentCache.get(safePath);
    if (cached) {
      return cached;
    }
    const pending = fetchRepositoryFile({
      github,
      context,
      headSha,
      filePath: safePath,
      requestCount,
    });
    contentCache.set(safePath, pending);
    return pending;
  };

  const addFile = (
    filePath: string,
    role: TypeSpecContextFileRole,
    metadata: Omit<Partial<TypeSpecContextFile>, "path" | "roles"> = {},
  ): void => {
    const safePath = requireSafeContextPath(filePath);
    const existing = files.get(safePath) ?? {
      path: safePath,
      roles: new Set<TypeSpecContextFileRole>(),
    };
    existing.roles.add(role);
    Object.assign(existing, metadata);
    files.set(safePath, existing);
    if (files.size > MAX_TYPESPEC_CONTEXT_FILES) {
      throw new Error(`TypeSpec context exceeds ${MAX_TYPESPEC_CONTEXT_FILES} files`);
    }
  };

  for (const changedFile of changedFiles) {
    const changedPath = getChangedTypeSpecPath(changedFile)!;
    const filePath = requireSafeContextPath(changedPath);
    const remainsTypeSpec = isTypeSpecContextPath(changedFile.filename);
    const status = remainsTypeSpec ? changedFile.status : "removed";
    const patch = changedFile.patch;
    if (patch && Buffer.byteLength(patch) > MAX_TYPESPEC_CONTEXT_PATCH_BYTES) {
      throw new Error(
        `TypeSpec patch for '${filePath}' exceeds ${MAX_TYPESPEC_CONTEXT_PATCH_BYTES} bytes`,
      );
    }
    const content = status === "removed" ? undefined : await getContent(filePath);
    const previousPath =
      remainsTypeSpec && changedFile.previous_filename
        ? requireSafePreviousPath(changedFile.previous_filename)
        : undefined;
    const renamedTo = remainsTypeSpec ? undefined : requireSafePreviousPath(changedFile.filename);
    addFile(filePath, "changed", {
      status,
      previousPath,
      renamedTo,
      patch,
      content,
    });
  }

  const projects = [];
  for (const projectRoot of safeProjectRoots) {
    const projectFiles: string[] = [];
    for (const fileName of PROJECT_CONTEXT_FILE_NAMES) {
      const filePath = path.posix.join(projectRoot, fileName);
      const content = await getContent(filePath);
      if (content === undefined) {
        continue;
      }
      addFile(filePath, getFileRole(filePath), { content });
      projectFiles.push(filePath);
    }
    projects.push({ root: projectRoot, files: projectFiles.sort() });
  }

  const contextFiles = [...files.values()]
    .map((file) => ({ ...file, roles: [...file.roles].sort() }))
    .sort((left, right) => left.path.localeCompare(right.path));
  const totalBytes = contextFiles.reduce(
    (total, file) =>
      total + Buffer.byteLength(file.content ?? "") + Buffer.byteLength(file.patch ?? ""),
    0,
  );
  if (totalBytes > MAX_TYPESPEC_CONTEXT_TOTAL_BYTES) {
    throw new Error(`TypeSpec context exceeds ${MAX_TYPESPEC_CONTEXT_TOTAL_BYTES} bytes`);
  }

  return {
    schemaVersion: 1,
    source: {
      specPrNumber: prNumber,
      specHeadSha: headSha,
      specBaseSha: baseSha,
    },
    projects,
    files: contextFiles,
  };
}
