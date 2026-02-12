import { writeFileSync } from 'fs';
import { join } from 'path';
import { simpleGit } from 'simple-git';
import { getChangedFiles, swagger, resourceManager } from '../../shared/src/changed-files.js';
import { getRootFolder } from '../../shared/src/simple-git.js';
import { checkLease } from './detect-arm-leases.js';
import { CoreLogger } from './core-logger.js';
import { LabelAction } from './label.js';

// ============================================
// Configuration
// ============================================

// Match pattern: specification/<service>/resource-manager/<ResourceProvider.Namespace>/...
// Trailing slash ensures the match is a directory component, not a file like readme.md
const RESOURCE_MANAGER_PATTERN = /^specification\/[^\/]+\/resource-manager\/([^\/]+)\//;
// Match pattern with optional service group: specification/<service>/resource-manager/<ResourceProvider.Namespace>/<ServiceGroup>/...
// ServiceGroup folder name should not start with "stable" or "preview"
const RESOURCE_MANAGER_WITH_GROUP_PATTERN = /^specification\/[^\/]+\/resource-manager\/([^\/]+)\/(?!stable|preview)([^\/]+)\//;

/**
 * New resource provider label names.
 * @readonly
 * @enum {string}
 */
const NewRpLabel = Object.freeze({
  ArmModelingReviewRequired: 'ARMModelingReviewRequired'
});

const DEFAULT_LABEL_ACTIONS = Object.freeze({
  [NewRpLabel.ArmModelingReviewRequired]: LabelAction.None
});

// ============================================
// Utility Functions
// ============================================

/**
 * Check if a resource provider namespace existed in a specific git commit.
 * Uses git ls-tree to check the base commit, avoiding false positives from
 * RPs that were just added in the current PR.
 * 
 * @param {Object} git - simple-git instance
 * @param {string} commitish - Git commit reference (e.g., merge base SHA)
 * @param {string} namespace - Resource provider namespace (e.g., Microsoft.App)
 * @returns {Promise<boolean>} True if namespace existed in the commit
 */
async function resourceProviderExistsInCommit(git, commitish, namespace) {
  try {
    // List all directories under specification/*/resource-manager/ in the base commit
    const output = await git.raw([
      'ls-tree',
      '-d',
      '--name-only',
      '-r',
      commitish,
      'specification/'
    ]);

    // Look for resource-manager/<namespace> pattern in any service directory
    const pattern = new RegExp(`^specification/[^/]+/resource-manager/${namespace.replace('.', '\\.')}$`, 'm');
    return pattern.test(output);
  } catch {
    // Error checking - assume RP doesn't exist if we can't verify
    return false;
  }
}

function getLabelActions(hasNewResourceProviders) {
  if (!hasNewResourceProviders) {
    return {
      [NewRpLabel.ArmModelingReviewRequired]: LabelAction.Remove
    };
  }

  return {
    [NewRpLabel.ArmModelingReviewRequired]: LabelAction.Add
  };
}

/**
 * Extract resource provider namespaces, service names, and optional service groups from file paths
 * @param {string[]} files - Array of file paths
 * @returns {Map<string, {serviceName: string, serviceGroup?: string}>} Map of namespace to service info
 */
function extractResourceProviders(files) {
  const resourceProviders = new Map();
  
  for (const file of files) {
    const match = file.match(RESOURCE_MANAGER_PATTERN);
    if (match) {
      const parts = file.split('/');
      const serviceName = parts[1];
      const namespace = match[1];
      
      // Check if there's a service group
      const groupMatch = file.match(RESOURCE_MANAGER_WITH_GROUP_PATTERN);
      if (groupMatch) {
        const serviceGroup = groupMatch[2];
        resourceProviders.set(namespace, { serviceName, serviceGroup });
      } else {
        resourceProviders.set(namespace, { serviceName });
      }
    }
  }
  
  return resourceProviders;
}

// ============================================
// Main Detection Logic
// ============================================

/**
 * Main detection logic for GitHub script action
 * @param {Object} params - Parameters from github-script
 * @param {Object} params.context - GitHub context
 * @param {Object} params.core - GitHub Actions core
 * @returns {Promise<{ status: string, labelActions: Record<string, string> }>} Result including status and label actions
 */
export default async function detectNewResourceProvider({ context, core }) {
  const repoRoot = await getRootFolder(process.cwd());
  const git = simpleGit(repoRoot);

  core.info('Detecting New Resource Providers');

  // Get base branch from context
  const baseBranch = context.payload.pull_request?.base?.ref;
  if (!baseBranch) {
    throw new Error('Could not determine base branch from pull request context');
  }

  // Get the merge base for proper PR comparison.
  // With fetch-depth: 2, HEAD is the PR merge commit and HEAD^ is the base commit.
  // git merge-base may fail if origin/<branch> isn't fetched, so fall back to HEAD^.
  let mergeBase;
  try {
    mergeBase = await git.raw(['merge-base', `origin/${baseBranch}`, 'HEAD']).then(s => s.trim());
  } catch {
    mergeBase = 'HEAD^';
  }

  // Get all changed files in specification/
  const options = {
    cwd: repoRoot,
    paths: ['specification'],
    logger: new CoreLogger(core),
  };

  const changedFiles = await getChangedFiles(options);

  // Filter to resource-manager files
  const rmFiles = changedFiles.filter(resourceManager);

  if (rmFiles.length === 0) {
    core.info("No changes to files containing path '/resource-manager/'");
    return {
      status: 'no-changes',
      labelActions: DEFAULT_LABEL_ACTIONS
    };
  }

  // Extract resource providers from changed files
  const changedResourceProviders = extractResourceProviders(rmFiles);

  // Pre-check: Verify if any namespace directories are brand new (don't exist in base branch)
  // Extract unique namespace paths directly from the changed files using the regex pattern
  const changedNamespacePaths = new Set(
    rmFiles
      .map((f) => {
        const match = f.match(RESOURCE_MANAGER_PATTERN);
        if (match) {
          // Extract path up to and including the namespace: specification/<service>/resource-manager/<namespace>
          // match[0] includes trailing slash, so strip it
          return f.substring(0, match.index + match[0].length - 1);
        }
        return null;
      })
      .filter(Boolean)
  );

  if (changedNamespacePaths.size > 0) {
    let hasAtLeastOneBrandNewRP = false;
    
    for (const namespacePath of changedNamespacePaths) {
      try {
        const specFilesBaseBranch = await git.raw([
          'ls-tree',
          '-r',
          '--name-only',
          mergeBase,
          namespacePath,
        ]);
        
        const specRmSwaggerFilesBaseBranch = specFilesBaseBranch
          .split('\n')
          .filter((file) => resourceManager(file) && swagger(file));

        if (specRmSwaggerFilesBaseBranch.length === 0) {
          hasAtLeastOneBrandNewRP = true;
        }
      } catch {
        // Directory doesn't exist in base - brand new RP
        hasAtLeastOneBrandNewRP = true;
      }
    }
    
    if (!hasAtLeastOneBrandNewRP) {
      core.info('No brand new resource providers detected, spec directories exist in base branch.');
      core.info('Skipping workflow.');
      return {
        status: 'no-new-rp',
        labelActions: getLabelActions(false)
      };
    }
  }

  // Extract resource providers and filter for new ones
  const newResourceProviders = [];
  
  for (const [rp, info] of changedResourceProviders) {
    const existsInBase = await resourceProviderExistsInCommit(git, mergeBase, rp);
    if (!existsInBase) {
      newResourceProviders.push({ 
        namespace: rp, 
        serviceName: info.serviceName,
        serviceGroup: info.serviceGroup 
      });
    } 
  }
  
  // Check ARM leases for new resource providers
  const leaseCheckResults = [];
  
  if (newResourceProviders.length > 0) {
    core.info(`Detected ${newResourceProviders.length} new resource provider(s)`);
    
    for (const rp of newResourceProviders) {
      const leaseValid = await checkLease(rp.serviceName, rp.namespace, rp.serviceGroup || '');
      
      leaseCheckResults.push({
        namespace: rp.namespace,
        serviceName: rp.serviceName,
        serviceGroup: rp.serviceGroup,
        leaseValid: leaseValid,
        leaseMessage: leaseValid ? 'Lease is valid' : 'No lease file found or lease has expired'
      });
      
      const leaseStatus = leaseValid ? 'Lease valid' : 'Lease invalid';
      core.info(`  - ${rp.namespace}: ${leaseStatus}`);
    }
    
    writeFileSync(
      join(repoRoot, '.github', 'new-rp-output.json'),
      JSON.stringify({ newResourceProviders: leaseCheckResults }, null, 2)
    );
    
    // Partition results by lease validity
    const invalidLeases = leaseCheckResults.filter(rp => !rp.leaseValid);
    const allLeasesValid = invalidLeases.length === 0;

    if (!allLeasesValid) {
      for (const rp of invalidLeases) {
        core.error(`${rp.namespace}: ${rp.leaseMessage}`);
      }
      core.setFailed(
        `${invalidLeases.length} new resource provider(s) detected without a valid ARM lease. ` +
        'Please schedule a discussion at ARM API Modeling Office Hours before merging: ' +
        'https://outlook.office365.com/book/ARMOfficeHours1@microsoft.onmicrosoft.com/?ismsaljsauthenabled=true'
      );
    } else {
      core.info('New resource provider(s) detected with valid ARM lease — no action required.');
    }

    return {
      status: allLeasesValid ? 'new-rp-all-leases-valid' : 'new-rp-invalid-lease',
      labelActions: getLabelActions(!allLeasesValid)
    };
  } else {
    core.info('No new resource providers detected.');
    return {
      status: 'no-new-rp',
      labelActions: getLabelActions(false)
    };
  }
}

