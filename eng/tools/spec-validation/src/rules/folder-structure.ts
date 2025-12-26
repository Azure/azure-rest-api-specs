import debug from "debug";
import { readFile } from "fs/promises";
import { globby } from "globby";
import path from "path";
import { simpleGit, SimpleGit } from "simple-git";
import { parse as yamlParse } from "yaml";
import { RuleResult } from "../rule-result.js";
import { Rule } from "../rule.js";
import { fileExists, normalizePath, readTspConfig } from "../utils.js";

// Enable simple-git debug logging to improve console output
debug.enable("simple-git");

export class FolderStructureRule implements Rule {
  readonly name = "FolderStructure";
  readonly description = "Verify spec directory's folder structure and naming conventions.";

  private normalizePathSeparators(filePath: string): string {
    return filePath.replace(/\\/g, "/");
  }

  /**
   * Check if there are any changes in the specification folder that would require validation.
   * Only run folder structure validation if there are actual changes in specification/
   */
  private async hasSpecificationFolderChanges(gitRoot: string, folder: string): Promise<boolean> {
    try {
      const git = simpleGit(gitRoot);

      // Get current branch info using git.branch() as requested
      const branchSummary = await git.branch(["-vv"]);
      const currentBranch =
        this.normalizeBranchName(branchSummary.current) ?? branchSummary.current;

      // Get target branch for comparison
      const targetBranch = await this.getTargetBranch(git);
      const targetRemote = await this.getTargetRemote(git);

      if (currentBranch === targetBranch) {
        // We're on the target branch, check for uncommitted changes
        const status = await git.status();
        const specChanges = [
          ...status.modified,
          ...status.not_added,
          ...status.created,
          ...status.deleted,
        ].some((file) => this.normalizePathSeparators(file).startsWith("specification/"));
        return specChanges;
      }

      // Get the diff between current branch and target branch
      try {
        const diffFiles = await git.raw([
          "diff",
          "--name-only",
          `${targetRemote}/${targetBranch}...HEAD`,
        ]);

        const changedFiles = diffFiles
          .trim()
          .split("\n")
          .filter(Boolean)
          .map((file) => this.normalizePathSeparators(file.trim()));
        const hasSpecChanges = changedFiles.some((file) => file.startsWith("specification/"));

        if (hasSpecChanges) {
          console.log(
            `Found changes in specification folder: ${changedFiles
              .filter((f) => f.startsWith("specification/"))
              .slice(0, 5)
              .join(", ")}${changedFiles.length > 5 ? "..." : ""}`,
          );
        }

        return hasSpecChanges;
      } catch {
        // If diff fails, fall back to checking if the current folder is in specification/
        const relativePath = this.normalizePathSeparators(path.relative(gitRoot, folder));
        return relativePath.startsWith("specification/");
      }
    } catch (error) {
      console.log(`Could not check for specification changes: ${String(error)}`);
      // If we can't determine changes, assume validation is needed to be safe
      return true;
    }
  }

  /**
   * Validates that a folder exists.
   */
  private async validateFolderExists(
    folder: string,
  ): Promise<{ success: boolean; errorOutput: string }> {
    if (!(await fileExists(folder))) {
      return {
        success: false,
        errorOutput: `Folder '${folder}' does not exist.\n`,
      };
    }
    return { success: true, errorOutput: "" };
  }

  /**
   * Validates TSP config file naming conventions.
   */
  private async validateTspConfigNaming(
    folder: string,
  ): Promise<{ success: boolean; errorOutput: string; stdOutput: string }> {
    let success = true;
    let errorOutput = "";

    const tspConfigs = await globby([`${folder}/**tspconfig.*`]);
    const stdOutput = `config files: ${JSON.stringify(tspConfigs)}\n`;

    tspConfigs.forEach((file: string) => {
      if (!file.endsWith("tspconfig.yaml")) {
        success = false;
        errorOutput += `Invalid config file '${file}'.  Must be named 'tspconfig.yaml'.\n`;
      }
    });

    return { success, errorOutput, stdOutput };
  }

  /**
   * Determines if a folder is intended to be a TypeSpec project.
   * A folder is considered a TypeSpec project if it has:
   * - tspconfig.yaml file, OR
   * - main.tsp file, OR
   * - client.tsp file
   */
  private async isTypeSpecProject(folder: string, configStdOutput: string): Promise<boolean> {
    // Check if tspconfig files were found
    if (configStdOutput.includes("tspconfig.yaml")) {
      return true;
    }

    // Check for TypeSpec source files
    const mainExists = await fileExists(path.join(folder, "main.tsp"));
    const clientExists = await fileExists(path.join(folder, "client.tsp"));

    return mainExists || clientExists;
  }

  /**
   * Validates required files (main.tsp, client.tsp, examples).
   */
  private async validateRequiredFiles(
    folder: string,
  ): Promise<{ success: boolean; errorOutput: string }> {
    let success = true;
    let errorOutput = "";

    const mainExists = await fileExists(path.join(folder, "main.tsp"));
    const clientExists = await fileExists(path.join(folder, "client.tsp"));

    if (!mainExists && !clientExists) {
      errorOutput += `Invalid folder structure: Spec folder must contain main.tsp or client.tsp.`;
      success = false;
    }

    if (mainExists && !(await fileExists(path.join(folder, "examples")))) {
      errorOutput += `Invalid folder structure: Spec folder with main.tsp must contain examples folder.`;
      success = false;
    }

    return { success, errorOutput };
  }

  /**
   * Validates general folder depth restrictions.
   */
  private validateGeneralDepth(pathSegments: string[]): { success: boolean; errorOutput: string } {
    if (pathSegments.length > 5) {
      return {
        success: false,
        errorOutput: `Please limit TypeSpec folder depth to 5 levels or less (specification/org/type/namespace/service). Current path has ${pathSegments.length} levels.\n`,
      };
    }
    return { success: true, errorOutput: "" };
  }

  /**
   * Validates top-level folder naming (must be lowercase).
   */
  private validateTopLevelFolderNaming(folderStruct: string[]): {
    success: boolean;
    errorOutput: string;
  } {
    if (folderStruct.length < 2) {
      return { success: true, errorOutput: "" };
    }

    if (folderStruct[1].match(/[A-Z]/g)) {
      return {
        success: false,
        errorOutput: `Invalid folder name. Folders under specification/ must be lower case.\n`,
      };
    }
    return { success: true, errorOutput: "" };
  }

  /**
   * Validates import restrictions (files can only import from same service folder).
   */
  private async validateImportRestrictions(
    gitRoot: string,
    folderStruct: string[],
    structureVersion: number,
    folder: string,
  ): Promise<{ success: boolean; errorOutput: string; stdOutput: string }> {
    let success = true;
    let errorOutput = "";
    let stdOutput = "imports:\n";

    const allowedImportRoot =
      structureVersion === 1 ? path.join(...folderStruct.slice(0, 2)) : folder;
    stdOutput += `  ${allowedImportRoot}\n`;

    const allowedImportRootResolved = path.resolve(gitRoot, allowedImportRoot);
    const tsps = await globby("**/*.tsp", { cwd: allowedImportRootResolved });

    for (const tsp of tsps) {
      const tspResolved = path.resolve(allowedImportRootResolved, tsp);

      const pattern = /^\s*import\s+['"]([^'"]+)['"]\s*;\s*$/gm;
      const text = await readFile(tspResolved, { encoding: "utf8" });
      const imports = [...text.matchAll(pattern)].map((m) => m[1]);

      const fileImports = imports.filter(
        (i) => i.startsWith("./") || i.startsWith("../") || path.isAbsolute(i),
      );

      stdOutput += `    ${tsp}: ${JSON.stringify(fileImports)}\n`;

      for (const fileImport of fileImports) {
        const fileImportResolved = path.resolve(path.dirname(tspResolved), fileImport);
        const relative = path.relative(allowedImportRootResolved, fileImportResolved);

        if (relative.startsWith("..")) {
          errorOutput +=
            `Invalid folder structure: '${tsp}' imports '${fileImport}', ` +
            `which is outside '${path.relative(gitRoot, allowedImportRoot)}'`;
          success = false;
        }
      }
    }

    return { success, errorOutput, stdOutput };
  }

  /**
   * Validates V1 folder structure rules.
   */
  private async validateV1Structure(
    folder: string,
    folderStruct: string[],
    isTypeSpecProject: boolean,
  ): Promise<{ success: boolean; errorOutput: string; stdOutput: string }> {
    let success = true;
    let errorOutput = "";
    let stdOutput = "";

    const packageFolder = folderStruct[folderStruct.length - 1];
    const tspConfigExists = await fileExists(path.join(folder, "tspconfig.yaml"));

    // Verify package folder is at most 3 levels deep (for v1 specifically)
    if (folderStruct.length > 4) {
      success = false;
      errorOutput += `Please limit TypeSpec folder depth to 3 levels or less for v1 structure (specification/service/package)`;
    }

    // Check for reserved folder names at second level (after specification/orgName)
    if (folderStruct.length >= 3) {
      const secondLevelFolder = folderStruct[2];
      if (secondLevelFolder === "data-plane" || secondLevelFolder === "resource-manager") {
        success = false;
        errorOutput += `Invalid folder name. '${secondLevelFolder}' does not match regex for package folders.\n`;
      }
    } // Verify second level folder is capitalized after each '.'
    if (/(^|\. *)([a-z])/g.test(packageFolder)) {
      success = false;
      errorOutput += `Invalid folder name. Folders under specification/${folderStruct[1]} must be capitalized after each '.'\n`;
    }

    // Verify 'Shared' follows 'Management'
    if (packageFolder.includes("Management") && packageFolder.includes("Shared")) {
      if (!packageFolder.includes("Management.Shared")) {
        success = false;
        errorOutput += `Invalid folder name. For management libraries with a shared component, 'Shared' should follow 'Management'.`;
      }
    }

    if (!packageFolder.includes("Shared") && !tspConfigExists && isTypeSpecProject) {
      errorOutput += `Invalid folder structure: Spec folder must contain tspconfig.yaml.`;
      success = false;
    }

    if (tspConfigExists) {
      const configText = await readTspConfig(folder);
      const config = yamlParse(configText) as Record<string, unknown>;
      const options = config?.options as Record<string, unknown> | undefined;
      const autorestConfig = options?.["@azure-tools/typespec-autorest"] as
        | Record<string, unknown>
        | undefined;
      const rpFolder = autorestConfig?.["azure-resource-provider-folder"] as string | undefined;
      stdOutput += `azure-resource-provider-folder: ${JSON.stringify(rpFolder)}\n`;

      if (
        typeof rpFolder === "string" &&
        rpFolder.trim().endsWith("resource-manager") &&
        !packageFolder.endsWith(".Management")
      ) {
        errorOutput += `Invalid folder structure: TypeSpec for resource-manager specs must be in a folder ending with '.Management'`;
        success = false;
      } else if (
        (typeof rpFolder !== "string" || !rpFolder.trim().endsWith("resource-manager")) &&
        packageFolder.endsWith(".Management")
      ) {
        errorOutput += `Invalid folder structure: TypeSpec for data-plane specs or shared code must be in a folder NOT ending with '.Management'`;
        success = false;
      }
    }

    return { success, errorOutput, stdOutput };
  }

  /**
   * Determines structure version (1 or 2) based on analyzing all files in the folder.
   *
   * The logic analyzes actual file locations:
   * - For TypeSpec files: V2 requires main.tsp/client.tsp/tspconfig.yaml in serviceName folder
   *   * Data-plane V2: specification/{orgName}/data-plane/{serviceName}/ <- files here
   *   * Resource-manager V2: specification/{orgName}/resource-manager/{rpNamespace}/{serviceName}/ <- files here
   *
   * - For Swagger files: V2 requires stable/preview folders in serviceName folder
   *   * Data-plane V2: specification/{orgName}/data-plane/{serviceName}/stable|preview/ <- files here
   *   * Resource-manager V2: specification/{orgName}/resource-manager/{rpNamespace}/{serviceName}/stable|preview/ <- files here
   *
   * V1 structure: everything else, including Swagger organized as:
   *   * specification/{org}/data-plane/{RP.Namespace}/stable/{version}/ <- files here
   *   * specification/{org}/resource-manager/{RP.Namespace}/stable/{version}/ <- files here
   */
  private async determineStructureVersion(folder: string, pathSegments: string[]): Promise<number> {
    const hasDataPlane = pathSegments.includes("data-plane");
    const hasResourceManager = pathSegments.includes("resource-manager");

    // If current folder doesn't have data-plane or resource-manager, it's V1
    if (!hasDataPlane && !hasResourceManager) {
      return 1;
    }

    try {
      const gitRoot = normalizePath(await simpleGit(folder).revparse("--show-toplevel"));

      // Check TypeSpec files first
      const typespecFiles = await globby(["**/*.tsp", "**/tspconfig.yaml"], { cwd: folder });
      for (const typespecFile of typespecFiles) {
        const fullPath = path.join(folder, typespecFile);
        const relativePath = path.relative(gitRoot, fullPath).split(path.sep).join("/");
        const filePathSegments = relativePath.split("/");

        // Check if this TypeSpec file follows V2 pattern
        if (hasDataPlane) {
          const dataPlaneIndex = filePathSegments.indexOf("data-plane");
          if (dataPlaneIndex === 2) {
            // V2 data-plane: specification/{orgName}/data-plane/{serviceName}/ <- TypeSpec files here
            if (filePathSegments.length === dataPlaneIndex + 3) {
              // serviceName/file.tsp
              return 2;
            }
          }
        } else if (hasResourceManager) {
          const resourceManagerIndex = filePathSegments.indexOf("resource-manager");
          if (resourceManagerIndex === 2) {
            // V2 resource-manager: specification/{orgName}/resource-manager/{rpNamespace}/{serviceName}/ <- TypeSpec files here
            if (filePathSegments.length === resourceManagerIndex + 4) {
              // rpNamespace/serviceName/file.tsp
              return 2;
            }
          }
        }
      }

      // Check Swagger/JSON files
      const jsonFiles = await globby(["**/*.json"], { cwd: folder });
      for (const jsonFile of jsonFiles) {
        const fullPath = path.join(folder, jsonFile);
        const relativePath = path.relative(gitRoot, fullPath).split(path.sep).join("/");
        const filePathSegments = relativePath.split("/");

        // Check if this JSON file follows V2 pattern
        if (hasDataPlane) {
          const dataPlaneIndex = filePathSegments.indexOf("data-plane");
          if (dataPlaneIndex === 2) {
            // V2 data-plane: specification/{orgName}/data-plane/{serviceName}/stable|preview/{version}/ <- JSON files here
            const versionTypeIndex = dataPlaneIndex + 2; // stable or preview
            if (
              filePathSegments.length >= versionTypeIndex + 2 && // serviceName/stable|preview/version/...
              filePathSegments[versionTypeIndex].match(/^(stable|preview)$/)
            ) {
              return 2;
            }

            // Also check for V1 swagger pattern: specification/{org}/data-plane/{RP.Namespace}/stable/{version}/
            // In V1, the RP.Namespace is at the service position and stable comes right after
            if (
              filePathSegments.length >= versionTypeIndex + 3 && // RP.Namespace/stable/version/...
              filePathSegments[versionTypeIndex].match(/^(stable|preview)$/)
            ) {
              return 1; // This is V1 swagger structure
            }
          }
        } else if (hasResourceManager) {
          const resourceManagerIndex = filePathSegments.indexOf("resource-manager");
          if (resourceManagerIndex === 2) {
            // V2 resource-manager: specification/{orgName}/resource-manager/{rpNamespace}/{serviceName}/stable|preview/{version}/ <- JSON files here
            const versionTypeIndex = resourceManagerIndex + 3; // stable or preview
            if (
              filePathSegments.length >= versionTypeIndex + 2 && // serviceName/stable|preview/version/...
              filePathSegments[versionTypeIndex].match(/^(stable|preview)$/)
            ) {
              return 2;
            }

            // Also check for V1 swagger pattern: specification/{org}/resource-manager/{RP.Namespace}/stable/{version}/
            // In V1, the RP.Namespace is at rpNamespace position and stable comes right after
            const potentialStableIndex = resourceManagerIndex + 2;
            if (
              filePathSegments.length >= potentialStableIndex + 3 && // RP.Namespace/stable/version/...
              filePathSegments[potentialStableIndex].match(/^(stable|preview)$/)
            ) {
              return 1; // This is V1 swagger structure
            }
          }
        }
      }
    } catch (error) {
      // If we can't analyze files, fall back to folder-based detection
      console.warn(`Could not analyze files for structure detection: ${String(error)}`);
    }

    // If we found data-plane or resource-manager in path but couldn't determine from files,
    // check the current folder path structure for validation purposes
    if (hasDataPlane) {
      const dataPlaneIndex = pathSegments.indexOf("data-plane");
      if (dataPlaneIndex === 2) {
        return 2; // Treat as V2 for validation
      }
    } else if (hasResourceManager) {
      const resourceManagerIndex = pathSegments.indexOf("resource-manager");
      if (resourceManagerIndex === 2) {
        return 2; // Treat as V2 for validation
      }
    }

    return 1; // default to v1
  }

  /**
   * Determines the target branch for the current PR/branch.
   *
   * @param git The simple-git instance
   * @returns Promise<string> The target branch name
   */
  private normalizeBranchName(branch?: string | null): string | undefined {
    if (!branch) {
      return undefined;
    }

    let normalized = branch.trim();
    if (!normalized) {
      return undefined;
    }

    const patterns = [/^refs\/(heads|remotes)\//i, /^remotes\//i];

    let previous: string;
    do {
      previous = normalized;
      for (const pattern of patterns) {
        normalized = normalized.replace(pattern, "");
      }
      normalized = normalized.replace(/^(origin|upstream)\//i, "");
    } while (normalized !== previous);

    normalized = normalized.replace(/^\/+/, "").replace(/\/+$/, "");

    return normalized || undefined;
  }

  private async getTargetBranch(git: SimpleGit): Promise<string> {
    try {
      // Method 1: Check if we're in a GitHub Actions environment
      const githubBaseRef = this.normalizeBranchName(process.env.GITHUB_BASE_REF);
      if (githubBaseRef) {
        return githubBaseRef;
      }

      // Method 2: Check if we're in an Azure DevOps environment
      const adoTargetBranch = this.normalizeBranchName(process.env.SYSTEM_PULLREQUEST_TARGETBRANCH);
      if (adoTargetBranch) {
        return adoTargetBranch;
      }

      // Method 3: Try to get target branch from GitHub CLI
      try {
        const ghOutput = await git.raw(["config", "--get", "remote.origin.url"]);
        if (typeof ghOutput === "string" && ghOutput.includes("github.com")) {
          // Try to use gh CLI if available
          const { execSync } = await import("child_process");
          const prInfo = execSync("gh pr view --json baseRefName", {
            encoding: "utf8",
            cwd: (git as SimpleGit & { _baseDir: string })._baseDir,
          });
          const prData = JSON.parse(String(prInfo)) as { baseRefName?: string };
          const normalizedBase = this.normalizeBranchName(prData.baseRefName);
          if (normalizedBase) {
            return normalizedBase;
          }
        }
      } catch {
        // GitHub CLI not available or not in a PR, continue with other methods
      }

      // Method 4: Use merge-base to find common ancestor with common default branches
      // Try with different remotes (upstream first, then origin)
      const remotes = ["upstream", "origin"];
      const commonBranches = ["main", "master", "develop"];

      for (const remote of remotes) {
        for (const branch of commonBranches) {
          try {
            await git.raw(["merge-base", "HEAD", `${remote}/${branch}`]);
            console.log(`Found target branch from merge-base: ${remote}/${branch}`);
            return branch;
          } catch {
            // Branch doesn't exist or no common ancestor, try next
          }
        }
      }

      // Method 5: Fallback to main
      console.log("Using fallback target branch: main");
      const fallbackBranch = this.normalizeBranchName("main") ?? "main";
      return fallbackBranch;
    } catch {
      // Fallback to main if all methods fail
      console.log("Error determining target branch, using fallback: main");
      return "main";
    }
  }

  /**
   * Determines the appropriate remote to use for target branch lookup.
   * In forked repositories, the target branch is usually in the upstream remote.
   *
   * @param git The simple-git instance
   * @returns Promise<string> The remote name to use (upstream, origin, etc.)
   */
  private async getTargetRemote(git: SimpleGit): Promise<string> {
    try {
      // Get all remotes
      const remotes = (await git.getRemotes(true)) as Array<{
        name: string;
        refs: { fetch: string };
      }>;

      // Look for upstream remote first (common in forks)
      const upstreamRemote = remotes.find((remote) => remote.name === "upstream");
      if (upstreamRemote) {
        return "upstream";
      }

      // Look for a remote pointing to Azure/azure-rest-api-specs
      const azureRemote = remotes.find((remote) =>
        remote.refs.fetch.includes("Azure/azure-rest-api-specs"),
      );
      if (azureRemote) {
        return azureRemote.name;
      }

      // Fallback to origin

      return "origin";
    } catch {
      return "origin";
    }
  }

  /**
   * Determines if v2 folder structure compliance should be enforced.
   *
   * This method checks if the target branch already has v2-compliant folder structures.
   * If the target branch is already using v2 structure, then all new changes must also comply with v2.
   *
   * When v2 compliance is enforced, new specifications must use the v2 folder structure:
   * - Data-plane: specification/service/data-plane/ServiceName
   * - Resource-manager: specification/service/resource-manager/Microsoft.ServiceName/ServiceName
   *
   * @param gitRoot The git repository root path
   * @param folder The folder being validated
   * @returns Promise<{shouldEnforce: boolean, validationResult?: {success: boolean, errorOutput: string}}>
   *   shouldEnforce: true if v2 compliance should be enforced
   *   validationResult: validation result if enforcement is needed, undefined otherwise
   */
  private async shouldEnforceV2Compliance(
    gitRoot: string,
    folder: string,
  ): Promise<{
    shouldEnforce: boolean;
    validationResult?: { success: boolean; errorOutput: string };
  }> {
    try {
      const git = simpleGit(gitRoot);

      // Get current branch info using git.branch() as requested
      const branchSummary = await git.branch(["-vv"]);
      const currentBranch =
        this.normalizeBranchName(branchSummary.current) ?? branchSummary.current;

      // Get the actual target branch and remote
      const targetBranch = await this.getTargetBranch(git);
      const targetRemote = await this.getTargetRemote(git);

      // Don't enforce if we're already on the target branch
      if (currentBranch === targetBranch) {
        return { shouldEnforce: false };
      }

      // Get service directory relative to specification folder
      const relativePath = this.normalizePathSeparators(path.relative(gitRoot, folder));
      const folderStruct = relativePath.split("/").filter(Boolean);
      if (folderStruct.length < 2 || folderStruct[0] !== "specification") {
        return { shouldEnforce: false };
      }

      const currentStructureVersion = await this.determineStructureVersion(folder, folderStruct);

      const serviceFolderStructForLookup =
        (await this.getServiceFolderStructFromChanges(
          git,
          targetRemote,
          targetBranch,
          folderStruct,
        )) || folderStruct;

      // Identify if this service already exists in the target branch and capture its folder structure
      const targetServiceFolderStruct = await this.findExistingServiceFolderStruct(
        git,
        targetRemote,
        targetBranch,
        serviceFolderStructForLookup,
      );

      if (!targetServiceFolderStruct) {
        // New service - must follow v2 structure
        const validationResult = this.validateV2Compliance(folderStruct);
        return { shouldEnforce: true, validationResult };
      }

      const targetStructureVersion =
        this.getStructureVersionFromFolderStruct(targetServiceFolderStruct);

      if (targetStructureVersion === 1 && currentStructureVersion === 2) {
        if (!this.isCompleteV2Structure(folderStruct)) {
          return { shouldEnforce: false };
        }
        return {
          shouldEnforce: true,
          validationResult: {
            success: false,
            errorOutput:
              `Invalid folder structure: The target branch uses v1 structure, but this PR is trying to add v2 structure. ` +
              `Please complete the migration by moving existing files to the v2 layout instead of mixing structures.\n`,
          },
        };
      }

      // we don't block new PRs to use v2 if the target branch is still v1
      if (targetStructureVersion === 2 || currentStructureVersion === 2) {
        const validationResult = this.validateV2Compliance(folderStruct);
        return { shouldEnforce: true, validationResult };
      }

      return { shouldEnforce: false };
    } catch {
      // If git operations fail, don't enforce v2 compliance

      return { shouldEnforce: false };
    }
  }

  private getStructureVersionFromFolderStruct(folderStruct: string[]): number {
    const hasDataPlane = folderStruct.includes("data-plane");
    const hasResourceManager = folderStruct.includes("resource-manager");
    if (hasDataPlane || hasResourceManager) {
      return 2;
    }
    return 1;
  }

  private isCompleteV2Structure(folderStruct: string[]): boolean {
    const dataPlaneIndex = folderStruct.indexOf("data-plane");
    if (dataPlaneIndex !== -1) {
      return folderStruct.length === dataPlaneIndex + 2;
    }

    const resourceManagerIndex = folderStruct.indexOf("resource-manager");
    if (resourceManagerIndex !== -1) {
      return folderStruct.length === resourceManagerIndex + 3;
    }

    return false;
  }

  private async getServiceFolderStructFromChanges(
    git: SimpleGit,
    remote: string,
    branch: string,
    folderStruct: string[],
  ): Promise<string[] | undefined> {
    try {
      const diffOutput = await git.raw(["diff", "--name-only", `${remote}/${branch}...HEAD`]);

      const specificationFiles = diffOutput
        .trim()
        .split("\n")
        .map((file) => file.trim())
        .filter((file) => file.startsWith("specification/"));

      if (specificationFiles.length === 0) {
        return undefined;
      }

      const folderPath = folderStruct.join("/");
      const matchingFiles = specificationFiles.filter((file) => file.startsWith(folderPath));
      const searchFiles = matchingFiles.length > 0 ? matchingFiles : specificationFiles;

      for (const file of searchFiles) {
        const pathSegments = file.split("/").filter(Boolean);
        const serviceStruct = this.extractServiceFolderStructFromPath(pathSegments);
        if (serviceStruct) {
          return serviceStruct;
        }
      }
    } catch {
      // Ignore errors and fall back to folderStruct
    }

    return undefined;
  }

  private extractServiceFolderStructFromPath(pathSegments: string[]): string[] | undefined {
    if (pathSegments.length < 3 || pathSegments[0] !== "specification") {
      return undefined;
    }

    const dataPlaneIndex = pathSegments.indexOf("data-plane");
    if (dataPlaneIndex !== -1 && pathSegments.length > dataPlaneIndex + 1) {
      return pathSegments.slice(0, dataPlaneIndex + 2);
    }

    const resourceManagerIndex = pathSegments.indexOf("resource-manager");
    if (resourceManagerIndex !== -1 && pathSegments.length > resourceManagerIndex + 2) {
      return pathSegments.slice(0, resourceManagerIndex + 3);
    }

    if (pathSegments.length >= 4) {
      return pathSegments.slice(0, 3);
    }
    return undefined;
  }

  private getCandidateServicePaths(folderStruct: string[]): string[][] {
    if (folderStruct.length < 3 || folderStruct[0] !== "specification") {
      return [];
    }

    const candidates = new Map<string, string[]>();
    const orgName = folderStruct[1];
    const base = ["specification", orgName];
    const packageFolder = folderStruct[folderStruct.length - 1];
    const dataPlaneIndex = folderStruct.indexOf("data-plane");
    const resourceManagerIndex = folderStruct.indexOf("resource-manager");

    const addCandidate = (segments: string[]) => {
      const key = segments.join("/");
      if (!candidates.has(key)) {
        candidates.set(key, segments);
      }
    };

    if (dataPlaneIndex !== -1 && folderStruct.length > dataPlaneIndex + 1) {
      const serviceName = folderStruct[dataPlaneIndex + 1];
      addCandidate([...base, "data-plane", serviceName]);
      addCandidate([...base, packageFolder]);
      addCandidate([...base, serviceName]);
    } else if (resourceManagerIndex !== -1 && folderStruct.length > resourceManagerIndex + 2) {
      const rpNamespace = folderStruct[resourceManagerIndex + 1];
      const serviceName = folderStruct[resourceManagerIndex + 2];
      addCandidate([...base, "resource-manager", rpNamespace, serviceName]);
      addCandidate([...base, packageFolder]);
      if (serviceName.endsWith("Management")) {
        const baseName = serviceName.replace(/Management$/, "");
        addCandidate([...base, `${baseName}.Management`]);
      }
    } else {
      addCandidate([...base, packageFolder]);
    }

    return Array.from(candidates.values());
  }

  private async findExistingServiceFolderStruct(
    git: SimpleGit,
    remote: string,
    branch: string,
    folderStruct: string[],
  ): Promise<string[] | undefined> {
    const candidates = this.getCandidateServicePaths(folderStruct);

    for (const candidate of candidates) {
      const candidatePath = candidate.join("/");
      try {
        await git.raw(["ls-tree", `${remote}/${branch}:${candidatePath}`]);
        return candidate;
      } catch {
        // Candidate doesn't exist; try the next one
        continue;
      }
    }
    return undefined;
  }

  /**
   * Validates that a folder structure complies with v2 guidelines.
   *
   * This method enforces strict v2 folder structure rules:
   * - Folders must use either data-plane or resource-manager structure
   * - Data-plane folders must be exactly one level under 'data-plane'
   * - Resource-manager folders must be exactly two levels under 'resource-manager'
   * - Service names must use PascalCase with alphanumeric characters only
   * - RP namespace must match the regex /^[A-Za-z0-9\.]+$/
   *
   * @param folderStruct The folder structure array (path segments)
   * @returns Promise<{success: boolean, errorOutput: string}> Validation result
   */
  private validateV2Compliance(folderStruct: string[]): { success: boolean; errorOutput: string } {
    let success = true;
    let errorOutput = "";

    // Check if this folder violates v2 structure guidelines
    const hasDataPlane = folderStruct.includes("data-plane");
    const hasResourceManager = folderStruct.includes("resource-manager");

    if (!hasDataPlane && !hasResourceManager) {
      // This is a v1 structure folder - should be migrated to v2
      success = false;
      errorOutput +=
        `Invalid folder structure: The target branch is already using folder structure v2. ` +
        `New specifications must use v2 structure with either 'data-plane' or 'resource-manager' in the path. ` +
        `Please use a path like 'specification/${folderStruct[1]}/data-plane/ServiceName' or ` +
        `'specification/${folderStruct[1]}/resource-manager/Microsoft.ServiceName/ServiceName'.\n`;
    } else {
      // This is a v2 structure folder - ensure it follows v2 guidelines correctly
      if (hasDataPlane && hasResourceManager) {
        success = false;
        errorOutput += `Invalid folder structure: Path cannot contain both 'data-plane' and 'resource-manager'.\n`;
      } else if (hasDataPlane) {
        // Validate data-plane structure: specification/{orgName}/data-plane/{serviceName}/
        const dataPlaneIndex = folderStruct.indexOf("data-plane");
        if (folderStruct.length !== dataPlaneIndex + 2) {
          success = false;
          errorOutput +=
            `Invalid folder structure: TypeSpec for data-plane specs must be exactly one level under 'data-plane'. ` +
            `Required structure: 'specification/{orgName}/data-plane/{serviceName}/'. ` +
            `Current path has ${folderStruct.length} levels: '${folderStruct.join("/")}'.\n`;
        } else {
          // Validate orgName (must be lowercase)
          const orgName = folderStruct[dataPlaneIndex - 1];
          if (orgName !== orgName.toLowerCase()) {
            success = false;
            errorOutput += `Invalid folder structure: orgName '${orgName}' must be all lowercase.\n`;
          }

          // Validate serviceName (PascalCase, no special characters)
          const serviceFolder = folderStruct[folderStruct.length - 1];
          const serviceRegex = /^[A-Z][A-Za-z0-9]*$/;
          if (!serviceRegex.test(serviceFolder)) {
            success = false;
            errorOutput += `Invalid folder structure: Service folder '${serviceFolder}' must be PascalCase without any special characters (e.g. dot, hyphen, underscore).\n`;
          }
        }
      } else if (hasResourceManager) {
        // Validate resource-manager structure: specification/{orgName}/resource-manager/{rpNamespace}/{serviceName}/
        const resourceManagerIndex = folderStruct.indexOf("resource-manager");
        if (folderStruct.length !== resourceManagerIndex + 3) {
          success = false;
          errorOutput +=
            `Invalid folder structure: TypeSpec for resource-manager specs must be exactly two levels under 'resource-manager'. ` +
            `Required structure: 'specification/{orgName}/resource-manager/{rpNamespace}/{serviceName}/'. ` +
            `Current path has ${folderStruct.length} levels: '${folderStruct.join("/")}'.\n`;
        } else {
          // Validate orgName (must be lowercase)
          const orgName = folderStruct[resourceManagerIndex - 1];
          if (orgName !== orgName.toLowerCase()) {
            success = false;
            errorOutput += `Invalid folder structure: orgName '${orgName}' must be all lowercase.\n`;
          }

          const rpNamespaceFolder = folderStruct[folderStruct.length - 2];
          const serviceFolder = folderStruct[folderStruct.length - 1];

          // Validate rpNamespace (must be A.B format with PascalCase)
          const rpNamespaceRegex = /^[A-Z][A-Za-z0-9]*\.[A-Z][A-Za-z0-9]*$/;
          if (!rpNamespaceRegex.test(rpNamespaceFolder)) {
            success = false;
            errorOutput += `Invalid folder structure: RPNamespace folder '${rpNamespaceFolder}' must be in format 'A.B' where A and B are PascalCase (e.g. 'Microsoft.ServiceName').\n`;
          }

          // Validate serviceName (PascalCase, no special characters)
          const serviceRegex = /^[A-Z][A-Za-z0-9]*$/;
          if (!serviceRegex.test(serviceFolder)) {
            success = false;
            errorOutput += `Invalid folder structure: Service folder '${serviceFolder}' must be PascalCase without any special characters (e.g. dot, hyphen, underscore).\n`;
          }
        }
      }
    }

    return { success, errorOutput };
  }

  async execute(folder: string): Promise<RuleResult> {
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    stdOutput += `folder: ${folder}\n`;

    // 1. Validate folder exists first before any git operations
    const folderExistsResult = await this.validateFolderExists(folder);
    if (!folderExistsResult.success) {
      return {
        success: false,
        errorOutput: folderExistsResult.errorOutput || "",
        stdOutput,
      };
    }

    const gitRoot = normalizePath(await simpleGit(folder).revparse("--show-toplevel"));
    const relativePath = path.relative(gitRoot, folder).split(path.sep).join("/");
    const pathSegments = relativePath.split("/");
    const folderStruct = relativePath.split("/").filter(Boolean);

    // 2. Check if v2 compliance should be enforced FIRST (before other validations)
    const v2ComplianceCheck = await this.shouldEnforceV2Compliance(gitRoot, folder);
    if (v2ComplianceCheck.shouldEnforce && v2ComplianceCheck.validationResult) {
      if (!v2ComplianceCheck.validationResult.success) {
        return {
          success: false,
          stdOutput: stdOutput,
          errorOutput: v2ComplianceCheck.validationResult.errorOutput,
        };
      }
    }

    // 3. Check if there are any changes in specification folder that require remaining validations
    const hasSpecChanges = await this.hasSpecificationFolderChanges(gitRoot, folder);
    if (!hasSpecChanges) {
      return {
        success: true,
        stdOutput:
          stdOutput + "No changes in specification folder, skipping folder structure validation\n",
        errorOutput: "",
      };
    }

    // 4. Validate general depth restrictions
    const depthResult = this.validateGeneralDepth(pathSegments);
    if (!depthResult.success) {
      return {
        success: false,
        stdOutput: stdOutput,
        errorOutput: depthResult.errorOutput,
      };
    }

    // 5. Validate TSP config naming
    const configResult = await this.validateTspConfigNaming(folder);
    success = success && configResult.success;
    errorOutput += configResult.errorOutput;
    stdOutput += configResult.stdOutput;

    // 6. Validate required files (only if this appears to be a TypeSpec project)
    const isTypeSpecProject = await this.isTypeSpecProject(folder, configResult.stdOutput);
    if (isTypeSpecProject) {
      const requiredFilesResult = await this.validateRequiredFiles(folder);
      success = success && requiredFilesResult.success;
      errorOutput += requiredFilesResult.errorOutput;
    }

    // 7. Validate top-level folder naming
    const topLevelResult = this.validateTopLevelFolderNaming(folderStruct);
    success = success && topLevelResult.success;
    errorOutput += topLevelResult.errorOutput;

    // 8. Determine structure version and apply appropriate validation
    const structureVersion = await this.determineStructureVersion(folder, pathSegments);

    // 9. Apply structure-specific validation

    if (structureVersion === 1) {
      const v1Result = await this.validateV1Structure(folder, folderStruct, isTypeSpecProject);
      success = success && v1Result.success;
      errorOutput += v1Result.errorOutput;
      stdOutput += v1Result.stdOutput;
    } else if (structureVersion === 2) {
      // For v2 structure, validate tspconfig.yaml requirement
      const tspConfigExists = await fileExists(path.join(folder, "tspconfig.yaml"));
      if (!tspConfigExists && isTypeSpecProject) {
        success = false;
        errorOutput += `Invalid folder structure: Spec folder must contain tspconfig.yaml.`;
      }

      // Only validate v2 compliance if not already validated in step 2
      if (!v2ComplianceCheck.shouldEnforce) {
        const v2Result = this.validateV2Compliance(folderStruct);
        success = success && v2Result.success;
        errorOutput += v2Result.errorOutput;
      }
    }

    // 9. Validate import restrictions
    const importResult = await this.validateImportRestrictions(
      gitRoot,
      folderStruct,
      structureVersion,
      folder,
    );
    success = success && importResult.success;
    errorOutput += importResult.errorOutput;
    stdOutput += importResult.stdOutput;

    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}
