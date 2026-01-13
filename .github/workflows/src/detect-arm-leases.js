import { existsSync, readFileSync } from 'fs';
import { join } from 'path';
import { execSync } from 'child_process';
import YAML from 'js-yaml';

/**
 * Check if ARM lease exists and is valid
 * @param {string} serviceName - Service name
 * @param {string} resourceProvider - Resource provider namespace
 * @returns {boolean} True if lease exists and is valid, false otherwise
 */
export function checkLease(serviceName, resourceProvider) {
  try {
    const repoRoot = process.env.TEST_REPO_ROOT || execSync('git rev-parse --show-toplevel', { encoding: 'utf-8' }).trim();
    const leasePath = join(repoRoot, '.github', 'arm-leases', serviceName, resourceProvider, 'lease.yaml');

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

  if (!serviceName || !resourceProvider) {
    console.error('Usage: node detect-arm-leases.js <service-name> <resource-provider-name>');
    process.exit(1);
  }

  const result = checkLease(serviceName, resourceProvider);

  if (!result) {
    const repoRoot = execSync('git rev-parse --show-toplevel', { encoding: 'utf-8' }).trim();
    const leasePath = join(repoRoot, '.github', 'arm-leases', serviceName, resourceProvider, 'lease.yaml');
    
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
