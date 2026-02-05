#!/usr/bin/env node

import { execSync } from 'child_process';
import { readdirSync, existsSync, statSync, writeFileSync } from 'fs';
import { join, dirname } from 'path';
import { simpleGit } from 'simple-git';
import { getChangedFiles, swagger, example, resourceManager } from '../../shared/src/changed-files.js';
import { checkLease } from './detect-arm-leases.js';

// ============================================
// Configuration
// ============================================

const SPECIFICATION_PATH = 'specification';
// Match pattern: specification/<service>/resource-manager/<ResourceProvider.Namespace>/...
const RESOURCE_MANAGER_PATTERN = /^specification\/[^\/]+\/resource-manager\/([^\/]+)/;
// Match pattern with optional service group: specification/<service>/resource-manager/<ResourceProvider.Namespace>/<ServiceGroup>/...
// ServiceGroup folder name should not start with "stable" or "preview"
const RESOURCE_MANAGER_WITH_GROUP_PATTERN = /^specification\/[^\/]+\/resource-manager\/([^\/]+)\/(?!stable|preview)([^\/]+)\//;

/**
 * New resource provider label names.
 * @readonly
 * @enum {string}
 */
const NewRpLabel = Object.freeze({
  ArmModelingReviewRequired: 'ARMModelingReviewRequired',
  NotReadyForArmReview: 'NotReadyForARMReview'
});

// Label action values used by update-labels workflow
const LABEL_ACTIONS = Object.freeze({
  add: 'add',
  remove: 'remove',
  none: 'none'
});

const DEFAULT_LABEL_ACTIONS = Object.freeze({
  [NewRpLabel.ArmModelingReviewRequired]: LABEL_ACTIONS.none,
  [NewRpLabel.NotReadyForArmReview]: LABEL_ACTIONS.none
});

// ============================================
// Utility Functions
// ============================================

/**
 * Check if a resource provider namespace exists in the specification directory
 * @param {string} specPath - Path to specification directory
 * @param {string} namespace - Resource provider namespace (e.g., Microsoft.App)
 * @returns {boolean} True if namespace exists
 */
function resourceProviderExists(specPath, namespace) {
  if (!existsSync(specPath)) {
    return false;
  }

  try {
    const serviceDirs = readdirSync(specPath);
    
    for (const serviceDir of serviceDirs) {
      const servicePath = join(specPath, serviceDir);
      if (!statSync(servicePath).isDirectory()) continue;
      
      const rmPath = join(servicePath, 'resource-manager');
      if (!existsSync(rmPath)) continue;
      
      const namespacePath = join(rmPath, namespace);
      if (existsSync(namespacePath) && statSync(namespacePath).isDirectory()) {
        return true;
      }
    }
  } catch (error) {
    console.error('Error checking resource provider existence:', error.message);
  }
  
  return false;
}

function getLabelActions(hasNewResourceProviders) {
  if (!hasNewResourceProviders) {
    return {
      [NewRpLabel.ArmModelingReviewRequired]: LABEL_ACTIONS.remove,
      [NewRpLabel.NotReadyForArmReview]: LABEL_ACTIONS.remove
    };
  }

  return {
    [NewRpLabel.ArmModelingReviewRequired]: LABEL_ACTIONS.add,
    [NewRpLabel.NotReadyForArmReview]: LABEL_ACTIONS.add
  };
}

function getContextOutput(context) {
  const headSha = context?.payload?.pull_request?.head?.sha || '';
  const issueNumber = Number(context?.issue?.number || context?.payload?.pull_request?.number || 0);

  return { headSha, issueNumber };
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
 * @param {Object} params.github - GitHub API client
 * @param {Object} params.context - GitHub context
 * @param {Object} params.core - GitHub Actions core
 * @param {string} params.baseBranch - Base branch name
 * @returns {Promise<string>} Result status
 */
export default async function detectNewResourceProvider({ github, context, core, baseBranch }) {
  const repoRoot = execSync('git rev-parse --show-toplevel', { encoding: 'utf-8' }).trim();

  console.log('Detecting New Resource Providers\n');

  // Get the merge base for proper PR comparison
  let mergeBase;
  try {
    mergeBase = execSync(`git merge-base origin/${baseBranch} HEAD`, { encoding: 'utf-8' }).trim();
  } catch (error) {
    mergeBase = `origin/${baseBranch}`;
  }

  // Get all changed files in specification/*/resource-manager/
  const allFiles = await getChangedFiles({
    baseCommitish: mergeBase,
    headCommitish: 'HEAD'
  });

  const rmFiles = allFiles.filter((file) => resourceManager(file) && file.startsWith('specification/'));

  if (rmFiles.length === 0) {
    console.log('No resource-manager files changed');
    return {
      status: 'no-changes',
      labelActions: DEFAULT_LABEL_ACTIONS,
      ...getContextOutput(context)
    };
  }

  // Extract resource providers from changed files
  const changedResourceProviders = extractResourceProviders(rmFiles);

  // Pre-check: Verify if spec directories are brand new (don't exist in base branch)
  const git = simpleGit(repoRoot);
  const changedSpecDirs = new Set([
    ...rmFiles.filter(swagger).map((f) => dirname(dirname(dirname(f)))),
    ...rmFiles.filter(example).map((f) => dirname(dirname(dirname(dirname(f))))),
  ]);

  if (changedSpecDirs.size > 0) {
    let hasAtLeastOneBrandNewRP = false;
    
    for (const changedSpecDir of changedSpecDirs) {
      try {
        const specFilesBaseBranch = await git.raw([
          'ls-tree',
          '-r',
          '--name-only',
          mergeBase,
          changedSpecDir,
        ]);
        
        const specRmSwaggerFilesBaseBranch = specFilesBaseBranch
          .split('\n')
          .filter((file) => resourceManager(file) && swagger(file));

        if (specRmSwaggerFilesBaseBranch.length === 0) {
          hasAtLeastOneBrandNewRP = true;
        }
      } catch (error) {
        // Directory doesn't exist in base - brand new RP
        hasAtLeastOneBrandNewRP = true;
      }
    }
    
    if (!hasAtLeastOneBrandNewRP) {
      console.log('No brand new resource providers detected, spec directories exist in base branch.');
      console.log('Skipping workflow.\n');
      return {
        status: 'no-new-rp',
        labelActions: getLabelActions(false),
        ...getContextOutput(context)
      };
    }
  }

  // Extract resource providers and filter for new ones
  const specPath = join(repoRoot, SPECIFICATION_PATH);
  const newResourceProviders = [];
  
  for (const [rp, info] of changedResourceProviders) {
    if (!resourceProviderExists(specPath, rp)) {
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
    console.log(`\nDetected ${newResourceProviders.length} new resource provider(s)\n`);
    
    for (const rp of newResourceProviders) {
      const leaseValid = checkLease(rp.serviceName, rp.namespace, rp.serviceGroup || '');
      
      leaseCheckResults.push({
        namespace: rp.namespace,
        serviceName: rp.serviceName,
        serviceGroup: rp.serviceGroup,
        leaseValid: leaseValid,
        leaseMessage: leaseValid ? 'Lease is valid' : 'No lease file found or lease has expired'
      });
      
      const leaseStatus = leaseValid ? 'Lease valid' : 'Lease invalid';
      console.log(`  - ${rp.namespace}: ${leaseStatus}`);
    }
    
    writeFileSync(
      join(repoRoot, '.github', 'new-rp-output.json'),
      JSON.stringify({ newResourceProviders: leaseCheckResults }, null, 2)
    );
    
    // Create PR comment with detected resource providers
    const rpList = leaseCheckResults
      .map(rp => `- \`${rp.namespace}\``)
      .join('\n');

    const commentBody = [
      '## New Resource Provider Detected',
      'The following new resource provider namespace(s) were detected in this PR:\n',
      rpList,
      '\n### Action Required',
      'New resource provider namespaces require having a discussion with the ARM team at **ARM API Modeling Office Hours** before merging.\n',
      '**Please schedule here:**',
      'https://outlook.office365.com/book/ARMOfficeHours1@microsoft.onmicrosoft.com/?ismsaljsauthenabled=true'
    ].join('\n');

    try {
      await github.rest.issues.createComment({
        owner: context.repo.owner,
        repo: context.repo.repo,
        issue_number: context.issue.number,
        body: commentBody
      });
      console.log('PR comment created successfully');
    } catch (error) {
      console.log(`[FAILED] Failed to create PR comment: ${error.message}`);
    }
    
    // Set the action as failed to indicate new RPs were detected
    core.setFailed('New resource providers detected');
    return {
      status: 'new-rp-detected',
      labelActions: getLabelActions(true),
      ...getContextOutput(context)
    };
  } else {
    console.log('No new resource providers detected.\n');
    return {
      status: 'no-new-rp',
      labelActions: getLabelActions(false),
      ...getContextOutput(context)
    };
  }
}

