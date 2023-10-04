import { globby } from "globby";
import path from "path";
import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";
import { checkFileExists } from "../utils.js";

export class FolderStructureRule implements Rule {
  readonly name = "FolderStructure";
  readonly description = "Verify spec directory's folder structure and naming conventions.";
  async execute(folder: string): Promise<RuleResult> {
    let success = true;
    let errorOutput = "";

    let stdOutput = "Verify tspconfig file extension";
    const tspConfig = await globby([`${folder}/**tspconfig.*`]);
    tspConfig.forEach((file: string) => {
      if (!file.endsWith("tspconfig.yaml")) {
        success = false;
        errorOutput += `Invalid config file '${file}'.  Must be named 'tspconfig.yaml'.\n`;
      }
    });

    // Verify top level folder is lower case
    let folderStruct = folder.split("/");
    if (folderStruct[1].match(/[A-Z]/g)) {
      success = false;
      errorOutput += `Invalid folder name. Folders under specification/ must be lower case.\n`;
    }

    let packageFolder = folderStruct[folderStruct.length - 1];

    // Verify package folder is at most 3 levels deep
    if (folderStruct.length > 4) {
      success = false;
      errorOutput += `Please limit TypeSpec folder depth to 3 levels or less`;
    }

    // Verify second level folder is capitalized after each '.'
    if (
      /(^|\. *)([a-z])/g.test(packageFolder) &&
      !["data-plane", "resource-manager"].includes(packageFolder)
    ) {
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

    // Verify tspconfig, main.tsp, examples/
    let containsMinStruct =
      (await checkFileExists(path.join(folder, "main.tsp"))) ||
      (await checkFileExists(path.join(folder, "client.tsp")));

    if (await checkFileExists(path.join(folder, "main.tsp"))) {
      containsMinStruct =
        containsMinStruct && (await checkFileExists(path.join(folder, "examples")));
    }

    if (!packageFolder.includes("Shared")) {
      containsMinStruct =
        containsMinStruct && (await checkFileExists(path.join(folder, "tspconfig.yaml")));
    }
    if (!containsMinStruct) {
      success = false;
      errorOutput += `Invalid folder structure. Package must contain main.tsp or client.tsp, tspconfig.yaml, and examples folder if there's main.tsp.`;
    }

    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}
