import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { inspect } from "node:util";
import { LogIssueType, setVsoVariable, vsoLogIssue } from "./log.ts";
import { type ExecutionReport, type SpecGenSdkCmdInput } from "./types.ts";
import { runCommandWithOutput } from "./utils.ts";

interface PackageApiVersion {
  Version: string;
  Namespace?: string | null;
}

function readApiVersions(filePath: string): PackageApiVersion[] | undefined {
  const packageInfo: unknown = JSON.parse(fs.readFileSync(filePath, "utf8"));
  if (!packageInfo || typeof packageInfo !== "object" || Array.isArray(packageInfo)) {
    throw new TypeError(`Invalid package info in ${filePath}`);
  }
  if (!("ApiVersions" in packageInfo)) {
    return undefined;
  }
  const versions: unknown = packageInfo.ApiVersions;
  if (versions === null || versions === undefined) {
    return undefined;
  }
  if (
    !Array.isArray(versions) ||
    !versions.every(
      (entry: unknown): entry is PackageApiVersion =>
        entry !== null &&
        typeof entry === "object" &&
        "Version" in entry &&
        typeof entry.Version === "string" &&
        entry.Version.trim().length > 0 &&
        (!("Namespace" in entry) ||
          entry.Namespace === null ||
          typeof entry.Namespace === "string"),
    )
  ) {
    throw new TypeError(`Invalid ApiVersions in ${filePath}`);
  }
  return versions;
}

/**
 * Collect the generated packages' API versions for the SDK pull request description.
 * Metadata failures are warnings so PRs can still be created for failed builds.
 */
export async function getGeneratedSdkApiVersions(
  executionReport: ExecutionReport,
  commandInput: SpecGenSdkCmdInput,
): Promise<string> {
  const versions = new Map<string, { version: string; namespace?: string }>();
  let complete = executionReport.packages.length > 0;
  for (const pkg of executionReport.packages) {
    if (!pkg.packageRootPath) {
      complete = false;
      vsoLogIssue(
        `Cannot collect API versions: no packageRootPath for ${pkg.packageName ?? "unknown package"}`,
        LogIssueType.Warning,
      );
      continue;
    }

    let outputDir: string | undefined;
    try {
      outputDir = fs.mkdtempSync(path.join(os.tmpdir(), "sdk-package-info-"));
      await runCommandWithOutput(process.env.AZSDK || "azsdk", [
        "eng",
        "package-info",
        "--package-path",
        path.resolve(commandInput.localSdkRepoPath, pkg.packageRootPath),
        "--out-dir",
        outputDir,
      ]);
      const files = fs
        .readdirSync(outputDir, { recursive: true, encoding: "utf8" })
        .filter((file) => file.endsWith(".json"));
      if (files.length === 0) {
        throw new Error("azsdk eng package-info did not produce any package info JSON files");
      }
      for (const file of files.sort()) {
        const apiVersions = readApiVersions(path.join(outputDir, file));
        if (!apiVersions) {
          complete = false;
          continue;
        }
        for (const entry of apiVersions) {
          const value = entry.Namespace
            ? `'${entry.Version}' (Namespace: '${entry.Namespace}')`
            : `'${entry.Version}'`;
          versions.set(value, {
            version: entry.Version,
            ...(entry.Namespace ? { namespace: entry.Namespace } : {}),
          });
        }
      }
    } catch (error) {
      complete = false;
      vsoLogIssue(
        `Unable to collect API versions for ${pkg.packageName ?? pkg.packageRootPath}: ${inspect(error)}`,
        LogIssueType.Warning,
      );
    } finally {
      if (outputDir) {
        fs.rmSync(outputDir, { recursive: true, force: true });
      }
    }
  }
  setVsoVariable("GeneratedSDKApiVersionsJson", JSON.stringify([...versions.values()]));
  setVsoVariable("GeneratedSDKApiVersionsComplete", String(complete));
  return versions.size > 0 ? `API Versions: ${[...versions.keys()].join(", ")}` : "";
}
