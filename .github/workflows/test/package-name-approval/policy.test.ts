import { describe, expect, it } from "vitest";
import {
  evaluatePackageNameAuthorization,
  parsePackageNamePolicy,
} from "../../src/package-name-approval/policy.ts";

describe("package-name policy", () => {
  it("projects only package-name-owned entries", () => {
    const policy = parsePackageNamePolicy({
      "global-approvers": ["global"],
      "data-plane-review-signoff": {
        team: "azure-data-plane-api-reviewers",
      },
      "typespec-suppressions-approved": {
        "data-plane": {
          team: "azure-data-plane-api-reviewers",
        },
      },
      "package-name-java-approved": {
        "management-plane": ["mgmt"],
        "data-plane": ["data"],
      },
      tier1: {
        "management-plane": ["dotnet", "java"],
        "data-plane": ["dotnet", "java", "python", "typescript"],
      },
    });

    expect(policy).toEqual({
      globalApprovers: ["global"],
      labels: {
        "package-name-java-approved": {
          "management-plane": ["mgmt"],
          "data-plane": ["data"],
        },
      },
      tier1: {
        "management-plane": ["dotnet", "java"],
        "data-plane": ["dotnet", "java", "python", "typescript"],
      },
    });
  });

  it.each([
    {
      "package-name-java-approved": {
        team: "azure-sdk-team",
      },
    },
    {
      "package-name-java-approved": {
        "data-plane": {
          team: "azure-sdk-team",
        },
      },
    },
  ])("rejects team policy on a package-name-owned key", (entry) => {
    expect(() => parsePackageNamePolicy(entry)).toThrow(
      /package-name-java-approved.*uses team approvers/,
    );
  });

  it("preserves explicit unprotected planes", () => {
    const policy = parsePackageNamePolicy({
      "package-name-go-approved": {
        "management-plane": ["mgmt"],
        "data-plane": "unprotected",
      },
    });

    expect(
      evaluatePackageNameAuthorization({
        policy,
        labelName: "package-name-go-approved",
        actor: "anyone",
        plane: "data-plane",
      }),
    ).toEqual({ status: "plane-unprotected", authorizedUsers: [] });
  });

  it("keeps missing package-name policies fail-closed", () => {
    const policy = parsePackageNamePolicy({
      "global-approvers": ["global"],
    });

    expect(
      evaluatePackageNameAuthorization({
        policy,
        labelName: "package-name-ruby-approved",
        actor: "someone",
        plane: "data-plane",
      }),
    ).toEqual({ status: "unprotected", authorizedUsers: [] });
  });

  it("authorizes configured users and global approvers case-insensitively", () => {
    const policy = parsePackageNamePolicy({
      "global-approvers": ["Global"],
      "package-name-java-approved": {
        "data-plane": ["JavaReviewer"],
      },
    });

    expect(
      evaluatePackageNameAuthorization({
        policy,
        labelName: "package-name-java-approved",
        actor: "javareviewer",
        plane: "data-plane",
      }).status,
    ).toBe("authorized");
    expect(
      evaluatePackageNameAuthorization({
        policy,
        labelName: "package-name-java-approved",
        actor: "global",
        plane: "data-plane",
      }).status,
    ).toBe("authorized");
  });
});
