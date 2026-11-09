import { describe, expect, it } from "vitest";
import {
  collectTypeSpecReviewContext,
  MAX_TYPESPEC_CONTEXT_API_REQUESTS,
  MAX_TYPESPEC_CONTEXT_FILES,
} from "../src/sdk-validation-typespec-context.ts";
import { createMockContext, createMockGithub } from "./mocks.ts";

const HEAD_SHA = "1".repeat(40);
const BASE_SHA = "2".repeat(40);
const PROJECT_ROOT = "specification/widget/Widget.Management";

function repositoryFile(content: string) {
  return {
    data: {
      type: "file",
      encoding: "base64",
      content: Buffer.from(content).toString("base64"),
    },
  };
}

function notFoundError() {
  return Object.assign(new Error("Not Found"), { status: 404 });
}

describe("collectTypeSpecReviewContext", () => {
  it("collects changed TypeSpec and minimal project context at the reviewed head", async () => {
    const github = createMockGithub();
    const context = createMockContext();
    const changedPath = `${PROJECT_ROOT}/models.tsp`;
    github.rest.pulls.listFiles.mockResolvedValue({
      data: [
        {
          filename: changedPath,
          status: "modified",
          patch: "@@ -1 +1 @@\n-model Old {}\n+model New {}",
        },
        {
          filename: "documentation/readme.md",
          status: "modified",
        },
      ],
    });
    github.rest.repos.getContent.mockImplementation((request) => {
      const { path, ref } = request as { path: string; ref?: string };
      expect(ref).toBe(HEAD_SHA);
      const contents = new Map([
        [changedPath, "model New {}"],
        [`${PROJECT_ROOT}/tspconfig.yaml`, "emit: []"],
        [`${PROJECT_ROOT}/main.tsp`, 'import "./models.tsp";'],
        [`${PROJECT_ROOT}/client.tsp`, '@@clientName(New, "WidgetModel", "csharp");'],
      ]);
      const content = contents.get(String(path));
      if (content === undefined) {
        return Promise.reject(notFoundError());
      }
      return Promise.resolve(repositoryFile(content));
    });

    const result = await collectTypeSpecReviewContext({
      github,
      context,
      prNumber: 42,
      headSha: HEAD_SHA,
      baseSha: BASE_SHA,
    });

    expect(result.source).toEqual({
      specPrNumber: 42,
      specHeadSha: HEAD_SHA,
      specBaseSha: BASE_SHA,
    });
    expect(result.projects).toEqual([
      {
        root: PROJECT_ROOT,
        files: [
          `${PROJECT_ROOT}/client.tsp`,
          `${PROJECT_ROOT}/main.tsp`,
          `${PROJECT_ROOT}/tspconfig.yaml`,
        ],
      },
    ]);
    expect(result.files).toEqual([
      {
        path: `${PROJECT_ROOT}/client.tsp`,
        roles: ["client"],
        content: '@@clientName(New, "WidgetModel", "csharp");',
      },
      {
        path: `${PROJECT_ROOT}/main.tsp`,
        roles: ["entrypoint"],
        content: 'import "./models.tsp";',
      },
      {
        path: changedPath,
        roles: ["changed"],
        status: "modified",
        patch: "@@ -1 +1 @@\n-model Old {}\n+model New {}",
        content: "model New {}",
      },
      {
        path: `${PROJECT_ROOT}/tspconfig.yaml`,
        roles: ["config"],
        content: "emit: []",
      },
    ]);
    expect(github.rest.pulls.listFiles).toHaveBeenCalledOnce();
    expect(github.rest.repos.getContent).toHaveBeenCalledTimes(4);
  });

  it("preserves deleted-file patches without requesting deleted content", async () => {
    const github = createMockGithub();
    const context = createMockContext();
    const deletedPath = `${PROJECT_ROOT}/old-model.tsp`;
    github.rest.pulls.listFiles.mockResolvedValue({
      data: [
        {
          filename: deletedPath,
          status: "removed",
          patch: "@@ -1 +0,0 @@\n-model Old {}",
        },
      ],
    });
    github.rest.repos.getContent.mockImplementation((request) => {
      const { path } = request as { path: string };
      if (path === `${PROJECT_ROOT}/tspconfig.yaml`) {
        return Promise.resolve(repositoryFile("emit: []"));
      }
      return Promise.reject(notFoundError());
    });

    const result = await collectTypeSpecReviewContext({
      github,
      context,
      prNumber: 42,
      headSha: HEAD_SHA,
      baseSha: BASE_SHA,
    });

    expect(result.files).toContainEqual({
      path: deletedPath,
      roles: ["changed"],
      status: "removed",
      patch: "@@ -1 +0,0 @@\n-model Old {}",
      content: undefined,
    });
    expect(
      github.rest.repos.getContent.mock.calls.some(
        ([request]) => (request as { path: string }).path === deletedPath,
      ),
    ).toBe(false);
  });

  it("rejects oversized changed-file sets before loading repository content", async () => {
    const github = createMockGithub();
    const context = createMockContext();
    github.rest.pulls.listFiles.mockResolvedValue({
      data: Array.from({ length: MAX_TYPESPEC_CONTEXT_FILES + 1 }, (_, index) => ({
        filename: `specification/widget/Widget.Management/model-${index}.tsp`,
        status: "modified",
      })),
    });

    await expect(
      collectTypeSpecReviewContext({
        github,
        context,
        prNumber: 42,
        headSha: HEAD_SHA,
        baseSha: BASE_SHA,
      }),
    ).rejects.toThrow(`maximum is ${MAX_TYPESPEC_CONTEXT_FILES}`);
    expect(github.rest.repos.getContent).not.toHaveBeenCalled();
  });

  it("rejects deep unrelated paths before consuming the GitHub content API budget", async () => {
    const github = createMockGithub();
    const context = createMockContext();
    github.rest.pulls.listFiles.mockResolvedValue({
      data: Array.from({ length: 100 }, (_, index) => ({
        filename: `specification/service-${index}/one/two/three/four/model.tsp`,
        status: "modified",
      })),
    });

    await expect(
      collectTypeSpecReviewContext({
        github,
        context,
        prNumber: 42,
        headSha: HEAD_SHA,
        baseSha: BASE_SHA,
      }),
    ).rejects.toThrow(`maximum is ${MAX_TYPESPEC_CONTEXT_API_REQUESTS}`);
    expect(github.rest.repos.getContent).not.toHaveBeenCalled();
  });

  it.each(["models.tsp", "tspconfig.yaml"])(
    "preserves %s renamed outside the specification tree as a removal",
    async (fileName) => {
      const github = createMockGithub();
      const context = createMockContext();
      const previousPath = `${PROJECT_ROOT}/${fileName}`;
      github.rest.pulls.listFiles.mockResolvedValue({
        data: [
          {
            filename: `archive/${fileName}.txt`,
            previous_filename: previousPath,
            status: "renamed",
            patch: "@@ -1 +0,0 @@\n-model Widget {}",
          },
        ],
      });
      github.rest.repos.getContent.mockImplementation((request) => {
        const { path } = request as { path: string };
        if (fileName !== "tspconfig.yaml" && path === `${PROJECT_ROOT}/tspconfig.yaml`) {
          return Promise.resolve(repositoryFile("emit: []"));
        }
        return Promise.reject(notFoundError());
      });

      const result = await collectTypeSpecReviewContext({
        github,
        context,
        prNumber: 42,
        headSha: HEAD_SHA,
        baseSha: BASE_SHA,
      });

      expect(result.files).toContainEqual({
        path: previousPath,
        roles: ["changed"],
        status: "removed",
        previousPath: undefined,
        renamedTo: `archive/${fileName}.txt`,
        patch: "@@ -1 +0,0 @@\n-model Widget {}",
        content: undefined,
      });
      expect(
        github.rest.repos.getContent.mock.calls.some(
          ([request]) => (request as { path: string }).path === `archive/${fileName}.txt`,
        ),
      ).toBe(false);
    },
  );
});
