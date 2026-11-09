import path from "node:path";
import { isSafeRelativePosixPath } from "../../shared/src/sdk-types.ts";
import { PER_PAGE_MAX } from "../../shared/src/github.ts";
import type { Context, GitHub } from "./github.ts";

export const TYPESPEC_REVIEW_CONTEXT_FILE_NAME = "typespec-review-context.json";
export const MAX_TYPESPEC_CONTEXT_FILES = 512;
export const MAX_TYPESPEC_CONTEXT_FILE_BYTES = 1024 * 1024;
export const MAX_TYPESPEC_CONTEXT_TOTAL_BYTES = 8 * 1024 * 1024;
export const MAX_TYPESPEC_CONTEXT_PATCH_BYTES = 512 * 1024;
export const MAX_TYPESPEC_CONTEXT_API_REQUESTS = 500;

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

function getProjectRootCandidates(filePath: string): string[] {
  const candidates: string[] = [];
  let directory = path.posix.dirname(filePath);
  while (directory !== "." && directory.startsWith("specification/")) {
    candidates.push(directory);
    directory = path.posix.dirname(directory);
  }
  return candidates;
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

function calculateMaximumContentRequests(
  changedFiles: Array<{
    filename: string;
    previous_filename?: string;
    status: string;
  }>,
): number {
  const initialPaths = new Set<string>();
  const changedPaths: string[] = [];
  for (const changedFile of changedFiles) {
    const changedPath = getChangedTypeSpecPath(changedFile)!;
    changedPaths.push(changedPath);
    if (isTypeSpecContextPath(changedFile.filename) && changedFile.status !== "removed") {
      initialPaths.add(changedFile.filename);
    }
    for (const candidate of getProjectRootCandidates(changedPath)) {
      initialPaths.add(path.posix.join(candidate, TYPESPEC_CONFIG_FILE_NAME));
    }
  }
  const maximumProjectRoots = Math.min(changedPaths.length, initialPaths.size);
  return initialPaths.size + maximumProjectRoots * 2;
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
}): Promise<TypeSpecReviewContext> {
  const { github, context, prNumber, headSha, baseSha } = params;
  const pullRequestFiles = await github.paginate(github.rest.pulls.listFiles, {
    owner: context.repo.owner,
    repo: context.repo.repo,
    pull_number: prNumber,
    per_page: PER_PAGE_MAX,
  });
  const changedFiles = pullRequestFiles.filter(
    (file) => getChangedTypeSpecPath(file) !== undefined,
  );
  if (changedFiles.length > MAX_TYPESPEC_CONTEXT_FILES) {
    throw new Error(
      `TypeSpec context has ${changedFiles.length} changed files; maximum is ${MAX_TYPESPEC_CONTEXT_FILES}`,
    );
  }
  const maximumContentRequests = calculateMaximumContentRequests(changedFiles);
  if (maximumContentRequests > MAX_TYPESPEC_CONTEXT_API_REQUESTS) {
    throw new Error(
      `TypeSpec context may require ${maximumContentRequests} GitHub content requests; maximum is ${MAX_TYPESPEC_CONTEXT_API_REQUESTS}`,
    );
  }

  const files = new Map<string, MutableTypeSpecContextFile>();
  const contentCache = new Map<string, Promise<string | undefined>>();
  const projectRootCache = new Map<string, Promise<string | undefined>>();
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

  const findProjectRoot = (filePath: string): Promise<string | undefined> => {
    const directory = path.posix.dirname(filePath);
    const cached = projectRootCache.get(directory);
    if (cached) {
      return cached;
    }
    const pending = (async () => {
      for (const candidate of getProjectRootCandidates(filePath)) {
        const configPath = path.posix.join(candidate, TYPESPEC_CONFIG_FILE_NAME);
        if ((await getContent(configPath)) !== undefined) {
          return candidate;
        }
      }
      return undefined;
    })();
    projectRootCache.set(directory, pending);
    return pending;
  };

  const projectRoots = new Set<string>();
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
    const projectRoot = await findProjectRoot(filePath);
    if (projectRoot) {
      projectRoots.add(projectRoot);
    }
  }

  const projects = [];
  for (const projectRoot of [...projectRoots].sort()) {
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
