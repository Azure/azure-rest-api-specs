import { describe, expect, it } from "vitest";
import { commentOrUpdate } from "../src/comment.ts";
import { createMockCore, createMockGithub } from "./mocks.ts";

describe("comment report handoff", () => {
  it.each(["create", "update", "unchanged"])(
    "returns the report ID without an additional lookup (%s)",
    async (action) => {
      const github = createMockGithub();
      const body = "Report\n<!-- report -->";
      github.rest.issues.createComment.mockResolvedValue({ data: { id: 99 } });
      github.rest.issues.listComments.mockResolvedValue({
        data:
          action === "create"
            ? []
            : [{ id: 42, body: action === "unchanged" ? body : "Old report\n<!-- report -->" }],
      });

      const id = await commentOrUpdate(
        github,
        createMockCore(),
        "owner",
        "repo",
        1,
        "Report",
        "report",
      );

      expect(id).toBe(action === "create" ? 99 : 42);
      expect(github.rest.issues.listComments).toHaveBeenCalledOnce();
      expect(github.rest.issues.createComment).toHaveBeenCalledTimes(action === "create" ? 1 : 0);
      expect(github.rest.issues.updateComment).toHaveBeenCalledTimes(action === "update" ? 1 : 0);
    },
  );
});
