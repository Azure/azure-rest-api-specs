import { join } from "path";
import { EmitAutorestRule } from "../src/rules/emit-autorest.js";
import { TsvTestHost } from "./tsv-test-host.js";
import { strict as assert } from "node:assert";

describe("#EmitAutorest", function () {
  it("Should succeed if no main.tsp", async function () {
    let host = new TsvTestHost();
    host.checkFileExists = async (file: string) => file != join(TsvTestHost.folder, "main.tsp");

    const result = await new EmitAutorestRule().execute(host, TsvTestHost.folder);

    assert(result.success);
  });
});
