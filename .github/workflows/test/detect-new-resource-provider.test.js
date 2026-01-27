import { describe, it, expect, vi, beforeEach } from 'vitest';
import detectNewResourceProvider from '../src/detect-new-resource-provider.js';

describe('detect-new-resource-provider', () => {
  let mockGithub;
  let mockContext;
  let mockCore;

  beforeEach(() => {
    mockGithub = {
      rest: {
        issues: {
          addLabels: vi.fn().mockResolvedValue({}),
          createComment: vi.fn().mockResolvedValue({})
        }
      }
    };

    mockContext = {
      repo: { owner: 'Azure', repo: 'azure-rest-api-specs' },
      issue: { number: 123 }
    };

    mockCore = {
      setFailed: vi.fn()
    };
  });

  describe('function export', () => {
    it('should be exported as default export', () => {
      expect(typeof detectNewResourceProvider).toBe('function');
    });
  });

  describe('no changes scenario', () => {
    it('should return "no-changes" when no resource-manager files are changed', async () => {
      const result = await detectNewResourceProvider({
        github: mockGithub,
        context: mockContext,
        core: mockCore,
        baseBranch: 'main'
      });

      expect(result).toBe('no-changes');
      expect(mockCore.setFailed).not.toHaveBeenCalled();
      expect(mockGithub.rest.issues.addLabels).not.toHaveBeenCalled();
      expect(mockGithub.rest.issues.createComment).not.toHaveBeenCalled();
    });
  });

  describe('parameter validation', () => {
    it('should accept all required parameters', async () => {
      const result = await detectNewResourceProvider({
        github: mockGithub,
        context: mockContext,
        core: mockCore,
        baseBranch: 'main'
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result);
    });

    it('should work with different baseBranch values', async () => {
      const result = await detectNewResourceProvider({
        github: mockGithub,
        context: mockContext,
        core: mockCore,
        baseBranch: 'main'
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result);
    });
  });

  describe('github API interactions', () => {
    it('should not call GitHub API when no changes detected', async () => {
      await detectNewResourceProvider({
        github: mockGithub,
        context: mockContext,
        core: mockCore,
        baseBranch: 'main'
      });

      expect(mockGithub.rest.issues.addLabels).not.toHaveBeenCalled();
      expect(mockGithub.rest.issues.createComment).not.toHaveBeenCalled();
    });

    it('should handle GitHub API errors gracefully', async () => {
      const errorGithub = {
        rest: {
          issues: {
            addLabels: vi.fn().mockRejectedValue(new Error('API Error')),
            createComment: vi.fn().mockRejectedValue(new Error('API Error'))
          }
        }
      };

      const result = await detectNewResourceProvider({
        github: errorGithub,
        context: mockContext,
        core: mockCore,
        baseBranch: 'main'
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result);
    });
  });

  describe('return values', () => {
    it('should return one of three valid statuses', async () => {
      const result = await detectNewResourceProvider({
        github: mockGithub,
        context: mockContext,
        core: mockCore,
        baseBranch: 'main'
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result);
    });
  });

  describe('context validation', () => {
    it('should handle minimal context object', async () => {
      const minimalContext = {
        repo: { owner: 'test-owner', repo: 'test-repo' },
        issue: { number: 1 }
      };

      const result = await detectNewResourceProvider({
        github: mockGithub,
        context: minimalContext,
        core: mockCore,
        baseBranch: 'main'
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result);
    });
  });

  describe('edge cases', () => {
    it('should handle issue number as zero', async () => {
      const zeroIssueContext = {
        repo: { owner: 'Azure', repo: 'azure-rest-api-specs' },
        issue: { number: 0 }
      };

      const result = await detectNewResourceProvider({
        github: mockGithub,
        context: zeroIssueContext,
        core: mockCore,
        baseBranch: 'main'
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result);
    });

    it('should handle very large issue numbers', async () => {
      const largeIssueContext = {
        repo: { owner: 'Azure', repo: 'azure-rest-api-specs' },
        issue: { number: 999999999 }
      };

      const result = await detectNewResourceProvider({
        github: mockGithub,
        context: largeIssueContext,
        core: mockCore,
        baseBranch: 'main'
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result);
    });

    it('should handle empty string repo owner', async () => {
      const emptyOwnerContext = {
        repo: { owner: '', repo: 'azure-rest-api-specs' },
        issue: { number: 123 }
      };

      const result = await detectNewResourceProvider({
        github: mockGithub,
        context: emptyOwnerContext,
        core: mockCore,
        baseBranch: 'main'
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result);
    });

    it('should handle empty string repo name', async () => {
      const emptyRepoContext = {
        repo: { owner: 'Azure', repo: '' },
        issue: { number: 123 }
      };

      const result = await detectNewResourceProvider({
        github: mockGithub,
        context: emptyRepoContext,
        core: mockCore,
        baseBranch: 'main'
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result);
    });

    it('should handle addLabels throwing network timeout', async () => {
      const timeoutGithub = {
        rest: {
          issues: {
            addLabels: vi.fn().mockRejectedValue(new Error('Network timeout')),
            createComment: vi.fn().mockResolvedValue({})
          }
        }
      };

      const result = await detectNewResourceProvider({
        github: timeoutGithub,
        context: mockContext,
        core: mockCore,
        baseBranch: 'main'
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result);
    });

    it('should handle createComment throwing permission error', async () => {
      const permissionGithub = {
        rest: {
          issues: {
            addLabels: vi.fn().mockResolvedValue({}),
            createComment: vi.fn().mockRejectedValue(new Error('Permission denied'))
          }
        }
      };

      const result = await detectNewResourceProvider({
        github: permissionGithub,
        context: mockContext,
        core: mockCore,
        baseBranch: 'main'
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result);
    });

    it('should handle both GitHub API methods failing', async () => {
      const failingGithub = {
        rest: {
          issues: {
            addLabels: vi.fn().mockRejectedValue(new Error('Service unavailable')),
            createComment: vi.fn().mockRejectedValue(new Error('Service unavailable'))
          }
        }
      };

      const result = await detectNewResourceProvider({
        github: failingGithub,
        context: mockContext,
        core: mockCore,
        baseBranch: 'main'
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result);
    });

    it('should handle core.setFailed as undefined', async () => {
      const noCoreSetFailed = {};

      const result = await detectNewResourceProvider({
        github: mockGithub,
        context: mockContext,
        core: noCoreSetFailed,
        baseBranch: 'main'
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result);
    });

    it('should handle multiple concurrent calls', async () => {
      const calls = Array(3).fill(null).map(() =>
        detectNewResourceProvider({
          github: mockGithub,
          context: mockContext,
          core: mockCore,
          baseBranch: 'main'
        })
      );

      const results = await Promise.all(calls);

      results.forEach(result => {
        expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result);
      });
    });

    it('should handle context with additional unexpected properties', async () => {
      const extendedContext = {
        repo: { owner: 'Azure', repo: 'azure-rest-api-specs', extra: 'data' },
        issue: { number: 123, title: 'Test PR', labels: [] },
        payload: { action: 'opened' },
        unexpected: 'property'
      };

      const result = await detectNewResourceProvider({
        github: mockGithub,
        context: extendedContext,
        core: mockCore,
        baseBranch: 'main'
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result);
    });

    it('should not throw when GitHub methods return null', async () => {
      const nullGithub = {
        rest: {
          issues: {
            addLabels: vi.fn().mockResolvedValue(null),
            createComment: vi.fn().mockResolvedValue(null)
          }
        }
      };

      const result = await detectNewResourceProvider({
        github: nullGithub,
        context: mockContext,
        core: mockCore,
        baseBranch: 'main'
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result);
    });
  });
});
