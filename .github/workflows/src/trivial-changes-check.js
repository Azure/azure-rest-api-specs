// For now, treat all paths as posix, since this is the format returned from git commands
import debug from "debug";
import { simpleGit } from "simple-git";
import {
  getChangedFiles,
  getChangedFilesStatuses,
  json,
  example,
} from "../../shared/src/changed-files.js";
import { CoreLogger } from "./core-logger.js";

// Enable simple-git debug logging to improve console output
debug.enable("simple-git");

/**
 * Non-functional JSON property keys that are safe to change without affecting API behavior
 */
const NON_FUNCTIONAL_PROPERTIES = new Set([
  'description',
  'title',
  'summary',
  'x-ms-summary',
  'x-ms-description',
  'externalDocs',
  'x-ms-examples',
  'x-example',
  'example',
  'examples',
  'x-ms-client-name',
  'x-ms-parameter-name',
  'x-ms-enum',
  'x-ms-discriminator-value',
  'x-ms-client-flatten',
  'x-ms-azure-resource',
  'x-ms-mutability',
  'x-ms-secret',
  'x-ms-parameter-location',
  'x-ms-skip-url-encoding',
  'x-ms-long-running-operation',
  'x-ms-long-running-operation-options',
  'x-ms-pageable',
  'x-ms-odata',
  'tags',
  'x-ms-api-annotation'
]);

/**
 * @param {import('@actions/github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<{documentationOnlyChanges: boolean, examplesOnlyChanges: boolean, nonFunctionalChanges: boolean, anyTrivialChanges: boolean}>}
 */
export default async function checkTrivialChanges({ core }) {
  const options = {
    cwd: process.env.GITHUB_WORKSPACE,
    logger: new CoreLogger(core),
  };

  const changedFiles = await getChangedFiles(options);
  const changedFilesStatuses = await getChangedFilesStatuses(options);
  const git = simpleGit(options.cwd);

  if (changedFiles.length === 0) {
    core.info("No changes detected in PR");
    return {
      documentationOnlyChanges: false,
      examplesOnlyChanges: false,
      nonFunctionalChanges: false,
      anyTrivialChanges: false,
    };
  }

  // Check for documentation-only changes (.md files)
  const documentationFiles = changedFiles.filter(file => 
    file.toLowerCase().endsWith('.md')
  );
  const documentationOnlyChanges = documentationFiles.length > 0 && 
    documentationFiles.length === changedFiles.length;

  core.info(`Documentation files changed: ${documentationFiles.length}`);
  core.info(`Documentation-only changes: ${documentationOnlyChanges}`);

  // Check for examples-only changes
  const exampleFiles = changedFiles.filter(example);
  const examplesOnlyChanges = exampleFiles.length > 0 && 
    exampleFiles.length === changedFiles.length;

  core.info(`Example files changed: ${exampleFiles.length}`);
  core.info(`Examples-only changes: ${examplesOnlyChanges}`);

  // Check what types of non-JSON files we have (used for multiple checks)
  // Note: Example files are JSON files, so they won't be in this list
  const nonJsonFiles = changedFiles.filter(file => !json(file));
  const nonJsonFilesAreTrivial = nonJsonFiles.every(file => 
    file.toLowerCase().endsWith('.md')
  );

  // Check for non-functional JSON changes
  let nonFunctionalChanges = false;
  const jsonFiles = changedFiles.filter(json).filter(file => !example(file));
  
  if (jsonFiles.length > 0) {
    core.info(`Analyzing ${jsonFiles.length} JSON files for non-functional changes...`);
    
    // Check if all JSON changes are non-functional
    let allJsonChangesNonFunctional = true;
    
    for (const file of jsonFiles) {
      core.info(`Analyzing file: ${file}`);
      
      try {
        const isNonFunctional = await analyzeJsonFileChanges(file, git, core);
        if (!isNonFunctional) {
          core.info(`File ${file} contains functional changes`);
          allJsonChangesNonFunctional = false;
          break;
        } else {
          core.info(`File ${file} contains only non-functional changes`);
        }
      } catch (error) {
        core.warning(`Failed to analyze ${file}: ${error.message}`);
        allJsonChangesNonFunctional = false;
        break;
      }
    }
    
    // Non-functional changes if:
    // 1. All non-example JSON files have only non-functional changes, AND
    // 2. Any remaining files are documentation (.md files)
    // Note: Example JSON files are already considered trivial by design
    nonFunctionalChanges = allJsonChangesNonFunctional && nonJsonFilesAreTrivial;
  }

  core.info(`Non-functional changes: ${nonFunctionalChanges}`);

  // Calculate if ANY trivial changes exist
  // This should be true if ALL changed files are trivial types:
  // - Documentation files (.md)
  // - Example files (/examples/*.json)  
  // - JSON files with only non-functional changes
  const trivialFileTypes = documentationFiles.length + exampleFiles.length;
  const functionalJsonFiles = jsonFiles.filter(async (file) => {
    try {
      return !(await analyzeJsonFileChanges(file, git, core));
    } catch {
      return true; // Treat errors as functional changes
    }
  });
  
  // For anyTrivialChanges, we need to check if ALL files are trivial
  // This is different from the individual "only" checks
  let anyTrivialChanges;
  if (documentationOnlyChanges || examplesOnlyChanges) {
    // Pure documentation or pure examples
    anyTrivialChanges = true;
  } else if (nonFunctionalChanges) {
    // JSON files with only non-functional changes (and possibly docs)
    anyTrivialChanges = true;
  } else if (jsonFiles.length === 0 && trivialFileTypes === changedFiles.length) {
    // Mixed documentation + examples (no JSON files to analyze)
    anyTrivialChanges = true;
  } else {
    // Some files are functional changes
    anyTrivialChanges = false;
  }

  core.info(`Any trivial changes: ${anyTrivialChanges}`);

  const result = {
    documentationOnlyChanges,
    examplesOnlyChanges,
    nonFunctionalChanges,
    anyTrivialChanges,
  };

  core.info(`Final result: ${JSON.stringify(result)}`);
  
  return result;
}

/**
 * Analyzes changes in a JSON file to determine if they are non-functional
 * @param {string} file - The file path
 * @param {import('simple-git').SimpleGit} git - Git instance
 * @param {typeof import("@actions/core")} core - Core logger
 * @returns {Promise<boolean>} - True if changes are non-functional
 */
async function analyzeJsonFileChanges(file, git, core) {
  let baseContent;
  let headContent;
  
  try {
    baseContent = await git.show([`HEAD^:${file}`]);
  } catch (e) {
    if (e instanceof Error && e.message.includes("does not exist")) {
      // New file - consider it functional change unless it's pure metadata
      core.info(`File ${file} is new`);
      try {
        headContent = await git.show([`HEAD:${file}`]);
        return isNewFileNonFunctional(headContent, core);
      } catch {
        return false;
      }
    } else {
      throw e;
    }
  }
  
  try {
    headContent = await git.show([`HEAD:${file}`]);
  } catch (e) {
    if (e instanceof Error && e.message.includes("does not exist")) {
      // File deleted - consider it functional change
      core.info(`File ${file} was deleted`);
      return false;
    } else {
      throw e;
    }
  }

  let baseJson, headJson;
  
  try {
    baseJson = JSON.parse(baseContent);
    headJson = JSON.parse(headContent);
  } catch (error) {
    core.warning(`Failed to parse JSON for ${file}: ${error.message}`);
    return false;
  }

  return analyzeJsonDifferences(baseJson, headJson, "", core);
}

/**
 * Analyzes if a new JSON file contains only non-functional content
 * @param {string} content - JSON content
 * @param {typeof import("@actions/core")} core - Core logger
 * @returns {boolean} - True if non-functional
 */
function isNewFileNonFunctional(content, core) {
  try {
    const jsonObj = JSON.parse(content);
    // For new files, we're more conservative - only consider it non-functional 
    // if it's clearly metadata-only (like a new example file)
    return false; // Conservative approach for new files
  } catch {
    return false;
  }
}

/**
 * Recursively analyzes differences between two JSON objects
 * @param {any} baseObj - Base object
 * @param {any} headObj - Head object  
 * @param {string} path - Current path in the object
 * @param {typeof import("@actions/core")} core - Core logger
 * @returns {boolean} - True if all differences are non-functional
 */
function analyzeJsonDifferences(baseObj, headObj, path, core) {
  // If types differ, it's a functional change
  if (typeof baseObj !== typeof headObj) {
    core.info(`Type change at ${path || 'root'}: ${typeof baseObj} -> ${typeof headObj}`);
    return false;
  }

  // Handle null values
  if (baseObj === null || headObj === null) {
    if (baseObj !== headObj) {
      core.info(`Null value change at ${path || 'root'}`);
      return false;
    }
    return true;
  }

  // Handle arrays
  if (Array.isArray(baseObj) && Array.isArray(headObj)) {
    // For arrays, we need to be careful about order and additions/removals
    if (baseObj.length !== headObj.length) {
      // Check if the change is just adding/removing non-functional properties
      const arrayPath = path || 'root';
      // For now, treat any array length change as functional unless we can prove otherwise
      core.info(`Array length change at ${arrayPath}: ${baseObj.length} -> ${headObj.length}`);
      
      // Special case: if arrays contain only strings and changes are in non-functional properties like tags
      if (isNonFunctionalArrayChange(baseObj, headObj, path)) {
        return true;
      }
      return false;
    }

    // Check each element
    for (let i = 0; i < baseObj.length; i++) {
      if (!analyzeJsonDifferences(baseObj[i], headObj[i], `${path}[${i}]`, core)) {
        return false;
      }
    }
    return true;
  }

  // Handle objects
  if (typeof baseObj === 'object' && typeof headObj === 'object') {
    const baseKeys = new Set(Object.keys(baseObj));
    const headKeys = new Set(Object.keys(headObj));
    
    // Check for added or removed keys
    for (const key of baseKeys) {
      if (!headKeys.has(key)) {
        const fullPath = path ? `${path}.${key}` : key;
        if (!NON_FUNCTIONAL_PROPERTIES.has(key)) {
          core.info(`Property removed at ${fullPath} (functional)`);
          return false;
        }
        core.info(`Property removed at ${fullPath} (non-functional)`);
      }
    }
    
    for (const key of headKeys) {
      if (!baseKeys.has(key)) {
        const fullPath = path ? `${path}.${key}` : key;
        if (!NON_FUNCTIONAL_PROPERTIES.has(key)) {
          core.info(`Property added at ${fullPath} (functional)`);
          return false;
        }
        core.info(`Property added at ${fullPath} (non-functional)`);
      }
    }

    // Check changed properties
    for (const key of baseKeys) {
      if (headKeys.has(key)) {
        const fullPath = path ? `${path}.${key}` : key;
        if (!analyzeJsonDifferences(baseObj[key], headObj[key], fullPath, core)) {
          // If the change is in a non-functional property, it's still non-functional
          if (NON_FUNCTIONAL_PROPERTIES.has(key)) {
            core.info(`Property changed at ${fullPath} (non-functional)`);
            continue;
          }
          return false;
        }
      }
    }
    
    return true;
  }

  // Handle primitive values
  if (baseObj !== headObj) {
    const currentProperty = path.split('.').pop() || path.split('[')[0];
    if (NON_FUNCTIONAL_PROPERTIES.has(currentProperty)) {
      core.info(`Value changed at ${path || 'root'} (non-functional): "${baseObj}" -> "${headObj}"`);
      return true;
    }
    core.info(`Value changed at ${path || 'root'} (functional): "${baseObj}" -> "${headObj}"`);
    return false;
  }

  return true;
}

/**
 * Checks if an array change is non-functional (e.g., tags, examples)
 * @param {any[]} baseArray - Base array
 * @param {any[]} headArray - Head array
 * @param {string} path - Current path
 * @returns {boolean} - True if non-functional
 */
function isNonFunctionalArrayChange(baseArray, headArray, path) {
  const currentProperty = path.split('.').pop() || path;
  
  // Tags array changes are typically non-functional
  if (currentProperty === 'tags') {
    return true;
  }
  
  // Examples array changes are typically non-functional
  if (currentProperty === 'examples' || currentProperty === 'x-ms-examples') {
    return true;
  }
  
  return false;
}