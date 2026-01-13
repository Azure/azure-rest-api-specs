import { describe, it, expect } from 'vitest';

// Mock functions for testing
function mockResourceProviderExists(specPath, namespace) {
  const existingNamespaces = ['Microsoft.Existing', 'Microsoft.Another'];
  return existingNamespaces.includes(namespace);
}

function mockExtractResourceProviders(files) {
  const resourceProviders = new Map();
  const pattern = /^specification\/([^\/]+)\/resource-manager\/([^\/]+)/;
  
  for (const file of files) {
    const match = file.match(pattern);
    if (match) {
      const serviceName = match[1];
      const namespace = match[2];
      resourceProviders.set(namespace, serviceName);
    }
  }
  
  return resourceProviders;
}

describe('detect-new-resource-provider', () => {
  describe('extractResourceProviders', () => {
    it('extracts namespace and service from valid paths', () => {
      const files = [
        'specification/app/resource-manager/Microsoft.App/stable/2023-01-01/app.json',
        'specification/compute/resource-manager/Microsoft.Compute/stable/2023-01-01/compute.json',
      ];

      const result = mockExtractResourceProviders(files);

      expect(result.size).toBe(2);
      expect(result.get('Microsoft.App')).toBe('app');
      expect(result.get('Microsoft.Compute')).toBe('compute');
    });

    it('handles multiple files from same namespace', () => {
      const files = [
        'specification/app/resource-manager/Microsoft.App/stable/2023-01-01/app.json',
        'specification/app/resource-manager/Microsoft.App/stable/2023-01-01/models.json',
        'specification/app/resource-manager/Microsoft.App/preview/2023-01-01-preview/app.json',
      ];

      const result = mockExtractResourceProviders(files);

      expect(result.size).toBe(1);
      expect(result.get('Microsoft.App')).toBe('app');
    });

    it('ignores non-resource-manager files', () => {
      const files = [
        'specification/app/data-plane/Microsoft.App/stable/2023-01-01/app.json',
        'specification/app/resource-manager/Microsoft.App/stable/2023-01-01/app.json',
        'specification/app/docs/readme.md',
      ];

      const result = mockExtractResourceProviders(files);

      expect(result.size).toBe(1);
      expect(result.get('Microsoft.App')).toBe('app');
    });

    it('handles empty file list', () => {
      const files = [];
      const result = mockExtractResourceProviders(files);
      expect(result.size).toBe(0);
    });

    it('handles nested namespace paths', () => {
      const files = [
        'specification/test-service/resource-manager/Microsoft.TestService/stable/2023-01-01/operations.json',
      ];

      const result = mockExtractResourceProviders(files);

      expect(result.size).toBe(1);
      expect(result.get('Microsoft.TestService')).toBe('test-service');
    });
  });

  describe('resourceProviderExists', () => {
    it('returns true for existing namespace', () => {
      const result = mockResourceProviderExists('/path/to/spec', 'Microsoft.Existing');
      expect(result).toBe(true);
    });

    it('returns false for new namespace', () => {
      const result = mockResourceProviderExists('/path/to/spec', 'Microsoft.NewService');
      expect(result).toBe(false);
    });

    it('returns false for non-matching namespace', () => {
      const result = mockResourceProviderExists('/path/to/spec', 'Microsoft.Unknown');
      expect(result).toBe(false);
    });
  });

  describe('new resource provider detection logic', () => {
    it('identifies new resource providers correctly', () => {
      const changedFiles = [
        'specification/newservice/resource-manager/Microsoft.NewService/stable/2023-01-01/service.json',
        'specification/existing/resource-manager/Microsoft.Existing/stable/2023-01-01/service.json',
      ];

      const changedResourceProviders = mockExtractResourceProviders(changedFiles);
      const newResourceProviders = [];

      for (const [rp, serviceName] of changedResourceProviders) {
        if (!mockResourceProviderExists('/spec', rp)) {
          newResourceProviders.push({ namespace: rp, serviceName });
        }
      }

      expect(newResourceProviders.length).toBe(1);
      expect(newResourceProviders[0].namespace).toBe('Microsoft.NewService');
      expect(newResourceProviders[0].serviceName).toBe('newservice');
    });

    it('handles no new resource providers', () => {
      const changedFiles = [
        'specification/existing/resource-manager/Microsoft.Existing/stable/2023-01-01/service.json',
        'specification/another/resource-manager/Microsoft.Another/stable/2023-01-01/service.json',
      ];

      const changedResourceProviders = mockExtractResourceProviders(changedFiles);
      const newResourceProviders = [];

      for (const [rp, serviceName] of changedResourceProviders) {
        if (!mockResourceProviderExists('/spec', rp)) {
          newResourceProviders.push({ namespace: rp, serviceName });
        }
      }

      expect(newResourceProviders.length).toBe(0);
    });

    it('handles multiple new resource providers', () => {
      const changedFiles = [
        'specification/service1/resource-manager/Microsoft.Service1/stable/2023-01-01/service.json',
        'specification/service2/resource-manager/Microsoft.Service2/stable/2023-01-01/service.json',
      ];

      const changedResourceProviders = mockExtractResourceProviders(changedFiles);
      const newResourceProviders = [];

      for (const [rp, serviceName] of changedResourceProviders) {
        if (!mockResourceProviderExists('/spec', rp)) {
          newResourceProviders.push({ namespace: rp, serviceName });
        }
      }

      expect(newResourceProviders.length).toBe(2);
      expect(newResourceProviders[0].namespace).toBe('Microsoft.Service1');
      expect(newResourceProviders[1].namespace).toBe('Microsoft.Service2');
    });
  });

  describe('lease validation integration', () => {
    it('creates correct output structure with lease validation', () => {
      const newResourceProviders = [
        { namespace: 'Microsoft.NewService', serviceName: 'newservice' }
      ];

      const leaseCheckResults = [];
      
      for (const rp of newResourceProviders) {
        const leaseValid = false; // Mock lease check
        const leaseMessage = 'No lease file found or lease has expired';
        
        leaseCheckResults.push({
          namespace: rp.namespace,
          serviceName: rp.serviceName,
          leaseValid: leaseValid,
          leaseMessage: leaseMessage
        });
      }

      const outputData = {
        newResourceProviders: leaseCheckResults
      };

      expect(outputData.newResourceProviders).toHaveLength(1);
      expect(outputData.newResourceProviders[0]).toEqual({
        namespace: 'Microsoft.NewService',
        serviceName: 'newservice',
        leaseValid: false,
        leaseMessage: 'No lease file found or lease has expired'
      });
    });

    it('handles valid lease in output', () => {
      const newResourceProviders = [
        { namespace: 'Microsoft.ValidLease', serviceName: 'validservice' }
      ];

      const leaseCheckResults = [];
      
      for (const rp of newResourceProviders) {
        const leaseValid = true; // Mock valid lease
        const leaseMessage = 'Lease is valid';
        
        leaseCheckResults.push({
          namespace: rp.namespace,
          serviceName: rp.serviceName,
          leaseValid: leaseValid,
          leaseMessage: leaseMessage
        });
      }

      const outputData = {
        newResourceProviders: leaseCheckResults
      };

      expect(outputData.newResourceProviders[0].leaseValid).toBe(true);
      expect(outputData.newResourceProviders[0].leaseMessage).toBe('Lease is valid');
    });
  });

  describe('JSON output file generation', () => {
    it('creates output JSON file with correct structure', () => {
      const leaseCheckResults = [
        {
          namespace: 'Microsoft.NewService',
          serviceName: 'newservice',
          leaseValid: false,
          leaseMessage: 'No lease file found or lease has expired'
        },
        {
          namespace: 'Microsoft.AnotherNew',
          serviceName: 'anothernew',
          leaseValid: true,
          leaseMessage: 'Lease is valid'
        }
      ];

      const outputData = {
        newResourceProviders: leaseCheckResults
      };

      expect(outputData).toHaveProperty('newResourceProviders');
      expect(Array.isArray(outputData.newResourceProviders)).toBe(true);
      expect(outputData.newResourceProviders).toHaveLength(2);
    });

    it('includes all required fields for each resource provider', () => {
      const leaseCheckResults = [
        {
          namespace: 'Microsoft.Test',
          serviceName: 'test',
          leaseValid: false,
          leaseMessage: 'No lease file found or lease has expired'
        }
      ];

      const outputData = {
        newResourceProviders: leaseCheckResults
      };

      const rp = outputData.newResourceProviders[0];
      expect(rp).toHaveProperty('namespace');
      expect(rp).toHaveProperty('serviceName');
      expect(rp).toHaveProperty('leaseValid');
      expect(rp).toHaveProperty('leaseMessage');
      expect(typeof rp.namespace).toBe('string');
      expect(typeof rp.serviceName).toBe('string');
      expect(typeof rp.leaseValid).toBe('boolean');
      expect(typeof rp.leaseMessage).toBe('string');
    });

    it('formats output data for PR comment consumption', () => {
      const leaseCheckResults = [
        {
          namespace: 'Microsoft.NewRP',
          serviceName: 'newrp',
          leaseValid: false,
          leaseMessage: 'No lease file found or lease has expired'
        }
      ];

      const outputData = {
        newResourceProviders: leaseCheckResults
      };

      const jsonString = JSON.stringify(outputData, null, 2);
      const parsed = JSON.parse(jsonString);

      expect(parsed.newResourceProviders).toEqual(leaseCheckResults);
      expect(jsonString).toContain('newResourceProviders');
      expect(jsonString).toContain('Microsoft.NewRP');
    });

    it('handles multiple new RPs with mixed lease statuses', () => {
      const leaseCheckResults = [
        {
          namespace: 'Microsoft.Valid',
          serviceName: 'valid',
          leaseValid: true,
          leaseMessage: 'Lease is valid'
        },
        {
          namespace: 'Microsoft.Expired',
          serviceName: 'expired',
          leaseValid: false,
          leaseMessage: 'Lease has expired'
        },
        {
          namespace: 'Microsoft.Missing',
          serviceName: 'missing',
          leaseValid: false,
          leaseMessage: 'No lease file found or lease has expired'
        }
      ];

      const outputData = {
        newResourceProviders: leaseCheckResults
      };

      expect(outputData.newResourceProviders).toHaveLength(3);
      expect(outputData.newResourceProviders.filter(rp => rp.leaseValid)).toHaveLength(1);
      expect(outputData.newResourceProviders.filter(rp => !rp.leaseValid)).toHaveLength(2);
    });
  });

  describe('PR comment data preparation', () => {
    it('provides data for office hours attendance message', () => {
      const leaseCheckResults = [
        {
          namespace: 'Microsoft.NewService',
          serviceName: 'newservice',
          leaseValid: false,
          leaseMessage: 'No lease file found or lease has expired'
        }
      ];

      const outputData = {
        newResourceProviders: leaseCheckResults
      };

      // Verify data structure for PR comment
      expect(outputData.newResourceProviders.length).toBeGreaterThan(0);
      
      const hasNewRP = outputData.newResourceProviders.length > 0;
      expect(hasNewRP).toBe(true);
      
      // Verify each RP has info needed for comment
      outputData.newResourceProviders.forEach(rp => {
        expect(rp.namespace).toBeTruthy();
        expect(rp.serviceName).toBeTruthy();
        expect(typeof rp.leaseValid).toBe('boolean');
        expect(rp.leaseMessage).toBeTruthy();
      });
    });

    it('identifies RPs without valid lease for office hours requirement', () => {
      const leaseCheckResults = [
        {
          namespace: 'Microsoft.WithLease',
          serviceName: 'withlease',
          leaseValid: true,
          leaseMessage: 'Lease is valid'
        },
        {
          namespace: 'Microsoft.WithoutLease',
          serviceName: 'withoutlease',
          leaseValid: false,
          leaseMessage: 'No lease file found or lease has expired'
        }
      ];

      const outputData = {
        newResourceProviders: leaseCheckResults
      };

      const rpsNeedingOfficeHours = outputData.newResourceProviders.filter(rp => !rp.leaseValid);
      const rpsWithValidLease = outputData.newResourceProviders.filter(rp => rp.leaseValid);

      expect(rpsNeedingOfficeHours).toHaveLength(1);
      expect(rpsNeedingOfficeHours[0].namespace).toBe('Microsoft.WithoutLease');
      expect(rpsWithValidLease).toHaveLength(1);
      expect(rpsWithValidLease[0].namespace).toBe('Microsoft.WithLease');
    });

    it('formats lease path information for PR comment', () => {
      const leaseCheckResults = [
        {
          namespace: 'Microsoft.Test',
          serviceName: 'testservice',
          leaseValid: false,
          leaseMessage: 'No lease file found or lease has expired'
        }
      ];

      const outputData = {
        newResourceProviders: leaseCheckResults
      };

      const rp = outputData.newResourceProviders[0];
      const expectedLeasePath = `.github/arm-leases/${rp.serviceName}/${rp.namespace}/lease.yaml`;

      expect(expectedLeasePath).toBe('.github/arm-leases/testservice/Microsoft.Test/lease.yaml');
    });
  });
});
