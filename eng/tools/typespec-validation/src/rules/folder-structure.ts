import debug from "debug";
import fs from "fs/promises";
import { globby } from "globby";
import path from "path";
import { simpleGit } from "simple-git";
import { parse as yamlParse } from "yaml";
import { RuleResult } from "../rule-result.js";
import { Rule } from "../rule.js";
import { fileExists, normalizePath, readTspConfig } from "../utils.js";

// Enable simple-git debug logging to improve console output
debug.enable("simple-git");

// Add console logging helper
function log(message: string, ...args: any[]): void {
  console.log(`[FolderStructureRule] ${message}`, ...args);
}

export interface FolderStructureRuleOptions {
  validateOldStructure?: boolean;
  validateNewStructure?: boolean;
}

export class FolderStructureRule implements Rule {
  readonly name = "FolderStructure";
  readonly description = "Verify spec directory's folder structure and naming conventions.";

  // Configuration for which structure to validate
  private validateOldStructure: boolean;
  private validateNewStructure: boolean;

  constructor(options?: FolderStructureRuleOptions) {
    // Default both to true if no options provided
    if (!options) {
      this.validateOldStructure = true;
      this.validateNewStructure = true;
    } else {
      this.validateOldStructure = options.validateOldStructure ?? true;
      this.validateNewStructure = options.validateNewStructure ?? true;
    }

    log("Initialized with options:", {
      validateOldStructure: this.validateOldStructure,
      validateNewStructure: this.validateNewStructure,
    });
  }

  async execute(folder: string): Promise<RuleResult> {
    log(`Starting execution for folder: ${folder}`);
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    log("Getting git root...");
    const gitRoot = normalizePath(await simpleGit(folder).revparse("--show-toplevel"));
    log(`Git root: ${gitRoot}`);

    const relativePath = path.relative(gitRoot, folder).split(path.sep).join("/");
    log(`Relative path: ${relativePath}`);

    stdOutput += `folder: ${folder}\n`;
    if (!(await fileExists(folder))) {
      log(`ERROR: Folder '${folder}' does not exist`);
      return {
        success: false,
        stdOutput: stdOutput,
        errorOutput: `Folder '${folder}' does not exist.\n`,
      };
    }

    // Log which validation modes are active
    const validationModeMsg = `Validation mode: ${this.validateOldStructure ? "Old structure" : ""}${
      this.validateOldStructure && this.validateNewStructure ? " and " : ""
    }${this.validateNewStructure ? "New structure" : ""}`;

    log(validationModeMsg);
    stdOutput += `${validationModeMsg}\n`;

    let oldResult: RuleResult = { success: true, stdOutput: "", errorOutput: "" };
    let newResult: RuleResult = { success: true, stdOutput: "", errorOutput: "" };

    // Determine which structure(s) to validate
    if (this.validateOldStructure) {
      log("Starting old structure validation...");
      oldResult = await this.validateOldStructureImpl(folder, gitRoot, relativePath);
      log(`Old structure validation result: ${oldResult.success ? "PASSED" : "FAILED"}`);
      success = success && oldResult.success;
      stdOutput += `\n--- Old Structure Validation ---\n${oldResult.stdOutput}`;
      if (!oldResult.success) {
        log("Old structure validation errors:", oldResult.errorOutput);
        errorOutput += `\n--- Old Structure Validation Errors ---\n${oldResult.errorOutput}`;
      }
    }

    if (this.validateNewStructure) {
      log("Starting new structure validation...");
      newResult = await this.validateNewStructureImpl(folder, gitRoot, relativePath);
      log(`New structure validation result: ${newResult.success ? "PASSED" : "FAILED"}`);
      success = success && newResult.success;
      stdOutput += `\n--- New Structure Validation ---\n${newResult.stdOutput}`;
      if (!newResult.success) {
        log("New structure validation errors:", newResult.errorOutput);
        errorOutput += `\n--- New Structure Validation Errors ---\n${newResult.errorOutput}`;
      }
    }

    // Special case: if validating both structures and at least one passes, consider it a success
    if (
      this.validateOldStructure &&
      this.validateNewStructure &&
      (oldResult.success || newResult.success)
    ) {
      log(
        "Both validations run and at least one passed - marking overall validation as successful",
      );
      success = true;
      stdOutput +=
        "\nAt least one structure validation passed, considering overall validation successful.\n";
    }

    log(`Final validation result: ${success ? "PASSED" : "FAILED"}`);
    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }

  // Implementation of the original validation logic for the old structure
  private async validateOldStructureImpl(
    folder: string,
    gitRoot: string,
    relativePath: string,
  ): Promise<RuleResult> {
    log(`[Old] Validating folder: ${folder}`);
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    const tspConfigs = await globby([`${folder}/**tspconfig.*`]);
    log(`[Old] Found tspconfig files:`, tspConfigs);
    stdOutput += `config files: ${JSON.stringify(tspConfigs)}\n`;
    tspConfigs.forEach((file: string) => {
      if (!file.endsWith("tspconfig.yaml")) {
        log(`[Old] Invalid config file: ${file}`);
        success = false;
        errorOutput += `Invalid config file '${file}'.  Must be named 'tspconfig.yaml'.\n`;
      }
    });

    // Verify top level folder is lower case and remove empty entries when splitting by slash
    const folderStruct = relativePath.split("/").filter(Boolean);
    log(`[Old] Folder structure: ${JSON.stringify(folderStruct)}`);

    if (folderStruct[1].match(/[A-Z]/g)) {
      log(`[Old] Invalid folder name: ${folderStruct[1]} contains uppercase letters`);
      success = false;
      errorOutput += `Invalid folder name. Folders under specification/ must be lower case.\n`;
    }

    const packageFolder = folderStruct[folderStruct.length - 1];
    log(`[Old] Package folder: ${packageFolder}`);

    // Verify package folder is at most 3 levels deep
    if (folderStruct.length > 4) {
      log(`[Old] Folder depth (${folderStruct.length}) exceeds maximum of 4`);
      success = false;
      errorOutput += `Please limit TypeSpec folder depth to 3 levels or less`;
    }

    // Verify second level folder is capitalized after each '.'
    if (/(^|\. *)([a-z])/g.test(packageFolder)) {
      log(`[Old] Package folder name ${packageFolder} not capitalized after each '.'`);
      success = false;
      errorOutput += `Invalid folder name. Folders under specification/${folderStruct[1]} must be capitalized after each '.'\n`;
    }

    // Verify 'Shared' follows 'Management'
    if (packageFolder.includes("Management") && packageFolder.includes("Shared")) {
      if (!packageFolder.includes("Management.Shared")) {
        log(`[Old] Invalid Management.Shared pattern in: ${packageFolder}`);
        success = false;
        errorOutput += `Invalid folder name. For management libraries with a shared component, 'Shared' should follow 'Management'.`;
      }
    }

    // Verify tspconfig, main.tsp, examples/
    const mainExists = await fileExists(path.join(folder, "main.tsp"));
    const clientExists = await fileExists(path.join(folder, "client.tsp"));
    const tspConfigExists = await fileExists(path.join(folder, "tspconfig.yaml"));
    log(
      `[Old] File check: main.tsp exists: ${mainExists}, client.tsp exists: ${clientExists}, tspconfig.yaml exists: ${tspConfigExists}`,
    );

    if (!mainExists && !clientExists) {
      log(`[Old] Missing both main.tsp and client.tsp`);
      errorOutput += `Invalid folder structure: Spec folder must contain main.tsp or client.tsp.`;
      success = false;
    }

    if (mainExists && !(await fileExists(path.join(folder, "examples")))) {
      log(`[Old] main.tsp exists but missing examples folder`);
      errorOutput += `Invalid folder structure: Spec folder with main.tsp must contain examples folder.`;
      success = false;
    }

    if (!packageFolder.includes("Shared") && !tspConfigExists) {
      log(`[Old] Missing tspconfig.yaml in non-Shared folder`);
      errorOutput += `Invalid folder structure: Spec folder must contain tspconfig.yaml.`;
      success = false;
    }

    if (tspConfigExists) {
      log(`[Old] Reading tspconfig.yaml`);
      const configText = await readTspConfig(folder);
      const config = yamlParse(configText);
      const rpFolder =
        config?.options?.["@azure-tools/typespec-autorest"]?.["azure-resource-provider-folder"];
      log(`[Old] azure-resource-provider-folder: ${rpFolder}`);
      stdOutput += `azure-resource-provider-folder: ${JSON.stringify(rpFolder)}\n`;

      if (
        rpFolder?.trim()?.endsWith("resource-manager") &&
        !packageFolder.endsWith(".Management")
      ) {
        log(`[Old] resource-manager folder without .Management suffix`);
        errorOutput += `Invalid folder structure: TypeSpec for resource-manager specs must be in a folder ending with '.Management'`;
        success = false;
      } else if (
        !rpFolder?.trim()?.endsWith("resource-manager") &&
        packageFolder.endsWith(".Management")
      ) {
        log(`[Old] Non-resource-manager folder with .Management suffix`);
        errorOutput += `Invalid folder structure: TypeSpec for data-plane specs or shared code must be in a folder NOT ending with '.Management'`;
        success = false;
      }
    }

    // Ensure specs only import files from same folder under "specification"
    stdOutput += "imports:\n";

    const teamFolder = path.join(...folderStruct.slice(0, 2));
    stdOutput += `  ${teamFolder}\n`;

    const teamFolderResolved = path.resolve(gitRoot, teamFolder);

    const tsps = await globby("**/*.tsp", { cwd: teamFolderResolved });

    for (const tsp of tsps) {
      const tspResolved = path.resolve(teamFolderResolved, tsp);

      const pattern = /^\s*import\s+['"]([^'"]+)['"]\s*;\s*$/gm;
      const text = await fs.readFile(tspResolved, { encoding: "utf8" });
      const matches: string[] = [];
      let match;
      while ((match = pattern.exec(text)) !== null) {
        matches.push(match[1]);
      }
      const imports = matches;

      const fileImports = imports.filter(
        (i) => i.startsWith("./") || i.startsWith("../") || path.isAbsolute(i),
      );

      stdOutput += `    ${tsp}: ${JSON.stringify(fileImports)}\n`;

      for (const fileImport of fileImports) {
        const fileImportResolved = path.resolve(path.dirname(tspResolved), fileImport);

        const relative = path.relative(teamFolderResolved, fileImportResolved);

        if (relative.startsWith("..")) {
          log(
            `[Old] Invalid import: '${tsp}' imports '${fileImport}', which is outside '${path.relative(gitRoot, teamFolder)}'`,
          );
          errorOutput +=
            `Invalid folder structure: '${tsp}' imports '${fileImport}', ` +
            `which is outside '${path.relative(gitRoot, teamFolder)}'`;
          success = false;
        }
      }
    }

    log(`[Old] Final validation result: ${success ? "PASSED" : "FAILED"}`);
    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }

  // New validation logic for the new structure
  private async validateNewStructureImpl(
    folder: string,
    _gitRoot: string,
    relativePath: string,
  ): Promise<RuleResult> {
    log(`[New] Validating folder: ${folder}`);
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    // Parse the folder structure
    const folderStruct = relativePath.split("/").filter(Boolean);
    log(`[New] Folder structure: ${JSON.stringify(folderStruct)}`);

    // Validate structure based on the new folder structure guidelines
    // 1. Check if the top-level folder is the RPNamespace
    if (folderStruct.length < 2) {
      log(`[New] Invalid folder structure: not enough segments in path`);
      return {
        success: false,
        stdOutput: stdOutput,
        errorOutput: "Invalid folder structure: Must be under specification/<rpnamespace>/\n",
      };
    }

    const rpNamespace = folderStruct[1];
    log(`[New] RPNamespace: ${rpNamespace}`);
    stdOutput += `RPNamespace: ${rpNamespace}\n`;

    // Check if this is the root of the RPNamespace
    const isRpNamespaceRoot = folderStruct.length === 2;
    log(`[New] Is RP namespace root? ${isRpNamespaceRoot}`);

    if (isRpNamespaceRoot) {
      log(`[New] Validating RP namespace root folder`);
      // Validate the RP namespace root folder
      // Check for cspell.yaml
      const cspellExists = await fileExists(path.join(folder, "cspell.yaml"));
      log(`[New] cspell.yaml exists: ${cspellExists}`);
      if (!cspellExists) {
        log(`[New] Missing cspell.yaml in RP namespace root`);
        errorOutput += "Invalid folder structure: RPNamespace root must contain cspell.yaml\n";
        success = false;
      }

      // Check for resource-manager and data-plane folders
      const resourceManagerExists = await fileExists(path.join(folder, "resource-manager"));
      const dataPlaneExists = await fileExists(path.join(folder, "data-plane"));
      log(
        `[New] resource-manager exists: ${resourceManagerExists}, data-plane exists: ${dataPlaneExists}`,
      );

      if (!resourceManagerExists && !dataPlaneExists) {
        log(`[New] Missing both resource-manager and data-plane folders`);
        errorOutput +=
          "Invalid folder structure: RPNamespace root must contain at least one of resource-manager/ or data-plane/ folders\n";
        success = false;
      }

      // Check that there are no other files or folders at this level
      const contents = await globby([`${folder}/*`], { onlyFiles: false, markDirectories: true });
      log(`[New] RP namespace contents: ${JSON.stringify(contents)}`);
      const validContents = [
        path.join(folder, "cspell.yaml"),
        path.join(folder, "resource-manager") + path.sep,
        path.join(folder, "data-plane") + path.sep,
      ];

      for (const item of contents) {
        if (!validContents.includes(item) && !validContents.includes(item + path.sep)) {
          log(`[New] Unexpected item in RP namespace root: ${item}`);
          errorOutput += `Invalid folder structure: Unexpected item '${path.basename(item)}' in RPNamespace root\n`;
          success = false;
        }
      }
    } else {
      // Not the RP root, so we need to determine if we're in resource-manager or data-plane
      // and validate accordingly
      if (folderStruct[2] === "resource-manager") {
        log(`[New] Validating resource-manager structure`);
        // Validate resource-manager structure
        const resourceManagerResult = await this.validateResourceManagerStructure(
          folder,
          folderStruct,
        );
        success = success && resourceManagerResult.success;
        stdOutput += resourceManagerResult.stdOutput;
        errorOutput += resourceManagerResult.errorOutput;
      } else if (folderStruct[2] === "data-plane") {
        log(`[New] Validating data-plane structure`);
        // Validate data-plane structure
        const dataPlaneResult = await this.validateDataPlaneStructure(folder, folderStruct);
        success = success && dataPlaneResult.success;
        stdOutput += dataPlaneResult.stdOutput;
        errorOutput += dataPlaneResult.errorOutput;
      } else {
        log(`[New] Invalid folder - not in resource-manager or data-plane: ${folderStruct[2]}`);
        // Invalid folder - not in resource-manager or data-plane
        errorOutput += `Invalid folder structure: Folder must be within resource-manager/ or data-plane/\n`;
        success = false;
      }
    }

    log(`[New] Final validation result: ${success ? "PASSED" : "FAILED"}`);
    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }

  // Helper methods with added logging...
  private async validateResourceManagerStructure(
    folder: string,
    folderStruct: string[],
  ): Promise<RuleResult> {
    log(`[ResourceManager] Validating folder: ${folder}`);
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    // Check if we're in the resource-manager root folder
    const isResourceManagerRoot = folderStruct.length === 3;
    log(`[ResourceManager] Is root folder? ${isResourceManagerRoot}`);

    if (isResourceManagerRoot) {
      log(`[ResourceManager] Validating root folder structure`);
      // Resource manager root must have a readme.md file and an operations folder
      const readmeExists = await fileExists(path.join(folder, "readme.md"));
      log(`[ResourceManager] readme.md exists: ${readmeExists}`);
      if (!readmeExists) {
        log(`[ResourceManager] Missing readme.md`);
        errorOutput +=
          "Invalid folder structure: resource-manager/ folder must contain a readme.md file\n";
        success = false;
      }

      // Check for operations folder
      const operationsExists = await fileExists(path.join(folder, "operations"));
      log(`[ResourceManager] operations folder exists: ${operationsExists}`);
      if (!operationsExists) {
        log(`[ResourceManager] Missing operations folder`);
        errorOutput +=
          "Invalid folder structure: resource-manager/ folder must contain an operations/ folder\n";
        success = false;
      }

      // Must have at least one service folder other than operations
      const contents = await globby([`${folder}/*`], { onlyDirectories: true });
      log(`[ResourceManager] Root folder contents: ${JSON.stringify(contents)}`);

      let hasServiceFolder = false;

      for (const item of contents) {
        const dirName = path.basename(item);
        if (dirName !== "operations" && dirName !== "readme.md") {
          hasServiceFolder = true;
          break;
        }
      }

      if (!hasServiceFolder) {
        log(`[ResourceManager] Missing service folder`);
        errorOutput +=
          "Invalid folder structure: resource-manager/ folder must contain at least one service folder other than operations/\n";
        success = false;
      }
    } else if (folderStruct.length === 4) {
      // We're in a service folder inside resource-manager
      const serviceName = folderStruct[3];
      log(`[ResourceManager] Validating service folder: ${serviceName}`);
      stdOutput += `Service name: ${serviceName}\n`;

      // Validate service folder structure
      const serviceResult = await this.validateServiceFolder(folder, serviceName);
      success = success && serviceResult.success;
      stdOutput += serviceResult.stdOutput;
      errorOutput += serviceResult.errorOutput;
    } else if (folderStruct.length > 4) {
      // We're deeper in the hierarchy, might be in examples, stable, or preview folders
      const serviceFolder = path.join(
        path.dirname(folder),
        path.dirname(path.dirname(folderStruct.slice(4).join("/"))),
      );
      const serviceName = folderStruct[3];
      const deepFolder = folderStruct[4];
      log(`[ResourceManager] Validating deeper folder: ${deepFolder}`);

      if (deepFolder === "examples") {
        // Validate examples folder
        const examplesResult = await this.validateExamplesFolder(folder, serviceName);
        success = success && examplesResult.success;
        stdOutput += examplesResult.stdOutput;
        errorOutput += examplesResult.errorOutput;
      } else if (deepFolder === "preview") {
        // Validate preview folder
        const previewResult = await this.validatePreviewFolder(folder, serviceName);
        success = success && previewResult.success;
        stdOutput += previewResult.stdOutput;
        errorOutput += previewResult.errorOutput;
      } else if (deepFolder === "stable") {
        // Validate stable folder
        const stableResult = await this.validateStableFolder(folder, serviceName);
        success = success && stableResult.success;
        stdOutput += stableResult.stdOutput;
        errorOutput += stableResult.errorOutput;
      }

      // If we're in a preview or stable version folder, check for conflicting dates
      if (folderStruct.length > 5 && (deepFolder === "preview" || deepFolder === "stable")) {
        const versionFolder = folderStruct[5];
        const serviceResult = await this.validateNoConflictingVersionDates(
          serviceFolder,
          versionFolder,
        );
        success = success && serviceResult.success;
        stdOutput += serviceResult.stdOutput;
        errorOutput += serviceResult.errorOutput;
      }
    }

    log(`[ResourceManager] Final validation result: ${success ? "PASSED" : "FAILED"}`);
    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }

  private async validateDataPlaneStructure(
    folder: string,
    folderStruct: string[],
  ): Promise<RuleResult> {
    log(`[DataPlane] Validating folder: ${folder}`);
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    // Check if we're in the data-plane root folder
    const isDataPlaneRoot = folderStruct.length === 3;
    log(`[DataPlane] Is root folder? ${isDataPlaneRoot}`);

    if (isDataPlaneRoot) {
      log(`[DataPlane] Validating root folder structure`);
      // data-plane/ folder must have at least one service folder
      const contents = await globby([`${folder}/*`], { onlyDirectories: true });
      log(`[DataPlane] Root folder contents: ${JSON.stringify(contents)}`);

      if (contents.length === 0) {
        log(`[DataPlane] Missing service folder`);
        errorOutput +=
          "Invalid folder structure: data-plane/ folder must contain at least one service folder\n";
        success = false;
      }

      // Data plane root should not have any files
      const files = await globby([`${folder}/*`], { onlyFiles: true });
      log(`[DataPlane] Root folder files: ${JSON.stringify(files)}`);
      if (files.length > 0) {
        log(`[DataPlane] Unexpected files in root folder`);
        errorOutput +=
          "Invalid folder structure: data-plane/ folder should not contain any files\n";
        success = false;
      }
    } else if (folderStruct.length === 4) {
      // We're in a service folder inside data-plane
      const serviceName = folderStruct[3];
      log(`[DataPlane] Validating service folder: ${serviceName}`);
      stdOutput += `Service name: ${serviceName}\n`;

      // Validate service folder structure
      const serviceResult = await this.validateServiceFolder(folder, serviceName);
      success = success && serviceResult.success;
      stdOutput += serviceResult.stdOutput;
      errorOutput += serviceResult.errorOutput;
    } else if (folderStruct.length > 4) {
      // We're deeper in the hierarchy, might be in examples, stable, or preview folders
      const serviceFolder = path.join(
        path.dirname(folder),
        path.dirname(path.dirname(folderStruct.slice(4).join("/"))),
      );
      const serviceName = folderStruct[3];
      const deepFolder = folderStruct[4];
      log(`[DataPlane] Validating deeper folder: ${deepFolder}`);

      if (deepFolder === "examples") {
        // Validate examples folder
        const examplesResult = await this.validateExamplesFolder(folder, serviceName);
        success = success && examplesResult.success;
        stdOutput += examplesResult.stdOutput;
        errorOutput += examplesResult.errorOutput;
      } else if (deepFolder === "preview") {
        // Validate preview folder
        const previewResult = await this.validatePreviewFolder(folder, serviceName);
        success = success && previewResult.success;
        stdOutput += previewResult.stdOutput;
        errorOutput += previewResult.errorOutput;
      } else if (deepFolder === "stable") {
        // Validate stable folder
        const stableResult = await this.validateStableFolder(folder, serviceName);
        success = success && stableResult.success;
        stdOutput += stableResult.stdOutput;
        errorOutput += stableResult.errorOutput;
      }

      // If we're in a preview or stable version folder, check for conflicting dates
      if (folderStruct.length > 5 && (deepFolder === "preview" || deepFolder === "stable")) {
        const versionFolder = folderStruct[5];
        const serviceResult = await this.validateNoConflictingVersionDates(
          serviceFolder,
          versionFolder,
        );
        success = success && serviceResult.success;
        stdOutput += serviceResult.stdOutput;
        errorOutput += serviceResult.errorOutput;
      }
    }

    log(`[DataPlane] Final validation result: ${success ? "PASSED" : "FAILED"}`);
    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }

  private async validateServiceFolder(folder: string, serviceName: string): Promise<RuleResult> {
    log(`[ServiceFolder] Validating folder: ${folder}`);
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    // Service folder must have tspconfig.yaml
    const tspConfigExists = await fileExists(path.join(folder, "tspconfig.yaml"));
    log(`[ServiceFolder] tspconfig.yaml exists: ${tspConfigExists}`);
    if (!tspConfigExists) {
      log(`[ServiceFolder] Missing tspconfig.yaml`);
      errorOutput += `Invalid folder structure: Service folder '${serviceName}' must contain tspconfig.yaml\n`;
      success = false;
    }

    // Service folder must have main.tsp or client.tsp
    const mainExists = await fileExists(path.join(folder, "main.tsp"));
    const clientExists = await fileExists(path.join(folder, "client.tsp"));
    log(`[ServiceFolder] main.tsp exists: ${mainExists}, client.tsp exists: ${clientExists}`);
    if (!mainExists && !clientExists) {
      log(`[ServiceFolder] Missing both main.tsp and client.tsp`);
      errorOutput += `Invalid folder structure: Service folder '${serviceName}' must contain main.tsp or client.tsp\n`;
      success = false;
    }

    // If main.tsp exists, examples folder must exist
    if (mainExists) {
      const examplesExists = await fileExists(path.join(folder, "examples"));
      log(`[ServiceFolder] examples folder exists: ${examplesExists}`);
      if (!examplesExists) {
        log(`[ServiceFolder] Missing examples folder`);
        errorOutput += `Invalid folder structure: Service folder '${serviceName}' with main.tsp must contain examples folder\n`;
        success = false;
      }
    }

    // Service folder must have examples, preview, and stable folders
    const examplesExists = await fileExists(path.join(folder, "examples"));
    const previewExists = await fileExists(path.join(folder, "preview"));
    const stableExists = await fileExists(path.join(folder, "stable"));
    log(
      `[ServiceFolder] examples exists: ${examplesExists}, preview exists: ${previewExists}, stable exists: ${stableExists}`,
    );

    if (!examplesExists || !previewExists || !stableExists) {
      const missing = [];
      if (!examplesExists) missing.push("examples");
      if (!previewExists) missing.push("preview");
      if (!stableExists) missing.push("stable");

      log(`[ServiceFolder] Missing folders: ${missing.join(", ")}`);
      errorOutput += `Invalid folder structure: Service folder '${serviceName}' must contain ${missing.join(", ")} folders\n`;
      success = false;
    }

    // Service folder should only have tspconfig.yaml, *.tsp files and specific subfolders
    const contents = await globby([`${folder}/*`], { onlyFiles: false, markDirectories: true });
    log(`[ServiceFolder] Folder contents: ${JSON.stringify(contents)}`);

    for (const item of contents) {
      const baseName = path.basename(item);

      // Skip valid files and folders
      if (
        baseName === "tspconfig.yaml" ||
        baseName.endsWith(".tsp") ||
        baseName === "examples" ||
        baseName === "preview" ||
        baseName === "stable" ||
        baseName.startsWith("readme.")
      ) {
        continue;
      }

      // For any other files or folders, flag as invalid
      log(`[ServiceFolder] Unexpected item: ${baseName}`);
      errorOutput += `Invalid folder structure: Unexpected item '${baseName}' in service folder '${serviceName}'\n`;
      success = false;
    }

    log(`[ServiceFolder] Final validation result: ${success ? "PASSED" : "FAILED"}`);
    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }

  private async validateExamplesFolder(folder: string, serviceName: string): Promise<RuleResult> {
    log(`[ExamplesFolder] Validating folder: ${folder}`);
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    // Examples folder should only have api-version subfolders
    const contents = await globby([`${folder}/*`], { onlyDirectories: true });
    log(`[ExamplesFolder] Folder contents: ${JSON.stringify(contents)}`);

    if (contents.length === 0) {
      log(`[ExamplesFolder] Missing api-version subfolders`);
      errorOutput += `Invalid folder structure: Examples folder in service '${serviceName}' must contain at least one api-version subfolder\n`;
      success = false;
    } else {
      for (const apiVersionFolder of contents) {
        const apiVersionName = path.basename(apiVersionFolder);
        log(`[ExamplesFolder] Validating api-version folder: ${apiVersionName}`);

        // Check if the api-version folder only contains .json files
        const apiVersionContents = await globby([`${apiVersionFolder}/*`]);
        log(`[ExamplesFolder] api-version folder contents: ${JSON.stringify(apiVersionContents)}`);

        if (apiVersionContents.length === 0) {
          log(
            `[ExamplesFolder] Missing example .json files in api-version folder: ${apiVersionName}`,
          );
          errorOutput += `Invalid folder structure: API version folder '${apiVersionName}' in examples must contain at least one example .json file\n`;
          success = false;
        } else {
          for (const file of apiVersionContents) {
            const fileName = path.basename(file);

            if (!fileName.endsWith(".json")) {
              log(`[ExamplesFolder] Invalid file in api-version folder: ${fileName}`);
              errorOutput += `Invalid folder structure: File '${fileName}' in API version folder '${apiVersionName}' must be a .json file\n`;
              success = false;
            }
          }
        }
      }
    }

    log(`[ExamplesFolder] Final validation result: ${success ? "PASSED" : "FAILED"}`);
    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }

  private async validatePreviewFolder(folder: string, _serviceName: string): Promise<RuleResult> {
    log(`[PreviewFolder] Validating folder: ${folder}`);
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    // Preview folder should only have YYYY-MM-DD-preview subfolders
    const contents = await globby([`${folder}/*`], { onlyDirectories: true });
    log(`[PreviewFolder] Folder contents: ${JSON.stringify(contents)}`);

    if (contents.length === 0) {
      // It's okay if preview folder is empty
      log(`[PreviewFolder] Folder is empty`);
      return { success, stdOutput, errorOutput };
    }

    for (const versionFolder of contents) {
      const versionName = path.basename(versionFolder);
      log(`[PreviewFolder] Validating version folder: ${versionName}`);

      // Check if the folder name matches YYYY-MM-DD-preview format
      if (!this.isValidPreviewVersionFormat(versionName)) {
        log(`[PreviewFolder] Invalid version folder name: ${versionName}`);
        errorOutput += `Invalid folder structure: Preview version folder '${versionName}' must follow the format 'YYYY-MM-DD-preview'\n`;
        success = false;
      }

      // Check if the version folder only contains .json files and an examples folder
      const versionContents = await globby([`${versionFolder}/*`], {
        onlyFiles: false,
        markDirectories: true,
      });
      log(`[PreviewFolder] Version folder contents: ${JSON.stringify(versionContents)}`);

      let hasExamplesFolder = false;

      for (const item of versionContents) {
        const itemName = path.basename(item);

        if (itemName === "examples") {
          hasExamplesFolder = true;

          // Validate the examples folder within this version folder
          const examplesResult = await this.validateVersionExamplesFolder(
            path.join(versionFolder, "examples"),
            versionName,
          );
          success = success && examplesResult.success;
          stdOutput += examplesResult.stdOutput;
          errorOutput += examplesResult.errorOutput;
        } else if (!itemName.endsWith(".json")) {
          log(`[PreviewFolder] Invalid item in version folder: ${itemName}`);
          errorOutput += `Invalid folder structure: Item '${itemName}' in preview version folder '${versionName}' must be a .json file or the examples folder\n`;
          success = false;
        }
      }

      if (!hasExamplesFolder) {
        log(`[PreviewFolder] Missing examples folder in version folder: ${versionName}`);
        errorOutput += `Invalid folder structure: Preview version folder '${versionName}' must contain an examples folder\n`;
        success = false;
      }
    }

    log(`[PreviewFolder] Final validation result: ${success ? "PASSED" : "FAILED"}`);
    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }

  private async validateStableFolder(folder: string, _serviceName: string): Promise<RuleResult> {
    log(`[StableFolder] Validating folder: ${folder}`);
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    // Stable folder should only have YYYY-MM-DD subfolders
    const contents = await globby([`${folder}/*`], { onlyDirectories: true });
    log(`[StableFolder] Folder contents: ${JSON.stringify(contents)}`);

    if (contents.length === 0) {
      // It's okay if stable folder is empty
      log(`[StableFolder] Folder is empty`);
      return { success, stdOutput, errorOutput };
    }

    for (const versionFolder of contents) {
      const versionName = path.basename(versionFolder);
      log(`[StableFolder] Validating version folder: ${versionName}`);

      // Check if the folder name matches YYYY-MM-DD format
      if (!this.isValidStableVersionFormat(versionName)) {
        log(`[StableFolder] Invalid version folder name: ${versionName}`);
        errorOutput += `Invalid folder structure: Stable version folder '${versionName}' must follow the format 'YYYY-MM-DD'\n`;
        success = false;
      }

      // Check if the version folder only contains .json files and an examples folder
      const versionContents = await globby([`${versionFolder}/*`], {
        onlyFiles: false,
        markDirectories: true,
      });
      log(`[StableFolder] Version folder contents: ${JSON.stringify(versionContents)}`);

      let hasExamplesFolder = false;

      for (const item of versionContents) {
        const itemName = path.basename(item);

        if (itemName === "examples") {
          hasExamplesFolder = true;

          // Validate the examples folder within this version folder
          const examplesResult = await this.validateVersionExamplesFolder(
            path.join(versionFolder, "examples"),
            versionName,
          );
          success = success && examplesResult.success;
          stdOutput += examplesResult.stdOutput;
          errorOutput += examplesResult.errorOutput;
        } else if (!itemName.endsWith(".json")) {
          log(`[StableFolder] Invalid item in version folder: ${itemName}`);
          errorOutput += `Invalid folder structure: Item '${itemName}' in stable version folder '${versionName}' must be a .json file or the examples folder\n`;
          success = false;
        }
      }

      if (!hasExamplesFolder) {
        log(`[StableFolder] Missing examples folder in version folder: ${versionName}`);
        errorOutput += `Invalid folder structure: Stable version folder '${versionName}' must contain an examples folder\n`;
        success = false;
      }
    }

    log(`[StableFolder] Final validation result: ${success ? "PASSED" : "FAILED"}`);
    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }

  private async validateVersionExamplesFolder(
    folder: string,
    versionName: string,
  ): Promise<RuleResult> {
    log(`[VersionExamplesFolder] Validating folder: ${folder}`);
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    // Version's examples folder should only contain .json files
    const contents = await globby([`${folder}/*`]);
    log(`[VersionExamplesFolder] Folder contents: ${JSON.stringify(contents)}`);

    if (contents.length === 0) {
      log(`[VersionExamplesFolder] Missing example .json files`);
      errorOutput += `Invalid folder structure: Examples folder in version '${versionName}' must contain at least one example .json file\n`;
      success = false;
    } else {
      for (const file of contents) {
        const fileName = path.basename(file);

        if (!fileName.endsWith(".json")) {
          log(`[VersionExamplesFolder] Invalid file: ${fileName}`);
          errorOutput += `Invalid folder structure: File '${fileName}' in examples folder of version '${versionName}' must be a .json file\n`;
          success = false;
        }
      }
    }

    log(`[VersionExamplesFolder] Final validation result: ${success ? "PASSED" : "FAILED"}`);
    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }

  private async validateNoConflictingVersionDates(
    serviceFolder: string,
    versionFolder: string,
  ): Promise<RuleResult> {
    log(`[VersionConflict] Validating version folder: ${versionFolder}`);
    let success = true;
    let stdOutput = "";
    let errorOutput = "";

    // Extract the date part from the version folder
    let date: string;
    let isPreview = false;

    if (versionFolder.endsWith("-preview")) {
      date = versionFolder.substring(0, versionFolder.length - 8); // Remove "-preview"
      isPreview = true;
    } else {
      date = versionFolder;
    }

    log(`[VersionConflict] Date extracted: ${date}, isPreview: ${isPreview}`);

    // Check if there's a conflicting version with the same date
    if (isPreview) {
      // We're in a preview folder, check if there's a stable version with the same date
      const stableVersionPath = path.join(serviceFolder, "stable", date);
      const stableExists = await fileExists(stableVersionPath);
      log(`[VersionConflict] Stable version exists: ${stableExists}`);
      if (stableExists) {
        log(`[VersionConflict] Conflict found with stable version: ${date}`);
        errorOutput += `Invalid folder structure: Preview version '${versionFolder}' conflicts with stable version '${date}'. A preview and stable version cannot share the same date.\n`;
        success = false;
      }
    } else {
      // We're in a stable folder, check if there's a preview version with the same date
      const previewVersionPath = path.join(serviceFolder, "preview", `${date}-preview`);
      const previewExists = await fileExists(previewVersionPath);
      log(`[VersionConflict] Preview version exists: ${previewExists}`);
      if (previewExists) {
        log(`[VersionConflict] Conflict found with preview version: ${date}-preview`);
        errorOutput += `Invalid folder structure: Stable version '${versionFolder}' conflicts with preview version '${date}-preview'. A stable and preview version cannot share the same date.\n`;
        success = false;
      }
    }

    log(`[VersionConflict] Final validation result: ${success ? "PASSED" : "FAILED"}`);
    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }

  private isValidPreviewVersionFormat(versionName: string): boolean {
    return /^\d{4}-\d{2}-\d{2}-preview$/.test(versionName);
  }

  private isValidStableVersionFormat(versionName: string): boolean {
    return /^\d{4}-\d{2}-\d{2}$/.test(versionName);
  }
}
