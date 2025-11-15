import path from "path";
import { simpleGit } from "simple-git";
import { describe, expect, it } from "vitest";
import { processFilesToSpecificationList } from "../src/runner.js";

const ROOT = path.resolve(__dirname, "..", "test", "fixtures");

describe("file processing", () => {
  it("should process a basic set of files and return a list of swagger files only", async () => {
    const changedFiles = [
      "specification/serviceB/data-plane/service.B/preview/2025-07-01-preview/serviceBspec.json",
      "specification/serviceB/data-plane/service.B/stable/2025-06-01/serviceBspec.json",
      "specification/serviceB/data-plane/service.B/readme.md",
    ];

    expect(processFilesToSpecificationList(ROOT, changedFiles)).resolves.toMatchInlineSnapshot(`
      [
        "specification/serviceB/data-plane/service.B/preview/2025-07-01-preview/serviceBspec.json",
        "specification/serviceB/data-plane/service.B/stable/2025-06-01/serviceBspec.json",
      ]
    `);
  });

  it("should process a larger set of files and return a list of expected resolved swagger files", async () => {
    // Simulate a change to each file under "fixtures".
    // Use simpleGit() instead of readdir(), since we always want git-style (POSIX) paths
    const changedFiles = (await simpleGit(ROOT).raw(["ls-files"])).trim().split("\n").sort();

    await expect(processFilesToSpecificationList(ROOT, changedFiles)).resolves
      .toMatchInlineSnapshot(`
      [
        "specification/serviceA/resource-manager/service.A/stable/2025-06-01/serviceAspec.json",
        "specification/serviceB/data-plane/service.B/preview/2025-07-01-preview/serviceBspec.json",
        "specification/serviceB/data-plane/service.B/stable/2025-06-01/serviceBspec.json",
      ]
    `);
  });

  it("should process the correct swagger file given only changed example files", async () => {
    const changedFiles = [
      "specification/serviceB/data-plane/service.B/preview/2025-07-01-preview/examples/CreateResource.json",
      "specification/serviceB/data-plane/service.B/stable/2025-06-01/examples/CreateResource.json",
    ];

    await expect(processFilesToSpecificationList(ROOT, changedFiles)).resolves
      .toMatchInlineSnapshot(`
      [
        "specification/serviceB/data-plane/service.B/preview/2025-07-01-preview/serviceBspec.json",
        "specification/serviceB/data-plane/service.B/stable/2025-06-01/serviceBspec.json",
      ]
    `);
  });

  it("should process the correct swagger file given only changed readme file", async () => {
    const changedFiles = ["specification/serviceB/data-plane/service.B/readme.md"];

    await expect(
      processFilesToSpecificationList(ROOT, changedFiles),
    ).resolves.toMatchInlineSnapshot(`[]`);
  });

  it("should handle deleted files without error", async () => {
    const changedFiles = [
      // existing spec
      "specification/serviceA/resource-manager/service.A/stable/2025-06-01/serviceAspec.json",
      // existing example
      "specification/serviceB/data-plane/service.B/stable/2025-06-01/examples/CreateResource.json",
      // non-existent spec. Should not throw and quietly omit
      "specification/serviceB/data-plane/service.B/stable/2025-06-01/serviceBspecDeleted.json",
      // non-existent example. Should not throw and quietly omit
      "specification/serviceB/data-plane/service.B/stable/2025-06-01/examples/CreateResourceDeleted.json",
      // non-existent example and containing version folder. Should not throw and quietly omit
      "specification/serviceB/data-plane/service.B/stable/2025-06-01-deleted/examples/CreateResource.json",
    ];

    await expect(processFilesToSpecificationList(ROOT, changedFiles)).resolves
      .toMatchInlineSnapshot(`
      [
        "specification/serviceA/resource-manager/service.A/stable/2025-06-01/serviceAspec.json",
        "specification/serviceB/data-plane/service.B/stable/2025-06-01/serviceBspec.json",
      ]
    `);
  });

  it("should skip examples outside preview and stable", async () => {
    const changedFiles = [
      // TypeSpec examples.  Should be silently ignored.
      "specification/serviceB/data-plane/service.B/examples/2025-06-01/CreateResource.json",
      "specification/serviceB/data-plane/service.B/examples/2025-07-01-preview/CreateResource.json",
    ];

    await expect(
      processFilesToSpecificationList(ROOT, changedFiles),
    ).resolves.toMatchInlineSnapshot(`[]`);
  });

  it("should handle examples in a subdirectory", async () => {
    const changedFiles = [
      "specification/serviceB/data-plane/service.B/preview/2025-07-01-preview/examples/subdir/ListResources.json",
      "specification/serviceB/data-plane/service.B/stable/2025-06-01/examples/subdir/ListResources.json",
    ];

    await expect(processFilesToSpecificationList(ROOT, changedFiles)).resolves
      .toMatchInlineSnapshot(`
      [
        "specification/serviceB/data-plane/service.B/preview/2025-07-01-preview/serviceBspec.json",
        "specification/serviceB/data-plane/service.B/stable/2025-06-01/serviceBspec.json",
      ]
    `);
  });
});
