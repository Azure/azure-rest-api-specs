import { describe, expect, it } from "vitest";
import { generateMarkdownSummary } from "../src/summarizer.js";
import { PRSummary } from "../src/types.js";

describe("summarizer", () => {
  describe("generateMarkdownSummary", () => {
    it("should generate a valid markdown summary", () => {
      const summary: PRSummary = {
        number: 12345,
        title: "Test PR",
        body: "This is a test PR description",
        author: "testuser",
        state: "open",
        createdAt: "2025-01-01T00:00:00Z",
        updatedAt: "2025-01-02T00:00:00Z",
        additions: 100,
        deletions: 50,
        changedFiles: 5,
        commits: 3,
        categories: [
          {
            name: "TypeSpec",
            files: [
              {
                filename: "specification/test/main.tsp",
                status: "modified",
                additions: 50,
                deletions: 20,
                changes: 70,
              },
            ],
            totalAdditions: 50,
            totalDeletions: 20,
            totalChanges: 70,
          },
          {
            name: "Documentation",
            files: [
              {
                filename: "README.md",
                status: "modified",
                additions: 50,
                deletions: 30,
                changes: 80,
              },
            ],
            totalAdditions: 50,
            totalDeletions: 30,
            totalChanges: 80,
          },
        ],
      };

      const markdown = generateMarkdownSummary(summary);

      // Check that markdown contains expected sections
      expect(markdown).toContain("# PR #12345: Test PR");
      expect(markdown).toContain("## Metadata");
      expect(markdown).toContain("## Change Statistics");
      expect(markdown).toContain("## Description");
      expect(markdown).toContain("## Changes by Category");
      expect(markdown).toContain("### TypeSpec");
      expect(markdown).toContain("### Documentation");
      expect(markdown).toContain("@testuser");
      expect(markdown).toContain("Files Changed**: 5");
      expect(markdown).toContain("Lines Added**: +100");
      expect(markdown).toContain("Lines Deleted**: -50");
    });

    it("should handle PR without description", () => {
      const summary: PRSummary = {
        number: 12345,
        title: "Test PR",
        body: "",
        author: "testuser",
        state: "open",
        createdAt: "2025-01-01T00:00:00Z",
        updatedAt: "2025-01-02T00:00:00Z",
        additions: 10,
        deletions: 5,
        changedFiles: 1,
        commits: 1,
        categories: [],
      };

      const markdown = generateMarkdownSummary(summary);

      // Should not have description section
      expect(markdown).not.toContain("## Description");
      expect(markdown).toContain("# PR #12345: Test PR");
    });
  });
});
