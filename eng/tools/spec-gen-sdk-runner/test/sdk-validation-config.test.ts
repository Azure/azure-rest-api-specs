import path from "node:path";
import { fileURLToPath } from "node:url";
import { beforeEach, describe, expect, test, vi } from "vitest";
import * as log from "../src/log.ts";
import { resolveSdkRepoBranch, validateSdkValidationConfig } from "../src/sdk-validation-config.ts";

const currentFilePath = fileURLToPath(import.meta.url);
const fixturesRoot = path.resolve(path.dirname(currentFilePath), "fixtures");

describe("sdk-validation-config", () => {
  beforeEach(() => {
    vi.restoreAllMocks();
    // Silence log output during tests.
    vi.spyOn(log, "logMessage").mockImplementation(() => {});
  });

  describe("validateSdkValidationConfig", () => {
    test("accepts a valid config", () => {
      const { config, errors } = validateSdkValidationConfig({
        languages: {
          "azure-sdk-for-python": { "repo-branch": "users/alice/feature-x" },
        },
      });
      expect(errors).toEqual([]);
      expect(config?.languages["azure-sdk-for-python"]?.["repo-branch"]).toBe(
        "users/alice/feature-x",
      );
    });

    test("rejects null/undefined", () => {
      expect(validateSdkValidationConfig(null).errors.length).toBeGreaterThan(0);
      expect(validateSdkValidationConfig(undefined).errors.length).toBeGreaterThan(0);
    });

    test("rejects non-mapping root", () => {
      expect(validateSdkValidationConfig("nope").errors.length).toBeGreaterThan(0);
      expect(validateSdkValidationConfig([]).errors.length).toBeGreaterThan(0);
    });

    test("rejects unknown top-level key", () => {
      const { errors } = validateSdkValidationConfig({ languages: {}, other: 1 });
      expect(errors.some((e) => e.includes("other"))).toBe(true);
    });

    test("requires the 'languages' mapping", () => {
      const { errors } = validateSdkValidationConfig({});
      expect(errors.some((e) => e.includes("languages"))).toBe(true);
    });

    test("rejects an unknown SDK language", () => {
      const { errors } = validateSdkValidationConfig({
        languages: { "azure-sdk-for-cobol": { "repo-branch": "x" } },
      });
      expect(errors.some((e) => e.includes("azure-sdk-for-cobol"))).toBe(true);
    });

    test("rejects an unknown per-language setting", () => {
      const { errors } = validateSdkValidationConfig({
        languages: { "azure-sdk-for-python": { branch: "x" } },
      });
      expect(errors.some((e) => e.includes("branch"))).toBe(true);
    });

    test("rejects a non-string repo-branch", () => {
      const { errors } = validateSdkValidationConfig({
        languages: { "azure-sdk-for-python": { "repo-branch": 5 } },
      });
      expect(errors.length).toBeGreaterThan(0);
    });

    test("rejects an invalid branch name (refs/ prefix)", () => {
      const { errors } = validateSdkValidationConfig({
        languages: { "azure-sdk-for-python": { "repo-branch": "refs/heads/x" } },
      });
      expect(errors.length).toBeGreaterThan(0);
    });
  });

  describe("resolveSdkRepoBranch", () => {
    test("returns the project-level pin", () => {
      const branch = resolveSdkRepoBranch(
        "specification/branchpin-project/Svc.Management/tspconfig.yaml",
        "azure-sdk-for-python",
        fixturesRoot,
      );
      expect(branch).toBe("users/alice/feature-x");
    });

    test("falls back to the service-level pin when no project file exists", () => {
      const branch = resolveSdkRepoBranch(
        "specification/branchpin-service/Svc.Management/tspconfig.yaml",
        "azure-sdk-for-python",
        fixturesRoot,
      );
      expect(branch).toBe("users/bob/svc-branch");
    });

    test("uses the plane-level pin before the service-level pin", () => {
      const branch = resolveSdkRepoBranch(
        "specification/branchpin-plane/resource-manager/ProjectWithoutOverride/tspconfig.yaml",
        "azure-sdk-for-python",
        fixturesRoot,
      );
      expect(branch).toBe("users/alice/plane-branch");
    });

    test("uses the project-level pin before the plane-level pin", () => {
      const branch = resolveSdkRepoBranch(
        "specification/branchpin-plane/resource-manager/ProjectWithOverride/tspconfig.yaml",
        "azure-sdk-for-python",
        fixturesRoot,
      );
      expect(branch).toBe("users/alice/project-branch");
    });

    test("resolves plane precedence from a Windows-style spec path", () => {
      const branch = resolveSdkRepoBranch(
        "specification\\branchpin-plane\\resource-manager\\ProjectWithoutOverride\\tspconfig.yaml",
        "azure-sdk-for-python",
        fixturesRoot,
      );
      expect(branch).toBe("users/alice/plane-branch");
    });

    test("treats an explicit 'main' pin as no-op (undefined)", () => {
      const branch = resolveSdkRepoBranch(
        "specification/branchpin-main/Svc.Management/tspconfig.yaml",
        "azure-sdk-for-python",
        fixturesRoot,
      );
      expect(branch).toBeUndefined();
    });

    test("warns and uses main when the project-level config is invalid", () => {
      const branch = resolveSdkRepoBranch(
        "specification/branchpin-invalid/Svc.Management/tspconfig.yaml",
        "azure-sdk-for-python",
        fixturesRoot,
      );

      expect(branch).toBeUndefined();
      expect(log.logMessage).toHaveBeenCalledWith(
        expect.stringContaining("using 'main' for azure-sdk-for-python"),
        log.LogLevel.Warn,
      );
    });

    test("returns undefined when no config file exists", () => {
      const branch = resolveSdkRepoBranch(
        "specification/branchpin-none/Svc.Management/tspconfig.yaml",
        "azure-sdk-for-python",
        fixturesRoot,
      );
      expect(branch).toBeUndefined();
    });

    test("returns undefined for a language not listed in the config", () => {
      const branch = resolveSdkRepoBranch(
        "specification/branchpin-project/Svc.Management/tspconfig.yaml",
        "azure-sdk-for-go",
        fixturesRoot,
      );
      expect(branch).toBeUndefined();
    });
  });
});
