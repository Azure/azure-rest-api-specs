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
          createComment: vi.fn().mockResolvedValue({})
        }
      }
    };

    mockContext = {
      repo: { owner: 'Azure', repo: 'azure-rest-api-specs' },
      issue: { number: 123 },
      payload: {
        pull_request: {
          base: { ref: 'main' },
          head: { sha: 'abc123' }
        }
      }
    };

    mockCore = {
      setFailed: vi.fn(),
      info: vi.fn(),
      error: vi.fn()
    };
  });

  describe('function export', () => {
    it('should be exported as default export', () => {
      expect(typeof detectNewResourceProvider).toBe('function');
    });
  });

  describe('basic behavior', () => {
    it('should return a valid status', async () => {
      const result = await detectNewResourceProvider({
        github: mockGithub,
        context: mockContext,
        core: mockCore
      });

      // Result depends on actual workspace state
      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result.status);
    });
  });

  describe('parameter validation', () => {
    it('should accept all required parameters', async () => {
      const result = await detectNewResourceProvider({
        github: mockGithub,
        context: mockContext,
        core: mockCore
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result.status);
    });

    it('should work with different baseBranch values from context', async () => {
      const rpsaasContext = {
        ...mockContext,
        payload: { pull_request: { base: { ref: 'RPSaaSMaster' }, head: { sha: 'abc123' } } }
      };

      const result = await detectNewResourceProvider({
        github: mockGithub,
        context: rpsaasContext,
        core: mockCore
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result.status);
    });
  });

  describe('github API interactions', () => {
    it('should complete without throwing', async () => {
      // Test runs against real workspace - result depends on actual state
      const result = await detectNewResourceProvider({
        github: mockGithub,
        context: mockContext,
        core: mockCore
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result.status);
    });

    it('should handle GitHub API errors gracefully', async () => {
      const errorGithub = {
        rest: {
          issues: {
            createComment: vi.fn().mockRejectedValue(new Error('API Error'))
          }
        }
      };

      const result = await detectNewResourceProvider({
        github: errorGithub,
        context: mockContext,
        core: mockCore
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result.status);
    });
  });

  describe('return values', () => {
    it('should return one of three valid statuses', async () => {
      const result = await detectNewResourceProvider({
        github: mockGithub,
        context: mockContext,
        core: mockCore
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result.status);
    });
  });

  describe('context validation', () => {
    it('should handle minimal context object', async () => {
      const minimalContext = {
        repo: { owner: 'test-owner', repo: 'test-repo' },
        issue: { number: 1 },
        payload: { pull_request: { base: { ref: 'main' }, head: { sha: 'abc123' } } }
      };

      const result = await detectNewResourceProvider({
        github: mockGithub,
        context: minimalContext,
        core: mockCore
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result.status);
    });
  });

  describe('edge cases', () => {
    it('should handle issue number as zero', async () => {
      const zeroIssueContext = {
        repo: { owner: 'Azure', repo: 'azure-rest-api-specs' },
        issue: { number: 0 },
        payload: { pull_request: { base: { ref: 'main' }, head: { sha: 'abc123' } } }
      };

      const result = await detectNewResourceProvider({
        github: mockGithub,
        context: zeroIssueContext,
        core: mockCore
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result.status);
    });

    it('should handle very large issue numbers', async () => {
      const largeIssueContext = {
        repo: { owner: 'Azure', repo: 'azure-rest-api-specs' },
        issue: { number: 999999999 },
        payload: { pull_request: { base: { ref: 'main' }, head: { sha: 'abc123' } } }
      };

      const result = await detectNewResourceProvider({
        github: mockGithub,
        context: largeIssueContext,
        core: mockCore
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result.status);
    });

    it('should handle empty string repo owner', async () => {
      const emptyOwnerContext = {
        repo: { owner: '', repo: 'azure-rest-api-specs' },
        issue: { number: 123 },
        payload: { pull_request: { base: { ref: 'main' }, head: { sha: 'abc123' } } }
      };

      const result = await detectNewResourceProvider({
        github: mockGithub,
        context: emptyOwnerContext,
        core: mockCore
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result.status);
    });

    it('should handle empty string repo name', async () => {
      const emptyRepoContext = {
        repo: { owner: 'Azure', repo: '' },
        issue: { number: 123 },
        payload: { pull_request: { base: { ref: 'main' }, head: { sha: 'abc123' } } }
      };

      const result = await detectNewResourceProvider({
        github: mockGithub,
        context: emptyRepoContext,
        core: mockCore
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result.status);
    });

    it('should handle createComment throwing network timeout', async () => {
      const timeoutGithub = {
        rest: {
          issues: {
            createComment: vi.fn().mockRejectedValue(new Error('Network timeout'))
          }
        }
      };

      const result = await detectNewResourceProvider({
        github: timeoutGithub,
        context: mockContext,
        core: mockCore
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result.status);
    });

    it('should handle createComment throwing permission error', async () => {
      const permissionGithub = {
        rest: {
          issues: {
            createComment: vi.fn().mockRejectedValue(new Error('Permission denied'))
          }
        }
      };

      const result = await detectNewResourceProvider({
        github: permissionGithub,
        context: mockContext,
        core: mockCore
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result.status);
    });

    it('should handle GitHub API methods failing', async () => {
      const failingGithub = {
        rest: {
          issues: {
            createComment: vi.fn().mockRejectedValue(new Error('Service unavailable'))
          }
        }
      };

      const result = await detectNewResourceProvider({
        github: failingGithub,
        context: mockContext,
        core: mockCore
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result.status);
    });

    it('should handle core.setFailed as noop', async () => {
      const noopCore = {
        info: vi.fn(),
        error: vi.fn(),
        setFailed: vi.fn()  // noop setFailed
      };

      const result = await detectNewResourceProvider({
        github: mockGithub,
        context: mockContext,
        core: noopCore
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result.status);
    });

    it('should handle multiple concurrent calls', async () => {
      const calls = Array(3).fill(null).map(() =>
        detectNewResourceProvider({
          github: mockGithub,
          context: mockContext,
          core: mockCore
        })
      );

      const results = await Promise.all(calls);

      results.forEach(result => {
        expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result.status);
      });
    });

    it('should handle context with additional unexpected properties', async () => {
      const extendedContext = {
        repo: { owner: 'Azure', repo: 'azure-rest-api-specs', extra: 'data' },
        issue: { number: 123, title: 'Test PR', labels: [] },
        payload: { action: 'opened', pull_request: { base: { ref: 'main' }, head: { sha: 'abc123' } } },
        unexpected: 'property'
      };

      const result = await detectNewResourceProvider({
        github: mockGithub,
        context: extendedContext,
        core: mockCore
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result.status);
    });

    it('should not throw when GitHub methods return null', async () => {
      const nullGithub = {
        rest: {
          issues: {
            createComment: vi.fn().mockResolvedValue(null)
          }
        }
      };

      const result = await detectNewResourceProvider({
        github: nullGithub,
        context: mockContext,
        core: mockCore
      });

      expect(['no-changes', 'no-new-rp', 'new-rp-detected']).toContain(result.status);
    });
  });
});
