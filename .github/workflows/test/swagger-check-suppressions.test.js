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
const suppression = {
  paths: ["contoso/**"],
  reason: "Swagger checks are not applicable",
};

describe("resolveSwaggerCheckSuppression", () => {
  it.each(Object.keys(SWAGGER_SUPPRESSION_TOOLS))(
    "supports SwaggerAll for %s",
    async (checkName) => {
      const getSuppressionsForPath = vi.fn((tool) =>
        Promise.resolve(tool === SWAGGER_ALL_SUPPRESSION_TOOL ? [suppression] : []),
      );

      await expect(
        resolveSwaggerCheckSuppression({
          changedPaths: [changedPath],
          checkName,
          getSuppressionsForPath,
        }),
      ).resolves.toEqual({
        skip: true,
        reason: suppression.reason,
      });
    },
  );

  it("supports a suppression for one Swagger check", async () => {
    await expect(
      resolveSwaggerCheckSuppression({
        changedPaths: [changedPath],
        checkName: "Swagger LintDiff",
        getSuppressionsForPath: (tool) =>
          Promise.resolve(tool === "SwaggerLintDiff" ? [suppression] : []),
      }),
    ).resolves.toEqual({
      skip: true,
      reason: suppression.reason,
    });
  });

  it("does not skip unless all changed specification paths are suppressed", async () => {
    await expect(
      resolveSwaggerCheckSuppression({
        changedPaths: [
          changedPath,
          "specification/fabrikam/resource-manager/Microsoft.Fabrikam/foo.json",
        ],
        checkName: "Swagger Avocado",
        getSuppressionsForPath: (_tool, path) =>
          Promise.resolve(path === changedPath ? [suppression] : []),
      }),
    ).resolves.toEqual({ skip: false });
  });

  it("ignores rule-scoped suppressions", async () => {
    await expect(
      resolveSwaggerCheckSuppression({
        changedPaths: [changedPath],
        checkName: "Swagger Avocado",
        getSuppressionsForPath: () => Promise.resolve([{ ...suppression, rules: ["SomeRule"] }]),
      }),
    ).resolves.toEqual({ skip: false });
  });

  it("does not skip non-Swagger checks or PRs without specification changes", async () => {
    const getSuppressionsForPath = vi.fn();

    await expect(
      resolveSwaggerCheckSuppression({
        changedPaths: [changedPath],
        checkName: "TypeSpec Suppressions",
        getSuppressionsForPath,
      }),
    ).resolves.toEqual({ skip: false });
    await expect(
      resolveSwaggerCheckSuppression({
        changedPaths: [".github/workflows/avocado-code.yaml"],
        checkName: "Swagger Avocado",
        getSuppressionsForPath,
      }),
    ).resolves.toEqual({ skip: false });
    expect(getSuppressionsForPath).not.toHaveBeenCalled();
  });
});

describe("getSwaggerCheckSuppression", () => {
  it("uses getSuppressions for current and previous paths", async () => {
    const github = createMockGithub();
    const previousPath = changedPath.replace("foo.json", "old.json");
    github.rest.pulls.listFiles.mockResolvedValue({
      data: [{ filename: changedPath, previous_filename: previousPath }],
    });
    const getSuppressionsImpl = vi.fn(() => Promise.resolve([suppression]));

    await expect(
      getSwaggerCheckSuppression({
        github,
        owner: "Azure",
        repo: "azure-rest-api-specs",
        pullNumber: 123,
        checkName: "Swagger Avocado",
        getSuppressionsImpl,
      }),
    ).resolves.toEqual({
      skip: true,
      reason: suppression.reason,
    });

    expect(github.rest.pulls.listFiles).toHaveBeenCalledWith({
      owner: "Azure",
      repo: "azure-rest-api-specs",
      pull_number: 123,
      per_page: 100,
    });
    expect(getSuppressionsImpl).toHaveBeenCalledWith(
      "SwaggerAvocado",
      expect.stringMatching(/pull-request-head[\\/]specification[\\/]contoso[\\/]resource-manager/),
      {},
      { allowMissingPath: true, evaluateIf: false },
    );
    expect(getSuppressionsImpl).toHaveBeenCalledWith(
      "SwaggerAll",
      expect.stringContaining("old.json"),
      {},
      { allowMissingPath: true, evaluateIf: false },
    );
  });
});
