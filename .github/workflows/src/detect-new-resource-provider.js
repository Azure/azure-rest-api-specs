#!/usr/bin/env node

import { execSync } from 'child_process';
import { readdirSync, existsSync, statSync, writeFileSync } from 'fs';
import { join } from 'path';
import { getChangedFiles } from '../../shared/src/changed-files.js';
import { checkLease } from './detect-arm-leases.js';

// ============================================
// Configuration
// ============================================

const SPECIFICATION_PATH = 'specification';
// Match pattern: specification/<service>/resource-manager/<ResourceProvider.Namespace>/...
const RESOURCE_MANAGER_PATTERN = /^specification\/[^\/]+\/resource-manager\/([^\/]+)/;

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
 * Extract resource provider namespaces and service names from file paths
 * @param {string[]} files - Array of file paths
 * @returns {Map<string, string>} Map of namespace to service name
 */
function extractResourceProviders(files) {
  const resourceProviders = new Map();
  
  for (const file of files) {
    const match = file.match(RESOURCE_MANAGER_PATTERN);
    if (match) {
      const parts = file.split('/');
      const serviceName = parts[1];
      const namespace = match[1];
      resourceProviders.set(namespace, serviceName);
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
    console.log('Warning: Could not find merge-base, using origin/main directly');
    mergeBase = `origin/${baseBranch}`;
  }

  // Step 1: Get all changed files in specification/*/resource-manager/
  const allFiles = await getChangedFiles({
    baseCommitish: mergeBase,
    headCommitish: 'HEAD'
  });

  const rmFiles = allFiles.filter(file => 
    file.includes('/resource-manager/') && file.startsWith('specification/')
  );

  console.log(`Found ${rmFiles.length} changed file(s) in resource-manager directories\n`);

  if (rmFiles.length === 0) {
    console.log('No resource-manager files changed');
    process.exit(0);
  }

  // Step 2: Extract resource providers from changed files
  const changedResourceProviders = extractResourceProviders(rmFiles);
  
  console.log(`Resource provider namespaces in changed files: ${changedResourceProviders.size}`);
  changedResourceProviders.forEach((serviceName, rp) => console.log(`  - ${rp} (service: ${serviceName})`));

  // Step 3: Check which resource providers are new (don't exist in main branch)
  const specPath = join(repoRoot, SPECIFICATION_PATH);
  const newResourceProviders = [];
  
  for (const [rp, serviceName] of changedResourceProviders) {
    if (!resourceProviderExists(specPath, rp)) {
      newResourceProviders.push({ namespace: rp, serviceName });
    } 
  }
  
  // Step 4: Check ARM leases for new resource providers
  const leaseCheckResults = [];
  
  if (newResourceProviders.length > 0) {
    console.log(`\n🆕 Detected ${newResourceProviders.length} NEW resource provider namespace(s):\n`);
    
    for (const rp of newResourceProviders) {
      console.log(`  ${rp.namespace} (service: ${rp.serviceName})`);
      
      const leaseValid = checkLease(rp.serviceName, rp.namespace);
      const leaseMessage = leaseValid ? 'Lease is valid' : 'No lease file found or lease has expired';
      
      leaseCheckResults.push({
        namespace: rp.namespace,
        serviceName: rp.serviceName,
        leaseValid: leaseValid,
        leaseMessage: leaseMessage
      });
      
      console.log(`    Lease check: ${leaseMessage}`);
    }
    
    console.log('\nNew resource provider namespaces require attending "ARM API Modeling Office Hours".');
    console.log('A comment will be posted on the PR with lease validation results.\n');
    
    // Step 5: Write output for GitHub Actions to use in PR comment
    const outputData = {
      newResourceProviders: leaseCheckResults
    };
    writeFileSync(
      join(repoRoot, '.github', 'new-rp-output.json'),
      JSON.stringify(outputData, null, 2)
    );
    
    exitCode = 1;
  } else {
    console.log('No new resource provider namespaces detected. All changes are to existing namespaces.\n');
  }

  process.exit(exitCode);
}

main();
