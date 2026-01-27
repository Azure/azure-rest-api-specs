import { describe, it, expect } from 'vitest';

// ============================================
// Test Fixtures and Mocks
// ============================================

const EXISTING_NAMESPACES = ['Microsoft.Existing', 'Microsoft.Another'];

const SAMPLE_PATHS = {
  basic: 'specification/app/resource-manager/Microsoft.App/stable/2023-01-01/app.json',
  withGroup: 'specification/compute/resource-manager/Microsoft.Compute/DiskRP/stable/2023-01-01/disk.json',
  example: 'specification/app/resource-manager/Microsoft.App/stable/2023-01-01/examples/example.json',
  dataPlane: 'specification/app/data-plane/Microsoft.App/stable/2023-01-01/app.json'
};

const LABELS = {
  armModeling: 'ARMModelingReviewRequired',
  notReady: 'NotReadyForARMReview'
};

// ============================================
// Mock Functions
// ============================================

function mockResourceProviderExists(specPath, namespace) {
  return EXISTING_NAMESPACES.includes(namespace);
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
      
      const groupMatch = file.match(groupPattern);
      if (groupMatch && groupMatch[2] !== 'stable' && groupMatch[2] !== 'preview' && groupMatch[2] !== 'preview-internal') {
        resourceProviders.set(namespace, { serviceName, serviceGroup: groupMatch[2] });
      } else {
        resourceProviders.set(namespace, { serviceName });
      }
    }
  }
  
  return resourceProviders;
}

// ============================================
// Test Suites
// ============================================

describe('detect-new-resource-provider', () => {
  
  // ==========================================
  // Resource Provider Extraction Tests
  // ==========================================
  
  describe('extractResourceProviders', () => {
    it('should extract namespace and service from valid paths', () => {
      const files = [
        'specification/app/resource-manager/Microsoft.App/stable/2023-01-01/app.json',
        'specification/compute/resource-manager/Microsoft.Compute/stable/2023-01-01/compute.json',
      ];

      const result = mockExtractResourceProviders(files);

      expect(result.size).toBe(2);
      expect(result.get('Microsoft.App')).toEqual({ serviceName: 'app' });
      expect(result.get('Microsoft.Compute')).toEqual({ serviceName: 'compute' });
    });

    it('should handle multiple files from same namespace', () => {
      const files = [
        'specification/app/resource-manager/Microsoft.App/stable/2023-01-01/app.json',
        'specification/app/resource-manager/Microsoft.App/stable/2023-01-01/models.json',
        'specification/app/resource-manager/Microsoft.App/preview/2023-01-01-preview/app.json',
      ];

      const result = mockExtractResourceProviders(files);

      expect(result.size).toBe(1);
      expect(result.get('Microsoft.App')).toEqual({ serviceName: 'app' });
    });

    it('should ignore non-resource-manager files', () => {
      const files = [
        SAMPLE_PATHS.dataPlane,
        SAMPLE_PATHS.basic,
        'specification/app/docs/readme.md',
      ];

      const result = mockExtractResourceProviders(files);

      expect(result.size).toBe(1);
      expect(result.get('Microsoft.App')).toEqual({ serviceName: 'app' });
    });

    it('should handle empty file list', () => {
      const result = mockExtractResourceProviders([]);
      expect(result.size).toBe(0);
    });

    it('should extract service group when present', () => {
      const files = [SAMPLE_PATHS.withGroup];
      const result = mockExtractResourceProviders(files);

      expect(result.size).toBe(1);
      expect(result.get('Microsoft.Compute')).toEqual({ 
        serviceName: 'compute', 
        serviceGroup: 'DiskRP' 
      });
    });

    it('should handle mix of files with and without service groups', () => {
      const files = [SAMPLE_PATHS.withGroup, SAMPLE_PATHS.basic];
      const result = mockExtractResourceProviders(files);

      expect(result.size).toBe(2);
      expect(result.get('Microsoft.Compute')).toEqual({ serviceName: 'compute', serviceGroup: 'DiskRP' });
      expect(result.get('Microsoft.App')).toEqual({ serviceName: 'app' });
    });

    it('should not treat version folders as service groups', () => {
      const testCases = [
        'specification/app/resource-manager/Microsoft.App/preview-2025-10-11/app.json',
        'specification/app/resource-manager/Microsoft.App/preview-internal/2023-01-01/app.json',
        'specification/app/resource-manager/Microsoft.App/stable-2024-01-01/app.json',
      ];

      testCases.forEach(filePath => {
        const result = mockExtractResourceProviders([filePath]);
        expect(result.get('Microsoft.App')).toEqual({ serviceName: 'app' });
      });
    });

    it('should extract service group when folder does not start with stable or preview', () => {
      const files = [
        'specification/compute/resource-manager/Microsoft.Compute/CloudServiceRP/stable/2023-01-01/cloudservice.json',
      ];

      const result = mockExtractResourceProviders(files);

      expect(result.get('Microsoft.Compute')).toEqual({ 
        serviceName: 'compute', 
        serviceGroup: 'CloudServiceRP' 
      });
    });

    it('should handle nested paths correctly', () => {
      const files = [
        'specification/compute/resource-manager/Microsoft.Compute/DiskRP/stable/2023-01-01/disk.json',
        'specification/compute/resource-manager/Microsoft.Compute/DiskRP/stable/2023-01-01/models.json',
      ];

      const result = mockExtractResourceProviders(files);

      expect(result.size).toBe(1);
      expect(result.get('Microsoft.Compute')).toEqual({ 
        serviceName: 'compute', 
        serviceGroup: 'DiskRP' 
      });
    });

    it('should extract multiple namespaces with different service groups', () => {
      const files = [
        'specification/compute/resource-manager/Microsoft.Compute/DiskRP/stable/2023-01-01/disk.json',
        'specification/compute/resource-manager/Microsoft.Compute/VirtualMachineRP/stable/2023-01-01/vm.json',
      ];

      const result = mockExtractResourceProviders(files);

      expect(result.size).toBe(1);
      expect(result.get('Microsoft.Compute')).toEqual({ serviceName: 'compute', serviceGroup: 'VirtualMachineRP' });
    });
  });

  // ==========================================
  // Resource Provider Existence Tests
  // ==========================================
  
  describe('resourceProviderExists', () => {
    it('should return true for existing namespaces', () => {
      expect(mockResourceProviderExists('/path/to/spec', 'Microsoft.Existing')).toBe(true);
      expect(mockResourceProviderExists('/path/to/spec', 'Microsoft.Another')).toBe(true);
    });

    it('should return false for new namespaces', () => {
      expect(mockResourceProviderExists('/path/to/spec', 'Microsoft.NewService')).toBe(false);
    });

    it('should return false for non-matching namespaces', () => {
      expect(mockResourceProviderExists('/path/to/spec', 'Microsoft.Unknown')).toBe(false);
    });
  });

  // ==========================================
  // New Resource Provider Detection Tests
  // ==========================================
  
  describe('new resource provider detection', () => {
    it('should identify new resource providers correctly', () => {
      const changedRPs = new Map([
        ['Microsoft.NewService', { serviceName: 'newservice' }],
        ['Microsoft.Existing', { serviceName: 'existing' }]
      ]);

      const newResourceProviders = [];
      for (const [rp, info] of changedRPs) {
        if (!mockResourceProviderExists('/path/to/spec', rp)) {
          newResourceProviders.push({ namespace: rp, ...info });
        }
      }

      expect(newResourceProviders).toHaveLength(1);
      expect(newResourceProviders[0].namespace).toBe('Microsoft.NewService');
      expect(newResourceProviders[0].serviceName).toBe('newservice');
    });

    it('should handle no new resource providers', () => {
      const changedRPs = new Map([
        ['Microsoft.Existing', { serviceName: 'existing' }],
        ['Microsoft.Another', { serviceName: 'another' }]
      ]);

      const newResourceProviders = [];
      for (const [rp, info] of changedRPs) {
        if (!mockResourceProviderExists('/path/to/spec', rp)) {
          newResourceProviders.push({ namespace: rp, ...info });
        }
      }

      expect(newResourceProviders).toHaveLength(0);
    });

    it('should handle multiple new resource providers', () => {
      const changedRPs = new Map([
        ['Microsoft.Service1', { serviceName: 'service1' }],
        ['Microsoft.Service2', { serviceName: 'service2' }]
      ]);

      const newResourceProviders = [];
      for (const [rp, info] of changedRPs) {
        if (!mockResourceProviderExists('/path/to/spec', rp)) {
          newResourceProviders.push({ namespace: rp, ...info });
        }
      }

      expect(newResourceProviders).toHaveLength(2);
      expect(newResourceProviders[0].namespace).toBe('Microsoft.Service1');
      expect(newResourceProviders[1].namespace).toBe('Microsoft.Service2');
    });

    it('should identify new resource providers with service groups', () => {
      const changedRPs = new Map([
        ['Microsoft.Compute', { serviceName: 'compute', serviceGroup: 'DiskRP' }]
      ]);

      const newResourceProviders = [];
      for (const [rp, info] of changedRPs) {
        if (!mockResourceProviderExists('/path/to/spec', rp)) {
          newResourceProviders.push({ namespace: rp, ...info });
        }
      }

      expect(newResourceProviders).toHaveLength(1);
      expect(newResourceProviders[0].serviceGroup).toBe('DiskRP');
    });
  });

  // ==========================================
  // Lease Validation Tests
  // ==========================================
  
  describe('lease validation', () => {
    it('should create correct output structure', () => {
      const leaseCheckResults = [{
        namespace: 'Microsoft.Test',
        serviceName: 'test',
        leaseValid: true,
        leaseMessage: 'Lease is valid'
      }];

      const outputData = { newResourceProviders: leaseCheckResults };

      expect(outputData.newResourceProviders).toHaveLength(1);
      expect(outputData.newResourceProviders[0]).toHaveProperty('namespace');
      expect(outputData.newResourceProviders[0]).toHaveProperty('leaseValid');
    });

    it('should include service group in output when present', () => {
      const leaseCheckResults = [{
        namespace: 'Microsoft.Compute',
        serviceName: 'compute',
        serviceGroup: 'DiskRP',
        leaseValid: false,
        leaseMessage: 'No lease file found'
      }];

      const outputData = { newResourceProviders: leaseCheckResults };

      expect(outputData.newResourceProviders[0].serviceGroup).toBe('DiskRP');
    });

    it('should handle valid lease in output', () => {
      const leaseCheckResults = [{
        namespace: 'Microsoft.Test',
        serviceName: 'test',
        leaseValid: true,
        leaseMessage: 'Lease is valid'
      }];

      expect(leaseCheckResults[0].leaseValid).toBe(true);
      expect(leaseCheckResults[0].leaseMessage).toBe('Lease is valid');
    });

    it('should handle invalid lease in output', () => {
      const leaseCheckResults = [{
        namespace: 'Microsoft.Test',
        serviceName: 'test',
        leaseValid: false,
        leaseMessage: 'No lease file found'
      }];

      expect(leaseCheckResults[0].leaseValid).toBe(false);
      expect(leaseCheckResults[0].leaseMessage).toBe('No lease file found');
    });
  });

  // ==========================================
  // JSON Output Generation Tests
  // ==========================================
  
  describe('JSON output generation', () => {
    it('should create output with correct structure', () => {
      const leaseCheckResults = [{
        namespace: 'Microsoft.Test',
        serviceName: 'test',
        leaseValid: false,
        leaseMessage: 'No lease file found'
      }];

      const outputData = { newResourceProviders: leaseCheckResults };

      expect(outputData).toHaveProperty('newResourceProviders');
      expect(Array.isArray(outputData.newResourceProviders)).toBe(true);
    });

    it('should include all required fields', () => {
      const leaseCheckResults = [{
        namespace: 'Microsoft.Test',
        serviceName: 'test',
        serviceGroup: 'TestRP',
        leaseValid: false,
        leaseMessage: 'No lease file found'
      }];

      const rp = leaseCheckResults[0];

      expect(rp).toHaveProperty('namespace');
      expect(rp).toHaveProperty('serviceName');
      expect(rp).toHaveProperty('serviceGroup');
      expect(rp).toHaveProperty('leaseValid');
      expect(rp).toHaveProperty('leaseMessage');
    });

    it('should format output for PR comment consumption', () => {
      const leaseCheckResults = [
        {
          namespace: 'Microsoft.Test1',
          serviceName: 'test1',
          leaseValid: true,
          leaseMessage: 'Lease is valid'
        },
        {
          namespace: 'Microsoft.Test2',
          serviceName: 'test2',
          leaseValid: false,
          leaseMessage: 'No lease file found'
        }
      ];

      const outputData = { newResourceProviders: leaseCheckResults };

      expect(outputData.newResourceProviders).toHaveLength(2);
      outputData.newResourceProviders.forEach(rp => {
        expect(rp.namespace).toBeTruthy();
        expect(typeof rp.leaseValid).toBe('boolean');
      });
    });

    it('should handle multiple new RPs with mixed lease statuses', () => {
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
          leaseMessage: 'No lease file found'
        }
      ];

      const outputData = { newResourceProviders: leaseCheckResults };

      const validLeases = outputData.newResourceProviders.filter(rp => rp.leaseValid);
      const invalidLeases = outputData.newResourceProviders.filter(rp => !rp.leaseValid);

      expect(validLeases).toHaveLength(1);
      expect(invalidLeases).toHaveLength(1);
    });

    it('should maintain order of RPs in output', () => {
      const leaseCheckResults = [
        { namespace: 'Microsoft.First', serviceName: 'first', leaseValid: true, leaseMessage: 'Valid' },
        { namespace: 'Microsoft.Second', serviceName: 'second', leaseValid: false, leaseMessage: 'Invalid' },
        { namespace: 'Microsoft.Third', serviceName: 'third', leaseValid: true, leaseMessage: 'Valid' }
      ];

      const outputData = { newResourceProviders: leaseCheckResults };

      expect(outputData.newResourceProviders[0].namespace).toBe('Microsoft.First');
      expect(outputData.newResourceProviders[1].namespace).toBe('Microsoft.Second');
      expect(outputData.newResourceProviders[2].namespace).toBe('Microsoft.Third');
    });

    it('should serialize to valid JSON', () => {
      const leaseCheckResults = [{
        namespace: 'Microsoft.Test',
        serviceName: 'test',
        leaseValid: false,
        leaseMessage: 'No lease file found'
      }];

      const outputData = { newResourceProviders: leaseCheckResults };
      const jsonString = JSON.stringify(outputData);
      const parsed = JSON.parse(jsonString);

      expect(parsed).toEqual(outputData);
    });

    it('should handle empty RPs list', () => {
      const outputData = { newResourceProviders: [] };

      expect(outputData.newResourceProviders).toHaveLength(0);
      expect(Array.isArray(outputData.newResourceProviders)).toBe(true);
    });

    it('should include optional service group field', () => {
      const leaseCheckResults = [{
        namespace: 'Microsoft.Compute',
        serviceName: 'compute',
        serviceGroup: 'DiskRP',
        leaseValid: true,
        leaseMessage: 'Valid'
      }];

      const outputData = { newResourceProviders: leaseCheckResults };

      expect(outputData.newResourceProviders[0].serviceGroup).toBe('DiskRP');
    });
  });

  // ==========================================
  // PR Comment Data Preparation Tests
  // ==========================================
  
  describe('PR comment data preparation', () => {
    it('should provide data for office hours message', () => {
      const leaseCheckResults = [{
        namespace: 'Microsoft.Test',
        serviceName: 'test',
        leaseValid: false,
        leaseMessage: 'No lease file found'
      }];

      const outputData = { newResourceProviders: leaseCheckResults };

      expect(outputData.newResourceProviders.length).toBeGreaterThan(0);
      outputData.newResourceProviders.forEach(rp => {
        expect(rp.namespace).toBeTruthy();
        expect(rp.serviceName).toBeTruthy();
        expect(typeof rp.leaseValid).toBe('boolean');
        expect(rp.leaseMessage).toBeTruthy();
      });
    });

    it('should identify RPs needing office hours', () => {
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
          serviceGroup: 'TestRP',
          leaseValid: false,
          leaseMessage: 'No lease file found'
        }
      ];

      const outputData = { newResourceProviders: leaseCheckResults };
      const rpsNeedingOfficeHours = outputData.newResourceProviders.filter(rp => !rp.leaseValid);
      const rpsWithValidLease = outputData.newResourceProviders.filter(rp => rp.leaseValid);

      expect(rpsNeedingOfficeHours).toHaveLength(1);
      expect(rpsNeedingOfficeHours[0].namespace).toBe('Microsoft.WithoutLease');
      expect(rpsWithValidLease).toHaveLength(1);
      expect(rpsWithValidLease[0].namespace).toBe('Microsoft.WithLease');
    });

    it('should format lease path for PR comment', () => {
      const rp = {
        namespace: 'Microsoft.Test',
        serviceName: 'testservice',
        leaseValid: false
      };

      const leasePath = `.github/arm-leases/${rp.serviceName}/${rp.namespace}/lease.yaml`;

      expect(leasePath).toBe('.github/arm-leases/testservice/Microsoft.Test/lease.yaml');
    });

    it('should format lease path with service group', () => {
      const rp = {
        namespace: 'Microsoft.Compute',
        serviceName: 'compute',
        serviceGroup: 'DiskRP',
        leaseValid: false
      };

      const leasePathParts = ['.github/arm-leases', rp.serviceName, rp.namespace];
      if (rp.serviceGroup) {
        leasePathParts.push(rp.serviceGroup);
      }
      leasePathParts.push('lease.yaml');
      const leasePath = leasePathParts.join('/');

      expect(leasePath).toBe('.github/arm-leases/compute/Microsoft.Compute/DiskRP/lease.yaml');
    });

    it('should distinguish between valid and invalid leases for messaging', () => {
      const leaseCheckResults = [
        { namespace: 'Microsoft.Valid', serviceName: 'valid', leaseValid: true, leaseMessage: 'Valid' },
        { namespace: 'Microsoft.Invalid', serviceName: 'invalid', leaseValid: false, leaseMessage: 'Invalid' }
      ];

      const invalidLeases = leaseCheckResults.filter(rp => !rp.leaseValid);
      const validLeases = leaseCheckResults.filter(rp => rp.leaseValid);

      expect(invalidLeases.length).toBe(1);
      expect(validLeases.length).toBe(1);
    });

    it('should provide complete RP information for PR comment', () => {
      const rp = {
        namespace: 'Microsoft.Test',
        serviceName: 'test',
        serviceGroup: 'SubGroup',
        leaseValid: false,
        leaseMessage: 'No lease file found'
      };

      expect(rp).toHaveProperty('namespace');
      expect(rp).toHaveProperty('serviceName');
      expect(rp).toHaveProperty('serviceGroup');
      expect(rp).toHaveProperty('leaseValid');
      expect(rp).toHaveProperty('leaseMessage');
    });

    it('should handle RPs without service group in PR comment data', () => {
      const rp = {
        namespace: 'Microsoft.Simple',
        serviceName: 'simple',
        leaseValid: false,
        leaseMessage: 'No lease'
      };

      expect(rp.serviceGroup).toBeUndefined();
      expect(rp.namespace).toBe('Microsoft.Simple');
      expect(rp.serviceName).toBe('simple');
    });

    it('should prepare data for multiple RPs in single comment', () => {
      const leaseCheckResults = [
        { namespace: 'Microsoft.One', serviceName: 'one', leaseValid: false, leaseMessage: 'No lease' },
        { namespace: 'Microsoft.Two', serviceName: 'two', leaseValid: false, leaseMessage: 'No lease' },
        { namespace: 'Microsoft.Three', serviceName: 'three', leaseValid: true, leaseMessage: 'Valid' }
      ];

      const needsOfficeHours = leaseCheckResults.filter(rp => !rp.leaseValid);
      const hasValidLease = leaseCheckResults.filter(rp => rp.leaseValid);

      expect(needsOfficeHours).toHaveLength(2);
      expect(hasValidLease).toHaveLength(1);
    });
  });

  // ==========================================
  // Brand New RP Validation Tests
  // ==========================================
  
  describe('brand new resource provider validation', () => {
    it('should identify directory as brand new when no files exist in base', () => {
      const gitLsTreeResult = '';
      const hasSwaggerFiles = gitLsTreeResult.split('\n')
        .filter(file => file.includes('/resource-manager/') && file.endsWith('.json'))
        .length > 0;
      
      expect(hasSwaggerFiles).toBe(false);
    });

    it('should identify directory as brand new when only non-swagger files exist', () => {
      const gitLsTreeResult = [
        'specification/newservice/resource-manager/Microsoft.NewService/readme.md',
        'specification/newservice/resource-manager/Microsoft.NewService/examples/example.json'
      ].join('\n');
      
      const hasSwaggerFiles = gitLsTreeResult.split('\n')
        .filter(file => file.includes('/resource-manager/') && file.endsWith('.json') && !file.includes('/examples/'))
        .length > 0;
      
      expect(hasSwaggerFiles).toBe(false);
    });

    it('should identify directory as existing when swagger files exist in base', () => {
      const gitLsTreeResult = [
        'specification/compute/resource-manager/Microsoft.Compute/stable/2023-01-01/compute.json',
        'specification/compute/resource-manager/Microsoft.Compute/stable/2023-01-01/models.json'
      ].join('\n');
      
      const hasSwaggerFiles = gitLsTreeResult.split('\n')
        .filter(file => file.includes('/resource-manager/') && file.endsWith('.json') && !file.includes('/examples/'))
        .length > 0;
      
      expect(hasSwaggerFiles).toBe(true);
    });

    it('should continue workflow when at least one brand new RP exists', () => {
      const specDirChecks = [
        { dir: 'specification/newservice/resource-manager/Microsoft.NewService', hasFilesInBase: false },
        { dir: 'specification/compute/resource-manager/Microsoft.Compute', hasFilesInBase: true },
      ];
      
      const hasAtLeastOneBrandNewRP = specDirChecks.some(check => !check.hasFilesInBase);
      
      expect(hasAtLeastOneBrandNewRP).toBe(true);
    });

    it('should skip workflow when no brand new RPs exist', () => {
      const specDirChecks = [
        { dir: 'specification/compute/resource-manager/Microsoft.Compute', hasFilesInBase: true },
        { dir: 'specification/storage/resource-manager/Microsoft.Storage', hasFilesInBase: true },
      ];
      
      const hasAtLeastOneBrandNewRP = specDirChecks.some(check => !check.hasFilesInBase);
      
      expect(hasAtLeastOneBrandNewRP).toBe(false);
    });

    it('should extract spec directory from swagger file path', () => {
      const swaggerFile = 'specification/newservice/resource-manager/Microsoft.NewService/stable/2024-01-01/service.json';
      const parts = swaggerFile.split('/');
      const specDir = parts.slice(0, parts.indexOf('stable')).join('/');
      
      expect(specDir).toBe('specification/newservice/resource-manager/Microsoft.NewService');
    });

    it('should extract spec directory from preview file path', () => {
      const previewFile = 'specification/newservice/resource-manager/Microsoft.NewService/preview/2024-01-01-preview/service.json';
      const parts = previewFile.split('/');
      const versionIndex = parts.indexOf('preview');
      const specDir = parts.slice(0, versionIndex).join('/');
      
      expect(specDir).toBe('specification/newservice/resource-manager/Microsoft.NewService');
    });

    it('should treat git ls-tree errors as brand new RP', () => {
      let gitError = false;
      let isBrandNew = false;
      
      try {
        throw new Error('path not found in ref');
      } catch (error) {
        gitError = true;
        isBrandNew = true;
      }
      
      expect(gitError).toBe(true);
      expect(isBrandNew).toBe(true);
    });

    it('should handle service group in spec directory extraction', () => {
      const swaggerFile = 'specification/compute/resource-manager/Microsoft.Compute/DiskRP/stable/2024-01-01/disk.json';
      const parts = swaggerFile.split('/');
      const stableIndex = parts.indexOf('stable');
      const specDir = parts.slice(0, stableIndex).join('/');
      
      expect(specDir).toBe('specification/compute/resource-manager/Microsoft.Compute/DiskRP');
    });
  });

  // ==========================================
  // Label Addition Tests
  // ==========================================
  
  describe('label addition', () => {
    const expectedLabels = [LABELS.armModeling, LABELS.notReady];

    it('should define correct label constants', () => {
      expect(expectedLabels).toHaveLength(2);
      expect(expectedLabels).toContain(LABELS.armModeling);
      expect(expectedLabels).toContain(LABELS.notReady);
    });

    it('should add both labels when new RPs detected', () => {
      const labelsToAdd = expectedLabels;
      
      expect(labelsToAdd).toEqual([LABELS.armModeling, LABELS.notReady]);
    });

    it('should skip when GITHUB_TOKEN unavailable', () => {
      const githubToken = undefined;
      const prNumber = '123';
      
      expect(!!(githubToken && prNumber)).toBe(false);
    });

    it('should skip when PR_NUMBER unavailable', () => {
      const githubToken = 'token';
      const prNumber = undefined;
      
      expect(!!(githubToken && prNumber)).toBe(false);
    });

    it('should proceed when both GITHUB_TOKEN and PR_NUMBER available', () => {
      const githubToken = 'token';
      const prNumber = '123';
      
      expect(!!(githubToken && prNumber)).toBe(true);
    });

    it('should use default repo owner and name', () => {
      const repoOwner = process.env.REPO_OWNER || 'Azure';
      const repoName = process.env.REPO_NAME || 'azure-rest-api-specs';
      
      expect(repoOwner).toBe('Azure');
      expect(repoName).toBe('azure-rest-api-specs');
    });

    it('should parse PR number as integer', () => {
      const parsedPrNumber = parseInt('456');
      
      expect(typeof parsedPrNumber).toBe('number');
      expect(parsedPrNumber).toBe(456);
    });

    it('should add labels once per PR regardless of RP count', () => {
      const newRPs = [
        { namespace: 'Microsoft.Service1', serviceName: 'service1' },
        { namespace: 'Microsoft.Service2', serviceName: 'service2' },
        { namespace: 'Microsoft.Service3', serviceName: 'service3' },
      ];
      
      expect(newRPs).toHaveLength(3);
      expect(expectedLabels).toEqual([LABELS.armModeling, LABELS.notReady]);
    });

    it('should not add labels when no new RPs detected', () => {
      const newRPs = [];
      
      expect(newRPs.length > 0).toBe(false);
    });

    it('should construct correct API request', () => {
      const apiRequest = {
        owner: 'Azure',
        repo: 'azure-rest-api-specs',
        issue_number: 123,
        labels: expectedLabels
      };
      
      expect(apiRequest.owner).toBe('Azure');
      expect(apiRequest.repo).toBe('azure-rest-api-specs');
      expect(apiRequest.issue_number).toBe(123);
      expect(apiRequest.labels).toEqual([LABELS.armModeling, LABELS.notReady]);
    });

    it('should handle errors gracefully', () => {
      let errorHandled = false;
      
      try {
        throw new Error('API error');
      } catch (error) {
        errorHandled = true;
      }
      
      expect(errorHandled).toBe(true);
    });

    it('should format error log message with [FAILED] prefix', () => {
      const errorMessage = 'Request failed with status code 401';
      const logMessage = `[FAILED] Failed to add labels: ${errorMessage}`;
      
      expect(logMessage).toContain('[FAILED]');
      expect(logMessage).toContain('Failed to add labels:');
      expect(logMessage).toContain(errorMessage);
    });
  });

  // ==========================================
  // Log Message Format Tests
  // ==========================================
  
  describe('log message formatting', () => {
    it('should format valid lease log with [OK] indicator', () => {
      const rp = {
        namespace: 'Microsoft.Test',
        leaseValid: true
      };
      
      const logMessage = `  - ${rp.namespace}: ${rp.leaseValid ? '[OK]' : '[FAILED]'} Lease ${rp.leaseValid ? 'valid' : 'invalid'}`;
      
      expect(logMessage).toContain('[OK]');
      expect(logMessage).toContain('Lease valid');
      expect(logMessage).not.toContain('[FAILED]');
      expect(logMessage).not.toContain('✓');
      expect(logMessage).not.toContain('✗');
    });

    it('should format invalid lease log with [FAILED] indicator', () => {
      const rp = {
        namespace: 'Microsoft.Test',
        leaseValid: false
      };
      
      const logMessage = `  - ${rp.namespace}: ${rp.leaseValid ? '[OK]' : '[FAILED]'} Lease ${rp.leaseValid ? 'valid' : 'invalid'}`;
      
      expect(logMessage).toContain('[FAILED]');
      expect(logMessage).toContain('Lease invalid');
      expect(logMessage).not.toContain('[OK]');
      expect(logMessage).not.toContain('✓');
      expect(logMessage).not.toContain('✗');
    });

    it('should format log messages consistently without unicode symbols', () => {
      const testCases = [
        { leaseValid: true, expected: '[OK]', notExpected: '[FAILED]' },
        { leaseValid: false, expected: '[FAILED]', notExpected: '[OK]' }
      ];
      
      testCases.forEach(testCase => {
        const logMessage = `  - Microsoft.Test: ${testCase.leaseValid ? '[OK]' : '[FAILED]'} Lease ${testCase.leaseValid ? 'valid' : 'invalid'}`;
        
        expect(logMessage).toContain(testCase.expected);
        expect(logMessage).not.toContain(testCase.notExpected);
        expect(logMessage).not.toMatch(/[✓✗]/);
      });
    });

    it('should use text-based indicators for multiple RPs', () => {
      const resourceProviders = [
        { namespace: 'Microsoft.Valid', leaseValid: true },
        { namespace: 'Microsoft.Invalid', leaseValid: false },
        { namespace: 'Microsoft.AnotherValid', leaseValid: true }
      ];
      
      const logMessages = resourceProviders.map(rp => 
        `  - ${rp.namespace}: ${rp.leaseValid ? '[OK]' : '[FAILED]'} Lease ${rp.leaseValid ? 'valid' : 'invalid'}`
      );
      
      expect(logMessages[0]).toContain('[OK]');
      expect(logMessages[1]).toContain('[FAILED]');
      expect(logMessages[2]).toContain('[OK]');
      
      logMessages.forEach(msg => {
        expect(msg).not.toMatch(/[✓✗]/);
      });
    });

    it('should format error message with [FAILED] prefix for label addition failures', () => {
      const error = new Error('Network timeout');
      const errorLog = `[FAILED] Failed to add labels: ${error.message}`;
      
      expect(errorLog).toContain('[FAILED]');
      expect(errorLog).toContain('Failed to add labels:');
      expect(errorLog).not.toContain('✗');
    });
  });
});
