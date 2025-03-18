import { describe, expect, it, vi, beforeEach } from "vitest";
import { LabelAction } from "../../src/label.js";
import {
  createMockCore,
  createMockGithub,
  createMockContext
} from "../../test/mocks.js";
import { getLabelAndAction, getLabelAndActionImpl, getIssueNumber } from "../src/sdk-breaking-change-labels.js";
import { sdkLabels } from "../../src/sdk-types.js";

// Mock dependencies
vi.mock('../../src/context.js', () => ({
  extractInputs: vi.fn()
}));

// Mock global fetch
global.fetch = vi.fn();

const mockCore = createMockCore();
const mockContext = createMockContext();
const mockGithub = createMockGithub();
describe('sdk-breaking-change-labels', () => {  
  beforeEach(() => {
    // Reset mocks
    vi.clearAllMocks();    
  });

  describe('getLabelAndAction', () => {
    it('should extract inputs and call getLabelAndActionImpl', async () => {
      // Mock extracted inputs
      const mockInputs = {
        ado_build_id: '12345',
        ado_project_url: 'https://dev.azure.com/project',
        head_sha: 'abc123'
      };

      // Setup mock implementation for extractInputs
      const { extractInputs } = await import('../../src/context.js');
      extractInputs.mockResolvedValue(mockInputs);

      // Mock fetch responses
      // First fetch - artifact metadata
      const mockArtifactResponse = {
        ok: true,
        json: vi.fn().mockResolvedValue({
          resource: {
            downloadUrl: 'https://dev.azure.com/download?format=zip'
          }
        }),
        text: vi.fn()
      };

      // Second fetch - artifact content
      const language = 'azure-sdk-for-js';
      const mockContentResponse = {
        ok: true,
        text: vi.fn().mockResolvedValue(JSON.stringify({
          labelAction: 'add',
          language
        }))
      };

      // Mock PR search results
      mockGithub.rest.search.issuesAndPullRequests.mockResolvedValue({
        data: {
          total_count: 1,
          items: [{ number: 123, html_url: 'https://github.com/pr/123' }]
        }
      });

      // Setup fetch to return different responses for each call
      global.fetch.mockImplementation((url) => {
        if (url.includes('artifacts?artifactName=')) {
          return mockArtifactResponse;
        } else {
          return mockContentResponse;
        }
      });

      // Call the function
      const result = await getLabelAndAction({ github: mockGithub, context: mockContext, core: mockCore });
      
      // Verify result
      expect(result).toEqual({
        labelName: sdkLabels[language].breakingChange,
        labelAction: LabelAction.Add,
        issueNumber: 123
      });
      
      // Verify mocks were called correctly
      expect(mockGithub.rest.search.issuesAndPullRequests).toHaveBeenCalledWith({
        q: `sha:abc123 type:pr state:open`
      });
    });
    it('should correctly set labelAction to Remove', async () => {
      // Setup inputs
      const inputs = {
        ado_build_id: '12345',
        ado_project_url: 'https://dev.azure.com/project',
        head_sha: 'abc123'
      };

      // Setup mock for extractInputs
      const { extractInputs } = await import('../../src/context.js');
      extractInputs.mockResolvedValue(inputs);

      // Mock artifact responses with 'remove' action
      const mockArtifactResponse = {
        ok: true,
        json: vi.fn().mockResolvedValue({
          resource: {
            downloadUrl: 'https://dev.azure.com/download?format=zip'
          }
        })
      };

      const language = "azure-sdk-for-js";
      const mockContentResponse = {
        ok: true,
        text: vi.fn().mockResolvedValue(JSON.stringify({
          labelAction: 'remove',
          language
        }))
      };

      // Setup fetch to return different responses for each call
      global.fetch.mockImplementation((url) => {
        if (url.includes('artifacts?artifactName=')) {
          return mockArtifactResponse;
        } else {
          return mockContentResponse;
        }
      });

      // Mock PR search
      mockGithub.rest.search.issuesAndPullRequests.mockResolvedValue({
        data: {
          total_count: 1,
          items: [{ number: 123, html_url: 'https://github.com/pr/123' }]
        }
      });

      // Call function
      const result = await getLabelAndAction({ github: mockGithub, context: mockContext, core: mockCore });

      // Verify result has Remove action
      expect(result).toEqual({
        labelName: sdkLabels[language].breakingChange,
        labelAction: LabelAction.Remove,
        issueNumber: 123
      });
    });
    it('should throw error with invalid inputs', async () => {
      // Setup inputs
      const inputs = {
        ado_build_id: '',
        ado_project_url: 'https://dev.azure.com/project',
        head_sha: 'abc123'
      };

      // Setup mock for extractInputs
      const { extractInputs } = await import('../../src/context.js');
      extractInputs.mockResolvedValue(inputs);

      // Call function and expect it to throw
      await expect(getLabelAndAction({ github: mockGithub, context: mockContext, core: mockCore })).rejects.toThrow();
    });
  });
  
  describe('getLabelAndActionImpl error handling', () => {
    it('should handle API failure', async () => {
      // Setup inputs
      const inputs = {
        ado_build_id: '12345',
        ado_project_url: 'https://dev.azure.com/project',
        head_sha: 'abc123'
      };

      // Mock fetch failure
      global.fetch.mockResolvedValue({
        ok: false,
        status: 404,
        statusText: 'Not Found',
        text: vi.fn().mockResolvedValue('Artifact not found')
      });

      // Mock PR search success
      mockGithub.rest.search.issuesAndPullRequests.mockResolvedValue({
        data: {
          total_count: 1,
          items: [{ number: 123, html_url: 'https://github.com/pr/123' }]
        }
      });

      // Call function
      const result = await getLabelAndActionImpl({ ado_build_id: inputs.ado_build_id, ado_project_url: inputs.ado_project_url, head_sha: inputs.head_sha, github: mockGithub, core: mockCore });

      // Verify result uses default values when artifact fetch fails
      expect(result).toEqual({
        labelName: '',
        labelAction: LabelAction.None,
        issueNumber: NaN
      });

      // Verify error was logged
      expect(mockCore.error).toHaveBeenCalledWith(expect.stringContaining('Failed to fetch artifacts'));
    });

    it('should throw error if resource is empty from the artifact api response', async () => {
      // Setup inputs
      const inputs = {
        ado_build_id: '12345',
        ado_project_url: 'https://dev.azure.com/project',
        head_sha: 'abc123'
      };

      // Mock artifact responses with 'remove' action
      const mockArtifactResponse = {
        ok: true,
        json: vi.fn().mockResolvedValue({})
      };

      // Setup fetch to return different responses for each call
      global.fetch.mockImplementation((url) => {
        if (url.includes('artifacts?artifactName=')) {
          return mockArtifactResponse;
        }
      });

      // Call function
      const result = await getLabelAndActionImpl({ ado_build_id: inputs.ado_build_id, ado_project_url: inputs.ado_project_url, head_sha: inputs.head_sha, github: mockGithub, core: mockCore });
            
      // Verify result
      expect(result).toEqual({
        labelName: '',
        labelAction: LabelAction.None,
        issueNumber: NaN
      });

      // Verify error was logged
      expect(mockCore.error).toHaveBeenCalledWith(expect.stringContaining('Error processing breaking change label artifact'));
    });

    it('should throw error if missing download url from the artifact api response', async () => {
      // Setup inputs
      const inputs = {
        ado_build_id: '12345',
        ado_project_url: 'https://dev.azure.com/project',
        head_sha: 'abc123'
      };

      // Mock artifact responses with 'remove' action
      const mockArtifactResponse = {
        ok: true,
        json: vi.fn().mockResolvedValue({
          resource: {
          }
        })
      };

      // Setup fetch to return different responses for each call
      global.fetch.mockImplementation((url) => {
        if (url.includes('artifacts?artifactName=')) {
          return mockArtifactResponse;
        }
      });

      // Call function
      const result = await getLabelAndActionImpl({ ado_build_id: inputs.ado_build_id, ado_project_url: inputs.ado_project_url, head_sha: inputs.head_sha, github: mockGithub, core: mockCore });
      
      // Verify result
      expect(result).toEqual({
        labelName: '',
        labelAction: LabelAction.None,
        issueNumber: NaN
      });
      
      // Verify error was logged
      expect(mockCore.error).toHaveBeenCalledWith(expect.stringContaining('Error processing breaking change label artifact'));
    });

    it('should throw error when fail to fetch artifact content', async () => {
      // Setup inputs
      const inputs = {
        ado_build_id: '12345',
        ado_project_url: 'https://dev.azure.com/project',
        head_sha: 'abc123'
      };

      // Mock fetch responses
      // First fetch - artifact metadata
      const mockArtifactResponse = {
        ok: true,
        json: vi.fn().mockResolvedValue({
          resource: {
            downloadUrl: 'https://dev.azure.com/download?format=zip'
          }
        }),
        text: vi.fn()
      };

      // Second fetch - artifact content
      const mockContentResponse = {
        ok: false,
        status: 404,
        statusText: 'Not Found',
        text: vi.fn().mockResolvedValue('Artifact not found')
      };

      // Setup fetch to return different responses for each call
      global.fetch.mockImplementation((url) => {
        if (url.includes('artifacts?artifactName=')) {
          return mockArtifactResponse;
        } else {
          return mockContentResponse;
        }
      });

      // Call function
      const result = await getLabelAndActionImpl({ ado_build_id: inputs.ado_build_id, ado_project_url: inputs.ado_project_url, head_sha: inputs.head_sha, github: mockGithub, core: mockCore });
      
      // Verify result
      expect(result).toEqual({
        labelName: '',
        labelAction: LabelAction.None,
        issueNumber: NaN
      });
      
      // Verify error was logged
      expect(mockCore.error).toHaveBeenCalledWith(expect.stringContaining('Error processing breaking change label artifact'));
    });

    it('should handle exception during processing', async () => {
      // Setup inputs
      const inputs = {
        ado_build_id: '12345',
        ado_project_url: 'https://dev.azure.com/project',
        head_sha: 'abc123'
      };

      // Mock fetch to throw an error
      global.fetch.mockImplementation(() => {
        throw new Error('Network error');
      });

      // Mock PR search success
      mockGithub.rest.search.issuesAndPullRequests.mockResolvedValue({
        data: {
          total_count: 1,
          items: [{ number: 123, html_url: 'https://github.com/pr/123' }]
        }
      });

      // Call function
      const result = await getLabelAndActionImpl({ ado_build_id: inputs.ado_build_id, ado_project_url: inputs.ado_project_url, head_sha: inputs.head_sha, github: mockGithub, core: mockCore });

      // Verify result
      expect(result).toEqual({
        labelName: '',
        labelAction: LabelAction.None,
        issueNumber: NaN
      });
      
      // Verify error was logged
      expect(mockCore.error).toHaveBeenCalledWith(expect.stringContaining('Error processing breaking change label artifact'));
    });
  });

  describe('getIssueNumber', () => {
    it('should return NaN when head_sha is missing', async () => {

      // Call function
      const result = await getIssueNumber({ head_sha: "", github: mockGithub, core: mockCore });
      
      // Verify result
      expect(result.issueNumber).toBeNaN();
      
      // Verify appropriate message was logged
      expect(mockCore.info).toHaveBeenCalledWith('No head_sha found in check run');
    });
    
    it('should handle multiple PRs for the same commit', async () => {
      // Mock multiple PRs found
      mockGithub.rest.search.issuesAndPullRequests.mockResolvedValue({
        data: {
          total_count: 2,
          items: [
            { number: 123, html_url: 'https://github.com/pr/123' },
            { number: 456, html_url: 'https://github.com/pr/456' }
          ]
        }
      });

      // Call function
      const result = await getIssueNumber({ head_sha: "abc", github: mockGithub, core: mockCore });

      // Verify result uses first PR
      expect(result.issueNumber).toBe(123);

      // Verify warning was logged
      expect(mockCore.warning).toHaveBeenCalledWith(expect.stringContaining('Multiple PRs found for commit'));
    });
    
    it('should handle no PRs found', async () => {
      // Mock no PRs found
      mockGithub.rest.search.issuesAndPullRequests.mockResolvedValue({
        data: {
          total_count: 0,
          items: []
        }
      });
      
      // Call function
      const result = await getIssueNumber({ head_sha: "abc", github: mockGithub, core: mockCore });
      
      // Verify result
      expect(result.issueNumber).toBeNaN();
      
      // Verify info was logged
      expect(mockCore.info).toHaveBeenCalledWith(expect.stringContaining('No open PRs found for commit'));
    });
    
    it('should handle GitHub search API errors', async () => {
      // Mock GitHub API error
      const searchError = new Error('GitHub API failure');
      mockGithub.rest.search.issuesAndPullRequests.mockRejectedValue(searchError);
      
      // Call function and expect it to throw
      await expect(getIssueNumber({ head_sha: "abc", github: mockGithub, core: mockCore })).rejects.toThrow();
      
      // Verify error was logged
      expect(mockCore.error).toHaveBeenCalledWith(expect.stringContaining('Error searching for PRs'));
    });
  });
});