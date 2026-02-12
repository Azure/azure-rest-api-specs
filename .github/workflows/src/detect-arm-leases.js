import { readFile } from 'fs/promises';
import { resolve } from 'path';
import yaml from 'js-yaml';
import * as z from 'zod';
import { getRootFolder } from '../../shared/src/simple-git.js';

/**
 * Schema for lease.yaml file
 * 
 * Example:
 * ```yaml
 * lease:
 *   startdate: "2024-01-01"
 *   duration: "30 days"
 * ```
 */
const leaseSchema = z.object({
  lease: z.object({
    startdate: z.string().regex(/^\d{4}-\d{2}-\d{2}$/, 'startdate must be in YYYY-MM-DD format'),
    duration: z.string().regex(/^\d+\s*days?$/i, 'duration must be in format "N days"'),
  }),
});

/**
 * Build the lease path based on service information.
 * 
 * Lease files are stored at:
 * - Without service group: `.github/arm-leases/<serviceName>/<resourceProvider>/lease.yaml`
 * - With service group:    `.github/arm-leases/<serviceName>/<resourceProvider>/<serviceGroup>/lease.yaml`
 * 
 * @param {string} repoRoot - Repository root path
 * @param {string} serviceName - Service name (e.g., "compute")
 * @param {string} resourceProvider - Resource provider namespace (e.g., "Microsoft.Compute")
 * @param {string} serviceGroup - Optional service group for RPs that have sub-groupings (e.g., "ComputeRP")
 * @returns {string} Full path to lease.yaml file
 */
function buildLeasePath(repoRoot, serviceName, resourceProvider, serviceGroup = '') {
  const leasePathParts = [repoRoot, '.github', 'arm-leases', serviceName, resourceProvider];
  if (serviceGroup) {
    leasePathParts.push(serviceGroup);
  }
  leasePathParts.push('lease.yaml');
  return resolve(...leasePathParts);
}

/**
 * Check if ARM lease exists and is valid
 * @param {string} serviceName - Service name
 * @param {string} resourceProvider - Resource provider namespace
 * @param {string} serviceGroup - Optional service group
 * @returns {Promise<{ exists: boolean, valid: boolean, leasePath: string }>} Lease status
 */
export async function getLeaseStatus(serviceName, resourceProvider, serviceGroup = '') {
  const repoRoot = process.env.TEST_REPO_ROOT || await getRootFolder(process.cwd());
  const leasePath = buildLeasePath(repoRoot, serviceName, resourceProvider, serviceGroup);

  let content;
  try {
    content = await readFile(leasePath, 'utf-8');
  } catch {
    return { exists: false, valid: false, leasePath };
  }

  try {
    const rawParsed = /** @type {any} */ (yaml.load(content, { schema: yaml.FAILSAFE_SCHEMA }));

    if (!rawParsed) {
      return { exists: true, valid: false, leasePath };
    }

    const parsed = leaseSchema.parse(rawParsed);
    const lease = parsed.lease;

    const durationDays = parseInt(lease.duration.match(/^(\d+)\s*days?$/i)[1], 10);
    const endDate = new Date(lease.startdate);
    endDate.setDate(endDate.getDate() + durationDays);

    const today = new Date();
    today.setHours(0, 0, 0, 0);

    return { exists: true, valid: today <= endDate, leasePath };
  } catch {
    // File exists but content is invalid
    return { exists: true, valid: false, leasePath };
  }
}

/**
 * Check if ARM lease exists and is valid.
 * 
 * Looks for a lease file at the appropriate path (see buildLeasePath for path structure).
 * 
 * @param {string} serviceName - Service name (e.g., "compute")
 * @param {string} resourceProvider - Resource provider namespace (e.g., "Microsoft.Compute")
 * @param {string} serviceGroup - Optional service group for RPs with sub-groupings
 * @returns {Promise<boolean>} True if lease exists and is valid, false otherwise
 */
export async function checkLease(serviceName, resourceProvider, serviceGroup = '') {
  const status = await getLeaseStatus(serviceName, resourceProvider, serviceGroup);
  return status.valid;
}
