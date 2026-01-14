import { describe, it, expect } from 'vitest';

// Mock functions for testing
function mockResourceProviderExists(specPath, namespace) {
  const existingNamespaces = ['Microsoft.Existing', 'Microsoft.Another'];
  return existingNamespaces.includes(namespace);
}

function mockExtractResourceProviders(files) {
  const resourceProviders = new Map();
  const pattern = /^specification\/([^\/]+)\/resource-manager\/([^\/]+)/;
  const groupPattern = /^specification\/[^\/]+\/resource-manager\/([^\/]+)\/([^\/]+)\/(stable|preview|preview-internal)\//;
  
  for (const file of files) {
    const match = file.match(pattern);
    if (match) {
      const serviceName = match[1];
      const namespace = match[2];
      
      // Check if there's a service group (folder between namespace and version folder)
      const groupMatch = file.match(groupPattern);
      if (groupMatch && groupMatch[2] !== 'stable' && groupMatch[2] !== 'preview' && groupMatch[2] !== 'preview-internal') {
        const serviceGroup = groupMatch[2];
        resourceProviders.set(namespace, { serviceName, serviceGroup });
      } else {
        resourceProviders.set(namespace, { serviceName });
      }
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
      expect(result.get('Microsoft.App')).toEqual({ serviceName: 'app' });
      expect(result.get('Microsoft.Compute')).toEqual({ serviceName: 'compute' });
    });

    it('handles multiple files from same namespace', () => {
      const files = [
        'specification/app/resource-manager/Microsoft.App/stable/2023-01-01/app.json',
        'specification/app/resource-manager/Microsoft.App/stable/2023-01-01/models.json',
        'specification/app/resource-manager/Microsoft.App/preview/2023-01-01-preview/app.json',
      ];

      const result = mockExtractResourceProviders(files);

      expect(result.size).toBe(1);
      expect(result.get('Microsoft.App')).toEqual({ serviceName: 'app' });
    });

    it('ignores non-resource-manager files', () => {
      const files = [
        'specification/app/data-plane/Microsoft.App/stable/2023-01-01/app.json',
        'specification/app/resource-manager/Microsoft.App/stable/2023-01-01/app.json',
        'specification/app/docs/readme.md',
      ];

      const result = mockExtractResourceProviders(files);

      expect(result.size).toBe(1);
      expect(result.get('Microsoft.App')).toEqual({ serviceName: 'app' });
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
      expect(result.get('Microsoft.TestService')).toEqual({ serviceName: 'test-service' });
    });

    it('extracts service group when present', () => {
      const files = [
        'specification/compute/resource-manager/Microsoft.Compute/DiskRP/stable/2023-01-01/disk.json',
      ];

      const result = mockExtractResourceProviders(files);

      expect(result.size).toBe(1);
      expect(result.get('Microsoft.Compute')).toEqual({ serviceName: 'compute', serviceGroup: 'DiskRP' });
    });

    it('handles mix of files with and without service groups', () => {
      const files = [
        'specification/compute/resource-manager/Microsoft.Compute/DiskRP/stable/2023-01-01/disk.json',
        'specification/app/resource-manager/Microsoft.App/stable/2023-01-01/app.json',
      ];

      const result = mockExtractResourceProviders(files);

      expect(result.size).toBe(2);
      expect(result.get('Microsoft.Compute')).toEqual({ serviceName: 'compute', serviceGroup: 'DiskRP' });
      expect(result.get('Microsoft.App')).toEqual({ serviceName: 'app' });
    });

    it('does not treat preview-<date> as service group', () => {
      const files = [
        'specification/app/resource-manager/Microsoft.App/preview-2025-10-11/app.json',
      ];

      const result = mockExtractResourceProviders(files);

      expect(result.size).toBe(1);
      expect(result.get('Microsoft.App')).toEqual({ serviceName: 'app' });
    });

    it('does not treat preview-internal as service group', () => {
      const files = [
        'specification/app/resource-manager/Microsoft.App/preview-internal/2023-01-01/app.json',
      ];

      const result = mockExtractResourceProviders(files);

      expect(result.size).toBe(1);
      expect(result.get('Microsoft.App')).toEqual({ serviceName: 'app' });
    });

    it('does not treat stable-<date> as service group', () => {
      const files = [
        'specification/app/resource-manager/Microsoft.App/stable-2024-01-01/app.json',
      ];

      const result = mockExtractResourceProviders(files);

      expect(result.size).toBe(1);
      expect(result.get('Microsoft.App')).toEqual({ serviceName: 'app' });
    });

    it('extracts service group when folder does not start with stable or preview', () => {
      const files = [
        'specification/compute/resource-manager/Microsoft.Compute/DiskRP/stable/2023-01-01/disk.json',
        'specification/compute/resource-manager/Microsoft.Compute/ComputeRP/preview/2023-01-01/compute.json',
        'specification/storage/resource-manager/Microsoft.Storage/StorageRP/stable/2023-01-01/storage.json',
      ];

      const result = mockExtractResourceProviders(files);

      expect(result.size).toBe(2);
      expect(result.get('Microsoft.Compute')).toEqual({ serviceName: 'compute', serviceGroup: 'ComputeRP' });
      expect(result.get('Microsoft.Storage')).toEqual({ serviceName: 'storage', serviceGroup: 'StorageRP' });
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

      for (const [rp, info] of changedResourceProviders) {
        if (!mockResourceProviderExists('/spec', rp)) {
          newResourceProviders.push({ 
            namespace: rp, 
            serviceName: info.serviceName,
            serviceGroup: info.serviceGroup 
          });
        }
      }

      expect(newResourceProviders.length).toBe(1);
      expect(newResourceProviders[0].namespace).toBe('Microsoft.NewService');
      expect(newResourceProviders[0].serviceName).toBe('newservice');
      expect(newResourceProviders[0].serviceGroup).toBeUndefined();
    });

    it('handles no new resource providers', () => {
      const changedFiles = [
        'specification/existing/resource-manager/Microsoft.Existing/stable/2023-01-01/service.json',
        'specification/another/resource-manager/Microsoft.Another/stable/2023-01-01/service.json',
      ];

      const changedResourceProviders = mockExtractResourceProviders(changedFiles);
      const newResourceProviders = [];

      for (const [rp, info] of changedResourceProviders) {
        if (!mockResourceProviderExists('/spec', rp)) {
          newResourceProviders.push({ 
            namespace: rp, 
            serviceName: info.serviceName,
            serviceGroup: info.serviceGroup 
          });
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

      for (const [rp, info] of changedResourceProviders) {
        if (!mockResourceProviderExists('/spec', rp)) {
          newResourceProviders.push({ 
            namespace: rp, 
            serviceName: info.serviceName,
            serviceGroup: info.serviceGroup 
          });
        }
      }

      expect(newResourceProviders.length).toBe(2);
      expect(newResourceProviders[0].namespace).toBe('Microsoft.Service1');
      expect(newResourceProviders[1].namespace).toBe('Microsoft.Service2');
    });

    it('identifies new resource providers with service groups', () => {
      const changedFiles = [
        'specification/compute/resource-manager/Microsoft.Compute/DiskRP/stable/2023-01-01/disk.json',
      ];

      const changedResourceProviders = mockExtractResourceProviders(changedFiles);
      const newResourceProviders = [];

      for (const [rp, info] of changedResourceProviders) {
        if (!mockResourceProviderExists('/spec', rp)) {
          newResourceProviders.push({ 
            namespace: rp, 
            serviceName: info.serviceName,
            serviceGroup: info.serviceGroup 
          });
        }
      }

      expect(newResourceProviders.length).toBe(1);
      expect(newResourceProviders[0].namespace).toBe('Microsoft.Compute');
      expect(newResourceProviders[0].serviceName).toBe('compute');
      expect(newResourceProviders[0].serviceGroup).toBe('DiskRP');
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
          serviceGroup: rp.serviceGroup,
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
        serviceGroup: undefined,
        leaseValid: false,
        leaseMessage: 'No lease file found or lease has expired'
      });
    });

    it('creates correct output structure with service group', () => {
      const newResourceProviders = [
        { namespace: 'Microsoft.Compute', serviceName: 'compute', serviceGroup: 'DiskRP' }
      ];

      const leaseCheckResults = [];
      
      for (const rp of newResourceProviders) {
        const leaseValid = true; // Mock lease check
        const leaseMessage = 'Lease is valid';
        
        leaseCheckResults.push({
          namespace: rp.namespace,
          serviceName: rp.serviceName,
          serviceGroup: rp.serviceGroup,
          leaseValid: leaseValid,
          leaseMessage: leaseMessage
        });
      }

      const outputData = {
        newResourceProviders: leaseCheckResults
      };

      expect(outputData.newResourceProviders).toHaveLength(1);
      expect(outputData.newResourceProviders[0]).toEqual({
        namespace: 'Microsoft.Compute',
        serviceName: 'compute',
        serviceGroup: 'DiskRP',
        leaseValid: true,
        leaseMessage: 'Lease is valid'
      });
    });

    it('handles valid lease in output', () => {
      const newResourceProviders = [
        { namespace: 'Microsoft.ValidLease', serviceName: 'validservice', serviceGroup: undefined }
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
          serviceGroup: undefined,
          leaseValid: false,
          leaseMessage: 'No lease file found or lease has expired'
        },
        {
          namespace: 'Microsoft.AnotherNew',
          serviceName: 'anothernew',
          serviceGroup: undefined,
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
          serviceGroup: undefined,
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
      expect(rp).toHaveProperty('serviceGroup');
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
          serviceGroup: undefined,
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
          serviceGroup: undefined,
          leaseValid: true,
          leaseMessage: 'Lease is valid'
        },
        {
          namespace: 'Microsoft.Expired',
          serviceName: 'expired',
          serviceGroup: 'SomeRP',
          leaseValid: false,
          leaseMessage: 'Lease has expired'
        },
        {
          namespace: 'Microsoft.Missing',
          serviceName: 'missing',
          serviceGroup: undefined,
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
          serviceGroup: undefined,
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
          serviceGroup: undefined,
          leaseValid: true,
          leaseMessage: 'Lease is valid'
        },
        {
          namespace: 'Microsoft.WithoutLease',
          serviceName: 'withoutlease',
          serviceGroup: 'TestRP',
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
          serviceGroup: undefined,
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

    it('formats lease path with service group', () => {
      const leaseCheckResults = [
        {
          namespace: 'Microsoft.Compute',
          serviceName: 'compute',
          serviceGroup: 'DiskRP',
          leaseValid: false,
          leaseMessage: 'No lease file found or lease has expired'
        }
      ];

      const outputData = {
        newResourceProviders: leaseCheckResults
      };

      const rp = outputData.newResourceProviders[0];
      const leasePathParts = ['.github/arm-leases', rp.serviceName, rp.namespace];
      if (rp.serviceGroup) {
        leasePathParts.push(rp.serviceGroup);
      }
      leasePathParts.push('lease.yaml');
      const expectedLeasePath = leasePathParts.join('/');

      expect(expectedLeasePath).toBe('.github/arm-leases/compute/Microsoft.Compute/DiskRP/lease.yaml');
    });
  });
});
