#!/usr/bin/env node

import { execSync } from 'child_process';
import { readFileSync, existsSync } from 'fs';
import { join } from 'path';
import YAML from 'yaml';

// ============================================
// Configuration
// ============================================

const ALLOWED_FILE_PATTERNS = [
  /^lease\//,
  /^\.github\/workflows\/validate-lease\.yaml$/,
  /^\.github\/workflows\/src\/validate-lease\.js$/,
  /^\.github\/workflows\/tests\/validate-lease\.test\.js$/,
  /^\.github\/package\.json$/,
  /^\.github\/\.gitignore$/
];

const LEASE_FILE_PATTERN = /^lease\/[A-Za-z0-9_.-]+\/[A-Za-z0-9_.-]+\/lease\.yaml$/;
const DATE_PATTERN = /^\d{4}-\d{2}-\d{2}$/;

// ============================================
// Utility Functions
// ============================================

/**
 * Get all changed files from git diff
 * @param {string} baseBranch - The base branch to compare against
 * @returns {string[]} Array of changed file paths
 */
function getChangedFiles(baseBranch) {
  const commands = [
    `git diff --name-only origin/${baseBranch} HEAD`,
    `git diff --name-only ${baseBranch} HEAD`,
    `git diff --name-only ${baseBranch} HEAD -- lease/ .github/`
  ];

  for (const command of commands) {
    try {
      const output = execSync(command, {
        encoding: 'utf-8',
        maxBuffer: 50 * 1024 * 1024,
        stdio: ['pipe', 'pipe', 'pipe']
      });
      return output.trim().split('\n').filter(f => f);
    } catch (error) {
      continue;
    }
  }

  console.error('Error getting changed files.');
  console.error('Make sure you have committed your changes and the base branch exists.');
  process.exit(1);
}

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
  return files.filter(file => !LEASE_FILE_PATTERN.test(file));
}

/**
 * Parse lease YAML file
 * @param {string} filePath - Path to lease.yaml file
 * @returns {object|null} Parsed lease data or null if error
 */
function parseLeaseFile(filePath) {
  try {
    const content = readFileSync(filePath, 'utf-8');
    const data = YAML.parse(content);
    
    if (!data || !data.lease) {
      return { error: 'Invalid YAML structure: missing "lease" key' };
    }
    
    return {
      resourceProvider: data.lease['resource-provider'] || '',
      startdate: data.lease.startdate || '',
      reviewer: data.lease.reviewer || ''
    };
  } catch (error) {
    return { error: `Error reading file: ${error.message}` };
  }
}

/**
 * Validate lease file contents
 * @param {string} leaseFile - Path to lease file (can be full or relative)
 * @param {string} today - Today's date in YYYY-MM-DD format
 * @param {string} relativePath - Relative path for folder name extraction
 * @returns {object} Validation result with errors array
 */
function validateLeaseContent(leaseFile, today, relativePath = null) {
  const errors = [];
  const pathForExtraction = relativePath || leaseFile;
  const folderRP = pathForExtraction.split('/')[1];
  
  if (!existsSync(leaseFile)) {
    return { file: leaseFile, errors: ['File does not exist'] };
  }

  const leaseData = parseLeaseFile(leaseFile);
  
  if (leaseData.error) {
    return { file: leaseFile, errors: [leaseData.error] };
  }

  // Validation 1: Resource provider name matches folder name
  if (leaseData.resourceProvider !== folderRP) {
    errors.push(`Resource provider mismatch: folder=${folderRP}, yaml=${leaseData.resourceProvider}`);
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

  return { file: leaseFile, errors };
}

// ============================================
// Main Validation Logic
// ============================================

function main() {
  const baseBranch = process.argv[2] || 'main';
  const today = new Date().toISOString().split('T')[0];
  const repoRoot = execSync('git rev-parse --show-toplevel', { encoding: 'utf-8' }).trim();
  let exitCode = 0;

  console.log('Running Lease File Validation\n');

  // Step 1: Get all changed files
  const allChangedFiles = getChangedFiles(baseBranch);

  // Step 2: Check for disallowed files
  const disallowedFiles = allChangedFiles.filter(file => !isFileAllowed(file));
  
  if (disallowedFiles.length > 0) {
    console.log(`❌Found ${disallowedFiles.length} file(s) outside the lease/ directory. Please note that only changes within the lease/ directory are permitted. Kindly move the following files into the lease/ directory to proceed.`);
    console.log('Disallowed files:');
    disallowedFiles.slice(0, 20).forEach(file => console.log(`  ${file}`));
    if (disallowedFiles.length > 20) {
      console.log(`  ... and ${disallowedFiles.length - 20} more files`);
    }
    console.log('');
    exitCode = 1;
  }

  // Step 3: Get lease files
  const leaseFiles = allChangedFiles.filter(file => 
    file.startsWith('lease/') && !file.endsWith('.md')
  );

  if (leaseFiles.length === 0) {
    if (exitCode === 0) {
      console.log('✅ No lease files to validate');
    }
    process.exit(exitCode);
  }

  console.log(`Found ${leaseFiles.length} lease file(s) to validate\n`);

  // Step 4: Validate folder structure
  const invalidStructure = validateFolderStructure(leaseFiles);
  
  if (invalidStructure.length > 0) {
    console.log(`❌ ${invalidStructure.length} file(s) with invalid folder structure:`);
    invalidStructure.forEach(file => console.log(`  ${file}`));
    console.log('\n✅Expected format: lease/<Namespace>/<Service>/lease.yaml');
    console.log('Examples:');
    console.log('  - lease/Microsoft.Widget/Widget/lease.yaml');
    console.log('  - lease/Azure.Storage/BlobService/lease.yaml\n');
    exitCode = 1;
  }

  // Step 5: Validate lease file contents
  const validLeaseFiles = leaseFiles.filter(file => LEASE_FILE_PATTERN.test(file));
  
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

  // Step 6: Print lease file content errors
  if (contentErrors.length > 0) {
    console.log('Lease content validation errors:\n');
    contentErrors.forEach(({ file, errors }) => {
      console.log(`❌ ${file}`);
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
    console.log('✅ All validations passed!');
  } else {
    console.log('Lease Validation failed - fix errors above');
  }
}

main();
