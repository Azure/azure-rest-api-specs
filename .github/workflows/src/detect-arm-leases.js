import { existsSync, readFileSync } from 'fs';
import { join } from 'path';
import { execSync } from 'child_process';
import YAML from 'js-yaml';

/**
 * Build the lease path based on service information
 * @param {string} repoRoot - Repository root path
 * @param {string} serviceName - Service name
 * @param {string} resourceProvider - Resource provider namespace
 * @param {string} serviceGroup - Optional service group
 * @returns {string} Full path to lease.yaml file
 */
function buildLeasePath(repoRoot, serviceName, resourceProvider, serviceGroup = '') {
  const leasePathParts = [repoRoot, '.github', 'arm-leases', serviceName, resourceProvider];
  if (serviceGroup) {
    leasePathParts.push(serviceGroup);
  }
  leasePathParts.push('lease.yaml');
  return join(...leasePathParts);
}

/**
 * Check if ARM lease exists and is valid
 * @param {string} serviceName - Service name
 * @param {string} resourceProvider - Resource provider namespace
 * @param {string} serviceGroup - Optional service group
 * @returns {{ exists: boolean, valid: boolean, leasePath: string }} Lease status
 */
function getLeaseStatus(serviceName, resourceProvider, serviceGroup = '') {
  const repoRoot = process.env.TEST_REPO_ROOT || execSync('git rev-parse --show-toplevel', { encoding: 'utf-8' }).trim();
  const leasePath = buildLeasePath(repoRoot, serviceName, resourceProvider, serviceGroup);

  try {
    if (!existsSync(leasePath)) {
      return { exists: false, valid: false, leasePath };
    }

    const content = readFileSync(leasePath, 'utf-8');
    const parsed = YAML.load(content);
    const lease = parsed.lease;

    let startdate = lease.startdate;
    if (startdate instanceof Date) {
      startdate = startdate.toISOString().split('T')[0];
    }

    const durationDays = parseInt(lease.duration.match(/^(\d+)\s*days?$/i)[1], 10);
    const endDate = new Date(startdate);
    endDate.setDate(endDate.getDate() + durationDays);

    const today = new Date();
    today.setHours(0, 0, 0, 0);

    return { exists: true, valid: today <= endDate, leasePath };
  } catch (error) {
    return { exists: existsSync(leasePath), valid: false, leasePath };
  }
}

/**
 * Check if ARM lease exists and is valid
 * @param {string} serviceName - Service name
 * @param {string} resourceProvider - Resource provider namespace
 * @param {string} serviceGroup - Optional service group
 * @returns {boolean} True if lease exists and is valid, false otherwise
 */
export function checkLease(serviceName, resourceProvider, serviceGroup = '') {
  return getLeaseStatus(serviceName, resourceProvider, serviceGroup).valid;
}

function main() {
  const serviceName = process.argv[2];
  const resourceProvider = process.argv[3];
  const serviceGroup = process.argv[4] || '';

  if (!serviceName || !resourceProvider) {
    console.error(`Missing arguments: serviceName="${serviceName}", resourceProviderName="${resourceProvider}"`);
    process.exit(1);
  }

  const status = getLeaseStatus(serviceName, resourceProvider, serviceGroup);

  if (!status.valid) {
    const message = status.exists ? 'Lease has expired' : 'No lease file found';
    console.log(message);
    process.exit(1);
  }

  console.log('Lease is valid');
  process.exit(0);
}

// Only run main if this file is executed directly (not imported)
if (process.argv[1] && process.argv[1].endsWith('detect-arm-leases.js')) {
  main();
}
