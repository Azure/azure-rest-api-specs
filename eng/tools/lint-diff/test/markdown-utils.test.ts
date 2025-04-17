import { beforeEach, test, describe, vi, Mock, expect } from "vitest";
import { readFile } from "fs/promises";
import { join } from "node:path";

import axios from "axios";

import {
  deduplicateTags,
  getDocRawUrl,
  getInputFiles,
  getDefaultTag,
  getAllTags,
  getOpenapiType,
  getTagsAndInputFiles,
  getRelatedArmRpcFromDoc,
} from "../src/markdown-utils.js";

vi.mock("axios");

function isWindows(): boolean {
  return process.platform === "win32";
}

describe("deduplicateTags", () => {
  // Original comment describing deduplicateTags
  // if one tag 'A' 's input files contains all the input files of Tag 'B' , then B tag will be de-duplicated

  test("deduplicates tags", () => {
    const tags = [
      { tagName: "tag1", inputFiles: ["file1", "file2"] },
      { tagName: "tag2", inputFiles: ["file1"] }, // Covered in tag1
      { tagName: "tag3", inputFiles: ["file2"] }, // Covered in tag2
      { tagName: "tag4", inputFiles: ["file3"] },
    ];

    const deduplicatedTags = deduplicateTags(tags);
    expect(deduplicatedTags).toEqual(["tag4", "tag1"]);
  });
});

describe("getInputFiles", () => {
  test("returns input files for a readme content's tag", async () => {
    const readmeContent = await readFile(join(__dirname, "fixtures/getInputFiles/readme.md"), {
      encoding: "utf-8",
    });

    const inputFiles = await getInputFiles(readmeContent, "package-2022-12-01");

    expect(inputFiles).toEqual(["Azure.Contoso.WidgetManager/stable/2022-12-01/widgets.json"]);
  });

  test("returns empty array when no input files are found", async () => {
    const readmeContent = await readFile(join(__dirname, "fixtures/getInputFiles/readme.md"), {
      encoding: "utf-8",
    });

    const inputFiles = await getInputFiles(readmeContent, "TAG-NOT-FOUND");

    expect(inputFiles).toEqual([]);
  });
});

describe("getDocRawUrl", () => {
  test("returns the expected doc url", () => {
    const docUrl = getDocRawUrl("Post201Response");

    expect(docUrl).toEqual(
      "https://raw.githubusercontent.com/Azure/azure-openapi-validator/main/docs/post201-response.md",
    );
  });

  test("returns N/A on FATAL", () => {
    const docUrl = getDocRawUrl("FATAL");

    expect(docUrl).toEqual("N/A");
  });
});

describe("getDefaultTag", () => {
  test("returns default tag when there is a Basic Information header", async () => {
    const readmeContent = await readFile(
      join(__dirname, "fixtures/getDefaultTag/hasBasicInformation.md"),
      {
        encoding: "utf-8",
      },
    );
    6;

    const defaultTag = getDefaultTag(readmeContent);

    expect(defaultTag).toEqual("package-2022-12-01");
  });

  test("returns default tag when there is no Basic Information header", async () => {
    const readmeContent = await readFile(
      join(__dirname, "fixtures/getDefaultTag/noBasicInformation.md"),
      {
        encoding: "utf-8",
      },
    );

    const defaultTag = getDefaultTag(readmeContent);

    expect(defaultTag).toEqual("package-2023-07-preview");
  });

  test("returns empty string when there is no default tag", async () => {
    const readmeContent = await readFile(
      join(__dirname, "fixtures/getDefaultTag/noDefaultTag.md"),
      {
        encoding: "utf-8",
      },
    );

    const defaultTag = getDefaultTag(readmeContent);

    expect(defaultTag).toEqual("");
  });
});

describe("getAllTags", () => {
  test("returns all tags", async () => {
    const readmeContent = await readFile(join(__dirname, "fixtures/getAllTags/readme.md"), {
      encoding: "utf-8",
    });

    const tags = getAllTags(readmeContent);

    expect(tags).toEqual([
      "package-preview-2024-01",
      "package-preview-2023-08",
      "package-preview-2023-07",
      "package-preview-2023-04",
      "package-preview-2023-01",
      "package-2023-03",
      "package-2021-08",
      "package-preview-2021-08",
      "package-preview-2021-07",
      "package-2021-04-only",
      "package-preview-2021-01",
      "package-2019-06-preview",
      "package-2019-06",
      "package-2019-03",
      "package-preview-2019-05",
      "package-2018-05",
      "package-2018-05-preview",
    ]);
  });
});

describe("getOpenapiType", () => {
  test("openapi-type found and valid", async () => {
    const markdownFile = join(__dirname, "fixtures/getOpenapiType/type-found-and-valid.md");
    const openapiType = await getOpenapiType(markdownFile);

    expect(openapiType).toEqual("data-plane");
  });

  test.skipIf(isWindows())("openapi-type found but not valid", async () => {
    const markdownFile = join(
      __dirname,
      "fixtures/getOpenapiType/specification/service1/data-plane/type-found-not-valid-readme.md",
    );
    const openapiType = await getOpenapiType(markdownFile);

    expect(openapiType).toEqual("data-plane");
  });

  test.skipIf(isWindows())("openapi-type not found, type arm", async () => {
    const markdownFile = join(
      __dirname,
      "fixtures/getOpenapiType/specification/service1/resource-manager/inferred-resource-manager-readme.md",
    );
    const openApiType = await getOpenapiType(markdownFile);
    expect(openApiType).toEqual("arm");
  });
  test.skipIf(isWindows())("openapi-type not found, type data-plane", async () => {
    const markdownFile = join(
      __dirname,
      "fixtures/getOpenapiType/specification/service1/data-plane/inferred-data-plane-readme.md",
    );
    const openApiType = await getOpenapiType(markdownFile);
    expect(openApiType).toEqual("data-plane");
  });

  test("openapi-type not found, type default", async () => {
    const markdownFile = join(__dirname, "fixtures/getOpenapiType/default.md");
    const openApiType = await getOpenapiType(markdownFile);
    expect(openApiType).toEqual("default");
  });
});

describe("getTagsAndInputFiles", () => {
  test("gets accurate input files for tag", async () => {
    const readmeContent = await readFile(
      join(__dirname, "fixtures/getTagsAndInputFiles/readme.md"),
      { encoding: "utf-8" },
    );

    const actual = await getTagsAndInputFiles(["package-preview-2019-05"], readmeContent);
    expect(actual.length).toEqual(1);
    expect(actual[0].tagName).toEqual("package-preview-2019-05");
    expect(actual[0].inputFiles).toEqual([
      "Microsoft.AlertsManagement/preview/2019-05-05-preview/ActionRules.json",
      "Microsoft.AlertsManagement/preview/2019-05-05-preview/AlertsManagement.json",
      "Microsoft.AlertsManagement/preview/2019-05-05-preview/SmartGroups.json",
    ]);
  });
});

describe("getRelatedArmRpcFromDoc", () => {
  // Tests are run sequentially to avoid concurrency issues with axios mocking
  beforeEach(() => {
    (axios.get as Mock).mockReset();
  });

  async function mockResponseFile(fileName: string): Promise<void> {
    const content = await readFile(join(__dirname, "fixtures/getRelatedArmRpcFromDoc", fileName), {
      encoding: "utf-8",
    });

    (axios.get as Mock).mockResolvedValue({
      data: content,
    });
  }

  test("returns empty array on FATAL", async () => {
    const rule = await getRelatedArmRpcFromDoc("FATAL");

    expect(rule).toEqual([]);
  });

  test("returns a rule from the cache", async () => {
    await mockResponseFile("lro-patch202.md");

    await getRelatedArmRpcFromDoc("LroPatch202");
    await getRelatedArmRpcFromDoc("LroPatch202");

    expect((axios.get as Mock).mock.calls.length).toBe(1);
  });

  test("returns an empty array when no rules are found", async () => {
    await mockResponseFile("api-host.md");
    const rules = await getRelatedArmRpcFromDoc("ApiHost");
    expect(rules).toEqual([]);
  });

  test("returns rules when a list is found", async () => {
    await mockResponseFile("system-data-definitions-common-types.md");
    const rules = await getRelatedArmRpcFromDoc("SystemDataDefinitionsCommonTypes");

    expect(rules).toEqual(["RPC-SystemData-V1-01", "RPC-SystemData-V1-02"]);
  });

  test("returns rules when a list with commas is found", async () => {
    await mockResponseFile("lro-patch202.md");
    const rules = await getRelatedArmRpcFromDoc("LroPatch202");

    expect(rules).toEqual(["RPC-Patch-V1-06", "RPC-Async-V1-08"]);
  });

  test("returns an empty set when the docUrl is not found", async () => {
    (axios.get as Mock).mockRejectedValue(new Error("404 Not Found"));
    const rules = await getRelatedArmRpcFromDoc("DoesNotExist");

    expect(rules).toEqual([]);
  });

  test("does not throw on axios errors", () => {
    (axios.get as Mock).mockRejectedValue(new Error("404 Not Found"));

    expect(async () => await getRelatedArmRpcFromDoc("DoesNotExist")).not.toThrow();
  });
});
