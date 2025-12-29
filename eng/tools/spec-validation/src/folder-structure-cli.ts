import { globby } from "globby";
import { stat } from "node:fs/promises";
import path from "node:path";
import { parseArgs, ParseArgsConfig } from "node:util";
import { simpleGit } from "simple-git";
import { FolderStructureRule } from "./rules/folder-structure.js";
import { fileExists, normalizePath } from "./utils.js";

// Context argument may add new properties or override checkingAllSpecs
export let context: Record<string, unknown> = { checkingAllSpecs: false };

function looksLikeJsonObject(value: string | undefined): boolean {
  const trimmed = value?.trim();
  return !!trimmed && trimmed.startsWith("{") && trimmed.endsWith("}");
}

function normalizeRel(p: string): string {
  return p.split(path.sep).join("/");
}

function getOrgFromSpecPath(specPath: string): string | undefined {
  const normalized = specPath.replace(/\\/g, "/");
  const parts = normalized.split("/").filter(Boolean);
  if (parts.length < 2) return undefined;
  if (parts[0] !== "specification") return undefined;
  return parts[1];
}

function isV1LikePath(specPath: string): boolean {
  const normalized = specPath.replace(/\\/g, "/");
  const parts = normalized.split("/").filter(Boolean);
  if (parts.length < 3 || parts[0] !== "specification") {
    return false;
  }

  // Files directly under specification/<org>/ are not structure indicators.
  // Examples: suppressions.yaml, cspell.yaml, readme.md.
  if (parts.length === 3) {
    return false;
  }

  const segment2 = parts[2];
  if (segment2 !== "data-plane" && segment2 !== "resource-manager") {
    // v1-style TypeSpec or swagger layout without data-plane/resource-manager.
    // Anything under specification/<org>/<something>/... indicates v1-like structure.
    return true;
  }

  if (segment2 === "data-plane") {
    // data-plane v2: specification/<org>/data-plane/<ServiceName>/...
    // data-plane v1 swagger: specification/<org>/data-plane/<RP.Namespace>/(stable|preview)/...
    const candidate = parts[3];
    const next = parts[4];
    if (candidate && next && (next === "stable" || next === "preview")) {
      // RP namespace typically contains '.', v2 service name must not.
      if (candidate.includes(".")) {
        return true;
      }
    }
    return false;
  }

  // resource-manager
  // v2: specification/<org>/resource-manager/<RP.Namespace>/<ServiceName>/...
  // v1 swagger: specification/<org>/resource-manager/<RP.Namespace>/(stable|preview)/...
  const afterRp = parts[4];
  if (afterRp === "stable" || afterRp === "preview") {
    return true;
  }
  return false;
}

type OrgStructureFlavor = "v1" | "v2" | "mixed" | "unknown";

function detectOrgFlavorFromPaths(paths: string[], org: string): OrgStructureFlavor {
  const prefix = `specification/${org}/`;
  const relevant = paths.map((p) => p.replace(/\\/g, "/")).filter((p) => p.startsWith(prefix));

  if (relevant.length === 0) {
    return "unknown";
  }

  let sawV2 = false;
  let sawV1 = false;

  for (const p of relevant) {
    const parts = p.split("/").filter(Boolean);

    // TypeSpec v2 evidence
    if (
      parts.length >= 5 &&
      parts[2] === "data-plane" &&
      parts[4] === "tspconfig.yaml" &&
      !parts[3].includes(".")
    ) {
      sawV2 = true;
      continue;
    }
    if (parts.length >= 6 && parts[2] === "resource-manager" && parts[5] === "tspconfig.yaml") {
      // spec/org/resource-manager/RP/Service/tspconfig.yaml
      sawV2 = true;
      continue;
    }

    // Swagger v2 evidence
    if (
      parts.length >= 6 &&
      parts[2] === "resource-manager" &&
      (parts[5] === "stable" || parts[5] === "preview")
    ) {
      // spec/org/resource-manager/RP/Service/(stable|preview)/...
      sawV2 = true;
      continue;
    }
    if (
      parts.length >= 5 &&
      parts[2] === "data-plane" &&
      (parts[4] === "stable" || parts[4] === "preview") &&
      !parts[3].includes(".")
    ) {
      // spec/org/data-plane/Service/(stable|preview)/...
      sawV2 = true;
      continue;
    }

    // v1 evidence
    if (isV1LikePath(p)) {
      sawV1 = true;
      continue;
    }
  }

  if (sawV1 && sawV2) return "mixed";
  if (sawV2) return "v2";
  if (sawV1) return "v1";
  return "unknown";
}

function getV1ServiceRootForPath(specPath: string): string | undefined {
  const normalized = specPath.replace(/\\/g, "/");
  const parts = normalized.split("/").filter(Boolean);
  if (parts.length < 4 || parts[0] !== "specification") return undefined;

  const org = parts[1];
  const segment2 = parts[2];

  if (segment2 === "resource-manager" || segment2 === "data-plane") {
    if (parts.length < 4) return undefined;
    const rpOrService = parts[3];
    return `specification/${org}/${segment2}/${rpOrService}`;
  }

  // v1 TypeSpec projects live directly under org: specification/<org>/<PackageFolder>/...
  return `specification/${org}/${segment2}`;
}

async function ensureRemoteBranchRef(
  gitRoot: string,
  remote: string,
  branch: string,
): Promise<string | undefined> {
  const normalizedRemote = remote?.trim() || "origin";
  const normalizedBranch = (branch || "").replace(/^refs\/(heads|remotes)\//, "").trim();
  if (!normalizedBranch) {
    return undefined;
  }

  const git = simpleGit(gitRoot);
  const refName = `refs/remotes/${normalizedRemote}/${normalizedBranch}`;

  const hasRemoteRef = async (): Promise<boolean> => {
    try {
      const output = await git.raw(["for-each-ref", "--format=%(refname)", refName]);
      return typeof output === "string" && output.trim().length > 0;
    } catch {
      return false;
    }
  };

  if (await hasRemoteRef()) {
    return `${normalizedRemote}/${normalizedBranch}`;
  }

  try {
    await git.fetch(normalizedRemote, normalizedBranch, ["--depth=1", "--no-tags"]);
  } catch {
    // ignore
  }

  if (await hasRemoteRef()) {
    return `${normalizedRemote}/${normalizedBranch}`;
  }

  return undefined;
}

function getTargetBranchFromEnv(): string | undefined {
  const githubBaseRef = process.env.GITHUB_BASE_REF;
  if (githubBaseRef) {
    return githubBaseRef;
  }

  const azureDevopsTarget = process.env.SYSTEM_PULLREQUEST_TARGETBRANCH;
  if (azureDevopsTarget) {
    return azureDevopsTarget.replace(/^refs\/(heads|remotes)\//, "");
  }

  return undefined;
}

async function chooseTargetRemote(gitRoot: string): Promise<string> {
  try {
    const remotes = await simpleGit(gitRoot).getRemotes(true);
    const remoteNames = remotes.map((r) => r.name);
    if (remoteNames.includes("upstream")) {
      return "upstream";
    }
  } catch {
    // ignore
  }
  return "origin";
}

async function listSpecFilesOnRef(gitRoot: string, ref: string, org: string): Promise<string[]> {
  const git = simpleGit(gitRoot);
  const out = await git.raw(["ls-tree", "-r", "--name-only", ref, `specification/${org}`]);
  return out
    .split("\n")
    .map((l) => l.trim())
    .filter(Boolean)
    .map((p) => p.replace(/\\/g, "/"));
}

async function listSpecFilesInFolder(gitRoot: string, folderAbs: string): Promise<string[]> {
  const files = await globby(["**/*"], {
    cwd: folderAbs,
    absolute: true,
    onlyFiles: true,
    followSymbolicLinks: false,
    ignore: ["**/node_modules/**", "**/dist/**", "**/.git/**"],
  });
  return files
    .map((f) => normalizeRel(path.relative(gitRoot, f)))
    .map((p) => p.replace(/\\/g, "/"));
}

async function printFolderVersion(gitRoot: string, folderAbs: string): Promise<void> {
  const rel = normalizeRel(path.relative(gitRoot, folderAbs));
  if (!rel.startsWith("specification/")) {
    console.log(`Folder: ${folderAbs}`);
    console.log("Folder structure version: unknown (outside specification/)");
    return;
  }

  const org = getOrgFromSpecPath(rel);
  if (!org) {
    console.log(`Folder: ${folderAbs}`);
    console.log("Folder structure version: unknown");
    return;
  }

  const paths = await listSpecFilesInFolder(gitRoot, folderAbs);
  const flavor = detectOrgFlavorFromPaths(paths, org);
  const versionLabel = flavor;
  console.log(`Folder: ${folderAbs}`);
  console.log(`Org: ${org}`);
  console.log(`Folder structure version: ${versionLabel}`);
}

async function validateNoV1RegressionPerOrg(
  gitRoot: string,
  targetRef: string,
  changedSpecFiles: string[],
): Promise<void> {
  const orgs = new Set<string>();
  for (const f of changedSpecFiles) {
    const org = getOrgFromSpecPath(f);
    if (org) orgs.add(org);
  }

  if (orgs.size === 0) {
    console.log("No changes under specification/.");
    return;
  }

  const violations: Array<{ org: string; files: string[] }> = [];

  for (const org of Array.from(orgs).sort()) {
    const basePaths = await listSpecFilesOnRef(gitRoot, targetRef, org);
    const baseFlavor = detectOrgFlavorFromPaths(basePaths, org);

    const orgChanged = changedSpecFiles.filter((p) => p.startsWith(`specification/${org}/`));
    const v1Like = orgChanged.filter((p) => isV1LikePath(p));
    if (v1Like.length === 0) {
      continue;
    }

    if (baseFlavor === "v2") {
      // Pure v2 orgs must not receive any v1-structured changes.
      violations.push({ org, files: v1Like });
      continue;
    }

    if (baseFlavor === "mixed") {
      // Mixed orgs: allow changes within existing v1 services, but do not allow
      // introducing *new* v1-structured service roots.
      const baseV1ServiceRoots = new Set<string>();
      for (const p of basePaths) {
        if (!isV1LikePath(p)) continue;
        const root = getV1ServiceRootForPath(p);
        if (root) baseV1ServiceRoots.add(root);
      }

      const newV1Roots = v1Like.filter((p) => {
        const root = getV1ServiceRootForPath(p);
        return !!root && !baseV1ServiceRoots.has(root);
      });

      if (newV1Roots.length > 0) {
        violations.push({ org, files: newV1Roots });
      }
    }
  }

  if (violations.length > 0) {
    console.log("Folder structure validation failed.");
    for (const v of violations) {
      console.log(`Org '${v.org}' is v2 on target branch, but PR includes v1-structured changes:`);
      for (const f of v.files.slice(0, 20)) {
        console.log(`  - ${f}`);
      }
      if (v.files.length > 20) {
        console.log(`  ...and ${v.files.length - 20} more`);
      }
    }
    process.exitCode = 1;
  } else {
    console.log("Folder structure validation passed.");
  }
}

export async function mainFolderStructure(): Promise<void> {
  const args = process.argv.slice(2);
  const options = {
    folder: {
      type: "string",
      short: "f",
    },
    context: {
      type: "string",
      short: "c",
    },
    validate: {
      type: "boolean",
    },
  };

  const parsedArgs = parseArgs({ args, options, allowPositionals: true } as ParseArgsConfig);
  const positional0 = parsedArgs.positionals[0];
  const positional1 = parsedArgs.positionals[1];
  const validateFolder = parsedArgs.values.validate === true;

  // Supported invocations:
  // - folder-structure <folder>
  // - folder-structure <folder> '{"checkingAllSpecs":true}'
  // - folder-structure '{"checkingAllSpecs":true}'
  let folderArg: string | undefined;
  let contextArg: string | undefined;

  if (looksLikeJsonObject(positional0)) {
    contextArg = positional0;
  } else {
    folderArg = positional0;
    if (looksLikeJsonObject(positional1)) {
      contextArg = positional1;
    }
  }

  if (contextArg) {
    context = { ...context, ...(JSON.parse(contextArg) as Record<string, unknown>) };
  }

  const folderAbs = normalizePath(path.resolve(folderArg ?? process.cwd()));

  if (!(await fileExists(folderAbs))) {
    console.log(`Folder ${folderAbs} does not exist`);
    process.exit(1);
  }
  if (!(await stat(folderAbs)).isDirectory()) {
    console.log("Please run folder structure validation on a directory path");
    process.exit(1);
  }

  const gitRoot = normalizePath(await simpleGit(folderAbs).revparse(["--show-toplevel"]));

  // Mode 1: folder arg provided.
  // - Default: output the folder structure version.
  // - With --validate: run folder structure validation for that folder.
  if (folderArg) {
    if (!validateFolder) {
      await printFolderVersion(gitRoot, folderAbs);
      return;
    }

    // Ensure FolderStructureRule doesn't self-skip due to lack of diffs.
    process.env.AZURE_SPEC_VALIDATION_FORCE_FOLDER_STRUCTURE = "true";
    const result = await new FolderStructureRule().execute(folderAbs);
    if (result.stdOutput) {
      console.log(result.stdOutput);
    }
    if (!result.success) {
      console.log("Rule FolderStructure failed");
      if (result.errorOutput) {
        console.log(result.errorOutput);
      }
      process.exitCode = 1;
    }
    return;
  }

  const git = simpleGit(gitRoot);

  const targetBranch = getTargetBranchFromEnv() ?? "main";
  const targetRemote = await chooseTargetRemote(gitRoot);
  const targetRef = await ensureRemoteBranchRef(gitRoot, targetRemote, targetBranch);

  if (!targetRef) {
    console.log(
      `Could not resolve base ref ${targetRemote}/${targetBranch}; skipping folder structure validation.`,
    );
    return;
  }

  const diffOutput = await git.raw(["diff", "--name-only", `${targetRef}...HEAD`]);
  const changedFiles = diffOutput
    .split("\n")
    .map((line) => line.trim())
    .filter(Boolean)
    .filter((file) => file.startsWith("specification/"));

  // Mode 2: no folder arg. If running in a PR branch, detect per-org v1 regressions.
  await validateNoV1RegressionPerOrg(gitRoot, targetRef, changedFiles);
}
