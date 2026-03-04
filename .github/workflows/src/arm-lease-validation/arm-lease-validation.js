import { readFile } from "fs/promises";
import { resolve } from "path";
import { inspect } from "util";
import YAML from "js-yaml";
import * as z from "zod";
import { Temporal } from "@js-temporal/polyfill";
import { getChangedFiles } from "../../../shared/src/changed-files.js";
import { CoreLogger } from "../core-logger.js";

// ============================================
// Configuration
// ============================================

export const LEASE_FILE_PATTERN = /^\.github\/arm-leases\/[a-z0-9]+\/[a-zA-Z0-9.]+\/lease\.yaml$/;
export const LEASE_FILE_WITH_GROUP_PATTERN =
  /^\.github\/arm-leases\/[a-z0-9]+\/[a-zA-Z0-9.]+\/(?!stable|preview)([^/]+)\/lease\.yaml$/;

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
 *   duration: "P180D"
 *   reviewer: alias
 * ```
 */
export const leaseSchema = z.object({
  lease: z.object({
    "resource-provider": z
      .string()
      .min(1, "resource-provider is required")
      .refine(
        (rp) => rp.split(".").every((part) => /^[A-Z]/.test(part)),
        "Resource provider parts must start with a capital letter (e.g., Microsoft.Test, Azure.Widget)",
      ),
    startdate: z
      .string()
      .regex(/^\d{4}-\d{2}-\d{2}$/, "Invalid startdate format (expected: YYYY-MM-DD)"),
    duration: z.string().refine(
      (v) => {
        try {
          Temporal.Duration.from(v);
          return true;
        } catch {
          return false;
        }
      },
      "duration must be a valid ISO 8601 duration (e.g. P180D, P6M, P1Y2M3D)",
    ),
    reviewer: z
      .string()
      .min(1, "Reviewer is required and cannot be empty")
      .refine(
        (r) => r.trim().length > 0,
        "Reviewer is required and cannot be empty",
      ),
  }),
});

// ============================================
// Utility Functions
// ============================================

/**
 * Check if a file is allowed based on patterns.
 * @param {string} file - File path to check
 * @returns {boolean} True if file is allowed
 */
export function isFileAllowed(file) {
  return ALLOWED_FILE_PATTERNS.some((pattern) => pattern.test(file));
}

/**
 * Validate folder structure of lease files.
 * @param {string[]} files - Array of file paths
 * @returns {string[]} Array of invalid files
 */
export function validateFolderStructure(files) {
  return files.filter(
    (file) => !LEASE_FILE_PATTERN.test(file) && !LEASE_FILE_WITH_GROUP_PATTERN.test(file),
  );
}

/**
 * Validate lease file contents using Zod schema.
 * @param {string} leaseFile - Full path to lease file
 * @param {string} today - Today's date in YYYY-MM-DD format
 * @param {string} relativePath - Relative path for folder name extraction
 * @returns {Promise<{file: string, errors: string[]}>} Validation result with errors array
 */
export async function validateLeaseContent(leaseFile, today, relativePath) {
  const errors = [];
  const pathForExtraction = relativePath || leaseFile;
  // Extract rpNamespace from .github/arm-leases/<orgName>/<rpNamespace>/lease.yaml
  // or .github/arm-leases/<orgName>/<rpNamespace>/<serviceName>/lease.yaml
  const folderRP = pathForExtraction.split("/")[3]; // rpNamespace is always at index 3

  /** @type {string} */
  let content;
  try {
    content = await readFile(leaseFile, "utf-8");
  } catch (error) {
    return { file: leaseFile, errors: [`Error reading file: ${inspect(error)}`] };
  }

  // Use FAILSAFE_SCHEMA to keep all values as strings (prevents YAML Date auto-parsing)
  let raw;
  try {
    raw = /** @type {any} */ (YAML.load(content, { schema: YAML.FAILSAFE_SCHEMA }));
  } catch (error) {
    return { file: leaseFile, errors: [`Invalid YAML: ${inspect(error)}`] };
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
  if (lease["resource-provider"] !== folderRP) {
    errors.push(
      `Resource provider mismatch: folder=${folderRP}, yaml=${lease["resource-provider"]}`,
    );
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
 * Main validation logic for GitHub script action.
 * @param {import('@actions/github-script').AsyncFunctionArguments['core']} core
 * @returns {Promise<{ status: string, errors: number }>} Validation result
 */
export default async function validateArmLeases(core) {
  const today = Temporal.Now.plainDateISO().toString();
  const cwd = process.env.GITHUB_WORKSPACE;
  let hasErrors = false;

  core.info("Running ARM Lease File Validation");

  // Get all changed files under .github/arm-leases/
  const allChangedFiles = await getChangedFiles({
    cwd,
    paths: [".github/arm-leases"],
    logger: new CoreLogger(core),
  });

  // Check for disallowed files
  core.startGroup("Checking for disallowed files");
  const disallowedFiles = allChangedFiles.filter((file) => !isFileAllowed(file));

  if (disallowedFiles.length > 0) {
    core.info(
      `Found ${disallowedFiles.length} disallowed file(s). Only lease.yaml and README.md files within .github/arm-leases/ are allowed:`,
    );
    for (const file of disallowedFiles.slice(0, 20)) {
      core.info(`  ${file}`);
    }
    if (disallowedFiles.length > 20) {
      core.info(`  ... and ${disallowedFiles.length - 20} more files`);
    }
    hasErrors = true;
  }
  core.endGroup();

  // Check for non-lease.yaml and non-README files
  core.startGroup("Checking for non-lease files");
  const nonLeaseFiles = allChangedFiles.filter(
    (file) => !file.endsWith("/lease.yaml") && !file.endsWith("/README.md"),
  );

  if (nonLeaseFiles.length > 0) {
    core.info(`Found ${nonLeaseFiles.length} file(s) that are not lease.yaml:`);
    for (const file of nonLeaseFiles) {
      core.info(`Remove or rename - ${file}`);
    }
    core.info("Only lease.yaml files are allowed in .github/arm-leases/ directory");
    hasErrors = true;
  }
  core.endGroup();

  // Get ARM lease files (only lease.yaml files)
  const armLeaseFiles = allChangedFiles.filter(
    (file) => file.startsWith(".github/arm-leases/") && !file.endsWith(".md"),
  );

  if (armLeaseFiles.length === 0) {
    if (!hasErrors) {
      core.info("No ARM lease files to validate");
    } else {
      core.setFailed("ARM Lease Validation failed - fix errors above");
    }
    return { status: hasErrors ? "failed" : "no-lease-files", errors: hasErrors ? 1 : 0 };
  }

  // Validate folder structure
  core.startGroup("Validating folder structure");
  const invalidStructure = validateFolderStructure(armLeaseFiles);

  if (invalidStructure.length > 0) {
    core.info(`${invalidStructure.length} file(s) with invalid folder structure:`);
    for (const file of invalidStructure) {
      core.info(`  ${file}`);
    }
    core.info(
      "Expected format: .github/arm-leases/<orgName>/<rpNamespace>/[<serviceName> (optional)]/lease.yaml",
    );
    core.info("Requirements:");
    core.info("  - <orgName>: lowercase alphanumeric only (e.g., testservice, widgetservice)");
    core.info(
      "  - <rpNamespace>: alphanumeric with dots and case-sensitive (e.g., Test.Rp, Widget.Manager)",
    );
    core.info(
      '  - <serviceName>: (optional) customer-facing service name within an RP (e.g., DiskRP, ComputeRP). Must not start with "stable" or "preview"',
    );
    core.info("  - Only lease.yaml files are allowed in arm-leases folder");
    core.info("Examples:");
    core.info("  - .github/arm-leases/testservice/Test.Rp/lease.yaml");
    core.info("  - .github/arm-leases/widgetservice/Widget.Manager/lease.yaml");
    core.info("  - .github/arm-leases/compute/Microsoft.Compute/DiskRP/lease.yaml");
    hasErrors = true;
  }
  core.endGroup();

  // Validate lease file contents
  core.startGroup("Validating lease file contents");
  const validLeaseFiles = armLeaseFiles.filter(
    (file) => LEASE_FILE_PATTERN.test(file) || LEASE_FILE_WITH_GROUP_PATTERN.test(file),
  );

  if (validLeaseFiles.length === 0) {
    core.endGroup();
    if (hasErrors) {
      core.setFailed("ARM Lease Validation failed - fix errors above");
    } else {
      core.info("All validations passed!");
    }
    return { status: hasErrors ? "failed" : "passed", errors: hasErrors ? 1 : 0 };
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

  if (contentErrors.length > 0) {
    core.info("Lease content validation errors:");
    for (const { file, errors } of contentErrors) {
      core.info(`${file}`);
      for (const error of errors) {
        core.info(`  - ${error}`);
      }
    }
  }
  core.endGroup();

  if (hasErrors) {
    core.setFailed("ARM Lease Validation failed - fix errors above");
  } else {
    core.info("All validations passed!");
  }

  return { status: hasErrors ? "failed" : "passed", errors: contentErrors.length };
}
