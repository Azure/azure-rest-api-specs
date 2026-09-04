import fs from "node:fs";
import os from "node:os";
import path from "node:path";

import { beforeEach, describe, expect, it, vi } from "vitest";
import { getAzurePipelineArtifact } from "../src/artifacts.js";
import {
  downloadSdkChangesFromPipelineArtifact,
  readSdkChangesFromPipelineArtifact,
} from "../src/sdk-breaking-change-analysis.js";
import { createMockCore } from "./mocks.js";

vi.mock("../src/artifacts.js", async (importOriginal) => ({
  ...(await importOriginal()),
  getAzurePipelineArtifact: vi.fn(),
}));

const mockCore = createMockCore();

describe("sdk-breaking-change-analysis", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it("reads sdkChanges from the spec-gen-sdk pipeline artifact", async () => {
    const sdkChanges = { changes: "Removed operation", hasBreakingChange: true };
    vi.mocked(getAzurePipelineArtifact).mockResolvedValue({
      artifactData: JSON.stringify(sdkChanges),
    });

    const result = await readSdkChangesFromPipelineArtifact({
      detailsUrl: "https://dev.azure.com/project/_build/results?buildId=12345",
      core: mockCore,
    });

    expect(result).toEqual(sdkChanges);
    expect(getAzurePipelineArtifact).toHaveBeenCalledWith(
      expect.objectContaining({
        ado_build_id: "12345",
        ado_project_url: "https://dev.azure.com/project",
        artifactName: "spec-gen-sdk-artifact",
        artifactFileName: "spec-gen-sdk-artifact.json",
      }),
    );
  });

  it("downloads sdkChanges to the destination file", async () => {
    const sdkChanges = { changes: "Removed operation", hasBreakingChange: true };
    vi.mocked(getAzurePipelineArtifact).mockResolvedValue({
      artifactData: JSON.stringify(sdkChanges),
    });
    const temporaryDirectory = fs.mkdtempSync(path.join(os.tmpdir(), "sdk-changes-"));
    const destinationPath = path.join(temporaryDirectory, "nested", "sdk-changes.json");

    await downloadSdkChangesFromPipelineArtifact({
      detailsUrl: "https://dev.azure.com/project/_build/results?buildId=12345",
      destinationPath,
      core: mockCore,
    });

    expect(JSON.parse(fs.readFileSync(destinationPath, "utf8"))).toEqual(sdkChanges);
    fs.rmSync(temporaryDirectory, { recursive: true, force: true });
  });
});