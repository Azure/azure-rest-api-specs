import { describe, expect, it, vi } from "vitest";
import { commentOrUpdate, findAllMatchingComments, parseExistingComments } from "../src/comment.js";

describe("comment.js", () => {
  describe("parseExistingComments", () => {
    it("should find existing comment by identifier", () => {
      const comments = [
        { id: 1, body: "Some other comment" },
        { id: 2, body: "Test comment\n<!-- NextStepsToMerge -->" },
        { id: 3, body: "Another comment" },
      ];

      const [commentId, commentBody] = parseExistingComments(comments, "NextStepsToMerge");

      expect(commentId).toBe(2);
      expect(commentBody).toBe("Test comment\n<!-- NextStepsToMerge -->");
    });

    it("should return undefined when no matching comment found", () => {
      const comments = [
        { id: 1, body: "Some other comment" },
        { id: 3, body: "Another comment" },
      ];

      const [commentId, commentBody] = parseExistingComments(comments, "NextStepsToMerge");

      expect(commentId).toBeUndefined();
      expect(commentBody).toBeUndefined();
    });

    it("should return the first matching comment when multiple exist", () => {
      const comments = [
        { id: 1, body: "First comment\n<!-- NextStepsToMerge -->" },
        { id: 2, body: "Second comment\n<!-- NextStepsToMerge -->" },
      ];

      const [commentId, commentBody] = parseExistingComments(comments, "NextStepsToMerge");

      expect(commentId).toBe(1);
      expect(commentBody).toBe("First comment\n<!-- NextStepsToMerge -->");
    });
  });

  describe("findAllMatchingComments", () => {
    it("should find and sort all matching comments by ID", () => {
      const comments = [
        { id: 300, body: "Third comment\n<!-- TestId -->" },
        { id: 100, body: "First comment\n<!-- TestId -->" },
        { id: 200, body: "Second comment\n<!-- TestId -->" },
        { id: 50, body: "Unrelated comment" },
      ];

      const matching = findAllMatchingComments(comments, "TestId");

      expect(matching).toHaveLength(3);
      expect(matching[0].id).toBe(100); // Oldest first
      expect(matching[1].id).toBe(200);
      expect(matching[2].id).toBe(300);
    });

    it("should return empty array when no matches found", () => {
      const comments = [
        { id: 1, body: "Some comment" },
        { id: 2, body: "Another comment" },
      ];

      const matching = findAllMatchingComments(comments, "TestId");

      expect(matching).toHaveLength(0);
    });

    it("should handle empty comments array", () => {
      const matching = findAllMatchingComments([], "TestId");
      expect(matching).toHaveLength(0);
    });

    it("should handle null/undefined comments", () => {
      expect(findAllMatchingComments(null, "TestId")).toHaveLength(0);
      expect(findAllMatchingComments(undefined, "TestId")).toHaveLength(0);
    });
  });

  describe("commentOrUpdate", () => {
    it("should create new comment when none exists", async () => {
      const mockGithub = {
        paginate: vi.fn().mockResolvedValue([]),
        rest: {
          issues: {
            createComment: vi.fn().mockResolvedValue({ data: { id: 123 } }),
          },
        },
      };
      const mockCore = {
        info: vi.fn(),
      };

      await commentOrUpdate(mockGithub, mockCore, "owner", "repo", 1, "Test body", "TestId");

      expect(mockGithub.rest.issues.createComment).toHaveBeenCalledWith({
        owner: "owner",
        repo: "repo",
        issue_number: 1,
        body: "Test body\n<!-- TestId -->",
      });
    });

    it("should update existing comment when it exists", async () => {
      const existingComments = [{ id: 456, body: "Existing comment\n<!-- TestId -->" }];

      const mockGithub = {
        paginate: vi.fn().mockResolvedValue(existingComments),
        rest: {
          issues: {
            updateComment: vi.fn(),
          },
        },
      };
      const mockCore = {
        info: vi.fn(),
      };

      await commentOrUpdate(mockGithub, mockCore, "owner", "repo", 1, "Updated body", "TestId");

      expect(mockGithub.rest.issues.updateComment).toHaveBeenCalledWith({
        owner: "owner",
        repo: "repo",
        comment_id: 456,
        body: "Updated body\n<!-- TestId -->",
      });
    });

    it("should not update when body is the same", async () => {
      const existingComments = [{ id: 456, body: "Same body\n<!-- TestId -->" }];

      const mockGithub = {
        paginate: vi.fn().mockResolvedValue(existingComments),
        rest: {
          issues: {
            updateComment: vi.fn(),
          },
        },
      };
      const mockCore = {
        info: vi.fn(),
      };

      await commentOrUpdate(mockGithub, mockCore, "owner", "repo", 1, "Same body", "TestId");

      expect(mockGithub.rest.issues.updateComment).not.toHaveBeenCalled();
    });

    it("should handle race condition by cleaning up duplicate comments", async () => {
      // Simulate race condition scenario
      let callCount = 0;
      const mockGithub = {
        paginate: vi.fn().mockImplementation(() => {
          callCount++;
          if (callCount === 1) {
            // First call - no existing comments found
            return Promise.resolve([]);
          } else {
            // Second call - multiple comments found (race condition detected)
            return Promise.resolve([
              { id: 100, body: "First comment\n<!-- TestId -->" },
              { id: 200, body: "Second comment\n<!-- TestId -->" },
            ]);
          }
        }),
        rest: {
          issues: {
            createComment: vi.fn().mockResolvedValue({ data: { id: 200 } }),
            updateComment: vi.fn(),
            deleteComment: vi.fn(),
          },
        },
      };
      const mockCore = {
        info: vi.fn(),
        warning: vi.fn(),
      };

      await commentOrUpdate(mockGithub, mockCore, "owner", "repo", 1, "New body", "TestId");

      // Should create new comment first
      expect(mockGithub.rest.issues.createComment).toHaveBeenCalledWith({
        owner: "owner",
        repo: "repo",
        issue_number: 1,
        body: "New body\n<!-- TestId -->",
      });

      // Should then detect race condition and delete the newer comment
      expect(mockGithub.rest.issues.deleteComment).toHaveBeenCalledWith({
        owner: "owner",
        repo: "repo",
        comment_id: 200,
      });

      // Should update the older comment
      expect(mockGithub.rest.issues.updateComment).toHaveBeenCalledWith({
        owner: "owner",
        repo: "repo",
        comment_id: 100,
        body: "New body\n<!-- TestId -->",
      });

      expect(mockCore.warning).toHaveBeenCalledWith(
        "Race condition detected: Found 2 comments with identifier 'TestId'. Cleaning up duplicate comment 200 and updating comment 100.",
      );
    });

    it("should handle race condition with multiple duplicates and keep oldest", async () => {
      // Test scenario with 3 comments to ensure we always keep the oldest
      let callCount = 0;
      const mockGithub = {
        paginate: vi.fn().mockImplementation(() => {
          callCount++;
          if (callCount === 1) {
            return Promise.resolve([]);
          } else {
            // Multiple comments found, not in chronological order to test sorting
            return Promise.resolve([
              { id: 300, body: "Third comment\n<!-- TestId -->" },
              { id: 100, body: "First comment\n<!-- TestId -->" },
              { id: 200, body: "Second comment\n<!-- TestId -->" },
            ]);
          }
        }),
        rest: {
          issues: {
            createComment: vi.fn().mockResolvedValue({ data: { id: 300 } }),
            updateComment: vi.fn(),
            deleteComment: vi.fn(),
          },
        },
      };
      const mockCore = {
        info: vi.fn(),
        warning: vi.fn(),
      };

      await commentOrUpdate(mockGithub, mockCore, "owner", "repo", 1, "New body", "TestId");

      // Should delete the newest comment (id: 300) that we just created
      expect(mockGithub.rest.issues.deleteComment).toHaveBeenCalledWith({
        owner: "owner",
        repo: "repo",
        comment_id: 300,
      });

      // Should update the oldest comment (id: 100)
      expect(mockGithub.rest.issues.updateComment).toHaveBeenCalledWith({
        owner: "owner",
        repo: "repo",
        comment_id: 100,
        body: "New body\n<!-- TestId -->",
      });

      expect(mockCore.warning).toHaveBeenCalledWith(
        "Race condition detected: Found 3 comments with identifier 'TestId'. Cleaning up duplicate comment 300 and updating comment 100.",
      );
    });
  });
});
