import { strict as assert } from "node:assert";
import path from "path";
import { describe, it } from "vitest";
import { NpmPrefixRule } from "../src/rules/npm-prefix.js";
import { IGitOperation, TsvTestHost } from "./tsv-test-host.js";

describe("npm-prefix", function () {
  it("should succeed if node returns inconsistent drive letter capitalization", async function () {
    let host = new TsvTestHost(path.win32);
    host.runFile = async (_file: string, args: string[], _cwd: string): Promise<[Error | null, string, string]> => {
      if (args.includes("prefix")) {
        return [null, `C:${path.sep}Git${path.sep}azure-rest-api-specs`, ""];
      } else {
        return [null, "", ""];
      }
    };
    host.gitOperation = (_folder: string): IGitOperation => {
      return {
        status: () => {
          return Promise.resolve({
            modified: [],
            not_added: [],
            isClean: () => true,
          });
        },
        diff: () => {
          return Promise.resolve("");
        },
        revparse: () => {
          return Promise.resolve("c:/Git/azure-rest-api-specs");
        },
      };
    };

    const result = await new NpmPrefixRule().execute(host, TsvTestHost.folder);

    assert(result.success);
  });

  it("should fail if npm prefix mismatch", async function () {
    let host = new TsvTestHost();
    host.runFile = async (_file: string, args: string[], _cwd: string): Promise<[Error | null, string, string]> => {
      if (args.includes("prefix")) {
        return [null, "/Git/azure-rest-api-specs/specification/foo", ""];
      } else {
        return [null, "", ""];
      }
    };
    host.gitOperation = (_folder: string): IGitOperation => {
      return {
        status: () => {
          return Promise.resolve({
            modified: [],
            not_added: [],
            isClean: () => true,
          });
        },
        diff: () => {
          return Promise.resolve("");
        },
        revparse: () => {
          return Promise.resolve("/Git/azure-rest-api-specs");
        },
      };
    };

    const result = await new NpmPrefixRule().execute(host, TsvTestHost.folder);

    assert(!result.success);
  });
});
