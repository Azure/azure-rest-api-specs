import { describe, expect, it, vi } from "vitest";
import {
  SWAGGER_ALL_SUPPRESSION_TOOL,
  SWAGGER_SUPPRESSION_TOOLS,
  getSwaggerCheckSuppression,
  resolveSwaggerCheckSuppression,
} from "../src/swagger-check-suppressions.js";
import { createMockGithub } from "./mocks.js";

const changedPath =
  "specification/contoso/resource-manager/Microsoft.Contoso/stable/2025-01-01/foo.json";

describe("resolveSwaggerCheckSuppression", () => {
  it.each(Object.keys(SWAGGER_SUPPRESSION_TOOLS))(
    "supports SwaggerAll for %s",
    async (checkName) => {
      const loadSuppressionsFile = vi.fn((path) =>
        Promise.resolve(
          path === "specification/suppressions.yaml"
            ? `
- tool: ${SWAGGER_ALL_SUPPRESSION_TOOL}
  path: contoso/**
  reason: Swagger checks are not applicable
`
            : undefined,
        ),
      );

      await expect(
        resolveSwaggerCheckSuppression({
          changedPaths: [changedPath],
          checkName,
          loadSuppressionsFile,
        }),
      ).resolves.toEqual({
        skip: true,
        reason: "Swagger checks are not applicable",
      });
    },
  );

  it("supports a suppression for one Swagger check", async () => {
    await expect(
      resolveSwaggerCheckSuppression({
        changedPaths: [changedPath],
        checkName: "Swagger LintDiff",
        loadSuppressionsFile: (path) =>
          Promise.resolve(
            path === "specification/contoso/suppressions.yaml"
              ? `
- tool: SwaggerLintDiff
  path: resource-manager/**
  reason: LintDiff is not applicable
`
              : undefined,
          ),
      }),
    ).resolves.toEqual({
      skip: true,
      reason: "LintDiff is not applicable",
    });
  });

  it("falls back to specification/suppressions.yaml when no nearer file exists", async () => {
    const loadSuppressionsFile = vi.fn((path) =>
      Promise.resolve(
        path === "specification/suppressions.yaml"
          ? `
- tool: SwaggerAll
  path: contoso/**
  reason: Central exemption
`
          : undefined,
      ),
    );

    await expect(
      resolveSwaggerCheckSuppression({
        changedPaths: [changedPath],
        checkName: "Swagger Avocado",
        loadSuppressionsFile,
      }),
    ).resolves.toEqual({ skip: true, reason: "Central exemption" });
    expect(loadSuppressionsFile).toHaveBeenCalledWith("specification/contoso/suppressions.yaml");
    expect(loadSuppressionsFile).toHaveBeenCalledWith("specification/suppressions.yaml");
  });

  it("uses a nearer project suppression before the central file", async () => {
    const loadSuppressionsFile = vi.fn((path) => {
      if (path === "specification/contoso/suppressions.yaml") {
        return Promise.resolve(`
- tool: SwaggerAll
  path: resource-manager/**
  reason: Project exemption
`);
      }
      if (path === "specification/suppressions.yaml") {
        return Promise.resolve(`
- tool: SwaggerAll
  path: contoso/**
  reason: Central exemption
`);
      }
      return Promise.resolve(undefined);
    });

    await expect(
      resolveSwaggerCheckSuppression({
        changedPaths: [changedPath],
        checkName: "Swagger Avocado",
        loadSuppressionsFile,
      }),
    ).resolves.toEqual({ skip: true, reason: "Project exemption" });
    expect(loadSuppressionsFile).not.toHaveBeenCalledWith("specification/suppressions.yaml");
  });

  it("does not skip unless all changed specification paths are suppressed", async () => {
    await expect(
      resolveSwaggerCheckSuppression({
        changedPaths: [
          changedPath,
          "specification/fabrikam/resource-manager/Microsoft.Fabrikam/foo.json",
        ],
        checkName: "Swagger Avocado",
        loadSuppressionsFile: (path) =>
          Promise.resolve(
            path === "specification/suppressions.yaml"
              ? `
- tool: SwaggerAll
  path: contoso/**
  reason: Contoso exemption
`
              : undefined,
          ),
      }),
    ).resolves.toEqual({ skip: false });
  });

  it("ignores rule-scoped and conditional suppressions", async () => {
    await expect(
      resolveSwaggerCheckSuppression({
        changedPaths: [changedPath],
        checkName: "Swagger Avocado",
        loadSuppressionsFile: (path) =>
          Promise.resolve(
            path === "specification/suppressions.yaml"
              ? `
- tool: SwaggerAll
  path: contoso/**
  rules: [SomeRule]
  reason: Rule only
- tool: SwaggerAll
  path: contoso/**
  if: "true"
  reason: Conditional
`
              : undefined,
          ),
      }),
    ).resolves.toEqual({ skip: false });
  });

  it("does not skip non-Swagger checks or PRs without specification changes", async () => {
    const loadSuppressionsFile = vi.fn();

    await expect(
      resolveSwaggerCheckSuppression({
        changedPaths: [changedPath],
        checkName: "TypeSpec Suppressions",
        loadSuppressionsFile,
      }),
    ).resolves.toEqual({ skip: false });
    await expect(
      resolveSwaggerCheckSuppression({
        changedPaths: [".github/workflows/avocado-code.yaml"],
        checkName: "Swagger Avocado",
        loadSuppressionsFile,
      }),
    ).resolves.toEqual({ skip: false });
    expect(loadSuppressionsFile).not.toHaveBeenCalled();
  });
});

describe("getSwaggerCheckSuppression", () => {
  it("loads suppression files from the pull request base commit", async () => {
    const github = createMockGithub();
    github.rest.pulls.get.mockResolvedValue({
      data: {
        base: {
          sha: "b".repeat(40),
          repo: {
            name: "azure-rest-api-specs",
            owner: { login: "Azure" },
          },
        },
      },
    });
    github.rest.pulls.listFiles.mockResolvedValue({
      data: [{ filename: changedPath }],
    });
    github.rest.repos.getContent.mockImplementation(({ path }) => {
      if (path !== "specification/suppressions.yaml") {
        const error = new Error("Not Found");
        Object.assign(error, { status: 404 });
        return Promise.reject(error);
      }
      return Promise.resolve({
        data: {
          type: "file",
          content: Buffer.from(
            `
- tool: SwaggerAll
  path: contoso/**
  reason: Central exemption
`,
          ).toString("base64"),
        },
      });
    });

    await expect(
      getSwaggerCheckSuppression({
        github,
        owner: "Azure",
        repo: "azure-rest-api-specs",
        pullNumber: 123,
        checkName: "Swagger Avocado",
      }),
    ).resolves.toEqual({ skip: true, reason: "Central exemption" });

    expect(github.rest.repos.getContent).toHaveBeenCalledWith({
      owner: "Azure",
      repo: "azure-rest-api-specs",
      path: "specification/suppressions.yaml",
      ref: "b".repeat(40),
    });
    expect(github.rest.pulls.listFiles).toHaveBeenCalledWith({
      owner: "Azure",
      repo: "azure-rest-api-specs",
      pull_number: 123,
      per_page: 100,
    });
  });
});
