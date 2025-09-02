import debug from "debug";
import { readFile } from "fs/promises";
import { globby } from "globby";
import path from "path";
import { simpleGit } from "simple-git";
import { parse as yamlParse } from "yaml";
import { RuleResult } from "./rule-result.js";
import { Rule } from "./rule.js";
import { fileExists, normalizePath, readTspConfig } from "./utils.js";

// Enable simple-git debug logging to improve console output
debug.enable("simple-git");

export class FolderStructureRule implements Rule {
  readonly name = "FolderStructure";
  readonly description = "Verify spec directory's folder structure and naming conventions.";

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

    // Verify second level folder is capitalized after each '.'
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

    if (!packageFolder.includes("Shared") && !tspConfigExists) {
      errorOutput += `Invalid folder structure: Spec folder must contain tspconfig.yaml.`;
      success = false;
    }

    if (tspConfigExists) {
      const configText = await readTspConfig(folder);
      const config = yamlParse(configText);
      const rpFolder =
        config?.options?.["@azure-tools/typespec-autorest"]?.["azure-resource-provider-folder"];
      stdOutput += `azure-resource-provider-folder: ${JSON.stringify(rpFolder)}\n`;

      if (
        rpFolder?.trim()?.endsWith("resource-manager") &&
        !packageFolder.endsWith(".Management")
      ) {
        errorOutput += `Invalid folder structure: TypeSpec for resource-manager specs must be in a folder ending with '.Management'`;
        success = false;
      } else if (
        !rpFolder?.trim()?.endsWith("resource-manager") &&
        packageFolder.endsWith(".Management")
      ) {
        errorOutput += `Invalid folder structure: TypeSpec for data-plane specs or shared code must be in a folder NOT ending with '.Management'`;
        success = false;
      }
    }

    return { success, errorOutput, stdOutput };
  }

  /**
   * Validates V2 folder structure rules.
   */
  private async validateV2Structure(
    folder: string,
    folderStruct: string[],
  ): Promise<{ success: boolean; errorOutput: string }> {
    let success = true;
    let errorOutput = "";

    const tspConfigExists = await fileExists(path.join(folder, "tspconfig.yaml"));
    if (!tspConfigExists) {
      errorOutput += `Invalid folder structure: Spec folder must contain tspconfig.yaml.`;
      success = false;
    }

    const specType = folder.includes("data-plane") ? "data-plane" : "resource-manager";

    if (specType === "data-plane") {
      if (folderStruct.length !== 4) {
        errorOutput +=
          "Invalid folder structure: TypeSpec for data-plane specs must be exactly 4 levels deep. Required structure: 'specification/{orgName}/data-plane/{serviceName}/'.";
        success = false;
      } else {
        // Validate orgName (must be lowercase)
        const orgName = folderStruct[1];
        if (orgName !== orgName.toLowerCase()) {
          success = false;
          errorOutput += `Invalid folder structure: orgName '${orgName}' must be all lowercase.`;
        }
      }
    } else if (specType === "resource-manager") {
      if (folderStruct.length !== 5) {
        errorOutput +=
          "Invalid folder structure: TypeSpec for resource-manager specs must be exactly 5 levels deep. Required structure: 'specification/{orgName}/resource-manager/{rpNamespace}/{serviceName}/'.";
        success = false;
      } else {
        // Validate orgName (must be lowercase)
        const orgName = folderStruct[1];
        if (orgName !== orgName.toLowerCase()) {
          success = false;
          errorOutput += `Invalid folder structure: orgName '${orgName}' must be all lowercase.`;
        }

        const rpNamespaceFolder = folderStruct[folderStruct.length - 2];

        // Validate rpNamespace (must be A.B format with PascalCase)
        const rpNamespaceRegex = /^[A-Z][A-Za-z0-9]*\.[A-Z][A-Za-z0-9]*$/;
        if (!rpNamespaceRegex.test(rpNamespaceFolder)) {
          success = false;
          errorOutput += `Invalid folder structure: RPNamespace folder '${rpNamespaceFolder}' must be in format 'A.B' where A and B are PascalCase (e.g. 'Microsoft.ServiceName').`;
        }
      }
    }

    // Validate serviceName (PascalCase, no special characters)
    const serviceRegex = /^[A-Z][A-Za-z0-9]*$/;
    const serviceFolder = folderStruct[folderStruct.length - 1];

    if (!serviceRegex.test(serviceFolder)) {
      success = false;
      errorOutput += `Invalid folder structure: Service folder '${serviceFolder}' must be PascalCase without any special characters (e.g. dot, hyphen, underscore).`;
    }

    return { success, errorOutput };
  }

  /**
   * Determines structure version (1 or 2) based on folder path.
   */
  private determineStructureVersion(pathSegments: string[]): number {
    const hasDataPlane = pathSegments.includes("data-plane");
    const hasResourceManager = pathSegments.includes("resource-manager");

    if (hasDataPlane) {
      const dataPlaneIndex = pathSegments.indexOf("data-plane");
      if (dataPlaneIndex >= 2) {
        return 2;
      }
    } else if (hasResourceManager) {
      const resourceManagerIndex = pathSegments.indexOf("resource-manager");
      if (resourceManagerIndex >= 2) {
        return 2;
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
  private async getTargetBranch(git: any): Promise<string> {
    try {
      // Method 1: Check if we're in a GitHub Actions environment
      if (process.env.GITHUB_BASE_REF) {
        console.log(`Found target branch from GITHUB_BASE_REF: ${process.env.GITHUB_BASE_REF}`);
        return process.env.GITHUB_BASE_REF;
      }

      // Method 2: Check if we're in an Azure DevOps environment
      if (process.env.SYSTEM_PULLREQUEST_TARGETBRANCH) {
        console.log(
          `Found target branch from SYSTEM_PULLREQUEST_TARGETBRANCH: ${process.env.SYSTEM_PULLREQUEST_TARGETBRANCH}`,
        );
        return process.env.SYSTEM_PULLREQUEST_TARGETBRANCH;
      }

      // Method 3: Try to get target branch from GitHub CLI
      try {
        const ghOutput = await git.raw(["config", "--get", "remote.origin.url"]);
        if (ghOutput.includes("github.com")) {
          // Try to use gh CLI if available
          const { execSync } = require("child_process");
          const prInfo = execSync("gh pr view --json baseRefName", {
            encoding: "utf8",
            cwd: git._baseDir,
          });
          const prData = JSON.parse(prInfo);
          if (prData.baseRefName) {
            console.log(`Found target branch from GitHub CLI: ${prData.baseRefName}`);
            return prData.baseRefName;
          }
        }
      } catch (error) {
        // GitHub CLI not available or not in a PR, continue with other methods
        console.log("GitHub CLI not available or not in a PR context");
      }

      // Method 4: Find the remote tracking branch
      const branchInfo = await git.branch(["-vv"]);
      const currentBranch = branchInfo.current;

      // Parse the verbose branch output to find upstream
      const branches = branchInfo.all;
      for (const branch of branches) {
        if (branch.name === currentBranch && branch.upstream) {
          // Extract the remote branch name (e.g., "origin/main" -> "main")
          const upstream = branch.upstream.split("/");
          if (upstream.length > 1) {
            const targetBranch = upstream.slice(1).join("/");
            console.log(`Found target branch from upstream tracking: ${targetBranch}`);
            return targetBranch;
          }
        }
      }

      // Method 5: Use merge-base to find common ancestor with common default branches
      // Try with different remotes (upstream first, then origin)
      const remotes = ["upstream", "origin"];
      const commonBranches = ["main", "master", "develop"];

      for (const remote of remotes) {
        for (const branch of commonBranches) {
          try {
            await git.raw(["merge-base", "HEAD", `${remote}/${branch}`]);
            console.log(`Found target branch from merge-base: ${remote}/${branch}`);
            return branch;
          } catch (error) {
            // Branch doesn't exist or no common ancestor, try next
          }
        }
      }

      // Method 6: Fallback to main
      console.log("Using fallback target branch: main");
      return "main";
    } catch (error) {
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
  private async getTargetRemote(git: any): Promise<string> {
    try {
      // Get all remotes
      const remotes = await git.getRemotes(true);

      // Look for upstream remote first (common in forks)
      const upstreamRemote = remotes.find((remote: any) => remote.name === "upstream");
      if (upstreamRemote) {
        console.log(`Using upstream remote: ${upstreamRemote.refs.fetch}`);
        return "upstream";
      }

      // Look for a remote pointing to Azure/azure-rest-api-specs
      const azureRemote = remotes.find((remote: any) =>
        remote.refs.fetch.includes("Azure/azure-rest-api-specs"),
      );
      if (azureRemote) {
        console.log(`Using Azure remote '${azureRemote.name}': ${azureRemote.refs.fetch}`);
        return azureRemote.name;
      }

      // Fallback to origin
      console.log("Using origin remote");
      return "origin";
    } catch (error) {
      console.log("Error determining remote, using origin");
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
   * @returns Promise<boolean> True if v2 compliance should be enforced
   */
  private async shouldEnforceV2Compliance(gitRoot: string, folder: string): Promise<boolean> {
    try {
      const git = simpleGit(gitRoot);

      // Get current branch info
      const branchInfo = await git.branch();
      const currentBranch = branchInfo.current;

      // Get the actual target branch and remote
      const targetBranch = await this.getTargetBranch(git);
      const targetRemote = await this.getTargetRemote(git);

      // Don't enforce if we're already on the target branch
      if (currentBranch === targetBranch) {
        return false;
      }

      // Get service directory relative to specification folder
      const folderStruct = folder.split(path.sep);
      const specIndex = folderStruct.indexOf("specification");
      if (specIndex === -1 || specIndex + 1 >= folderStruct.length) {
        return false;
      }

      const serviceDir = `specification/${folderStruct[specIndex + 1]}`;

      // Check if target branch uses v2 structure by listing directories
      // Use the appropriate remote (upstream for forks, origin for direct repos)
      const output = await git.raw([
        "ls-tree",
        "-d",
        "--name-only",
        `${targetRemote}/${targetBranch}:${serviceDir}`,
      ]);

      const directories = output
        .trim()
        .split("\n")
        .filter((dir) => dir.trim());
      const hasV2Structure = directories.some(
        (dir) => dir.trim() === "data-plane" || dir.trim() === "resource-manager",
      );

      console.log(`Target branch ${targetRemote}/${targetBranch} v2 structure: ${hasV2Structure}`);
      return hasV2Structure;
    } catch (error) {
      // If git operations fail, don't enforce v2 compliance
      console.log(`Error checking v2 compliance: ${error}`);
      return false;
    }
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
  private async validateV2Compliance(
    folderStruct: string[],
  ): Promise<{ success: boolean; errorOutput: string }> {
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
            `Invalid folder structure: TypeSpec for data-plane specs must be exactly 4 levels deep. ` +
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
            `Invalid folder structure: TypeSpec for resource-manager specs must be exactly 5 levels deep. ` +
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

    // 2. Validate general depth restrictions
    const depthResult = this.validateGeneralDepth(pathSegments);
    if (!depthResult.success) {
      return {
        success: false,
        stdOutput: stdOutput,
        errorOutput: depthResult.errorOutput,
      };
    }

    // 3. Validate TSP config naming
    const configResult = await this.validateTspConfigNaming(folder);
    success = success && configResult.success;
    errorOutput += configResult.errorOutput;
    stdOutput += configResult.stdOutput;

    // 4. Validate required files
    const requiredFilesResult = await this.validateRequiredFiles(folder);
    success = success && requiredFilesResult.success;
    errorOutput += requiredFilesResult.errorOutput;

    // 5. Validate top-level folder naming
    const topLevelResult = this.validateTopLevelFolderNaming(folderStruct);
    success = success && topLevelResult.success;
    errorOutput += topLevelResult.errorOutput;

    // 6. Determine structure version and apply appropriate validation
    const structureVersion = this.determineStructureVersion(pathSegments);

    // 7. Check if v2 compliance should be enforced
    const shouldEnforceV2 = await this.shouldEnforceV2Compliance(gitRoot, folder);
    if (shouldEnforceV2) {
      const v2Validation = await this.validateV2Compliance(folderStruct);
      if (!v2Validation.success) {
        success = false;
        errorOutput += v2Validation.errorOutput;
      }
    }

    // 8. Apply structure-specific validation
    if (structureVersion === 1) {
      const v1Result = await this.validateV1Structure(folder, folderStruct);
      success = success && v1Result.success;
      errorOutput += v1Result.errorOutput;
      stdOutput += v1Result.stdOutput;
    } else if (structureVersion === 2) {
      const v2Result = await this.validateV2Structure(folder, folderStruct);
      success = success && v2Result.success;
      errorOutput += v2Result.errorOutput;
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
