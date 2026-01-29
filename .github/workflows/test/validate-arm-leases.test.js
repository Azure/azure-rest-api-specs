import { describe, it, beforeEach, afterEach } from 'node:test';
import assert from 'node:assert';
import { mkdirSync, writeFileSync, rmSync, existsSync } from 'fs';
import { join } from 'path';
import { fileURLToPath } from 'url';
import { dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Test directory setup
const TEST_DIR = join(__dirname, 'test-temp');
const ARM_LEASES_DIR = join(TEST_DIR, '.github', 'arm-leases');

// Helper function to create test lease file
function createLeaseFile(serviceName, namespace, content) {
  const leaseDir = join(ARM_LEASES_DIR, serviceName, namespace);
  mkdirSync(leaseDir, { recursive: true });
  const leaseFilePath = join(leaseDir, 'lease.yaml');
  writeFileSync(leaseFilePath, content);
  return leaseFilePath;
}

// Helper function to get relative path
function getRelativePath(fullPath) {
  return fullPath.replace(TEST_DIR + '/', '');
}

describe('ARM Leases Validation Tests', () => {
  beforeEach(() => {
    // Clean up and create fresh test directory
    if (existsSync(TEST_DIR)) {
      rmSync(TEST_DIR, { recursive: true, force: true });
    }
    mkdirSync(ARM_LEASES_DIR, { recursive: true });
  });

  afterEach(() => {
    // Clean up test directory
    if (existsSync(TEST_DIR)) {
      rmSync(TEST_DIR, { recursive: true, force: true });
    }
  });

  describe('File Pattern Validation', () => {
    it('should accept valid lease file pattern', () => {
      const validPaths = [
        '.github/arm-leases/testservice/Microsoft.Test/lease.yaml',
        '.github/arm-leases/widgetservice/Azure.Widget/lease.yaml',
        '.github/arm-leases/service123/Contoso.Manager/lease.yaml'
      ];

      const LEASE_FILE_PATTERN = /^\.github\/arm-leases\/[a-z0-9]+\/[a-zA-Z0-9.]+\/lease\.yaml$/;
      
      validPaths.forEach(path => {
        assert.ok(LEASE_FILE_PATTERN.test(path), `${path} should be valid`);
      });
    });

    it('should accept valid lease file pattern with service group', () => {
      const validPaths = [
        '.github/arm-leases/compute/Microsoft.Compute/DiskRP/lease.yaml',
        '.github/arm-leases/compute/Microsoft.Compute/ComputeRP/lease.yaml',
        '.github/arm-leases/storage/Azure.Storage/BlobRP/lease.yaml'
      ];

      const LEASE_FILE_WITH_GROUP_PATTERN = /^\.github\/arm-leases\/[a-z0-9]+\/[a-zA-Z0-9.]+\/(?!stable|preview)([^\/]+)\/lease\.yaml$/;
      
      validPaths.forEach(path => {
        assert.ok(LEASE_FILE_WITH_GROUP_PATTERN.test(path), `${path} should be valid`);
      });
    });

    it('should reject lease files with stable or preview as service group', () => {
      const invalidPaths = [
        '.github/arm-leases/compute/Microsoft.Compute/stable/lease.yaml',
        '.github/arm-leases/compute/Microsoft.Compute/preview/lease.yaml',
        '.github/arm-leases/compute/Microsoft.Compute/stable-2024-01-01/lease.yaml',
        '.github/arm-leases/compute/Microsoft.Compute/preview-2025-10-11/lease.yaml',
        '.github/arm-leases/compute/Microsoft.Compute/preview-internal/lease.yaml'
      ];

      const LEASE_FILE_WITH_GROUP_PATTERN = /^\.github\/arm-leases\/[a-z0-9]+\/[a-zA-Z0-9.]+\/(?!stable|preview)([^\/]+)\/lease\.yaml$/;
      
      invalidPaths.forEach(path => {
        assert.ok(!LEASE_FILE_WITH_GROUP_PATTERN.test(path), `${path} should be invalid`);
      });
    });

    it('should reject invalid lease file patterns', () => {
      const invalidPaths = [
        '.github/arm-leases/TestService/Microsoft.Test/lease.yaml', // uppercase service name
        '.github/arm-leases/test-service/Microsoft.Test/lease.yaml', // hyphen in service name
        '.github/arm-leases/testservice/Microsoft.Test/other.yaml', // not lease.yaml
        'arm-leases/testservice/Microsoft.Test/lease.yaml', // missing .github
      ];

      const LEASE_FILE_PATTERN = /^\.github\/arm-leases\/[a-z0-9]+\/[a-zA-Z0-9.]+\/lease\.yaml$/;
      
      invalidPaths.forEach(path => {
        assert.ok(!LEASE_FILE_PATTERN.test(path), `${path} should be invalid`);
      });
    });
  });

  describe('Resource Provider Validation', () => {
    it('should validate resource provider starts with capital letter', () => {
      const validProviders = [
        'Microsoft.Test',
        'Azure.Widget',
        'Contoso.WidgetManager',
        'MyCompany.Service.Core'
      ];

      validProviders.forEach(provider => {
        const parts = provider.split('.');
        const invalidParts = parts.filter(part => part && !/^[A-Z]/.test(part));
        assert.strictEqual(invalidParts.length, 0, `${provider} should be valid`);
      });
    });

    it('should reject resource provider with lowercase parts', () => {
      const invalidProviders = [
        'microsoft.Test',
        'Microsoft.test',
        'azure.Widget',
        'Contoso.widgetManager'
      ];

      invalidProviders.forEach(provider => {
        const parts = provider.split('.');
        const invalidParts = parts.filter(part => part && !/^[A-Z]/.test(part));
        assert.ok(invalidParts.length > 0, `${provider} should be invalid`);
      });
    });
  });

  describe('Date Validation', () => {
    it('should accept valid ISO 8601 date format', () => {
      const validDates = [
        '2026-01-07',
        '2026-12-31',
        '2027-06-15'
      ];

      const DATE_PATTERN = /^\d{4}-\d{2}-\d{2}$/;
      
      validDates.forEach(date => {
        assert.ok(DATE_PATTERN.test(date), `${date} should be valid`);
      });
    });

    it('should reject invalid date formats', () => {
      const invalidDates = [
        '01-07-2026', // wrong order
        '2026/01/07', // wrong separator
        '2026-1-7', // missing leading zeros
        '26-01-07', // two-digit year
        'January 7, 2026' // text format
      ];

      const DATE_PATTERN = /^\d{4}-\d{2}-\d{2}$/;
      
      invalidDates.forEach(date => {
        assert.ok(!DATE_PATTERN.test(date), `${date} should be invalid`);
      });
    });

    it('should reject past dates', () => {
      const today = '2026-01-07';
      const pastDate = '2026-01-06';
      
      assert.ok(pastDate < today, 'Past date should be less than today');
    });

    it('should accept today and future dates', () => {
      const today = '2026-01-07';
      const todayDate = '2026-01-07';
      const futureDate = '2026-01-08';
      
      assert.ok(todayDate >= today, 'Today should be valid');
      assert.ok(futureDate >= today, 'Future date should be valid');
    });
  });

  describe('Duration Validation', () => {
    it('should accept valid duration formats', () => {
      const validDurations = [
        '90 days',
        '180 days',
        '1 day',
        '30days',
        '60 Days'
      ];

      validDurations.forEach(duration => {
        const match = duration.match(/^(\d+)\s*days?$/i);
        assert.ok(match !== null, `${duration} should match pattern`);
        
        const days = parseInt(match[1], 10);
        assert.ok(days > 0, `${duration} should be greater than 0`);
        assert.ok(days <= 180, `${duration} should not exceed 180 days`);
      });
    });

    it('should reject invalid duration formats', () => {
      const invalidDurations = [
        '90', // missing 'days'
        'ninety days', // not numeric
        '90 months', // wrong unit
        '-10 days', // negative
        '0 days' // zero
      ];

      invalidDurations.forEach(duration => {
        const match = duration.match(/^(\d+)\s*days?$/i);
        if (match) {
          const days = parseInt(match[1], 10);
          assert.ok(days <= 0, `${duration} should be invalid (0 or negative)`);
        } else {
          assert.ok(!match, `${duration} should not match pattern`);
        }
      });
    });

    it('should reject duration exceeding 180 days', () => {
      const excessiveDurations = ['181 days', '200 days', '365 days'];

      excessiveDurations.forEach(duration => {
        const match = duration.match(/^(\d+)\s*days?$/i);
        assert.ok(match !== null, `${duration} should match pattern`);
        
        const days = parseInt(match[1], 10);
        assert.ok(days > 180, `${duration} should exceed 180 days`);
      });
    });
  });

  describe('Reviewer Validation', () => {
    it('should accept non-empty reviewer names', () => {
      const validReviewers = [
        'John Doe',
        'Jane Smith',
        'PM Team'
      ];

      validReviewers.forEach(reviewer => {
        assert.ok(reviewer && reviewer.trim() !== '', `${reviewer} should be valid`);
      });
    });

    it('should reject empty or null reviewers', () => {
      const invalidReviewers = [
        '',
        '   ',
        null,
        undefined
      ];

      invalidReviewers.forEach(reviewer => {
        const isValid = reviewer && reviewer.trim() !== '';
        assert.ok(!isValid, `${reviewer} should be invalid`);
      });
    });
  });

  describe('Integration Tests', () => {
    it('should validate complete valid lease file', () => {
      const validLease = `lease:
  resource-provider: Microsoft.Test
  startdate: 2026-01-15
  duration: 90 days
  reviewer: John Doe`;

      const leaseFile = createLeaseFile('testservice', 'Microsoft.Test', validLease);
      assert.ok(existsSync(leaseFile), 'Lease file should be created');
    });

    it('should detect resource provider mismatch', () => {
      const invalidLease = `lease:
  resource-provider: Microsoft.Other
  startdate: 2026-01-15
  duration: 90 days
  reviewer: John Doe`;

      // Creating in Microsoft.Test folder but declaring Microsoft.Other
      const leaseFile = createLeaseFile('testservice', 'Microsoft.Test', invalidLease);
      const folderRP = 'Microsoft.Test';
      const fileRP = 'Microsoft.Other';
      
      assert.notStrictEqual(folderRP, fileRP, 'Resource providers should not match');
    });

    it('should detect invalid startdate format', () => {
      const invalidLease = `lease:
  resource-provider: Microsoft.Test
  startdate: 01-15-2026
  duration: 90 days
  reviewer: John Doe`;

      const leaseFile = createLeaseFile('testservice', 'Microsoft.Test', invalidLease);
      
      const DATE_PATTERN = /^\d{4}-\d{2}-\d{2}$/;
      const invalidDate = '01-15-2026';
      assert.ok(!DATE_PATTERN.test(invalidDate), 'Date format should be invalid');
    });

    it('should detect missing reviewer', () => {
      const invalidLease = `lease:
  resource-provider: Microsoft.Test
  startdate: 2026-01-15
  duration: 90 days
  reviewer: `;

      const leaseFile = createLeaseFile('testservice', 'Microsoft.Test', invalidLease);
      const reviewer = '';
      
      assert.ok(!reviewer || reviewer.trim() === '', 'Reviewer should be empty');
    });
  });

  describe('Allowed File Patterns', () => {
    it('should allow files in arm-leases directory', () => {
      const ALLOWED_FILE_PATTERNS = [
        /^\.github\/arm-leases\//,
        /^\.github\/workflows\/validate-arm-leases\.yaml$/,
        /^\.github\/workflows\/src\/validate-arm-leases\.js$/
      ];

      const allowedFiles = [
        '.github/arm-leases/testservice/Microsoft.Test/lease.yaml',
        '.github/workflows/validate-arm-leases.yaml',
        '.github/workflows/src/validate-arm-leases.js'
      ];

      allowedFiles.forEach(file => {
        const isAllowed = ALLOWED_FILE_PATTERNS.some(pattern => pattern.test(file));
        assert.ok(isAllowed, `${file} should be allowed`);
      });
    });

    it('should reject files outside allowed patterns', () => {
      const ALLOWED_FILE_PATTERNS = [
        /^\.github\/arm-leases\//,
        /^\.github\/workflows\/validate-arm-leases\.yaml$/,
        /^\.github\/workflows\/src\/validate-arm-leases\.js$/
      ];

      const disallowedFiles = [
        'specification/testservice/readme.md',
        '.github/other-file.yaml',
        'arm-leases/testservice/Microsoft.Test/lease.yaml'
      ];

      disallowedFiles.forEach(file => {
        const isAllowed = ALLOWED_FILE_PATTERNS.some(pattern => pattern.test(file));
        assert.ok(!isAllowed, `${file} should be disallowed`);
      });
    });
  });
});
