import { describe, test, expect } from "vitest";
import { isReleaseBranch } from "../src/branch.js";

describe("isReleaseBranch", () => {
  test("returns true for main branch", () => {
    expect(isReleaseBranch("main")).toBe(true);
  });

  test("returns true for RPSaaSMaster branch", () => {
    expect(isReleaseBranch("RPSaaSMaster")).toBe(true);
  });

  test("returns true for release branches", () => {
    expect(isReleaseBranch("release")).toBe(true);
    expect(isReleaseBranch("release-v1.0")).toBe(true);
    expect(isReleaseBranch("release/feature")).toBe(true);
    expect(isReleaseBranch("releasebranch")).toBe(true);
  });

  test("returns true for ARMCoreRPDev branch", () => {
    expect(isReleaseBranch("ARMCoreRPDev")).toBe(true);
  });

  test("returns false for feature branches", () => {
    expect(isReleaseBranch("feature/new-feature")).toBe(false);
    expect(isReleaseBranch("bugfix/fix-issue")).toBe(false);
    expect(isReleaseBranch("develop")).toBe(false);
    expect(isReleaseBranch("code-cleanup-classes")).toBe(false);
  });

  test("returns false for empty or invalid branch names", () => {
    expect(isReleaseBranch("")).toBe(false);
    expect(isReleaseBranch(" ")).toBe(false);
    expect(isReleaseBranch("test-branch")).toBe(false);
  });
});
