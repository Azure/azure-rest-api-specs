#!/usr/bin/env node

import { execSync } from 'child_process';
import { readdirSync, existsSync, statSync, writeFileSync } from 'fs';
import { join, dirname } from 'path';
import { Octokit } from '@octokit/rest';
import { simpleGit } from 'simple-git';
import { getChangedFiles, swagger, example } from '../../shared/src/changed-files.js';
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

// Labels to add when new resource providers are detected
const NEW_RP_LABELS = ['ARMModelingReviewRequired', 'NotReadyForARMReview'];

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

/**
 * Add labels to the PR for new resource providers
 * @returns {Promise<void>}
 */
async function addNewResourceProviderLabels() {
  const githubToken = process.env.GITHUB_TOKEN;
  const prNumber = process.env.PR_NUMBER;
  const repoOwner = process.env.REPO_OWNER || 'Azure';
  const repoName = process.env.REPO_NAME || 'azure-rest-api-specs';

  if (!githubToken) {
    console.log('GITHUB_TOKEN not available, skipping label addition');
    return;
  }

  if (!prNumber) {
    console.log('PR_NUMBER not available, skipping label addition');
    return;
  }

  try {
    const octokit = new Octokit({ auth: githubToken });
    
    await octokit.rest.issues.addLabels({
      owner: repoOwner,
      repo: repoName,
      issue_number: parseInt(prNumber),
      labels: NEW_RP_LABELS
    });

    console.log(`Successfully added labels: ${NEW_RP_LABELS.join(', ')}`);
  } catch (error) {
    console.log(`[FAILED] Failed to add labels: ${error.message}`);
  }
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

async function main() {
  const baseBranch = process.argv[2] || 'main';
  const repoRoot = execSync('git rev-parse --show-toplevel', { encoding: 'utf-8' }).trim();
  let exitCode = 0;

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

  const rmFiles = allFiles.filter(file => 
    file.includes('/resource-manager/') && file.startsWith('specification/')
  );

  if (rmFiles.length === 0) {
    console.log('No resource-manager files changed');
    process.exit(0);
  }

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
          .filter((file) => file.includes('/resource-manager/') && swagger(file));

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
      process.exit(0);
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
    console.log(`\n🆕 Detected ${newResourceProviders.length} new resource provider(s)\n`);
    
    for (const rp of newResourceProviders) {
      const leaseValid = checkLease(rp.serviceName, rp.namespace, rp.serviceGroup || '');
      
      leaseCheckResults.push({
        namespace: rp.namespace,
        serviceName: rp.serviceName,
        serviceGroup: rp.serviceGroup,
        leaseValid: leaseValid,
        leaseMessage: leaseValid ? 'Lease is valid' : 'No lease file found or lease has expired'
      });
      
      console.log(`  - ${rp.namespace}: ${leaseValid ? '[OK]' : '[FAILED]'} Lease ${leaseValid ? 'valid' : 'invalid'}`);
    }
    
    writeFileSync(
      join(repoRoot, '.github', 'new-rp-output.json'),
      JSON.stringify({ newResourceProviders: leaseCheckResults }, null, 2)
    );
    
    await addNewResourceProviderLabels();
    exitCode = 1;
  } else {
    console.log('No new resource providers detected.\n');
  }

  process.exit(exitCode);
}

main();
