import { describe, it, expect, beforeEach, afterEach } from 'vitest';
import { mkdirSync, writeFileSync, rmSync, existsSync } from 'fs';
import { join } from 'path';
import { checkLease } from '../src/detect-arm-leases.js';

const TEST_ROOT = join(process.cwd(), '.test-arm-leases');
const ARM_LEASES_DIR = join(TEST_ROOT, '.github', 'arm-leases');

describe('detect-arm-leases', () => {
  beforeEach(() => {
    if (existsSync(TEST_ROOT)) {
      rmSync(TEST_ROOT, { recursive: true, force: true });
    }
    mkdirSync(ARM_LEASES_DIR, { recursive: true });
    process.env.TEST_REPO_ROOT = TEST_ROOT;
  });

  afterEach(() => {
    if (existsSync(TEST_ROOT)) {
      rmSync(TEST_ROOT, { recursive: true, force: true });
    }
    delete process.env.TEST_REPO_ROOT;
  });

  function createLeaseFile(serviceName, resourceProvider, startdate, duration) {
    const leaseDir = join(ARM_LEASES_DIR, serviceName, resourceProvider);
    mkdirSync(leaseDir, { recursive: true });
    
    const leaseContent = `lease:
  resource-provider: ${resourceProvider}
  startdate: ${startdate}
  duration: ${duration}
  reviewer: Test Reviewer
`;
    
    writeFileSync(join(leaseDir, 'lease.yaml'), leaseContent);
  }

  describe('checkLease', () => {
    it('returns false when lease file does not exist', async () => {
      const result = await checkLease('testservice', 'Microsoft.Test');
      expect(result).toBe(false);
    });

    it('returns true when lease is valid and not expired', async () => {
      const today = new Date();
      const startDate = new Date(today);
      startDate.setDate(today.getDate() - 30);
      
      createLeaseFile(
        'testservice',
        'Microsoft.Test',
        startDate.toISOString().split('T')[0],
        '90 days'
      );

      const result = await checkLease('testservice', 'Microsoft.Test');
      expect(result).toBe(true);
    });

    it('returns false when lease has expired', async () => {
      const today = new Date();
      const startDate = new Date(today);
      startDate.setDate(today.getDate() - 100);
      
      createLeaseFile(
        'testservice',
        'Microsoft.Test',
        startDate.toISOString().split('T')[0],
        '90 days'
      );

      const result = await checkLease('testservice', 'Microsoft.Test');
      expect(result).toBe(false);
    });

    it('returns true on the last day of lease', async () => {
      const today = new Date();
      const startDate = new Date(today);
      startDate.setDate(today.getDate() - 89);
      
      createLeaseFile(
        'testservice',
        'Microsoft.Test',
        startDate.toISOString().split('T')[0],
        '90 days'
      );

      const result = await checkLease('testservice', 'Microsoft.Test');
      expect(result).toBe(true);
    });

    it('returns false one day after lease expires', async () => {
      const today = new Date();
      const startDate = new Date(today);
      startDate.setDate(today.getDate() - 91);
      
      createLeaseFile(
        'testservice',
        'Microsoft.Test',
        startDate.toISOString().split('T')[0],
        '90 days'
      );

      const result = await checkLease('testservice', 'Microsoft.Test');
      expect(result).toBe(false);
    });

    it('handles different duration formats', async () => {
      const today = new Date();
      const startDate = new Date(today);
      startDate.setDate(today.getDate() - 10);
      
      createLeaseFile(
        'testservice',
        'Microsoft.Test',
        startDate.toISOString().split('T')[0],
        '180 Days'
      );

      const result = await checkLease('testservice', 'Microsoft.Test');
      expect(result).toBe(true);
    });

    it('handles single day duration', async () => {
      const today = new Date();
      
      createLeaseFile(
        'testservice',
        'Microsoft.Test',
        today.toISOString().split('T')[0],
        '1 day'
      );

      const result = await checkLease('testservice', 'Microsoft.Test');
      expect(result).toBe(true);
    });

    it('returns false for invalid lease file format', async () => {
      const leaseDir = join(ARM_LEASES_DIR, 'testservice', 'Microsoft.Test');
      mkdirSync(leaseDir, { recursive: true });
      writeFileSync(join(leaseDir, 'lease.yaml'), 'invalid: yaml: content');

      const result = await checkLease('testservice', 'Microsoft.Test');
      expect(result).toBe(false);
    });

    it('handles multiple services and namespaces', async () => {
      const today = new Date();
      const startDate = new Date(today);
      startDate.setDate(today.getDate() - 30);
      
      createLeaseFile('app', 'Microsoft.App', startDate.toISOString().split('T')[0], '90 days');
      createLeaseFile('compute', 'Microsoft.Compute', startDate.toISOString().split('T')[0], '90 days');

      expect(await checkLease('app', 'Microsoft.App')).toBe(true);
      expect(await checkLease('compute', 'Microsoft.Compute')).toBe(true);
      expect(await checkLease('storage', 'Microsoft.Storage')).toBe(false);
    });

    it('handles future start dates', async () => {
      const today = new Date();
      const futureDate = new Date(today);
      futureDate.setDate(today.getDate() + 10);
      
      createLeaseFile(
        'testservice',
        'Microsoft.Test',
        futureDate.toISOString().split('T')[0],
        '90 days'
      );

      const result = await checkLease('testservice', 'Microsoft.Test');
      expect(result).toBe(true);
    });
  });
});
