#!/usr/bin/env node

import { execSync } from 'child_process';
import { readFileSync, existsSync } from 'fs';
import { join } from 'path';
import YAML from 'js-yaml';
import { getChangedFiles } from '../../shared/src/changed-files.js';

// ============================================
// Configuration
// ============================================

const ALLOWED_FILE_PATTERNS = [
  /^\.github\/arm-leases\//,
  /^\.github\/workflows\/validate-arm-leases\.yaml$/,
  /^\.github\/workflows\/src\/validate-arm-leases\.js$/
];

const LEASE_FILE_PATTERN = /^\.github\/arm-leases\/[a-z0-9]+\/[a-zA-Z0-9.]+\/lease\.yaml$/;
const LEASE_FILE_WITH_GROUP_PATTERN = /^\.github\/arm-leases\/[a-z0-9]+\/[a-zA-Z0-9.]+\/(?!stable|preview)([^\/]+)\/lease\.yaml$/;
const DATE_PATTERN = /^\d{4}-\d{2}-\d{2}$/;

// ============================================
// Utility Functions
// ============================================

/**
 * Check if a file is allowed based on patterns
 * @param {string} file - File path to check
 * @returns {boolean} True if file is allowed
 */
function isFileAllowed(file) {
  return ALLOWED_FILE_PATTERNS.some(pattern => pattern.test(file));
}

/**
 * Validate folder structure of lease files
 * @param {string[]} files - Array of file paths
 * @returns {string[]} Array of invalid files
 */
function validateFolderStructure(files) {
  return files.filter(file => !LEASE_FILE_PATTERN.test(file) && !LEASE_FILE_WITH_GROUP_PATTERN.test(file));
}

/**
 * Parse lease YAML file
 * @param {string} filePath - Path to lease.yaml file
 * @returns {{resourceProvider: string, startdate: string, duration: string, reviewer: string}|{error: string}} Parsed lease data or error object
 */
function parseLeaseFile(filePath) {
  try {
    const content = readFileSync(filePath, 'utf-8');
    const data = YAML.load(content);
    
    if (!data || !data.lease) {
      return { error: 'Invalid YAML structure: missing "lease" key' };
    }
    
    // Convert Date objects to YYYY-MM-DD strings
    let startdate = data.lease.startdate || '';
    if (startdate instanceof Date) {
      startdate = startdate.toISOString().split('T')[0];
    }
    
    return {
      resourceProvider: data.lease['resource-provider'] || '',
      startdate: startdate,
      duration: data.lease.duration || '',
      reviewer: data.lease.reviewer || ''
    };
  } catch (error) {
    const errorMessage = error instanceof Error ? error.message : String(error);
    return { error: `Error reading file: ${errorMessage}` };
  }
}

/**
 * Validate lease file contents
 * @param {string} leaseFile - Path to lease file (can be full or relative)
 * @param {string} today - Today's date in YYYY-MM-DD format
 * @param {string} relativePath - Relative path for folder name extraction
 * @returns {{file: string, errors: string[]}} Validation result with errors array
 */
function validateLeaseContent(leaseFile, today, relativePath) {
  const errors = [];
  const pathForExtraction = relativePath || leaseFile;
  // Extract namespace from .github/arm-leases/<servicename>/<namespace>/lease.yaml
  // or .github/arm-leases/<servicename>/<namespace>/<servicegroup>/lease.yaml
  const folderRP = pathForExtraction.split('/')[3]; // namespace is always at index 3
  
  if (!existsSync(leaseFile)) {
    return { file: leaseFile, errors: ['File does not exist'] };
  }

  const leaseData = parseLeaseFile(leaseFile);
  
  if (!leaseData) {
    return { file: leaseFile, errors: ['Failed to parse lease file'] };
  }
  
  if ('error' in leaseData) {
    return { file: leaseFile, errors: [leaseData.error] };
  }

  // Validation 1: Resource provider name matches folder name
  if (leaseData.resourceProvider !== folderRP) {
    errors.push(`Resource provider mismatch: folder=${folderRP}, yaml=${leaseData.resourceProvider}`);
  }

  // Validation 1b: Resource provider must start with a capital letter (before and after dot)
  if (leaseData.resourceProvider) {
    const parts = leaseData.resourceProvider.split('.');
    const invalidParts = parts.filter(part => part && !/^[A-Z]/.test(part));
    if (invalidParts.length > 0) {
      errors.push(`Resource provider parts must start with a capital letter: ${leaseData.resourceProvider} (e.g., Microsoft.Test, Azure.Widget)`);
    }
  }

  // Validation 2: Startdate format (ISO 8601: YYYY-MM-DD)
  if (!DATE_PATTERN.test(leaseData.startdate)) {
    errors.push(`Invalid startdate format: ${leaseData.startdate} (expected: YYYY-MM-DD)`);
  } else {
    // Validation 3: Startdate is today or future (not past)
    if (leaseData.startdate < today) {
      errors.push(`Startdate is in the past: ${leaseData.startdate} (today: ${today})`);
    }
  }

  // Validation 4: Duration validation (must not exceed 180 days)
  if (!leaseData.duration) {
    errors.push('Duration is missing (expected format: "180 days")');
  } else {
    const durationMatch = leaseData.duration.match(/^(\d+)\s*days?$/i);
    if (!durationMatch) {
      errors.push(`Invalid duration format: ${leaseData.duration} (expected format: "180 days")`);
    } else {
      const durationDays = parseInt(durationMatch[1], 10);
      if (durationDays > 180) {
        errors.push(`Duration exceeds maximum allowed: ${durationDays} days (maximum: 180 days)`);
      }
      if (durationDays <= 0) {
        errors.push(`Duration must be greater than 0: ${durationDays} days`);
      }
    }
  }

  // Validation 5: Reviewer cannot be null or empty
  if (!leaseData.reviewer || leaseData.reviewer.trim() === '') {
    errors.push('Reviewer is required and cannot be empty');
  }

  return { file: leaseFile, errors };
}

// ============================================
// Main Validation Logic
// ============================================

async function main() {
  const baseBranch = process.argv[2] || 'main';
  const today = new Date().toISOString().split('T')[0];
  const repoRoot = execSync('git rev-parse --show-toplevel', { encoding: 'utf-8' }).trim();
  let exitCode = 0;

  console.log('Running ARM Lease File Validation\n');

  // Get the merge base for proper PR comparison
  let mergeBase;
  try {
    mergeBase = execSync(`git merge-base origin/${baseBranch} HEAD`, { encoding: 'utf-8' }).trim();
  } catch (error) {
    console.log('Warning: Could not find merge-base, using origin/main directly');
    mergeBase = `origin/${baseBranch}`;
  }

  // Step 1: Get all changed files (first without filter to debug)
  const allFiles = await getChangedFiles({
    baseCommitish: mergeBase,
    headCommitish: 'HEAD'
  });
  
  // Filter for arm-leases files from all changed files
  const allChangedFiles = allFiles.filter(file => file.startsWith('.github/arm-leases/'));

  // Step 2: Check for disallowed files
  const disallowedFiles = allChangedFiles.filter(file => !isFileAllowed(file));
  
  if (disallowedFiles.length > 0) {
    console.log(`Found ${disallowedFiles.length} file(s) outside the .github/arm-leases/ directory. Only changes within .github/arm-leases/ directory are allowed. Please move the following files under .github/arm-leases/ directory:\n`);
    console.log('Disallowed files:');
    disallowedFiles.slice(0, 20).forEach(file => console.log(`  ${file}`));
    if (disallowedFiles.length > 20) {
      console.log(`  ... and ${disallowedFiles.length - 20} more files`);
    }
    console.log('');
    exitCode = 1;
  }

  // Step 3: Check for non-lease.yaml and non-README files
  const nonLeaseFiles = allChangedFiles.filter(file => 
    !file.endsWith('/lease.yaml') && !file.endsWith('/README.md')
  );
  
  if (nonLeaseFiles.length > 0) {
    console.log(`Found ${nonLeaseFiles.length} file(s) that are not lease.yaml:`);
    nonLeaseFiles.forEach(file => console.log(`Remove or rename - ${file}`));
    console.log('Only lease.yaml files are allowed in .github/arm-leases/ directory\n');
    exitCode = 1;
  }

  // Step 4: Get ARM lease files (only lease.yaml files)
  const armLeaseFiles = allChangedFiles.filter(file => 
    file.startsWith('.github/arm-leases/') && !file.endsWith('.md')
  );

  if (armLeaseFiles.length === 0) {
    if (exitCode === 0) {
      console.log('--------- No ARM lease files to validate ------------');
    }
    process.exit(exitCode);
  }

  // Step 5: Validate folder structure
  const invalidStructure = validateFolderStructure(armLeaseFiles);
  
  if (invalidStructure.length > 0) {
    console.log(`${invalidStructure.length} file(s) with invalid folder structure:`);
    invalidStructure.forEach(file => console.log(`  ${file}`));
    console.log('Expected format: .github/arm-leases/<servicename>/<namespace>/[<servicegroup> (optional)]/lease.yaml');
    console.log('Requirements:');
    console.log('  - <servicename>: lowercase alphanumeric only (e.g., testservice, widgetservice)');
    console.log('  - <namespace>: alphanumeric with dots and case-sensitive (e.g., Test.Rp, Widget.Manager)');
    console.log('  - <servicegroup>: (optional) logical grouping within an RP (e.g., DiskRP, ComputeRP). Must not start with "stable" or "preview"');
    console.log('  - Only lease.yaml files are allowed in arm-leases folder');
    console.log('Examples:');
    console.log('  - .github/arm-leases/testservice/Test.Rp/lease.yaml');
    console.log('  - .github/arm-leases/widgetservice/Widget.Manager/lease.yaml');
    console.log('  - .github/arm-leases/compute/Microsoft.Compute/DiskRP/lease.yaml\n');
    exitCode = 1;
  }

  // Step 6: Validate lease file contents
  const validLeaseFiles = armLeaseFiles.filter(file => 
    LEASE_FILE_PATTERN.test(file) || LEASE_FILE_WITH_GROUP_PATTERN.test(file)
  );
  
  if (validLeaseFiles.length === 0) {
    printSummary(exitCode);
    process.exit(exitCode);
  }

  const contentErrors = [];
  
  for (const leaseFile of validLeaseFiles) {
    const fullPath = join(repoRoot, leaseFile);
    const result = validateLeaseContent(fullPath, today, leaseFile);
    if (result.errors.length > 0) {
      // Store with relative path for display
      contentErrors.push({ file: leaseFile, errors: result.errors });
      exitCode = 1;
    }
  }

  // Step 7: Print lease file content errors
  if (contentErrors.length > 0) {
    console.log('Lease content validation errors:\n');
    contentErrors.forEach(({ file, errors }) => {
      console.log(`${file}`);
      errors.forEach(error => console.log(`  - ${error}`));
      console.log('');
    });
  }

  printSummary(exitCode);
  process.exit(exitCode);
}

/**
 * Print final validation summary
 * @param {number} exitCode - Exit code (0 = success, 1 = failure)
 */
function printSummary(exitCode) {
  if (exitCode === 0) {
    console.log('All validations passed!');
  } else {
    console.log('ARM Lease Validation failed - fix errors above');
  }
}

main();