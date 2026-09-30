import { getSourceLocation } from "@typespec/compiler";
import { createTester, mockFile } from "@typespec/compiler/testing";
import { resolve } from "node:path";
import { describe, expect, it } from "vitest";
import { $lib, $linter } from "../src/index.ts";

const rule = `${$lib.name}/use-standard-operations`;
const namespace = "Microsoft.Foundry.Core.StandardOperations";
const templates = [
  "PostJob",
  "QueryJobStatus",
  "ListJobs",
  "CancelJob",
  "DeleteJob",
  "PostJobPreview",
  "QueryJobStatusPreview",
  "ListJobsPreview",
  "CancelJobPreview",
  "DeleteJobPreview",
];
// Test-only templates exercise provenance and ancestry without adding a public API.
const tester = createTester(resolve(import.meta.dirname, ".."), { libraries: [] }).files({
  [`node_modules/${$lib.name}/package.json`]: JSON.stringify({
    name: $lib.name,
    version: "0.1.0",
    main: "index.js",
    tspMain: "main.tsp",
  }),
  [`node_modules/${$lib.name}/index.js`]: mockFile.js({ $lib, $linter }),
  [`node_modules/${$lib.name}/main.tsp`]: `
    namespace ${namespace};
    ${templates.map((name) => `op ${name}<T>(item: T): T;`).join("\n")}
  `,
});

async function diagnose(
  source: string,
  options: boolean | Record<string, unknown> = true,
  importLibrary = true,
) {
  const diagnostics = await tester.diagnose(
    `${importLibrary ? `import "${$lib.name}";` : ""}\n${source}`,
    { compilerOptions: { linterRuleSet: { enable: { [rule]: options } } } },
  );
  return diagnostics.map((diagnostic) => {
    const location = getSourceLocation(diagnostic.target, { locateId: true });
    return {
      code: diagnostic.code,
      severity: diagnostic.severity,
      target: location?.file.text.slice(location.pos, location.end),
    };
  });
}

const warning = (target: string) => ({ code: rule, severity: "warning", target });

describe("use-standard-operations", () => {
  it.each(templates)("accepts library-owned %s ancestry", async (name) => {
    expect(await diagnose(`op runJob is ${namespace}.${name}<string>;`)).toEqual([]);
  });

  it("follows generic wrappers, concrete aliases, and inherited interfaces", async () => {
    const diagnostics = await diagnose(`
        op ReadBase<T> is ${namespace}.QueryJobStatus<T>;
        op Again<T> is ReadBase<T>;
        op getJob is Again<string>;
        op aliasJob is getJob;
        interface Base<T> { get is Again<T>; }
        interface Jobs extends Base<string> {}
      `);
    expect(diagnostics).toEqual([]);
  });

  it("warns on raw concrete operations, not generic declarations or instances", async () => {
    const diagnostics = await diagnose(`
        op Custom<T>(item: T): T;
        alias Instance = Custom<string>;
        op concrete is Custom<string>;
        interface Generic<T> { read(item: T): T; }
        alias GenericInstance = Generic<string>;
        interface Jobs { raw(): void; }
        op loose(): void;
      `);
    expect(diagnostics).toHaveLength(3);
    expect(diagnostics).toEqual(
      expect.arrayContaining([warning("concrete"), warning("raw"), warning("loose")]),
    );
    expect(await diagnose("op Custom<T>(item: T): T; alias Instance = Custom<string>;")).toEqual(
      [],
    );
  });

  it("requires actual library provenance, not a matching namespace and name", async () => {
    expect(
      await diagnose(
        `namespace ${namespace} { op PostJob<T>(item: T): T; }
         namespace Consumer { op fake is ${namespace}.PostJob<string>; }`,
        true,
        false,
      ),
    ).toEqual([warning("fake")]);
  });

  it("does not approve consumer additions to the real library namespace", async () => {
    expect(
      await diagnose(`
        namespace ${namespace} { op Custom<T>(): T; }
        namespace Consumer { op custom is ${namespace}.Custom<string>; }
      `),
    ).toEqual([warning("custom")]);
  });

  it("matches only exact fully qualified interface names", async () => {
    expect(
      await diagnose(
        `namespace Demo {
          op loose(): void;
          interface Jobs { selected(): void; }
          interface JobsExtra { ignored(): void; }
        }
        namespace Other { interface Jobs { ignored(): void; } }`,
        { includeInterfaces: ["Demo.Jobs"] },
      ),
    ).toEqual([warning("selected")]);
  });

  it("reports inherited failures on the consuming interface", async () => {
    expect(
      await diagnose(
        `namespace Shared { interface Base<T> { read(item: T): T; } }
         namespace Consumer { interface Jobs extends Shared.Base<string> {} }`,
        { includeInterfaces: ["Consumer.Jobs"] },
      ),
    ).toEqual([warning("Jobs")]);
  });

  it("supports normal suppression and an empty options object", async () => {
    expect(await diagnose("op raw(): void;", {})).toEqual([warning("raw")]);
    expect(await diagnose(`#suppress "${rule}" "Demo exception"\nop raw(): void;`)).toEqual([]);
  });

  it.each([
    { interfaces: ["Demo.Jobs"] },
    { includeInterfaces: [] },
    { includeInterfaces: ["Demo.Jobs", "Demo.Jobs"] },
    { includeInterfaces: "Demo.Jobs" },
    { includeInterfaces: null },
    { includeInterfaces: [12] },
    { includeInterfaces: [""] },
    { includeInterfaces: ["Demo.*"] },
    { includeInterfaces: ["Demo..Jobs"] },
  ])("rejects invalid options: %j", async (options) => {
    expect(await diagnose("", options)).toEqual([
      { code: "invalid-rule-options", severity: "error", target: undefined },
    ]);
  });
});
