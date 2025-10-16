// @ts-check

import { describe, expect, test } from "vitest";
import {
  getSwaggersToProcess,
  indexMd,
  mappingJSONTemplate,
  parseSwaggerFilePath,
  repoJSONTemplate,
} from "../src/doc-preview.js";

describe("parseSwaggerFilePath", () => {
  test("throws null when given invalid path", () => {
    expect(() => parseSwaggerFilePath("invalid/path/to/swagger.json")).toThrow();
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
  test("returns empty arrays when no files match the expected pattern", () => {
    const files = ["invalid/path/to/swagger.json", "another/invalid/path/swagger.json"];
    const { selectedVersion, swaggersToProcess } = getSwaggersToProcess(files);
    expect(selectedVersion).toBeNull();
    expect(swaggersToProcess).toEqual([]);
  });

  test("skips files that do not match the expected pattern", () => {
    const files = [
      "specification/batch/data-plane/Azure.Batch/preview/2024-07-01.20.0/BatchService.json",
      "invalid/path/to/swagger.json",
    ];

    const { selectedVersion, swaggersToProcess } = getSwaggersToProcess(files);

    expect(selectedVersion).toEqual("2024-07-01.20.0");
    expect(swaggersToProcess).toEqual([
      "specification/batch/data-plane/Azure.Batch/preview/2024-07-01.20.0/BatchService.json",
    ]);
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
    const actual = repoJSONTemplate("test-repo", "1234");

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
    const repoName = "test-repo";
    const prNumber = "1234";
    const actual = indexMd(buildId, repoName, prNumber);

    expect(actual).toMatchInlineSnapshot(`
      "# Documentation Preview for swagger pipeline build #build-123

      Welcome to documentation preview for test-repo/pull/1234 
      created via the swagger pipeline.

      Your documentation may be viewed in the menu on the left hand side.

      If you have issues around documentation generation, please feel free to contact 
      us in the [Docs Support Teams Channel](https://aka.ms/ci-fix/api-docs-help)"
    `);
  });
});
