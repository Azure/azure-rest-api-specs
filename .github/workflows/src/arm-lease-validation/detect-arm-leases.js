import { readFile } from "fs/promises";
import { resolve } from "path";
import yaml from "js-yaml";
import * as z from "zod";
import { Temporal } from "@js-temporal/polyfill";
import { getRootFolder } from "../../../shared/src/simple-git.js";

/**
 * Schema for lease.yaml file
 *
 * Example:
 * ```yaml
 * lease:
 *   startdate: "2024-01-01"
 *   duration: "P180D"
 * ```
 */
const leaseSchema = z.object({
  lease: z.object({
    startdate: z.string().regex(/^\d{4}-\d{2}-\d{2}$/, "startdate must be in YYYY-MM-DD format"),
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
  }),
});

/**
 * Build the lease path based on service information.
 *
 * Lease files are stored at:
 * - Without service name: `.github/arm-leases/<orgName>/<rpNamespace>/lease.yaml`
 * - With service name:    `.github/arm-leases/<orgName>/<rpNamespace>/<serviceName>/lease.yaml`
 *
 * @param {string} repoRoot - Repository root path
 * @param {string} orgName - Organization name (e.g., "compute")
 * @param {string} rpNamespace - Resource provider namespace (e.g., "Microsoft.Compute")
 * @param {string} serviceName - Optional service name for RPs with sub-groupings (e.g., "ComputeRP")
 * @returns {string} Full path to lease.yaml file
 */
function buildLeasePath(repoRoot, orgName, rpNamespace, serviceName = "") {
  const leasePathParts = [repoRoot, ".github", "arm-leases", orgName, rpNamespace];
  if (serviceName) {
    leasePathParts.push(serviceName);
  }
  leasePathParts.push("lease.yaml");
  return resolve(...leasePathParts);
}

/**
 * Parse and validate lease YAML content. Pure function — no I/O.
 *
 * @param {string} content - Raw YAML string from a lease file
 * @returns {{ valid: boolean, reason: string }} Whether the lease is valid and why
 */
export function parseLease(content) {
  let rawParsed;
  try {
    rawParsed = /** @type {any} */ (yaml.load(content, { schema: yaml.FAILSAFE_SCHEMA }));
  } catch {
    return { valid: false, reason: "YAML parse error" };
  }

  if (!rawParsed) {
    return { valid: false, reason: "Empty YAML content" };
  }

  const result = leaseSchema.safeParse(rawParsed);
  if (!result.success) {
    return { valid: false, reason: result.error.issues.map((i) => i.message).join("; ") };
  }

  const lease = result.data.lease;
  const startDate = Temporal.PlainDate.from(lease.startdate);
  const duration = Temporal.Duration.from(lease.duration);
  const endDate = startDate.add(duration);
  const today = Temporal.Now.plainDateISO();

  if (Temporal.PlainDate.compare(today, endDate) > 0) {
    return { valid: false, reason: `Lease expired on ${endDate}` };
  }

  return { valid: true, reason: "Lease is valid" };
}

/**
 * Check if ARM lease exists and is valid.
 *
 * Looks for a lease file at the appropriate path (see buildLeasePath for path structure).
 *
 * @param {string} orgName - Organization name (e.g., "compute")
 * @param {string} rpNamespace - Resource provider namespace (e.g., "Microsoft.Compute")
 * @param {string} serviceName - Optional service name for RPs with sub-groupings
 * @returns {Promise<boolean>} True if lease exists and is valid, false otherwise
 */
export async function checkLease(orgName, rpNamespace, serviceName = "") {
  const repoRoot = await getRootFolder(process.cwd());
  const leasePath = buildLeasePath(repoRoot, orgName, rpNamespace, serviceName);

  let content;
  try {
    content = await readFile(leasePath, "utf-8");
  } catch {
    return false;
  }

  return parseLease(content).valid;
}
