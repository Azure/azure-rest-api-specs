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
    let folderStruct = folder.split(path.sep)
    if (folderStruct[1].match(/[A-Z]/g)) {
      success = false;
      errorOutput += `Invalid folder name. Folders under specification/ must be lower case.\n`
    }
    
    // Verify second level folder is capitalized after each '.'
    if (/(^|\. *)([a-z])/g.test(folderStruct[2]) && !["data-plane", "resource-manager"].includes(folderStruct[2])) {
      success = false;
      errorOutput += `Invalid folder name. Folders under specification/${folderStruct[1]} must be capitalized after each '.'\n`
    }

    // Verify 'Shared' follows 'Management'
    if (folderStruct[2].includes("Management") && folderStruct[2].includes("Shared")) {
      if (!folderStruct[2].includes("Management.Shared")) {
        success = false;
        errorOutput += `Invalid folder name. For management libraries with a shared component, 'Shared' should follow 'Management'.`
      }
    }

    // Verify tspconfig, main.tsp, examples/
    let containsMinStruct = await checkFileExists(path.join(folder, "main.tsp")) && await checkFileExists(path.join(folder, "examples"))
    if (!folderStruct[2].includes("Shared")) {
      containsMinStruct = containsMinStruct && await checkFileExists(path.join(folder, "tspconfig.yaml"))
    }
    if (!containsMinStruct) {
      success = false;
      errorOutput += `Invalid folder structure. Package must contain tspconfig.yaml, main.tsp, and examples folder.`
    }

    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}
