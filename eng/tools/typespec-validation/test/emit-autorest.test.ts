import { join } from "path";
import { EmitAutorestRule } from "../src/rules/emit-autorest.js";
import { TsvTestHost } from "./tsv-test-host.js";
import { strict as assert } from "node:assert";

describe("emit-autorest", function () {
  it("should succeed if no main.tsp", async function () {
    let host = new TsvTestHost();
    host.checkFileExists = async (file: string) => file != join(TsvTestHost.folder, "main.tsp");

    const result = await new EmitAutorestRule().execute(host, TsvTestHost.folder);

    assert(result.success);
  });

  it("should succeed if emits autorest", async function () {
    let host = new TsvTestHost();
    host.readTspConfig = async (_folder: string) => `
emit:
  - "@azure-tools/typespec-autorest"
`;

    const result = await new EmitAutorestRule().execute(host, TsvTestHost.folder);

    assert(result.success);
  });

  it("should fail if config is empty", async function () {
    let host = new TsvTestHost();
    host.readTspConfig = async (_folder: string) => "";

    const result = await new EmitAutorestRule().execute(host, TsvTestHost.folder);

    assert(!result.success);
  });

  it("should fail if no emit", async function () {
    let host = new TsvTestHost();
    host.readTspConfig = async (_folder: string) => `
linter:
  extends:
    - "@azure-tools/typespec-azure-core/all"
`;

    const result = await new EmitAutorestRule().execute(host, TsvTestHost.folder);

    assert(!result.success);
  });

  it("should fail if no emit autorest", async function () {
    let host = new TsvTestHost();
    host.readTspConfig = async (_folder: string) => `
emit:
- foo
`;

    const result = await new EmitAutorestRule().execute(host, TsvTestHost.folder);

    assert(!result.success);
  });
});
