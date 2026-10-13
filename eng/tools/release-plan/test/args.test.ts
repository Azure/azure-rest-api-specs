import { describe, expect, it } from "vitest";
import { parseCliArguments } from "../src/args.ts";

describe("parseCliArguments", () => {
  it("parses required arguments without azsdk-path option", () => {
    const result = parseCliArguments(["--commit-sha", "abcdef123456", "--repo", "Azure/repo"]);

    expect(result.commitSha).toBe("abcdef123456");
    expect(result.owner).toBe("Azure");
    expect(result.repo).toBe("repo");
  });

  it("rejects the removed --azsdk-path option", () => {
    expect(() =>
      parseCliArguments([
        "--commit-sha",
        "abcdef123456",
        "--repo",
        "Azure/repo",
        "--azsdk-path",
        "/tools/azsdk",
      ]),
    ).toThrow(/Unknown option '--azsdk-path'/);
  });
});
