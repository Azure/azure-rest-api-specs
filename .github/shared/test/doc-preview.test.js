import { test, describe, expect } from "vitest";
import {
  parseSwaggerFilePath,
  getSwaggersToProcess,
  indexMd,
  mappingJSONTemplate,
  repoJSONTemplate,
} from "../src/doc-preview.js";

describe("parseSwaggerFilePath", () => {
  test("returns null for invalid path", () => {
    const result = parseSwaggerFilePath("invalid/path/to/swagger.json");
    expect(result).toBeNull();
  });

  test("parses valid swagger file path", () => {
    const path =
      "specification/batch/data-plane/Azure.Batch/preview/2024-07-01.20.0/BatchService.json";
    const result = parseSwaggerFilePath(path);

    expect(result).toEqual({
      path: path,
      serviceName: "batch",
      serviceType: "data-plane",
      resourceProvider: "Azure.Batch",
      releaseState: "preview",
      apiVersion: "2024-07-01.20.0",
      fileName: "BatchService.json",
    });
  });
});

describe("getSwaggersToProcess", () => {
  test("returns empty array for no files", () => {
    const { selectedVersion, swaggersToProcess } = getSwaggersToProcess([]);

    expect(selectedVersion).toEqual(null);
    expect(swaggersToProcess).toEqual([]);
  });

  test("returns swaggers to process for valid files", () => {
    const files = [
      "specification/batch/data-plane/Azure.Batch/preview/2024-07-01.20.0/BatchService.json",
    ];

    const { selectedVersion, swaggersToProcess } = getSwaggersToProcess(files);

    expect(selectedVersion).toEqual("2024-07-01.20.0");
    expect(swaggersToProcess).toEqual(files);
  });

  test("selects the latest version from multiple files with multiple versions", () => {
    const files = [
      "specification/batch/data-plane/Azure.Batch/preview/2024-07-01.20.0/BatchService.json",
      "specification/batch/data-plane/Azure.Batch/preview/2025-06-01/BatchService.json",
    ];

    const { selectedVersion, swaggersToProcess } = getSwaggersToProcess(files);

    expect(selectedVersion).toEqual("2025-06-01");
    expect(swaggersToProcess).toEqual([files[1]]);
  });
});

describe("repoJSONTemplate", () => {
  test("matches snapshot", () => {
    const actual = repoJSONTemplate({
      repoName: "test-repo",
      prNumber: "1234",
    });

    expect(actual).toMatchInlineSnapshot(`
      {
        "repo": [
          {
            "name": "_swagger_specs",
            "prNumber": "1234",
            "url": "https://github.com/test-repo",
          },
        ],
      }
    `);
  });
});

describe("mappingJSONTemplate", () => {
  test("matches snapshot", () => {
    const swaggers = [
      "specification/batch/data-plane/Azure.Batch/preview/2024-07-01.20.0/BatchService.json",
    ];
    const actual = mappingJSONTemplate(swaggers);

    expect(actual).toMatchInlineSnapshot(`
      {
        "enable_markdown_fragment": true,
        "formalize_url": true,
        "markdown_fragment_folder": "authored",
        "organizations": [
          {
            "default_toc_title": "Getting Started",
            "index": "index.md",
            "services": [
              {
                "swagger_files": [
                  {
                    "source": "_swagger_specs/specification/batch/data-plane/Azure.Batch/preview/2024-07-01.20.0/BatchService.json",
                  },
                ],
                "toc_title": "Documentation Preview",
                "url_group": "documentation-preview",
              },
            ],
            "version": "default",
          },
        ],
        "target_api_root_dir": "structured",
        "use_yaml_toc": true,
        "version_list": [
          "default",
        ],
      }
    `);
  });
});

describe("indexMd", () => {
  test("matches snapshot", () => {
    const buildId = "build-123";
    const key = {
      repoName: "test-repo",
      prNumber: "1234",
    };
    const actual = indexMd(buildId, key);

    expect(actual).toMatchInlineSnapshot(`
      "# Documentation Preview for swagger pipeline build #build-123

      Welcome to documentation preview for test-repo/pull/1234 
      created via the swagger pipeline.

      Your documentation may be viewed in the menu on the left hand side.

      If you have issues around documentation generation, please feel free to contact 
      us in the [Docs Support Teams Channel](https://teams.microsoft.com/l/channel/19%3A7506cc3e220f430ab89d992c7db5284f%40thread.skype/API%20Reference%20and%20Samples?groupId=de9ddba4-2574-4830-87ed-41668c07a1ca&tenantId=72f988bf-86f1-41af-91ab-2d7cd011db47)"
    `);
  });
});
