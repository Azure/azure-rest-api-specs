import { readFile } from "fs/promises";
import { join } from "node:path";
import { Mock, beforeEach, describe, expect, test, vi } from "vitest";

import { Readme } from "@azure-tools/specs-shared/readme";
import {
  deduplicateTags,
  getDefaultTag,
  getDocRawUrl,
  getOpenapiType,
  getRelatedArmRpcFromDoc,
} from "../src/markdown-utils.js";

vi.stubGlobal("fetch", vi.fn());

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
    const defaultTag = await getDefaultTag(
      new Readme(join(__dirname, "fixtures/getDefaultTag/hasBasicInformation.md")),
    );

    expect(defaultTag).toEqual("package-2022-12-01");
  });

  test("returns default tag when there is no Basic Information header", async () => {
    const defaultTag = await getDefaultTag(
      new Readme(join(__dirname, "fixtures/getDefaultTag/noBasicInformation.md")),
    );

    expect(defaultTag).toEqual("package-2023-07-preview");
  });

  test("returns empty string when there is no default tag", async () => {
    const defaultTag = await getDefaultTag(
      new Readme(join(__dirname, "fixtures/getDefaultTag/noDefaultTag.md")),
    );

    expect(defaultTag).toEqual("");
  });

  test.each([
    {
      description: "without Basic Information header",
      readmeContent: `# Some header
This should be parsed as a string, not a Date object.
\`\`\`yaml
tag: 2025-01-01
\`\`\`
`,
    },
    {
      description: "with Basic Information header",
      readmeContent: `# Basic Information
This should be parsed as a string, not a Date object.
\`\`\`yaml
tag: 2025-01-01
\`\`\`
`,
    },
  ])(
    "returns a string for default tag even when the tag is formatted like a date ($description)",
    async ({ readmeContent }) => {
      const defaultTag = await getDefaultTag(new Readme("readme", { content: readmeContent }));

      expect(defaultTag).not.toBeInstanceOf(Date);
      expect(defaultTag).toBeTypeOf("string");
      expect(defaultTag).toEqual("2025-01-01");
    },
  );
});

describe("getOpenapiType", () => {
  test("openapi-type found and valid", async () => {
    const markdownFile = join(__dirname, "fixtures/getOpenapiType/type-found-and-valid.md");
    const readme = new Readme(markdownFile);
    const openapiType = await getOpenapiType(readme);

    expect(openapiType).toEqual("data-plane");
  });

  test.skipIf(isWindows())("openapi-type found but not valid", async () => {
    const markdownFile = join(
      __dirname,
      "fixtures/getOpenapiType/specification/service1/data-plane/type-found-not-valid-readme.md",
    );
    const readme = new Readme(markdownFile);
    const openapiType = await getOpenapiType(readme);

    expect(openapiType).toEqual("data-plane");
  });

  test.skipIf(isWindows())("openapi-type not found, type arm", async () => {
    const markdownFile = join(
      __dirname,
      "fixtures/getOpenapiType/specification/service1/resource-manager/inferred-resource-manager-readme.md",
    );
    const readme = new Readme(markdownFile);
    const openapiType = await getOpenapiType(readme);
    expect(openapiType).toEqual("arm");
  });
  test.skipIf(isWindows())("openapi-type not found, type data-plane", async () => {
    const markdownFile = join(
      __dirname,
      "fixtures/getOpenapiType/specification/service1/data-plane/inferred-data-plane-readme.md",
    );
    const readme = new Readme(markdownFile);
    const openapiType = await getOpenapiType(readme);
    expect(openapiType).toEqual("data-plane");
  });

  test("openapi-type not found, type default", async () => {
    const markdownFile = join(__dirname, "fixtures/getOpenapiType/default.md");
    const readme = new Readme(markdownFile);
    const openapiType = await getOpenapiType(readme);
    expect(openapiType).toEqual("default");
  });
});

describe("getRelatedArmRpcFromDoc", () => {
  // Tests are run sequentially to avoid concurrency issues with fetch mocking
  beforeEach(() => {
    (fetch as Mock).mockReset();
  });

  async function mockResponseFile(fileName: string): Promise<void> {
    const content = await readFile(join(__dirname, "fixtures/getRelatedArmRpcFromDoc", fileName), {
      encoding: "utf-8",
    });

    (fetch as Mock).mockResolvedValue({
      ok: true,
      text: () => Promise.resolve(content),
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

    expect((fetch as Mock).mock.calls.length).toBe(1);
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
    (fetch as Mock).mockResolvedValue({
      ok: false,
      status: 404,
      statusText: "Not Found",
    });
    const rules = await getRelatedArmRpcFromDoc("DoesNotExist");

    expect(rules).toEqual([]);
  });

  test("does not throw on fetch errors", () => {
    (fetch as Mock).mockRejectedValue(new Error("404 Not Found"));

    expect(async () => await getRelatedArmRpcFromDoc("DoesNotExist")).not.toThrow();
  });
});
