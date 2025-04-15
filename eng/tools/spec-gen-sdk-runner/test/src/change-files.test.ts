import { describe, test, expect, vi, beforeEach } from "vitest";
import { detectChangedSpecConfigFiles } from "../../src/change-files.js";
import * as utils from "../../src/utils.js";
import { logMessage } from "../../src/log.js";
import { SpecGenSdkCmdInput } from "../../src/types.js";

vi.mock("../../src/utils.js", () => ({
  getChangedFiles: vi.fn(),
  searchRelatedParentFolders: vi.fn(),
  searchSharedLibrary: vi.fn(),
  searchRelatedTypeSpecProjectBySharedLibrary: vi.fn().mockReturnValue({}),
  groupPathsByService: vi.fn(),
  createCombinedSpecs: vi.fn(),
}));

vi.mock("../src/log.js", () => ({
  logMessage: vi.fn(),
}));

describe("detectChangedSpecConfigFiles", () => {
  const mockCommandInput: SpecGenSdkCmdInput = {
      localSpecRepoPath: "/path/to/spec-repo",
      workingFolder: "",
      runMode: "",
      localSdkRepoPath: "",
      sdkRepoName: "",
      sdkLanguage: "",
      specCommitSha: "",
      specRepoHttpsUrl: ""
  };

  beforeEach(() => {
    vi.clearAllMocks();
  });

  test("should return an empty array if no files are changed", () => {
    vi.mocked(utils.getChangedFiles).mockReturnValue([]);
    const result = detectChangedSpecConfigFiles(mockCommandInput);
    expect(result).toEqual([]);
    expect(logMessage).toHaveBeenCalledWith("No files changed in the PR");
  });

  test("should filter and process changed files correctly", () => {
    vi.mocked(utils.getChangedFiles).mockReturnValue([
      "specification/service1/resource-manager/readme.md",
      "specification/service1/resource-manager/tspconfig.yaml",
      "specification/service2/data-plane/readme.md",
      "specification/service2/data-plane/tspconfig.yaml",
    ]);

    vi.mocked(utils.searchRelatedParentFolders).mockImplementation((_fileList, options) => {
      if (options.searchFileRegex?.toString() === /^readme.md$/.toString()) {
        return {
          "specification/service1/resource-manager": ["readme.md"],
          "specification/service2/data-plane": ["readme.md"],
        };
      }
      if (options.searchFileRegex?.toString() === /^tspconfig.yaml$/.toString()) {
        return {
          "specification/service1/resource-manager": ["tspconfig.yaml"],
          "specification/service2/data-plane": ["tspconfig.yaml"],
        };
      }
      return {
        "specification/service1/resource-manager": [],
        "specification/service2/data-plane": [],
      };
    });

    vi.mocked(utils.groupPathsByService).mockReturnValue(
      new Map([
        [
          "service1",
          {
            resourceManagerPaths: [{ path: "specification/service1/resource-manager" }],
            dataPlanePaths: [],
            managementPaths: [],
            otherTypeSpecPaths: [],
          },
        ],
        [
          "service2",
          {
            resourceManagerPaths: [],
            dataPlanePaths: [{ path: "specification/service2/data-plane" }],
            managementPaths: [],
            otherTypeSpecPaths: [],
          },
        ],
      ])
    );

    vi.mocked(utils.createCombinedSpecs).mockImplementation((readmePath, typespecPaths) => {
      return [
        {
          specs: [readmePath, ...typespecPaths],
          readmeMd: `${readmePath}/readme.md`,
          typespecProject: `${typespecPaths[0]}/tspconfig.yaml`,
        },
      ];
    });

    const result = detectChangedSpecConfigFiles(mockCommandInput);

    expect(result).toHaveLength(2);
    expect(result[0]).toEqual({
      specs: ["specification/service1/resource-manager/readme.md", "specification/service1/resource-manager/tspconfig.yaml"],
      readmeMd: "specification/service1/resource-manager/readme.md",
      typespecProject: "specification/service1/resource-manager/tspconfig.yaml",
    });
    expect(result[1]).toEqual({
      specs: ["specification/service2/data-plane/readme.md", "specification/service2/data-plane/tspconfig.yaml"],
      readmeMd: "specification/service2/data-plane/readme.md",
      typespecProject: "specification/service2/data-plane/tspconfig.yaml",
    });
  });

  test("should handle unmatched paths correctly", () => {
    vi.mocked(utils.getChangedFiles).mockReturnValue([
      "specification/service3/resource-manager/readme.md",
    ]);

    vi.mocked(utils.searchRelatedParentFolders).mockReturnValue({});
    vi.mocked(utils.groupPathsByService).mockReturnValue(new Map());

    const result = detectChangedSpecConfigFiles(mockCommandInput);

    expect(result).toHaveLength(1);
    expect(result[0]).toEqual({
      specs: [],
      readmeMd: "specification/service3/resource-manager/readme.md",
    });
  });
});