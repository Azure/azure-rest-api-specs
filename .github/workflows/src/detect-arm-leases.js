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
 * @returns {boolean} True if lease exists and is valid, false otherwise
 */
export function checkLease(serviceName, resourceProvider, serviceGroup = '') {
  try {
    const repoRoot = process.env.TEST_REPO_ROOT || execSync('git rev-parse --show-toplevel', { encoding: 'utf-8' }).trim();
    const leasePath = buildLeasePath(repoRoot, serviceName, resourceProvider, serviceGroup);

    if (!existsSync(leasePath)) {
      return false;
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

    return today <= endDate;
  } catch (error) {
    return false;
  }
}

function main() {
  const serviceName = process.argv[2];
  const resourceProvider = process.argv[3];
  const serviceGroup = process.argv[4] || '';

  if (!serviceName || !resourceProvider) {
    console.error('Usage: node detect-arm-leases.js <service-name> <resource-provider-name> [service-group]');
    process.exit(1);
  }

  const result = checkLease(serviceName, resourceProvider, serviceGroup);

  if (!result) {
    const repoRoot = execSync('git rev-parse --show-toplevel', { encoding: 'utf-8' }).trim();
    const leasePath = buildLeasePath(repoRoot, serviceName, resourceProvider, serviceGroup);
    
    if (!existsSync(leasePath)) {
      console.log('No lease file found');
    } else {
      console.error('Lease has expired');
    }
    process.exit(1);
  }

  console.log('Lease is valid');
  process.exit(0);
}

// Only run main if this file is executed directly (not imported)
if (process.argv[1] && process.argv[1].endsWith('detect-arm-leases.js')) {
  main();
}
