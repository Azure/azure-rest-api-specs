import { describe, it, expect, vi, beforeEach } from 'vitest';

// ============================================
// Mock all external dependencies
// ============================================

// simple-git: mock git.raw() for merge-base and ls-tree calls
const mockGitRaw = vi.fn();
vi.mock('simple-git', () => ({
  simpleGit: () => ({ raw: mockGitRaw })
}));

// fs: mock writeFileSync to avoid writing to disk
vi.mock('fs', () => ({
  writeFileSync: vi.fn()
}));

// shared/simple-git: mock getRootFolder so it doesn't depend on cwd
vi.mock('../../shared/src/simple-git.js', () => ({
  getRootFolder: vi.fn().mockResolvedValue('/fake/repo')
}));

// shared/changed-files: mock getChangedFiles, keep resourceManager and swagger real
const mockGetChangedFiles = vi.fn();
vi.mock('../../shared/src/changed-files.js', async (importOriginal) => {
  const actual = await importOriginal();
  return {
    ...actual,
    getChangedFiles: (...args) => mockGetChangedFiles(...args)
  };
});

// detect-arm-leases: mock checkLease
const mockCheckLease = vi.fn();
vi.mock('../src/detect-arm-leases.js', () => ({
  checkLease: (...args) => mockCheckLease(...args)
}));

import detectNewResourceProvider from '../src/detect-new-resource-provider.js';

// ============================================
// Helpers
// ============================================

function makeMockCore() {
  return {
    info: vi.fn(),
    error: vi.fn(),
    setFailed: vi.fn()
  };
}

function makeMockContext(baseBranch = 'main') {
  return {
    repo: { owner: 'Azure', repo: 'azure-rest-api-specs' },
    issue: { number: 42 },
    payload: {
      pull_request: {
        base: { ref: baseBranch },
        head: { sha: 'abc123' }
      }
    }
  };
}

/**
 * Configure mockGitRaw to handle merge-base and ls-tree calls.
 * @param {Object} opts
 * @param {string} opts.mergeBase - SHA returned by merge-base
 * @param {string[]} [opts.lsTreeDirOutput] - output for ls-tree -d (namespace existence check)
 * @param {string[]} [opts.lsTreeFileOutput] - output for ls-tree -r (brand-new RP pre-check)
 */
function setupGitMock({ mergeBase = 'base123', lsTreeDirOutput = [], lsTreeFileOutput = [] } = {}) {
  mockGitRaw.mockImplementation(async (args) => {
    if (args[0] === 'merge-base') {
      return `${mergeBase}\n`;
    }
    if (args[0] === 'ls-tree') {
      // ls-tree -d (directory listing for resourceProviderExistsInCommit)
      if (args.includes('-d')) {
        return lsTreeDirOutput.join('\n');
      }
      // ls-tree -r (file listing for brand-new RP pre-check)
      if (args.includes('-r')) {
        return lsTreeFileOutput.join('\n');
      }
    }
    return '';
  });
}

// ============================================
// Tests
// ============================================

describe('detect-new-resource-provider', () => {
  let mockCore;
  let mockContext;

  beforeEach(() => {
    vi.clearAllMocks();
    mockCore = makeMockCore();
    mockContext = makeMockContext();
  });

  describe('no resource-manager changes', () => {
    it('should return no-changes when no resource-manager files are modified', async () => {
      mockGetChangedFiles.mockResolvedValue([
        'specification/compute/data-plane/foo.json'
      ]);
      setupGitMock();

      const result = await detectNewResourceProvider({ context: mockContext, core: mockCore });

      expect(result.status).toBe('no-changes');
      expect(result.labelActions.ARMModelingReviewRequired).toBe('none');
      expect(mockCore.setFailed).not.toHaveBeenCalled();
    });

    it('should return no-changes when changed files list is empty', async () => {
      mockGetChangedFiles.mockResolvedValue([]);
      setupGitMock();

      const result = await detectNewResourceProvider({ context: mockContext, core: mockCore });

      expect(result.status).toBe('no-changes');
    });
  });

  describe('existing resource provider (not new)', () => {
    it('should return no-new-rp when all RP namespaces exist in base branch', async () => {
      const rmFile = 'specification/compute/resource-manager/Microsoft.Compute/stable/2024-01-01/compute.json';
      mockGetChangedFiles.mockResolvedValue([rmFile]);
      setupGitMock({
        // Pre-check: file exists in base → not brand new
        lsTreeFileOutput: [rmFile],
      });

      const result = await detectNewResourceProvider({ context: mockContext, core: mockCore });

      expect(result.status).toBe('no-new-rp');
      expect(result.labelActions.ARMModelingReviewRequired).toBe('remove');
      expect(mockCore.setFailed).not.toHaveBeenCalled();
    });
  });

  describe('new resource provider with valid lease', () => {
    it('should return new-rp-all-leases-valid and not fail', async () => {
      const rmFile = 'specification/newservice/resource-manager/Microsoft.NewService/stable/2025-01-01/api.json';
      mockGetChangedFiles.mockResolvedValue([rmFile]);
      setupGitMock({
        // Pre-check: no files in base for this namespace → brand new
        lsTreeFileOutput: [],
        // Namespace doesn't exist in base commit directories
        lsTreeDirOutput: [],
      });
      mockCheckLease.mockResolvedValue(true);

      const result = await detectNewResourceProvider({ context: mockContext, core: mockCore });

      expect(result.status).toBe('new-rp-all-leases-valid');
      expect(result.labelActions.ARMModelingReviewRequired).toBe('remove');
      expect(mockCore.setFailed).not.toHaveBeenCalled();
      expect(mockCore.info).toHaveBeenCalledWith(
        expect.stringContaining('valid ARM lease')
      );
      expect(mockCheckLease).toHaveBeenCalledWith('newservice', 'Microsoft.NewService', '');
    });
  });

  describe('new resource provider with invalid lease', () => {
    it('should return new-rp-invalid-lease and call setFailed', async () => {
      const rmFile = 'specification/badservice/resource-manager/Microsoft.BadService/preview/2025-01-01/api.json';
      mockGetChangedFiles.mockResolvedValue([rmFile]);
      setupGitMock({
        lsTreeFileOutput: [],
        lsTreeDirOutput: [],
      });
      mockCheckLease.mockResolvedValue(false);

      const result = await detectNewResourceProvider({ context: mockContext, core: mockCore });

      expect(result.status).toBe('new-rp-invalid-lease');
      expect(result.labelActions.ARMModelingReviewRequired).toBe('add');
      expect(mockCore.setFailed).toHaveBeenCalledTimes(1);
      expect(mockCore.setFailed).toHaveBeenCalledWith(
        expect.stringContaining('ARM API Modeling Office Hours')
      );
      expect(mockCore.error).toHaveBeenCalledWith(
        expect.stringContaining('Microsoft.BadService')
      );
    });
  });

  describe('multiple new resource providers with mixed leases', () => {
    it('should fail when at least one lease is invalid', async () => {
      mockGetChangedFiles.mockResolvedValue([
        'specification/svcA/resource-manager/Microsoft.SvcA/stable/2025-01-01/a.json',
        'specification/svcB/resource-manager/Microsoft.SvcB/stable/2025-01-01/b.json',
      ]);
      setupGitMock({
        lsTreeFileOutput: [],
        lsTreeDirOutput: [],
      });
      // SvcA valid, SvcB invalid
      mockCheckLease.mockImplementation(async (svc) =>
        svc === 'svcA'
      );

      const result = await detectNewResourceProvider({ context: mockContext, core: mockCore });

      expect(result.status).toBe('new-rp-invalid-lease');
      expect(result.labelActions.ARMModelingReviewRequired).toBe('add');
      expect(mockCore.setFailed).toHaveBeenCalledTimes(1);
      expect(mockCore.setFailed).toHaveBeenCalledWith(
        expect.stringContaining('without a valid ARM lease')
      );
    });

    it('should pass when all leases are valid', async () => {
      mockGetChangedFiles.mockResolvedValue([
        'specification/svcA/resource-manager/Microsoft.SvcA/stable/2025-01-01/a.json',
        'specification/svcB/resource-manager/Microsoft.SvcB/stable/2025-01-01/b.json',
      ]);
      setupGitMock({
        lsTreeFileOutput: [],
        lsTreeDirOutput: [],
      });
      mockCheckLease.mockResolvedValue(true);

      const result = await detectNewResourceProvider({ context: mockContext, core: mockCore });

      expect(result.status).toBe('new-rp-all-leases-valid');
      expect(result.labelActions.ARMModelingReviewRequired).toBe('remove');
      expect(mockCore.setFailed).not.toHaveBeenCalled();
    });
  });

  describe('service group extraction', () => {
    it('should pass serviceGroup to checkLease when present', async () => {
      const rmFile = 'specification/svc/resource-manager/Microsoft.Svc/ComputeRP/stable/2025-01-01/api.json';
      mockGetChangedFiles.mockResolvedValue([rmFile]);
      setupGitMock({
        lsTreeFileOutput: [],
        lsTreeDirOutput: [],
      });
      mockCheckLease.mockResolvedValue(true);

      await detectNewResourceProvider({ context: mockContext, core: mockCore });

      expect(mockCheckLease).toHaveBeenCalledWith('svc', 'Microsoft.Svc', 'ComputeRP');
    });
  });

  describe('merge-base fallback', () => {
    it('should fall back to HEAD^ when merge-base fails', async () => {
      mockGetChangedFiles.mockResolvedValue([
        'specification/svc/resource-manager/Microsoft.Svc/stable/2025-01-01/api.json',
      ]);
      let callCount = 0;
      mockGitRaw.mockImplementation(async (args) => {
        if (args[0] === 'merge-base') {
          throw new Error('Not a valid object name');
        }
        if (args[0] === 'ls-tree') {
          callCount++;
          // For the pre-check ls-tree -r call, verify it uses HEAD^ as commitish
          if (args.includes('-r') && callCount === 1) {
            expect(args).toContain('HEAD^');
          }
          return '';
        }
        return '';
      });
      mockCheckLease.mockResolvedValue(true);

      const result = await detectNewResourceProvider({ context: mockContext, core: mockCore });

      // Should still succeed despite merge-base failure
      expect(['new-rp-all-leases-valid', 'new-rp-invalid-lease', 'no-new-rp']).toContain(result.status);
    });
  });

  describe('context validation', () => {
    it('should throw when pull_request context is missing', async () => {
      const badContext = {
        repo: { owner: 'Azure', repo: 'azure-rest-api-specs' },
        issue: { number: 1 },
        payload: {}
      };

      await expect(
        detectNewResourceProvider({ context: badContext, core: mockCore })
      ).rejects.toThrow('Could not determine base branch');
    });

    it('should use baseBranch from context payload', async () => {
      const rpsaasContext = makeMockContext('RPSaaSMaster');
      mockGetChangedFiles.mockResolvedValue([]);
      setupGitMock();

      await detectNewResourceProvider({ context: rpsaasContext, core: mockCore });

      // merge-base should have been called with origin/RPSaaSMaster
      expect(mockGitRaw).toHaveBeenCalledWith(
        expect.arrayContaining(['merge-base', 'origin/RPSaaSMaster', 'HEAD'])
      );
    });
  });

  describe('label actions', () => {
    it('should return Remove for ARMModelingReviewRequired when no new RPs', async () => {
      const rmFile = 'specification/compute/resource-manager/Microsoft.Compute/stable/2024-01-01/compute.json';
      mockGetChangedFiles.mockResolvedValue([rmFile]);
      setupGitMock({ lsTreeFileOutput: [rmFile] });

      const result = await detectNewResourceProvider({ context: mockContext, core: mockCore });

      expect(result.labelActions.ARMModelingReviewRequired).toBe('remove');
    });

    it('should return Add for ARMModelingReviewRequired when new RP has invalid lease', async () => {
      mockGetChangedFiles.mockResolvedValue([
        'specification/svc/resource-manager/Microsoft.Svc/stable/2025-01-01/api.json',
      ]);
      setupGitMock({ lsTreeFileOutput: [], lsTreeDirOutput: [] });
      mockCheckLease.mockResolvedValue(false);

      const result = await detectNewResourceProvider({ context: mockContext, core: mockCore });

      expect(result.labelActions.ARMModelingReviewRequired).toBe('add');
    });

    it('should return Remove for ARMModelingReviewRequired when new RP has valid lease', async () => {
      mockGetChangedFiles.mockResolvedValue([
        'specification/svc/resource-manager/Microsoft.Svc/stable/2025-01-01/api.json',
      ]);
      setupGitMock({ lsTreeFileOutput: [], lsTreeDirOutput: [] });
      mockCheckLease.mockResolvedValue(true);

      const result = await detectNewResourceProvider({ context: mockContext, core: mockCore });

      expect(result.labelActions.ARMModelingReviewRequired).toBe('remove');
    });

    it('should return none for no-changes status', async () => {
      mockGetChangedFiles.mockResolvedValue([]);
      setupGitMock();

      const result = await detectNewResourceProvider({ context: mockContext, core: mockCore });

      expect(result.labelActions.ARMModelingReviewRequired).toBe('none');
    });
  });
});
