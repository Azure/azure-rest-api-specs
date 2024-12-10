import { describe, it } from "vitest";
import { FolderStructureRule } from "../src/rules/folder-structure.js";
import { TsvTestHost } from "./tsv-test-host.js";
import { strict as assert } from "node:assert";

describe("folder-structure", function () {
  it("should fail if tspconfig has incorrect extension", async function () {
    let host = new TsvTestHost();
    host.globby = async () => {
      return ["/foo/bar/tspconfig.yml"];
    };

    const result = await new FolderStructureRule().execute(host, TsvTestHost.folder);
    assert(result.errorOutput);
    assert(result.errorOutput.includes("Invalid config file"));
  });

  it("should fail if folder under specification/ is capitalized", async function () {
    let host = new TsvTestHost();
    host.globby = async () => {
      return ["/foo/bar/tspconfig.yaml"];
    };
    host.normalizePath = () => {
      return "/gitroot";
    };

    const result = await new FolderStructureRule().execute(host, "/gitroot/specification/Foo/Foo");
    assert(result.errorOutput);
    assert(result.errorOutput.includes("must be lower case"));
  });

  it("should succeed if package folder has trailing slash", async function () {
    let host = new TsvTestHost();
    host.globby = async () => {
      return ["/foo/bar/tspconfig.yaml"];
    };
    host.normalizePath = () => {
      return "/gitroot";
    };

    const result = await new FolderStructureRule().execute(
      host,
      "/gitroot/specification/foo/Foo/Foo/",
    );
    assert(result.success);
  });

  it("should fail if package folder is more than 3 levels deep", async function () {
    let host = new TsvTestHost();
    host.globby = async () => {
      return ["/foo/bar/tspconfig.yaml"];
    };
    host.normalizePath = () => {
      return "/gitroot";
    };

    const result = await new FolderStructureRule().execute(
      host,
      "/gitroot/specification/foo/Foo/Foo/Foo",
    );
    assert(result.errorOutput);
    assert(result.errorOutput.includes("3 levels or less"));
  });

  it("should fail if second level folder not capitalized at after each '.' ", async function () {
    let host = new TsvTestHost();
    host.globby = async () => {
      return ["/foo/bar/tspconfig.yaml"];
    };
    host.normalizePath = () => {
      return "/gitroot";
    };

    const result = await new FolderStructureRule().execute(
      host,
      "/gitroot/specification/foo/Foo.foo",
    );
    assert(result.errorOutput);
    assert(result.errorOutput.includes("must be capitalized"));
  });

  it("should fail if second level folder is data-plane", async function () {
    let host = new TsvTestHost();
    host.globby = async () => {
      return ["/foo/bar/tspconfig.yaml"];
    };
    host.normalizePath = () => {
      return "/gitroot";
    };

    const result = await new FolderStructureRule().execute(
      host,
      "/gitroot/specification/foo/data-plane",
    );
    assert(result.errorOutput);
    assert(result.errorOutput.includes("must be capitalized"));
  });

  it("should fail if second level folder is resource-manager", async function () {
    let host = new TsvTestHost();
    host.globby = async () => {
      return ["/foo/bar/tspconfig.yaml"];
    };
    host.normalizePath = () => {
      return "/gitroot";
    };

    const result = await new FolderStructureRule().execute(
      host,
      "/gitroot/specification/foo/resource-manager",
    );
    assert(result.errorOutput);
    assert(result.errorOutput.includes("must be capitalized"));
  });

  it("should fail if Shared does not follow Management ", async function () {
    let host = new TsvTestHost();
    host.globby = async () => {
      return ["/foo/bar/tspconfig.yaml"];
    };
    host.normalizePath = () => {
      return "/gitroot";
    };

    const result = await new FolderStructureRule().execute(
      host,
      "/gitroot/specification/foo/Foo.Management.Foo.Shared",
    );
    assert(result.errorOutput);
    assert(result.errorOutput.includes("should follow"));
  });

  it("should fail if folder doesn't contain main.tsp nor client.tsp", async function () {
    let host = new TsvTestHost();
    host.globby = async () => {
      return ["/foo/bar/tspconfig.yaml"];
    };
    host.normalizePath = () => {
      return "/gitroot";
    };
    host.checkFileExists = async (file: string) => {
      if (file.includes("main.tsp")) {
        return false;
      } else if (file.includes("client.tsp")) {
        return false;
      }
      return true;
    };

    const result = await new FolderStructureRule().execute(
      host,
      "/gitroot/specification/foo/Foo.Management",
    );

    assert(result.errorOutput);
    assert(result.errorOutput.includes("must contain"));
  });

  it("should fail if folder doesn't contain examples when main.tsp exists", async function () {
    let host = new TsvTestHost();
    host.globby = async () => {
      return ["/foo/bar/tspconfig.yaml"];
    };
    host.normalizePath = () => {
      return "/gitroot";
    };
    host.checkFileExists = async (file: string) => {
      if (file.includes("main.tsp")) {
        return true;
      } else if (file.includes("examples")) {
        return false;
      }
      return true;
    };

    const result = await new FolderStructureRule().execute(
      host,
      "/gitroot/specification/foo/Foo.Management",
    );

    assert(result.errorOutput);
    assert(result.errorOutput.includes("must contain"));
  });

  it("should fail if non-shared folder doesn't contain tspconfig", async function () {
    let host = new TsvTestHost();
    host.globby = async () => {
      return ["/foo/bar/tspconfig.yaml"];
    };
    host.normalizePath = () => {
      return "/gitroot";
    };
    host.checkFileExists = async (file: string) => {
      if (file.includes("tspconfig.yaml")) {
        return false;
      }
      return true;
    };

    const result = await new FolderStructureRule().execute(
      host,
      "/gitroot/specification/foo/Foo.Management",
    );

    assert(result.errorOutput);
    assert(result.errorOutput.includes("must contain"));
  });

  it("should succeed with resource-manager/Management", async function() {
    let host = new TsvTestHost();
    host.globby = async () => {
      return ["/foo/Foo.Management/tspconfig.yaml"];
    };
    host.normalizePath = () => {
      return "/gitroot";
    };
    host.readTspConfig = async (_folder: string) => `
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "resource-manager"
`;

    const result = await new FolderStructureRule().execute(
      host,
      "/gitroot/specification/foo/Foo.Management",
    );

    assert(result.success);
  });

  it("should succeed with data-plane/NoManagement", async function() {
    let host = new TsvTestHost();
    host.globby = async () => {
      return ["/foo/Foo/tspconfig.yaml"];
    };
    host.normalizePath = () => {
      return "/gitroot";
    };
    host.readTspConfig = async (_folder: string) => `
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "data-plane"
`;

    const result = await new FolderStructureRule().execute(
      host,
      "/gitroot/specification/foo/Foo",
    );

    assert(result.success);
  });

  it("should fail with resource-manager/NoManagement", async function() {
    let host = new TsvTestHost();
    host.globby = async () => {
      return ["/foo/Foo/tspconfig.yaml"];
    };
    host.normalizePath = () => {
      return "/gitroot";
    };
    host.readTspConfig = async (_folder: string) => `
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "resource-manager"
`;

    const result = await new FolderStructureRule().execute(
      host,
      "/gitroot/specification/foo/Foo",
    );

    assert(result.errorOutput);
    assert(result.errorOutput.includes(".Management"));
  });

  it("should fail with data-plane/Management", async function() {
    let host = new TsvTestHost();
    host.globby = async () => {
      return ["/foo/Foo.Management/tspconfig.yaml"];
    };
    host.normalizePath = () => {
      return "/gitroot";
    };
    host.readTspConfig = async (_folder: string) => `
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "data-plane"
`;

    const result = await new FolderStructureRule().execute(
      host,
      "/gitroot/specification/foo/Foo.Management",
    );

    assert(result.errorOutput);
    assert(result.errorOutput.includes(".Management"));
  });
});
