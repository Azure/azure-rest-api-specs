import { execa } from "execa";
import { cp, mkdir, mkdtemp, readFile, realpath, rm, symlink, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join, posix } from "node:path";
import { expect, test } from "vitest";

const packageRoot = join(import.meta.dirname, "..");
const oldService = "specification/foo/resource-manager/Microsoft.Foo";
const newService = `${oldService}/Foo`;
const legacy = JSON.stringify(
  {
    swagger: "2.0",
    info: { title: "Legacy service", version: "2020-01-01" },
    paths: {
      "/resources": {
        get: {
          operationId: "Resources_List",
          responses: { "200": { description: "Existing response" } },
        },
      },
    },
    definitions: { Resource: { $ref: "../../common/resource.json" } },
  },
  null,
  2,
);
const generated =
  '{"info":{"x-typespec-generated":[{"emitter":"@azure-tools/typespec-autorest"}]}}';

async function checkChanges(
  initial: Record<string, string>,
  changes: Record<string, string | null>,
) {
  const root = await mkdtemp(join(tmpdir(), "typespec-relocations-"));
  const tool = join(root, "eng/tools/spec-pr-validation");
  async function writeFiles(files: Record<string, string | null>) {
    for (const [path, content] of Object.entries(files)) {
      const fullPath = join(root, path);
      if (content === null) {
        await rm(fullPath);
      } else {
        await mkdir(dirname(fullPath), { recursive: true });
        await writeFile(fullPath, content);
      }
    }
  }
  async function git(...args: string[]) {
    return await execa(
      "git",
      [
        "-c",
        "user.name=Test",
        "-c",
        "user.email=test@example.com",
        "-c",
        "commit.gpgsign=false",
        ...args,
      ],
      { cwd: root },
    );
  }
  async function commit() {
    await git("add", "specification");
    await git("commit", "--quiet", "-m", "Fixture");
  }
  try {
    await cp(join(packageRoot, "src"), join(tool, "src"), { recursive: true });
    await writeFile(join(tool, "package.json"), '{"type":"module"}');
    await mkdir(join(tool, "node_modules/@azure-tools"), { recursive: true });
    for (const dependency of ["specs-shared", "suppressions"]) {
      await symlink(
        await realpath(join(packageRoot, "node_modules/@azure-tools", dependency)),
        join(tool, "node_modules/@azure-tools", dependency),
        process.platform === "win32" ? "junction" : "dir",
      );
    }
    await git("init", "--quiet");
    await writeFiles(initial);
    await commit();
    await writeFiles(changes);
    await commit();
    const outputFile = join(root, "github-output");
    await writeFile(outputFile, "");
    const responseCache = Object.fromEntries(
      Object.keys(changes)
        .filter((path) => path.endsWith(".json"))
        .map((path) => [
          `https://github.com/Azure/azure-rest-api-specs/tree/main/${posix.dirname(path)}`,
          404,
        ]),
    );
    const result = await execa(
      process.execPath,
      [join(tool, "src/index.ts"), "--response-cache", JSON.stringify(responseCache)],
      { cwd: root, reject: false, env: { GITHUB_OUTPUT: outputFile } },
    );
    return {
      exitCode: result.exitCode,
      stdout: result.stdout + result.stderr,
      githubOutput: await readFile(outputFile, "utf8"),
    };
  } finally {
    await rm(root, { recursive: true, force: true });
  }
}

function suppression(service: string, version: string) {
  return {
    [`${service}/suppressions.yaml`]: `- tool: TypeSpecRequirement\n  path: ./${version}/*.json\n  reason: Historical relocation\n`,
  };
}

test("Preserves suppressions when historical Swagger and generated Swagger move together", async () => {
  const old = `${oldService}/preview/2020-01-01/legacy.json`;
  const oldGenerated = `${oldService}/preview/2026-01-01/generated.json`;
  const version = "preview/2020-01-01";
  const result = await checkChanges(
    { [old]: legacy, [oldGenerated]: generated, "specification/foo/tspconfig.yaml": "{}" },
    {
      [old]: null,
      [oldGenerated]: null,
      [`${newService}/${version}/legacy.json`]: legacy.replace(
        "../../common/resource.json",
        "../common/resource.json",
      ),
      [`${newService}/preview/2026-01-01/generated.json`]: generated,
      ...suppression(newService, version),
    },
  );
  expect(result.exitCode).toBe(0);
  expect(result.stdout).toContain("existing API version relocated");
  expect(result.githubOutput).toBe("");
});

test("Recognizes preview-to-stable folder moves and additional files in the relocated version", async () => {
  const old = "specification/foo/data-plane/Microsoft.Foo/preview/2020-01-01/legacy.json";
  const service = "specification/foo/data-plane/Foo";
  const version = "stable/2020-01-01";
  const result = await checkChanges(
    { [old]: legacy, [`${service}/stable/2026-01-01/generated.json`]: generated },
    {
      [old]: null,
      [`${service}/${version}/legacy.json`]: legacy,
      [`${service}/${version}/additional.json`]: "{}",
      ...suppression(service, version),
    },
  );
  expect(result.exitCode).toBe(0);
  expect(result.stdout).toContain("existing API version relocated");
});

test.each([
  { label: "new version identifier", service: newService, version: "preview/2021-01-01" },
  {
    label: "different API plane",
    service: "specification/foo/data-plane/Foo",
    version: "preview/2020-01-01",
  },
  {
    label: "different specification area",
    service: "specification/bar/resource-manager/Microsoft.Foo/Foo",
    version: "preview/2020-01-01",
  },
])("Does not exempt a rename into a $label", async ({ service, version }) => {
  const old = `${oldService}/preview/2020-01-01/legacy.json`;
  const result = await checkChanges(
    { [old]: legacy, [`${service}/stable/2026-01-01/generated.json`]: generated },
    {
      [old]: null,
      [`${service}/${version}/legacy.json`]: legacy,
      ...suppression(service, version),
    },
  );
  expect(result.exitCode).toBe(1);
  expect(result.stdout).toContain("suppressions cannot permit new handwritten API versions");
});

test("Does not treat a copied Swagger as an API-version relocation", async () => {
  const version = "preview/2020-01-01";
  const result = await checkChanges(
    {
      [`${oldService}/${version}/legacy.json`]: legacy,
      [`${newService}/stable/2026-01-01/generated.json`]: generated,
    },
    { [`${newService}/${version}/legacy.json`]: legacy, ...suppression(newService, version) },
  );
  expect(result.exitCode).toBe(1);
  expect(result.stdout).toContain("suppressions cannot permit new handwritten API versions");
});

test("Does not treat common JSON as an existing Swagger version", async () => {
  const version = "preview/2020-01-01";
  const old = `specification/foo/resource-manager/common/${version}/legacy.json`;
  const result = await checkChanges(
    { [old]: legacy, [`${newService}/stable/2026-01-01/generated.json`]: generated },
    {
      [old]: null,
      [`${newService}/${version}/legacy.json`]: legacy,
      ...suppression(newService, version),
    },
  );
  expect(result.exitCode).toBe(1);
  expect(result.stdout).toContain("suppressions cannot permit new handwritten API versions");
});

test("A relocated version does not exempt another newly added version in the same service", async () => {
  const old = `${oldService}/preview/2020-01-01/legacy.json`;
  const result = await checkChanges(
    { [old]: legacy, [`${newService}/stable/2026-01-01/generated.json`]: generated },
    {
      [old]: null,
      [`${newService}/preview/2020-01-01/legacy.json`]: legacy,
      [`${newService}/preview/2027-01-01/new.json`]: "{}",
      [`${newService}/suppressions.yaml`]:
        "- tool: TypeSpecRequirement\n  path: ./preview/2020-01-01/*.json\n  reason: Historical relocation\n" +
        "- tool: TypeSpecRequirement\n  path: ./preview/2027-01-01/*.json\n  reason: Cannot bypass a new version\n",
    },
  );
  expect(result.exitCode).toBe(1);
  expect(result.stdout).toContain("existing API version relocated");
  expect(result.stdout).toContain("suppressions cannot permit new handwritten API versions");
});
