import { readFile, access } from 'fs/promises';
import { resolve } from 'path';
import YAML from 'js-yaml';
import * as z from 'zod';
import { getChangedFiles } from '../../../shared/src/changed-files.js';
import { CoreLogger } from '../core-logger.js';

// ============================================
// Configuration
// ============================================

export const LEASE_FILE_PATTERN = /^\.github\/arm-leases\/[a-z0-9]+\/[a-zA-Z0-9.]+\/lease\.yaml$/;
export const LEASE_FILE_WITH_GROUP_PATTERN = /^\.github\/arm-leases\/[a-z0-9]+\/[a-zA-Z0-9.]+\/(?!stable|preview)([^/]+)\/lease\.yaml$/;

export const ALLOWED_FILE_PATTERNS = [
  LEASE_FILE_PATTERN,
  LEASE_FILE_WITH_GROUP_PATTERN,
  /^\.github\/arm-leases\/README\.md$/,
];

/**
 * Zod schema for lease.yaml file content.
 *
 * Example:
 * ```yaml
 * lease:
 *   resource-provider: Microsoft.Compute
 *   startdate: "2025-06-01"
 *   duration-days: "P180D"
 *   reviewer: alias
 * ```
 */
export const leaseSchema = z.object({
  lease: z.object({
    'resource-provider': z.string().min(1, 'resource-provider is required').refine(
      (rp) => rp.split('.').every(part => /^[A-Z]/.test(part)),
      'Resource provider parts must start with a capital letter (e.g., Microsoft.Test, Azure.Widget)',
    ),
    startdate: z.string().regex(/^\d{4}-\d{2}-\d{2}$/, 'Invalid startdate format (expected: YYYY-MM-DD)'),
    'duration-days': z.string().regex(/^P(\d+)D$/i, 'Invalid duration-days format (expected ISO 8601: "P180D")').refine(
      (d) => {
        const m = d.match(/^P(\d+)D$/i);
        if (!m) return false;
        const days = parseInt(m[1], 10);
        return days > 0 && days <= 180;
      },
      'Duration must be between 1 and 180 days',
    ),
    reviewer: z.string().min(1, 'Reviewer is required and cannot be empty').refine(
      (r) => r.trim().length > 0,
      'Reviewer is required and cannot be empty',
    ),
  }),
});

// ============================================
// Utility Functions
// ============================================

/**
 * Check if a file is allowed based on patterns
 * @param {string} file - File path to check
 * @returns {boolean} True if file is allowed
 */
export function isFileAllowed(file) {
  return ALLOWED_FILE_PATTERNS.some(pattern => pattern.test(file));
}

/**
 * Validate folder structure of lease files
 * @param {string[]} files - Array of file paths
 * @returns {string[]} Array of invalid files
 */
export function validateFolderStructure(files) {
  return files.filter(file => !LEASE_FILE_PATTERN.test(file) && !LEASE_FILE_WITH_GROUP_PATTERN.test(file));
}

/**
 * Validate lease file contents using Zod schema
 * @param {string} leaseFile - Full path to lease file
 * @param {string} today - Today's date in YYYY-MM-DD format
 * @param {string} relativePath - Relative path for folder name extraction
 * @returns {Promise<{file: string, errors: string[]}>} Validation result with errors array
 */
export async function validateLeaseContent(leaseFile, today, relativePath) {
  const errors = [];
  const pathForExtraction = relativePath || leaseFile;
  // Extract namespace from .github/arm-leases/<servicename>/<namespace>/lease.yaml
  // or .github/arm-leases/<servicename>/<namespace>/<servicegroup>/lease.yaml
  const folderRP = pathForExtraction.split('/')[3]; // namespace is always at index 3

  try {
    await access(leaseFile);
  } catch {
    return { file: leaseFile, errors: ['File does not exist'] };
  }

  let content;
  try {
    content = await readFile(leaseFile, 'utf-8');
  } catch (error) {
    const msg = error instanceof Error ? error.message : String(error);
    return { file: leaseFile, errors: [`Error reading file: ${msg}`] };
  }

  // Use FAILSAFE_SCHEMA to keep all values as strings (prevents YAML Date auto-parsing)
  let raw;
  try {
    raw = /** @type {any} */ (YAML.load(content, { schema: YAML.FAILSAFE_SCHEMA }));
  } catch (error) {
    const msg = error instanceof Error ? error.message : String(error);
    return { file: leaseFile, errors: [`Invalid YAML: ${msg}`] };
  }

  // Parse with Zod schema — collects all field-level errors at once
  const result = leaseSchema.safeParse(raw);
  if (!result.success) {
    for (const issue of result.error.issues) {
      errors.push(issue.message);
    }
    return { file: leaseFile, errors };
  }

  const lease = result.data.lease;

  // Cross-field validation: resource-provider must match folder name
  if (lease['resource-provider'] !== folderRP) {
    errors.push(`Resource provider mismatch: folder=${folderRP}, yaml=${lease['resource-provider']}`);
  }

  // Cross-field validation: startdate must not be in the past
  if (lease.startdate < today) {
    errors.push(`Startdate is in the past: ${lease.startdate} (today: ${today})`);
  }

  return { file: leaseFile, errors };
}

// ============================================
// Main Validation Logic
// ============================================

/**
 * Main validation logic for GitHub script action
 * @param {import('@actions/github-script').AsyncFunctionArguments['core']} core
 * @returns {Promise<{ status: string, errors: number }>} Validation result
 */
export default async function validateArmLeases(core) {
  const today = new Date().toISOString().split('T')[0];
  const cwd = process.env.GITHUB_WORKSPACE;
  let hasErrors = false;

  core.info('Running ARM Lease File Validation\n');

  // Step 1: Get all changed files under .github/arm-leases/
  const allChangedFiles = await getChangedFiles({
    cwd,
    paths: ['.github/arm-leases'],
    logger: new CoreLogger(core),
  });

  // Step 2: Check for disallowed files
  const disallowedFiles = [];
  for (const file of allChangedFiles) {
    if (!isFileAllowed(file)) {
      disallowedFiles.push(file);
    }
  }

  if (disallowedFiles.length > 0) {
    core.info(`Found ${disallowedFiles.length} disallowed file(s). Only lease.yaml and README.md files within .github/arm-leases/ are allowed:\n`);
    core.info('Disallowed files:');
    disallowedFiles.slice(0, 20).forEach(file => core.info(`  ${file}`));
    if (disallowedFiles.length > 20) {
      core.info(`  ... and ${disallowedFiles.length - 20} more files`);
    }
    core.info('');
    hasErrors = true;
  }

  // Step 3: Check for non-lease.yaml and non-README files
  const nonLeaseFiles = allChangedFiles.filter(file =>
    !file.endsWith('/lease.yaml') && !file.endsWith('/README.md')
  );

  if (nonLeaseFiles.length > 0) {
    core.info(`Found ${nonLeaseFiles.length} file(s) that are not lease.yaml:`);
    nonLeaseFiles.forEach(file => core.info(`Remove or rename - ${file}`));
    core.info('Only lease.yaml files are allowed in .github/arm-leases/ directory\n');
    hasErrors = true;
  }

  // Step 4: Get ARM lease files (only lease.yaml files)
  const armLeaseFiles = allChangedFiles.filter(file =>
    file.startsWith('.github/arm-leases/') && !file.endsWith('.md')
  );

  if (armLeaseFiles.length === 0) {
    if (!hasErrors) {
      core.info('--------- No ARM lease files to validate ------------');
    } else {
      core.setFailed('ARM Lease Validation failed - fix errors above');
    }
    return { status: hasErrors ? 'failed' : 'no-lease-files', errors: hasErrors ? 1 : 0 };
  }

  // Step 5: Validate folder structure
  const invalidStructure = validateFolderStructure(armLeaseFiles);

  if (invalidStructure.length > 0) {
    core.info(`${invalidStructure.length} file(s) with invalid folder structure:`);
    invalidStructure.forEach(file => core.info(`  ${file}`));
    core.info('Expected format: .github/arm-leases/<servicename>/<namespace>/[<servicegroup> (optional)]/lease.yaml');
    core.info('Requirements:');
    core.info('  - <servicename>: lowercase alphanumeric only (e.g., testservice, widgetservice)');
    core.info('  - <namespace>: alphanumeric with dots and case-sensitive (e.g., Test.Rp, Widget.Manager)');
    core.info('  - <servicegroup>: (optional) logical grouping within an RP (e.g., DiskRP, ComputeRP). Must not start with "stable" or "preview"');
    core.info('  - Only lease.yaml files are allowed in arm-leases folder');
    core.info('Examples:');
    core.info('  - .github/arm-leases/testservice/Test.Rp/lease.yaml');
    core.info('  - .github/arm-leases/widgetservice/Widget.Manager/lease.yaml');
    core.info('  - .github/arm-leases/compute/Microsoft.Compute/DiskRP/lease.yaml\n');
    hasErrors = true;
  }

  // Step 6: Validate lease file contents
  const validLeaseFiles = armLeaseFiles.filter(file =>
    LEASE_FILE_PATTERN.test(file) || LEASE_FILE_WITH_GROUP_PATTERN.test(file)
  );

  if (validLeaseFiles.length === 0) {
    if (hasErrors) {
      core.setFailed('ARM Lease Validation failed - fix errors above');
    } else {
      core.info('All validations passed!');
    }
    return { status: hasErrors ? 'failed' : 'passed', errors: hasErrors ? 1 : 0 };
  }

  const contentErrors = [];

  for (const leaseFile of validLeaseFiles) {
    const fullPath = resolve(cwd, leaseFile);
    const result = await validateLeaseContent(fullPath, today, leaseFile);
    if (result.errors.length > 0) {
      contentErrors.push({ file: leaseFile, errors: result.errors });
      hasErrors = true;
    }
  }

  // Step 7: Print lease file content errors
  if (contentErrors.length > 0) {
    core.info('Lease content validation errors:\n');
    contentErrors.forEach(({ file, errors }) => {
      core.info(`${file}`);
      errors.forEach(error => core.info(`  - ${error}`));
      core.info('');
    });
  }

  if (hasErrors) {
    core.setFailed('ARM Lease Validation failed - fix errors above');
  } else {
    core.info('All validations passed!');
  }

  return { status: hasErrors ? 'failed' : 'passed', errors: contentErrors.length };
}
