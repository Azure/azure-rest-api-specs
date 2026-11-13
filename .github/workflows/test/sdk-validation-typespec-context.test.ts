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
  it("uses the SDK package project instead of a nearer nested config", async () => {
    const github = createMockGithub();
    const context = createMockContext();
    const changedPath = `${PROJECT_ROOT}/private/nested/models.tsp`;
    github.rest.repos.compareCommitsWithBasehead.mockResolvedValue({
      data: {
        files: [
          {
            filename: changedPath,
            status: "modified",
            patch: "@@ -1 +1 @@\n-model Old {}\n+model New {}",
          },
        ],
      },
    });
    github.rest.repos.getContent.mockImplementation((request) => {
      const { path, ref } = request as { path: string; ref?: string };
      expect(ref).toBe(HEAD_SHA);
      const contents = new Map([
        [changedPath, "model New {}"],
        [`${PROJECT_ROOT}/tspconfig.yaml`, "emit: []"],
        [`${PROJECT_ROOT}/main.tsp`, 'import "./private/nested/models.tsp";'],
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
      changedFileCount: 1,
      projectRoots: [PROJECT_ROOT],
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
    expect(result.files).toContainEqual({
      path: `${PROJECT_ROOT}/client.tsp`,
      roles: ["client"],
      content: '@@clientName(New, "WidgetModel", "csharp");',
    });
    expect(
      github.rest.repos.getContent.mock.calls.some(
        ([request]) =>
          (request as { path: string }).path === `${PROJECT_ROOT}/private/nested/tspconfig.yaml`,
      ),
    ).toBe(false);
    expect(github.rest.repos.compareCommitsWithBasehead).toHaveBeenCalledWith({
      owner: context.repo.owner,
      repo: context.repo.repo,
      basehead: `${BASE_SHA}...${HEAD_SHA}`,
    });
    expect(github.rest.repos.getContent).toHaveBeenCalledTimes(4);
  });

  it("preserves deleted-file patches without requesting deleted content", async () => {
    const github = createMockGithub();
    const context = createMockContext();
    const deletedPath = `${PROJECT_ROOT}/old-model.tsp`;
    github.rest.repos.compareCommitsWithBasehead.mockResolvedValue({
      data: {
        files: [
          {
            filename: deletedPath,
            status: "removed",
            patch: "@@ -1 +0,0 @@\n-model Old {}",
          },
        ],
      },
    });
    github.rest.repos.getContent.mockRejectedValue(notFoundError());

    const result = await collectTypeSpecReviewContext({
      github,
      context,
      prNumber: 42,
      headSha: HEAD_SHA,
      baseSha: BASE_SHA,
      changedFileCount: 1,
      projectRoots: [PROJECT_ROOT],
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

  it("uses the complete immutable diff when more than 300 files changed", async () => {
    const github = createMockGithub();
    const context = createMockContext();
    const addedPath = `${PROJECT_ROOT}/added model.tsp`;
    const deletedPath = `${PROJECT_ROOT}/deleted.tsp`;
    const previousPath = `${PROJECT_ROOT}/old name.tsp`;
    const renamedPath = `${PROJECT_ROOT}/new name.tsp`;
    const unrelatedSections = Array.from({ length: 298 }, (_, index) => {
      const filePath = `docs/file-${index}.md`;
      return [
        `diff --git a/${filePath} b/${filePath}`,
        "index 1111111..2222222 100644",
        `--- a/${filePath}`,
        `+++ b/${filePath}`,
        "@@ -1 +1 @@",
        "-old",
        "+new",
        "",
      ].join("\n");
    });
    const typeSpecSections = [
      [
        `diff --git a/${addedPath} b/${addedPath}`,
        "new file mode 100644",
        "--- /dev/null",
        `+++ b/${addedPath}\t`,
        "@@ -0,0 +1 @@",
        "+model Added {}",
        "",
      ].join("\n"),
      [
        `diff --git a/${deletedPath} b/${deletedPath}`,
        "deleted file mode 100644",
        `--- a/${deletedPath}`,
        "+++ /dev/null",
        "@@ -1 +0,0 @@",
        "-model Deleted {}",
        "",
      ].join("\n"),
      [
        `diff --git a/${previousPath} b/${renamedPath}`,
        "similarity index 100%",
        `rename from "${previousPath}"`,
        `rename to "${renamedPath}"`,
        "",
      ].join("\n"),
    ];
    github.request.mockResolvedValue({
      data: [...unrelatedSections, ...typeSpecSections].join(""),
    });
    github.rest.repos.getContent.mockImplementation((request) => {
      const contents = new Map([
        [addedPath, "model Added {}"],
        [renamedPath, "model Renamed {}"],
        [`${PROJECT_ROOT}/tspconfig.yaml`, "emit: []"],
        [`${PROJECT_ROOT}/main.tsp`, 'import "./added.tsp";'],
        [`${PROJECT_ROOT}/client.tsp`, '@@clientName(Added, "WidgetModel", "csharp");'],
      ]);
      const content = contents.get(String((request as { path: string }).path));
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
      changedFileCount: 301,
      projectRoots: [PROJECT_ROOT],
    });

    expect(github.request).toHaveBeenCalledWith("GET /repos/{owner}/{repo}/compare/{basehead}", {
      owner: context.repo.owner,
      repo: context.repo.repo,
      basehead: `${BASE_SHA}...${HEAD_SHA}`,
      headers: { accept: "application/vnd.github.diff" },
    });
    expect(github.rest.repos.compareCommitsWithBasehead).not.toHaveBeenCalled();
    expect(result.files).toContainEqual({
      path: addedPath,
      roles: ["changed"],
      status: "added",
      previousPath: undefined,
      renamedTo: undefined,
      patch: "@@ -0,0 +1 @@\n+model Added {}",
      content: "model Added {}",
    });
    expect(result.files).toContainEqual({
      path: deletedPath,
      roles: ["changed"],
      status: "removed",
      previousPath: undefined,
      renamedTo: undefined,
      patch: "@@ -1 +0,0 @@\n-model Deleted {}",
      content: undefined,
    });
    expect(result.files).toContainEqual({
      path: renamedPath,
      roles: ["changed"],
      status: "renamed",
      previousPath,
      renamedTo: undefined,
      patch: undefined,
      content: "model Renamed {}",
    });
  });

  it("rejects oversized changed-file sets before loading repository content", async () => {
    const github = createMockGithub();
    const context = createMockContext();
    const changedFiles = Array.from({ length: MAX_TYPESPEC_CONTEXT_FILES + 1 }, (_, index) => ({
      filename: `${PROJECT_ROOT}/model-${index}.tsp`,
      status: "modified",
    }));
    github.request.mockResolvedValue({
      data: changedFiles
        .map(({ filename }) =>
          [
            `diff --git a/${filename} b/${filename}`,
            "index 1111111..2222222 100644",
            `--- a/${filename}`,
            `+++ b/${filename}`,
            "@@ -1 +1 @@",
            "-model Old {}",
            "+model New {}",
            "",
          ].join("\n"),
        )
        .join(""),
    });

    await expect(
      collectTypeSpecReviewContext({
        github,
        context,
        prNumber: 42,
        headSha: HEAD_SHA,
        baseSha: BASE_SHA,
        changedFileCount: changedFiles.length,
        projectRoots: [PROJECT_ROOT],
      }),
    ).rejects.toThrow(`maximum is ${MAX_TYPESPEC_CONTEXT_FILES}`);
    expect(github.rest.repos.getContent).not.toHaveBeenCalled();
  });

  it("counts distinct paths when many changed files share one project", async () => {
    const github = createMockGithub();
    const context = createMockContext();
    const changedFiles = Array.from({ length: 167 }, (_, index) => ({
      filename: `${PROJECT_ROOT}/model-${index}.tsp`,
      status: "modified",
    }));
    github.rest.repos.compareCommitsWithBasehead.mockResolvedValue({
      data: { files: changedFiles },
    });
    github.rest.repos.getContent.mockResolvedValue(repositoryFile("model Widget {}"));

    await expect(
      collectTypeSpecReviewContext({
        github,
        context,
        prNumber: 42,
        headSha: HEAD_SHA,
        baseSha: BASE_SHA,
        changedFileCount: changedFiles.length,
        projectRoots: [PROJECT_ROOT, PROJECT_ROOT],
      }),
    ).resolves.toMatchObject({
      projects: [{ root: PROJECT_ROOT }],
    });
    expect(github.rest.repos.getContent).toHaveBeenCalledTimes(170);
  });

  it("rejects contexts that exceed the exact content request budget", async () => {
    const github = createMockGithub();
    const context = createMockContext();
    const changedFiles = Array.from({ length: 126 }, (_, index) => ({
      filename: `specification/service-${index}/project/model.tsp`,
      status: "modified",
    }));
    const projectRoots = Array.from(
      { length: 126 },
      (_, index) => `specification/service-${index}/project`,
    );
    github.rest.repos.compareCommitsWithBasehead.mockResolvedValue({
      data: { files: changedFiles },
    });

    await expect(
      collectTypeSpecReviewContext({
        github,
        context,
        prNumber: 42,
        headSha: HEAD_SHA,
        baseSha: BASE_SHA,
        changedFileCount: changedFiles.length,
        projectRoots,
      }),
    ).rejects.toThrow(`maximum is ${MAX_TYPESPEC_CONTEXT_API_REQUESTS}`);
    expect(github.rest.repos.getContent).not.toHaveBeenCalled();
  });

  it("rejects an incomplete exact-revision comparison", async () => {
    const github = createMockGithub();
    const context = createMockContext();
    github.rest.repos.compareCommitsWithBasehead.mockResolvedValue({
      data: {
        files: [{ filename: `${PROJECT_ROOT}/models.tsp`, status: "modified" }],
      },
    });

    await expect(
      collectTypeSpecReviewContext({
        github,
        context,
        prNumber: 42,
        headSha: HEAD_SHA,
        baseSha: BASE_SHA,
        changedFileCount: 2,
        projectRoots: [PROJECT_ROOT],
      }),
    ).rejects.toThrow("returned 1 of 2 changed files");
    expect(github.rest.repos.getContent).not.toHaveBeenCalled();
  });

  it.each(["models.tsp", "tspconfig.yaml"])(
    "preserves %s renamed outside the specification tree as a removal",
    async (fileName) => {
      const github = createMockGithub();
      const context = createMockContext();
      const previousPath = `${PROJECT_ROOT}/${fileName}`;
      github.rest.repos.compareCommitsWithBasehead.mockResolvedValue({
        data: {
          files: [
            {
              filename: `archive/${fileName}.txt`,
              previous_filename: previousPath,
              status: "renamed",
              patch: "@@ -1 +0,0 @@\n-model Widget {}",
            },
          ],
        },
      });
      github.rest.repos.getContent.mockRejectedValue(notFoundError());

      const result = await collectTypeSpecReviewContext({
        github,
        context,
        prNumber: 42,
        headSha: HEAD_SHA,
        baseSha: BASE_SHA,
        changedFileCount: 1,
        projectRoots: [PROJECT_ROOT],
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
