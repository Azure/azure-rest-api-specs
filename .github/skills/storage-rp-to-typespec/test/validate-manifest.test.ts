import { readFileSync } from "node:fs";
import { spawnSync } from "node:child_process";
import { fileURLToPath } from "node:url";
import { describe, expect, it } from "vitest";
import { stringify } from "yaml";
import { validateManifestText } from "../scripts/validate-manifest.ts";

const property = {
  wireName: "exampleName",
  type: "string",
  required: false,
  nullable: false,
  visibility: ["read", "create"],
};
const propertyAddition = {
  kind: "property",
  action: "add",
  target: "ExampleProperties.exampleName",
  apiVersions: ["2026-09-01"],
  after: property,
};

function manifest(changes: object[]) {
  return {
    schemaVersion: 1,
    provider: "Microsoft.Storage",
    typespecProject: "specification/storage/Storage.Management",
    baseline: {
      branch: "feature/example",
      commit: "1111111111111111111111111111111111111111",
    },
    changes,
  };
}

describe("contract-change manifest", () => {
  it.each(["property-delta", "operation-addition", "no-public-changes"])(
    "accepts the synthetic %s example",
    (name) => {
      const source = readFileSync(new URL(`../examples/${name}.yaml`, import.meta.url), "utf8");
      expect(() => validateManifestText(source)).not.toThrow();
    },
  );

  it.each([
    ["addition without after", { ...propertyAddition, after: undefined }],
    ["addition with before", { ...propertyAddition, before: property }],
    ["modification without before", { ...propertyAddition, action: "modify" }],
    ["removal with after", { ...propertyAddition, action: "remove", before: property }],
    ["unknown kind", { ...propertyAddition, kind: "implementation" }],
    ["missing version", { ...propertyAddition, apiVersions: [] }],
    ["downstream version", { ...propertyAddition, apiVersions: ["Dec26"] }],
    ["duplicate version", { ...propertyAddition, apiVersions: ["2026-09-01", "2026-09-01"] }],
    ["missing nullability", { ...propertyAddition, after: { ...property, nullable: undefined } }],
    ["invented lifecycle", { ...propertyAddition, after: { ...property, visibility: ["write"] } }],
    ["source evidence", { ...propertyAddition, evidence: ["internal-path"] }],
    [
      "source reference in state",
      { ...propertyAddition, after: { ...property, source: "internal" } },
    ],
  ])("rejects %s", (_name, change) => {
    expect(() => validateManifestText(stringify(manifest([change])))).toThrow();
  });

  it("requires a pinned public baseline and the registered SRP target", () => {
    const valid = manifest([]);
    for (const invalid of [
      { ...valid, baseline: { commit: valid.baseline.commit } },
      { ...valid, baseline: { ...valid.baseline, commit: "HEAD" } },
      { ...valid, provider: "Microsoft.Example" },
      { ...valid, typespecProject: "specification/example/Example.Management" },
    ]) {
      expect(() => validateManifestText(stringify(invalid))).toThrow();
    }
  });

  it("preserves explicit false defaults, nullability, and differing lifecycle requiredness", () => {
    expect(() =>
      validateManifestText(
        stringify(
          manifest([
            {
              ...propertyAddition,
              after: {
                ...property,
                type: "boolean",
                default: false,
                nullable: true,
                required: { read: true, create: false },
              },
            },
          ]),
        ),
      ),
    ).not.toThrow();
  });

  it("requires lifecycle requiredness to cover exactly the visible lifecycles", () => {
    for (const required of [{ read: true }, { read: true, create: false, update: false }]) {
      expect(() =>
        validateManifestText(
          stringify(manifest([{ ...propertyAddition, after: { ...property, required } }])),
        ),
      ).toThrow("Requiredness must match visibility");
    }
  });

  it("rejects overlapping target/version changes but permits disjoint versions", () => {
    expect(() =>
      validateManifestText(stringify(manifest([propertyAddition, propertyAddition]))),
    ).toThrow("Duplicate change");
    expect(() =>
      validateManifestText(
        stringify(
          manifest([propertyAddition, { ...propertyAddition, apiVersions: ["2026-12-01"] }]),
        ),
      ),
    ).not.toThrow();
  });

  it("rejects duplicate model wire properties", () => {
    expect(() =>
      validateManifestText(
        stringify(
          manifest([
            {
              kind: "model",
              action: "add",
              target: "ExampleModel",
              apiVersions: ["2026-09-01"],
              after: { properties: [property, { ...property }] },
            },
          ]),
        ),
      ),
    ).toThrow("Duplicate property");
  });

  it("requires enum wire values to match their scalar type", () => {
    const change = {
      kind: "enum",
      action: "modify",
      target: "ExampleMode",
      apiVersions: ["2026-09-01"],
      before: { type: "string", extensible: true, values: ["Standard"] },
      after: { type: "string", extensible: true, values: ["Standard", 2] },
    };
    expect(() => validateManifestText(stringify(manifest([change])))).toThrow();
    change.after.values = ["Standard", "Enhanced"];
    expect(() => validateManifestText(stringify(manifest([change])))).not.toThrow();
  });

  it("requires explicit polling behavior for an LRO", () => {
    const operation = {
      method: "POST",
      path: "/providers/Microsoft.Storage/exampleAction",
      parameters: [],
      requestBodyType: "void",
      responses: [{ statusCodes: ["202"], bodyType: "void" }],
      longRunning: true,
    };
    const change = {
      kind: "operation",
      action: "add",
      target: "Examples.action",
      apiVersions: ["2026-09-01"],
      after: operation,
    };
    expect(() => validateManifestText(stringify(manifest([change])))).toThrow();
    expect(() =>
      validateManifestText(
        stringify(
          manifest([
            {
              ...change,
              after: {
                ...operation,
                pollingHeaders: ["Azure-AsyncOperation"],
                finalResponseType: "void",
              },
            },
          ]),
        ),
      ),
    ).not.toThrow();
  });

  it("rejects optional path parameters and LRO fields on synchronous operations", () => {
    const operation = {
      method: "GET",
      path: "/providers/Microsoft.Storage/examples/{name}",
      parameters: [{ wireName: "name", location: "path", type: "string", required: false }],
      requestBodyType: "void",
      responses: [{ statusCodes: ["200"], bodyType: "Example" }],
      longRunning: false,
    };
    const change = {
      kind: "operation",
      action: "add",
      target: "Examples.get",
      apiVersions: ["2026-09-01"],
      after: operation,
    };
    expect(() => validateManifestText(stringify(manifest([change])))).toThrow();
    operation.parameters[0].required = true;
    expect(() => validateManifestText(stringify(manifest([change])))).not.toThrow();
    expect(() =>
      validateManifestText(
        stringify(
          manifest([
            {
              ...change,
              after: { ...operation, pollingHeaders: ["Location"] },
            },
          ]),
        ),
      ),
    ).toThrow();
  });

  it("rejects backend provenance and unresolved questions in the envelope", () => {
    for (const extra of [{ source: { pr: "internal" } }, { questions: ["Which version?"] }]) {
      expect(() => validateManifestText(stringify({ ...manifest([]), ...extra }))).toThrow();
    }
  });

  it("rejects malformed YAML, duplicate keys, and multiple documents", () => {
    for (const source of ["changes: [", "schemaVersion: 1\nschemaVersion: 1", "---\n{}\n---\n{}"]) {
      expect(() => validateManifestText(source)).toThrow();
    }
  });

  it("rejects unrecognized YAML tags rather than silently discarding their meaning", () => {
    const source = stringify(manifest([])).replace(
      "provider: Microsoft.Storage",
      "provider: !unknown Microsoft.Storage",
    );
    expect(() => validateManifestText(source)).toThrow("Unresolved tag");
  });

  it("reports CLI success and failure through exit codes", () => {
    const script = fileURLToPath(new URL("../scripts/validate-manifest.ts", import.meta.url));
    const example = fileURLToPath(new URL("../examples/no-public-changes.yaml", import.meta.url));
    const success = spawnSync(process.execPath, [script, example], { encoding: "utf8" });
    expect(success.status).toBe(0);
    expect(success.stdout).toContain("Valid contract-change manifest");
    const failure = spawnSync(process.execPath, [script], { encoding: "utf8" });
    expect(failure.status).toBe(1);
    expect(failure.stderr).toContain("Usage:");
    const invalidFile = fileURLToPath(
      new URL("../schemas/contract-changes.schema.json", import.meta.url),
    );
    const invalid = spawnSync(process.execPath, [script, invalidFile], { encoding: "utf8" });
    expect(invalid.status).toBe(1);
    expect(invalid.stdout).toBe("");
    expect(invalid.stderr).toContain("must have required property");
  });
});
