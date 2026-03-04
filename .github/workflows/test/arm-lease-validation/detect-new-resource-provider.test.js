import { afterEach, describe, expect, it, vi } from "vitest";
import { createMockCore, createMockContext } from "../mocks.js";

/** @type {import("vitest").MockedFunction<import("simple-git").SimpleGit["raw"]>} */
const mockRaw = vi.hoisted(() => vi.fn().mockResolvedValue(""));

vi.mock("simple-git", () => ({
  simpleGit: vi.fn().mockReturnValue({ raw: mockRaw }),
}));

vi.mock("../../src/arm-lease-validation/detect-arm-leases.js", () => ({
  checkLease: vi.fn().mockResolvedValue(false),
}));

vi.mock("../../src/arm-lease-validation/detect-new-resource-types.js", () => ({
  detectNewResourceTypes: vi.fn().mockResolvedValue([]),
}));

import * as changedFiles from "../../../shared/src/changed-files.js";
import { checkLease } from "../../src/arm-lease-validation/detect-arm-leases.js";
import { detectNewResourceTypes } from "../../src/arm-lease-validation/detect-new-resource-types.js";
import detectNewResourceProvider from "../../src/arm-lease-validation/detect-new-resource-provider.js";

const core = createMockCore();
const context = createMockContext();

describe("detectNewResourceProvider", () => {
  afterEach(() => {
    vi.clearAllMocks();
    delete process.env.GITHUB_WORKSPACE;
  });

  it("returns no-new-rp when all RP namespaces exist in base branch", async () => {
    process.env.GITHUB_WORKSPACE = "/fake/repo";
    const rmFile =
      "specification/compute/resource-manager/Microsoft.Compute/stable/2024-01-01/compute.json";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([rmFile]);

    // Pre-check: file exists in base → not brand new
    vi.mocked(mockRaw).mockResolvedValue(rmFile);

    const result = await detectNewResourceProvider({ context, core });

    expect(result.status).toBe("no-new-rp");
    expect(result.labelActions.ARMModelingReviewRequired).toBe("remove");
    expect(core.setFailed).not.toHaveBeenCalled();
  });

  it("returns new-rp-all-leases-valid when new RP has valid lease", async () => {
    process.env.GITHUB_WORKSPACE = "/fake/repo";
    const rmFile =
      "specification/newservice/resource-manager/Microsoft.NewService/stable/2025-01-01/api.json";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([rmFile]);

    // Pre-check: no files in base → brand new; namespace doesn't exist in base directories
    vi.mocked(mockRaw).mockResolvedValue("");
    vi.mocked(checkLease).mockResolvedValue(true);

    const result = await detectNewResourceProvider({ context, core });

    expect(result.status).toBe("new-rp-all-leases-valid");
    expect(result.labelActions.ARMModelingReviewRequired).toBe("remove");
    expect(result.labelActions.ARMModelingAutoSignedOff).toBe("add");
    expect(core.setFailed).not.toHaveBeenCalled();
    expect(core.info).toHaveBeenCalledWith(expect.stringContaining("valid ARM lease"));
    expect(checkLease).toHaveBeenCalledWith("newservice", "Microsoft.NewService", "");
  });

  it("returns new-rp-invalid-lease and calls setFailed when lease is invalid", async () => {
    process.env.GITHUB_WORKSPACE = "/fake/repo";
    const rmFile =
      "specification/badservice/resource-manager/Microsoft.BadService/preview/2025-01-01/api.json";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([rmFile]);
    vi.mocked(mockRaw).mockResolvedValue("");
    vi.mocked(checkLease).mockResolvedValue(false);

    const result = await detectNewResourceProvider({ context, core });

    expect(result.status).toBe("new-rp-invalid-lease");
    expect(result.labelActions.ARMModelingReviewRequired).toBe("add");
    expect(result.labelActions.ARMModelingAutoSignedOff).toBe("remove");
    expect(core.setFailed).toHaveBeenCalledTimes(1);
    expect(core.setFailed).toHaveBeenCalledWith(
      expect.stringContaining("ARM API Modeling Office Hours"),
    );
    expect(core.error).toHaveBeenCalledWith(expect.stringContaining("Microsoft.BadService"));
  });

  it("fails when at least one of multiple new RPs has invalid lease", async () => {
    process.env.GITHUB_WORKSPACE = "/fake/repo";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([
      "specification/svcA/resource-manager/Microsoft.SvcA/stable/2025-01-01/a.json",
      "specification/svcB/resource-manager/Microsoft.SvcB/stable/2025-01-01/b.json",
    ]);
    vi.mocked(mockRaw).mockResolvedValue("");

    // SvcA valid, SvcB invalid
    vi.mocked(checkLease).mockImplementation(async (orgName) => orgName === "svcA");

    const result = await detectNewResourceProvider({ context, core });

    expect(result.status).toBe("new-rp-invalid-lease");
    expect(result.labelActions.ARMModelingReviewRequired).toBe("add");
    expect(core.setFailed).toHaveBeenCalledTimes(1);
    expect(core.setFailed).toHaveBeenCalledWith(
      expect.stringContaining("without a valid ARM lease"),
    );
  });

  it("passes when all multiple new RPs have valid leases", async () => {
    process.env.GITHUB_WORKSPACE = "/fake/repo";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([
      "specification/svcA/resource-manager/Microsoft.SvcA/stable/2025-01-01/a.json",
      "specification/svcB/resource-manager/Microsoft.SvcB/stable/2025-01-01/b.json",
    ]);
    vi.mocked(mockRaw).mockResolvedValue("");
    vi.mocked(checkLease).mockResolvedValue(true);

    const result = await detectNewResourceProvider({ context, core });

    expect(result.status).toBe("new-rp-all-leases-valid");
    expect(result.labelActions.ARMModelingReviewRequired).toBe("remove");
    expect(result.labelActions.ARMModelingAutoSignedOff).toBe("add");
    expect(core.setFailed).not.toHaveBeenCalled();
  });

  it("passes serviceName to checkLease when present", async () => {
    process.env.GITHUB_WORKSPACE = "/fake/repo";
    const rmFile =
      "specification/svc/resource-manager/Microsoft.Svc/ComputeRP/stable/2025-01-01/api.json";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([rmFile]);
    vi.mocked(mockRaw).mockResolvedValue("");
    vi.mocked(checkLease).mockResolvedValue(true);

    await detectNewResourceProvider({ context, core });

    expect(checkLease).toHaveBeenCalledWith("svc", "Microsoft.Svc", "ComputeRP");
  });

  it("returns Remove for ARMModelingReviewRequired when no new RPs", async () => {
    process.env.GITHUB_WORKSPACE = "/fake/repo";
    const rmFile =
      "specification/compute/resource-manager/Microsoft.Compute/stable/2024-01-01/compute.json";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([rmFile]);
    vi.mocked(mockRaw).mockResolvedValue(rmFile);

    const result = await detectNewResourceProvider({ context, core });

    expect(result.labelActions.ARMModelingReviewRequired).toBe("remove");
    expect(result.labelActions.ARMModelingSignedOff).toBe("remove");
    expect(result.labelActions.ARMModelingAutoSignedOff).toBe("remove");
  });

  it("returns Add for ARMModelingReviewRequired when new RP has invalid lease", async () => {
    process.env.GITHUB_WORKSPACE = "/fake/repo";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([
      "specification/svc/resource-manager/Microsoft.Svc/stable/2025-01-01/api.json",
    ]);
    vi.mocked(mockRaw).mockResolvedValue("");
    vi.mocked(checkLease).mockResolvedValue(false);

    const result = await detectNewResourceProvider({ context, core });

    expect(result.labelActions.ARMModelingReviewRequired).toBe("add");
    expect(result.labelActions.ARMModelingSignedOff).toBe("remove");
    expect(result.labelActions.ARMModelingAutoSignedOff).toBe("remove");
  });

  it("returns Remove for ARMModelingReviewRequired when new RP has valid lease", async () => {
    process.env.GITHUB_WORKSPACE = "/fake/repo";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([
      "specification/svc/resource-manager/Microsoft.Svc/stable/2025-01-01/api.json",
    ]);
    vi.mocked(mockRaw).mockResolvedValue("");
    vi.mocked(checkLease).mockResolvedValue(true);

    const result = await detectNewResourceProvider({ context, core });

    expect(result.labelActions.ARMModelingReviewRequired).toBe("remove");
    expect(result.labelActions.ARMModelingSignedOff).toBe("remove");
    expect(result.labelActions.ARMModelingAutoSignedOff).toBe("add");
  });

  // ── New resource type detection (no new RP) ──────────────────────────

  it("checks for new resource types when no new RP is detected", async () => {
    process.env.GITHUB_WORKSPACE = "/fake/repo";
    const rmFile =
      "specification/compute/resource-manager/Microsoft.Compute/stable/2024-01-01/compute.json";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([rmFile]);
    vi.mocked(mockRaw).mockResolvedValue(rmFile);

    // detectNewResourceTypes returns new RT
    vi.mocked(detectNewResourceTypes).mockResolvedValue([
      { namespace: "Microsoft.Compute", orgName: "compute", newResourceTypes: [{ resourceType: "Microsoft.Compute/disks" }] },
    ]);
    vi.mocked(checkLease).mockResolvedValue(true);

    const result = await detectNewResourceProvider({ context, core });

    expect(result.status).toBe("new-rt-all-leases-valid");
    expect(result.labelActions.ARMModelingAutoSignedOff).toBe("add");
    expect(result.labelActions.ARMModelingReviewRequired).toBe("remove");
    expect(core.setFailed).not.toHaveBeenCalled();
  });

  it("adds ARMModelingReviewRequired when new RT has no valid lease", async () => {
    process.env.GITHUB_WORKSPACE = "/fake/repo";
    const rmFile =
      "specification/compute/resource-manager/Microsoft.Compute/stable/2024-01-01/compute.json";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([rmFile]);
    vi.mocked(mockRaw).mockResolvedValue(rmFile);

    vi.mocked(detectNewResourceTypes).mockResolvedValue([
      { namespace: "Microsoft.Compute", orgName: "compute", newResourceTypes: [{ resourceType: "Microsoft.Compute/disks" }] },
    ]);
    vi.mocked(checkLease).mockResolvedValue(false);

    const result = await detectNewResourceProvider({ context, core });

    expect(result.status).toBe("new-rt-invalid-lease");
    expect(result.labelActions.ARMModelingReviewRequired).toBe("add");
    expect(result.labelActions.ARMModelingAutoSignedOff).toBe("remove");
    expect(core.setFailed).toHaveBeenCalled();
  });

  it("returns no-new-rp when no new RTs detected either", async () => {
    process.env.GITHUB_WORKSPACE = "/fake/repo";
    const rmFile =
      "specification/compute/resource-manager/Microsoft.Compute/stable/2024-01-01/compute.json";

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([rmFile]);
    vi.mocked(mockRaw).mockResolvedValue(rmFile);
    vi.mocked(detectNewResourceTypes).mockResolvedValue([]);

    const result = await detectNewResourceProvider({ context, core });

    expect(result.status).toBe("no-new-rp");
    expect(result.labelActions.ARMModelingReviewRequired).toBe("remove");
    expect(result.labelActions.ARMModelingAutoSignedOff).toBe("remove");
  });
});