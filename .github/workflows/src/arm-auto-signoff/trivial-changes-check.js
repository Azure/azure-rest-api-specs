// For now, treat all paths as posix, since this is the format returned from git commands
import debug from "debug";
import { simpleGit } from "simple-git";
import {
  getChangedFiles,
  getChangedFilesStatuses,
  json,
  example,
  markdown,
  resourceManager,
} from "../../../shared/src/changed-files.js";
import {
  createEmptyPullRequestChanges,
  isTrivialPullRequest,
  isDocumentationOnly,
  isExamplesOnly,
  isNonFunctionalOnly,
} from "../../../shared/src/pr-changes.js";
import { CoreLogger } from "../core-logger.js";

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
 * Analyzes a PR to determine what types of changes it contains
 * @param {import('@actions/github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<string>} JSON string of {@link import('../../../shared/src/pr-changes.js').PullRequestChanges}
 */
export default async function checkTrivialChanges({ core, context }) {
  // Get the actual PR base branch from GitHub context
  // This works for any target branch (main, dev, release/*, etc.)
  const baseBranch = context.payload.pull_request?.base?.ref || "main";
  const baseRef = `origin/${baseBranch}`;
  
  core.info(`Comparing against base branch: ${baseRef}`);
  
  const options = {
    cwd: process.env.GITHUB_WORKSPACE,
    logger: new CoreLogger(core),
    // Compare against the actual PR base branch
    baseCommitish: baseRef,
  };

  const changedFiles = await getChangedFiles(options);
  const changedFilesStatuses = await getChangedFilesStatuses(options);
  const git = simpleGit(options.cwd);

  // Filter to only resource-manager files for ARM auto-signoff
  const changedRmFiles = changedFiles.filter(resourceManager);
  const changedRmFilesStatuses = {
    additions: changedFilesStatuses.additions.filter(resourceManager),
    modifications: changedFilesStatuses.modifications.filter(resourceManager),
    deletions: changedFilesStatuses.deletions.filter(resourceManager),
    renames: changedFilesStatuses.renames.filter(r => resourceManager(r.to) || resourceManager(r.from))
  };

  if (changedRmFiles.length === 0) {
    core.info("No resource-manager changes detected in PR");
    return JSON.stringify(createEmptyPullRequestChanges());
  }

  // Check if PR contains non-resource-manager changes
  const hasNonRmChanges = changedFiles.length > changedRmFiles.length;
  if (hasNonRmChanges) {
    const nonRmFiles = changedFiles.filter(file => !resourceManager(file));
    core.info(`PR contains ${nonRmFiles.length} non-resource-manager changes - not eligible for ARM auto-signoff`);
    core.info(`Non-RM files: ${nonRmFiles.slice(0, 5).join(', ')}${nonRmFiles.length > 5 ? ` ... and ${nonRmFiles.length - 5} more` : ''}`);
    const result = createEmptyPullRequestChanges();
    result.other = true;
    return JSON.stringify(result);
  }

  // Check for non-trivial file operations (additions, deletions, renames)
  const hasNonTrivialFileOperations = checkForNonTrivialFileOperations(changedRmFilesStatuses, core);
  if (hasNonTrivialFileOperations) {
    core.info("Non-trivial file operations detected (new spec files, deletions, or renames)");
    // These are functional changes by policy
    const result = createEmptyPullRequestChanges();
    result.functional = true;
    return JSON.stringify(result);
  }

  // Analyze what types of changes are present
  const changes = await analyzePullRequestChanges(changedRmFiles, git, core, baseRef);

  core.info(`PR Changes: ${JSON.stringify(changes)}`);
  core.info(`Is trivial: ${isTrivialPullRequest(changes)}`);
  
  return JSON.stringify(changes);
}

/**
 * Checks for non-trivial file operations: additions/deletions of spec files, or any renames
 * @param {{additions: string[], modifications: string[], deletions: string[], renames: {from: string, to: string}[]}} changedFilesStatuses - File status information
 * @param {typeof import("@actions/core")} core - Core logger
 * @returns {boolean} - True if non-trivial operations detected
 */
function checkForNonTrivialFileOperations(changedFilesStatuses, core) {
  // New spec files (non-example JSON) are non-trivial
  const newSpecFiles = changedFilesStatuses.additions.filter(file => 
    json(file) && !example(file) && !markdown(file)
  );
  if (newSpecFiles.length > 0) {
    core.info(`Non-trivial: New spec files detected: ${newSpecFiles.join(', ')}`);
    return true;
  }

  // Deleted spec files (non-example JSON) are non-trivial
  const deletedSpecFiles = changedFilesStatuses.deletions.filter(file => 
    json(file) && !example(file) && !markdown(file)
  );
  if (deletedSpecFiles.length > 0) {
    core.info(`Non-trivial: Deleted spec files detected: ${deletedSpecFiles.join(', ')}`);
    return true;
  }

  // Any file renames/moves are non-trivial (conservative approach)
  if (changedFilesStatuses.renames.length > 0) {
    core.info(`Non-trivial: File renames detected: ${changedFilesStatuses.renames.map(r => `${r.from} → ${r.to}`).join(', ')}`);
    return true;
  }

  // Deletions of docs/examples are OK, but already filtered above
  return false;
}

/**
 * Analyzes a PR to determine what types of changes it contains
 * @param {string[]} changedFiles - Array of changed file paths
 * @param {import('simple-git').SimpleGit} git - Git instance
 * @param {typeof import("@actions/core")} core - Core logger
 * @param {string} baseRef - The base branch reference (e.g., "origin/main")
 * @returns {Promise<import('../../../shared/src/pr-changes.js').PullRequestChanges>}
 */
async function analyzePullRequestChanges(changedFiles, git, core, baseRef) {
  const changes = createEmptyPullRequestChanges();

  // Categorize files by type
  const documentationFiles = changedFiles.filter(markdown);
  const exampleFiles = changedFiles.filter(example);
  const specFiles = changedFiles.filter(json).filter(file => !example(file));
  const otherFiles = changedFiles.filter(file => !json(file) && !markdown(file));

  core.info(`File breakdown: ${documentationFiles.length} docs, ${exampleFiles.length} examples, ${specFiles.length} specs, ${otherFiles.length} other`);

  // Set flags for file types present
  if (documentationFiles.length > 0) {
    changes.documentation = true;
  }

  if (exampleFiles.length > 0) {
    changes.examples = true;
  }

  if (otherFiles.length > 0) {
    changes.other = true;
  }

  // Analyze spec files to determine if functional or non-functional
  if (specFiles.length > 0) {
    core.info(`Analyzing ${specFiles.length} spec files...`);
    
    let hasFunctionalChanges = false;
    let hasNonFunctionalChanges = false;

    for (const file of specFiles) {
      core.info(`Analyzing file: ${file}`);
      
      try {
        const isNonFunctional = await analyzeSpecFileForFunctionalChanges(file, git, core, baseRef);
        if (isNonFunctional) {
          hasNonFunctionalChanges = true;
          core.info(`File ${file} contains only non-functional changes`);
        } else {
          hasFunctionalChanges = true;
          core.info(`File ${file} contains functional changes`);
          // Once we find functional changes, we can stop
          break;
        }
      } catch (error) {
        core.warning(`Failed to analyze ${file}: ${error.message}`);
        // On error, treat as functional to be conservative
        hasFunctionalChanges = true;
        break;
      }
    }

    changes.functional = hasFunctionalChanges;
    changes.nonFunctional = hasNonFunctionalChanges;
  }

  return changes;
}

/**
 * Analyzes changes in a spec file to determine if they are functional or non-functional
 * Note: New files and deletions should already be filtered by checkForNonTrivialFileOperations
 * @param {string} file - The file path
 * @param {import('simple-git').SimpleGit} git - Git instance
 * @param {typeof import("@actions/core")} core - Core logger
 * @param {string} baseRef - The base branch reference (e.g., "origin/main")
 * @returns {Promise<boolean>} - True if changes are non-functional only
 */
async function analyzeSpecFileForFunctionalChanges(file, git, core, baseRef) {
  let baseContent;
  let headContent;
  
  try {
    // Get file content from PR base branch
    baseContent = await git.show([`${baseRef}:${file}`]);
  } catch (e) {
    if (e instanceof Error && e.message.includes("does not exist")) {
      // New file - should have been caught earlier, but treat as functional to be safe
      core.info(`File ${file} is new - treating as functional`);
      return false;
    } else {
      throw e;
    }
  }
  
  try {
    headContent = await git.show([`HEAD:${file}`]);
  } catch (e) {
    if (e instanceof Error && e.message.includes("does not exist")) {
      // File deleted - should have been caught earlier, but treat as functional to be safe
      core.info(`File ${file} was deleted - treating as functional`);
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
  return NON_FUNCTIONAL_PROPERTIES.has(currentProperty);
}