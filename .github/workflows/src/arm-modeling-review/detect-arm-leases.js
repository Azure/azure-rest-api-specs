import { Temporal } from "@js-temporal/polyfill";
import yaml from "js-yaml";
import { join } from "path";
import { simpleGit } from "simple-git";
import * as z from "zod";
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
    duration: z.string().refine((v) => {
      try {
        Temporal.Duration.from(v);
        return true;
      } catch {
        return false;
      }
    }, "duration must be a valid ISO 8601 duration (e.g. P180D, P6M, P1Y2M3D)"),
  }),
});

/**
 * Build the relative lease path based on service information.
 *
 * Lease files are stored at:
 * - Without service name: `.github/arm-leases/<orgName>/<rpNamespace>/lease.yaml`
 * - With service name:    `.github/arm-leases/<orgName>/<rpNamespace>/<serviceName>/lease.yaml`
 *
 * @param {string} orgName - Organization name (e.g., "compute")
 * @param {string} rpNamespace - Resource provider namespace (e.g., "Microsoft.Compute")
 * @param {string} serviceName - Optional service name for RPs with sub-groupings (e.g., "ComputeRP")
 * @returns {string} Relative path to lease.yaml file (e.g., ".github/arm-leases/compute/Microsoft.Compute/lease.yaml")
 */
function buildLeaseRelativePath(orgName, rpNamespace, serviceName = "") {
  if (serviceName) {
    return join(".github", "arm-leases", orgName, rpNamespace, serviceName, "lease.yaml");
  }
  return join(".github", "arm-leases", orgName, rpNamespace, "lease.yaml");
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
    return { valid: false, reason: `Lease expired on ${endDate.toString()}` };
  }

  return { valid: true, reason: "Lease is valid" };
}

/**
 * Check if ARM lease exists and is valid.
 *
 * Reads the lease file directly from HEAD^ (the base-branch parent of the merge commit)
 * via git show. If the lease is not found in HEAD^ (which can happen when the PR's merge
 * commit is stale — i.e., the lease was merged to the base branch after the merge commit
 * was last generated), falls back to checking origin/<GITHUB_BASE_REF> after fetching
 * the latest state of the base branch.
 *
 * @param {string} orgName - Organization name (e.g., "compute")
 * @param {string} rpNamespace - Resource provider namespace (e.g., "Microsoft.Compute")
 * @param {string} serviceName - Optional service name for RPs with sub-groupings
 * @returns {Promise<boolean>} True if lease exists and is valid, false otherwise
 */
export async function checkLease(orgName, rpNamespace, serviceName = "") {
  const repoRoot = await getRootFolder(process.cwd());
  const relLeasePath = buildLeaseRelativePath(orgName, rpNamespace, serviceName);

  const git = simpleGit(repoRoot);

  // Try reading from HEAD^ (the base-branch parent of the merge commit).
  // This is the common case when the lease was merged before the PR's merge commit was generated.
  try {
    const content = await git.show([`HEAD^:${relLeasePath}`]);
    return parseLease(content).valid;
  } catch {
    // Expected when the lease file is absent from HEAD^ — this happens when the PR's merge
    // commit is stale (the lease was merged to the base branch after the last PR push).
    // Fall back to origin/<baseBranch> after fetching latest.
  }

  const baseBranch = process.env.GITHUB_BASE_REF;
  if (!baseBranch) {
    return false;
  }

  try {
    // Fetch the latest base branch to get any leases merged after the PR was created
    await git.fetch(["origin", `${baseBranch}:refs/remotes/origin/${baseBranch}`, "--depth=1"]);
    const content = await git.show([`origin/${baseBranch}:${relLeasePath}`]);
    return parseLease(content).valid;
  } catch {
    return false;
  }
}
