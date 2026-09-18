import { parseYaml } from "@azure-tools/specs-shared/yaml";
import { Temporal } from "@js-temporal/polyfill";
import { readFile } from "fs/promises";
import { resolve } from "path";
import * as z from "zod";

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
 * Build the full path to a lease file within the ARM leases checkout.
 *
 * Lease files are stored at:
 * - Without service name: `.github/arm-leases/<orgName>/<rpNamespace>/lease.yaml`
 * - With service name:    `.github/arm-leases/<orgName>/<rpNamespace>/<serviceName>/lease.yaml`
 * @param leasesDir - Root folder of the checkout containing `.github/arm-leases`
 * @param orgName - Organization name (e.g., "compute")
 * @param rpNamespace - Resource provider namespace (e.g., "Microsoft.Compute")
 * @param serviceName - Optional service name for RPs with sub-groupings (e.g., "ComputeRP")
 * @returns Path to lease.yaml file
 */
function buildLeasePath(
  leasesDir: string,
  orgName: string,
  rpNamespace: string,
  serviceName: string = "",
): string {
  const leasesRoot = resolve(leasesDir, ".github", "arm-leases");
  if (serviceName) {
    return resolve(leasesRoot, orgName, rpNamespace, serviceName, "lease.yaml");
  }
  return resolve(leasesRoot, orgName, rpNamespace, "lease.yaml");
}

/**
 * Parse and validate lease YAML content. Pure function — no I/O.
 * @param content - Raw YAML string from a lease file
 * @returns Whether the lease is valid and why
 */
export function parseLease(content: string): { valid: boolean; reason: string } {
  let rawParsed: unknown;
  try {
    rawParsed = parseYaml(content, { schema: "failsafe" });
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
 * Leases are read from the checkout of the public repo's main branch (`ARM_LEASES_DIR`), which is
 * the single source of truth. Lease files in the PR's own branch are intentionally ignored, so a
 * lease merged to public main applies to private branches without being synced into them.
 * @param orgName - Organization name (e.g., "compute")
 * @param rpNamespace - Resource provider namespace (e.g., "Microsoft.Compute")
 * @param serviceName - Optional service name for RPs with sub-groupings
 * @returns True if lease exists and is valid, false otherwise
 */
export async function checkLease(
  orgName: string,
  rpNamespace: string,
  serviceName: string = "",
): Promise<boolean> {
  const cwd = process.env.GITHUB_WORKSPACE ?? process.cwd();
  const leasesDir = process.env.ARM_LEASES_DIR ?? resolve(cwd, "arm-leases");
  const leasePath = buildLeasePath(leasesDir, orgName, rpNamespace, serviceName);

  let content: string;
  try {
    content = await readFile(leasePath, "utf-8");
  } catch {
    return false;
  }

  return parseLease(content).valid;
}
