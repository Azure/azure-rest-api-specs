import { execa } from "execa";
import { glob, mkdir, mkdtemp, readFile, rm, stat, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join, relative, resolve } from "pathe";
import { expect, test } from "vitest";
import { writeBrownfield } from "../src/cli.ts";
import { checkRequirements } from "../src/typespec-requirement.ts";

async function checkAllUnder(
  path: string,
  responseCache: Record<string, number | undefined> = {},
  captureGithubOutput = false,
) {
  const directory = resolve(import.meta.dirname, path);
  const paths: string[] = [];
  for await (const file of glob("**/*", { cwd: directory })) {
    if ((await stat(resolve(directory, file))).isFile()) paths.push(resolve(directory, file));
  }
  const firstSpec = paths.find((path) => path.split("/").includes("specification"));
  const root = firstSpec
    ? firstSpec.split("/").slice(0, firstSpec.split("/").lastIndexOf("specification")).join("/")
    : directory;
  const messages: string[] = [];
  const outputDirectory = captureGithubOutput
    ? await mkdtemp(join(tmpdir(), "typespec-requirement-"))
    : undefined;
  const outputFile = outputDirectory ? join(outputDirectory, "github-output") : undefined;

  try {
    if (outputFile) {
      await writeFile(outputFile, "");
    }
    const result = await checkRequirements(
      {
        root,
        baseCommitish: "base",
        headCommitish: "head",
        changes: {
          additions: paths.map((path) => relative(root, path)),
          modifications: [],
          deletions: [],
          renames: [],
          total: paths.length,
        },
        logger: {
          debug: (message) => messages.push(message),
          info: (message) => messages.push(message),
          error: (message) => messages.push(message),
          warning: (message) => messages.push(message),
          isDebug: () => true,
        },
      },
      (url) => {
        const status = responseCache[url];
        if (status === undefined) throw new Error(`Unexpected upstream request: ${url}`);
        return Promise.resolve(status);
      },
    );
    await writeBrownfield(result.brownfield, outputFile);
    return {
      stdout: [...messages, ...result.diagnostics.map((diagnostic) => diagnostic.message)].join(
        "\n",
      ),
      exitCode: result.diagnostics.some((diagnostic) => diagnostic.severity === "error") ? 1 : 0,
      githubOutput: outputFile ? await readFile(outputFile, "utf8") : "",
    };
  } finally {
    if (outputDirectory) {
      await rm(outputDirectory, { recursive: true, force: true });
    }
  }
}

async function checkFixtures(
  files: Record<string, string>,
  responseCache: Record<string, number> = {},
  captureGithubOutput = false,
) {
  const directory = await mkdtemp(join(tmpdir(), "typespec-requirement-fixtures-"));
  try {
    for (const [path, content] of Object.entries(files)) {
      const fullPath = join(directory, "specification", path);
      await mkdir(dirname(fullPath), { recursive: true });
      await writeFile(fullPath, content);
    }
    return await checkAllUnder(directory, responseCache, captureGithubOutput);
  } finally {
    await rm(directory, { recursive: true, force: true });
  }
}

test.concurrent("No files to check", async ({ expect }) => {
  const { stdout, exitCode } = await checkAllUnder("specification/empty");

  expect(stdout).toMatchInlineSnapshot(`"No OpenAPI files found to check"`);
  expect(exitCode).toBe(0);
});

test("Rejects removed CLI options", async ({ expect }) => {
  const repoRoot = join(import.meta.dirname, "..", "..", "..", "..");
  const script = join(
    repoRoot,
    "eng",
    "tools",
    "spec-pr-validation",
    "cmd",
    "spec-pr-validation.js",
  );
  const { stderr, exitCode } = await execa(
    process.execPath,
    [script, "--spec-type", "data-plane)|.*"],
    { cwd: repoRoot, reject: false },
  );

  expect(stderr).toContain("Unknown option '--spec-type'");
  expect(exitCode).toBe(1);
});

test.concurrent("Suppression", async ({ expect }) => {
  const { stdout, exitCode } = await checkAllUnder("specification/suppression");

  expect(stdout).toContain("Suppressed");
  expect(exitCode).toBe(0);
});

test.concurrent("Parse error", async ({ expect }) => {
  const { stdout, exitCode } = await checkAllUnder("specification/parse-error", {
    "https://github.com/Azure/azure-rest-api-specs/tree/main/specification/parse-error/resource-manager/Microsoft.ParseError/preview/2024-01-01-preview": 404,
  });

  expect(stdout).toContain("cannot be parsed as JSON");
  expect(exitCode).toBe(1);
});

test.concurrent("No tspconfig.yaml", async ({ expect }) => {
  const { stdout, exitCode } = await checkAllUnder("specification/no-tspconfig");

  expect(stdout).toContain("no files named 'tspconfig.yaml'");
  expect(exitCode).toBe(1);
});

test.concurrent("Generated from TypeSpec", async ({ expect }) => {
  const { stdout, exitCode } = await checkAllUnder("specification/typespec-generated");

  expect(stdout).toContain("was generated from TypeSpec");
  expect(exitCode).toBe(0);
});

test.concurrent.each(["Common", "Common-Types", "Examples", "Scenarios", "Restler"])(
  "Excludes %s paths regardless of casing",
  async (folder) => {
    const apiVersion = `excluded/data-plane/${folder}/stable/2026-01-01`;
    const { stdout, exitCode } = await checkFixtures(
      { [`${apiVersion}/openapi.json`]: "{}" },
      {
        [`https://github.com/Azure/azure-rest-api-specs/tree/main/specification/${apiVersion}`]: 404,
      },
    );

    expect(stdout).toBe("No OpenAPI files found to check");
    expect(exitCode).toBe(0);
  },
);

test.concurrent.each(["Stable", "Preview"])(
  "Checks %s paths regardless of casing",
  async (folder) => {
    const apiVersion = `case-sensitive/data-plane/CaseSensitive/${folder}/2026-01-01`;
    const { stdout, exitCode } = await checkFixtures(
      { [`${apiVersion}/openapi.json`]: "{}" },
      {
        [`https://github.com/Azure/azure-rest-api-specs/tree/main/specification/${apiVersion}`]: 404,
      },
    );

    expect(stdout).toContain("API version is new and must use TypeSpec");
    expect(exitCode).toBe(1);
  },
);

test.concurrent("Finds tspconfig.yaml regardless of casing", async ({ expect }) => {
  const { stdout, exitCode } = await checkFixtures({
    "generated/data-plane/Generated/stable/2026-01-01/openapi.json":
      '{"info":{"x-typespec-generated":true}}',
    "generated/Generated/TspConfig.yaml": "{}",
  });

  expect(stdout).toContain("contains 1 file(s) named 'tspconfig.yaml'");
  expect(exitCode).toBe(0);
});

test.concurrent("Treats malformed JSON as handwritten", async ({ expect }) => {
  const apiVersion = "generated/data-plane/Generated/stable/2026-01-01";
  const { stdout, exitCode } = await checkFixtures(
    {
      [`${apiVersion}/openapi.json`]: '{"info":{"x-typespec-generated":true}',
      "generated/Generated/tspconfig.yaml": "{}",
    },
    {
      [`https://github.com/Azure/azure-rest-api-specs/tree/main/specification/${apiVersion}`]: 404,
    },
  );

  expect(stdout).toContain("cannot be parsed as JSON");
  expect(stdout).toContain("API version is new and must use TypeSpec");
  expect(exitCode).toBe(1);
});

test.concurrent.each([
  { label: "single version", version: "2026-01-01", exitCode: 0, message: "Suppressed" },
  { label: "wildcard version", version: "*", exitCode: 1, message: "Invalid path" },
])("Validates $label suppressions with mixed-case paths", async (scenario) => {
  const { stdout, exitCode } = await checkFixtures({
    "suppressed/data-plane/Suppressed/Stable/2026-01-01/openapi.json": "{}",
    "suppressed/suppressions.yaml":
      `- tool: TypeSpecRequirement\n` +
      `  paths: ["data-plane/Suppressed/Stable/${scenario.version}/*.json"]\n` +
      `  reason: Allowed version\n`,
  });

  expect(stdout).toContain(scenario.message);
  expect(exitCode).toBe(scenario.exitCode);
});

test.concurrent.each([
  { status: 404, message: "API version is new and must use TypeSpec" },
  { status: 519, message: "Unexpected response" },
])(
  "Preserves brownfield output when another version returns $status",
  async ({ status, message }) => {
    const existingVersion = "mixed/data-plane/Mixed/stable/2026-01-01";
    const failingVersion = "mixed/data-plane/Mixed/stable/2026-02-01";
    const { stdout, exitCode, githubOutput } = await checkFixtures(
      {
        [`${existingVersion}/openapi.json`]: "{}",
        [`${failingVersion}/openapi.json`]: "{}",
      },
      {
        [`https://github.com/Azure/azure-rest-api-specs/tree/main/specification/${existingVersion}`]: 200,
        [`https://github.com/Azure/azure-rest-api-specs/tree/main/specification/${failingVersion}`]:
          status,
      },
      true,
    );

    expect(stdout).toContain(message);
    expect(exitCode).toBe(1);
    expect(githubOutput).toBe("brownfield=true\n");
  },
);

test.concurrent.each([
  {
    label: "resource-manager stable",
    path: "specification/hand-written/resource-manager/Microsoft.HandWritten/HandWritten/stable",
    responseCache: {
      "https://github.com/Azure/azure-rest-api-specs/tree/main/specification/hand-written/resource-manager/Microsoft.HandWritten/HandWritten/stable/2026-01-01": 404,
    },
  },
  {
    label: "resource-manager preview",
    path: "specification/hand-written/resource-manager/Microsoft.HandWritten/HandWritten/preview",
    responseCache: {
      "https://github.com/Azure/azure-rest-api-specs/tree/main/specification/hand-written/resource-manager/Microsoft.HandWritten/HandWritten/preview/2026-02-01-preview": 404,
    },
  },
  {
    label: "data-plane stable",
    path: "specification/hand-written/data-plane/HandWritten.Analytics/stable",
    responseCache: {
      "https://github.com/Azure/azure-rest-api-specs/tree/main/specification/hand-written/data-plane/HandWritten.Analytics/stable/2026-01-01": 404,
    },
  },
  {
    label: "data-plane preview",
    path: "specification/hand-written/data-plane/HandWritten.Analytics/preview",
    responseCache: {
      "https://github.com/Azure/azure-rest-api-specs/tree/main/specification/hand-written/data-plane/HandWritten.Analytics/preview/2026-02-01-preview": 404,
    },
  },
])("Hand-written, new $label API version", async ({ path, responseCache }) => {
  const { stdout, exitCode } = await checkAllUnder(path, responseCache);

  expect(stdout).toContain("was not generated from TypeSpec");
  expect(stdout).toContain("'main' does not contain path");
  expect(exitCode).toBe(1);
});

test.concurrent.each([
  {
    label: "resource-manager stable",
    path: "specification/hand-written/resource-manager/Microsoft.HandWritten/HandWritten/stable",
    responseCache: {
      "https://github.com/Azure/azure-rest-api-specs/tree/main/specification/hand-written/resource-manager/Microsoft.HandWritten/HandWritten/stable/2026-01-01": 200,
    },
  },
  {
    label: "resource-manager preview",
    path: "specification/hand-written/resource-manager/Microsoft.HandWritten/HandWritten/preview",
    responseCache: {
      "https://github.com/Azure/azure-rest-api-specs/tree/main/specification/hand-written/resource-manager/Microsoft.HandWritten/HandWritten/preview/2026-02-01-preview": 200,
    },
  },
  {
    label: "data-plane stable",
    path: "specification/hand-written/data-plane/HandWritten.Analytics/stable",
    responseCache: {
      "https://github.com/Azure/azure-rest-api-specs/tree/main/specification/hand-written/data-plane/HandWritten.Analytics/stable/2026-01-01": 200,
    },
  },
  {
    label: "data-plane preview",
    path: "specification/hand-written/data-plane/HandWritten.Analytics/preview",
    responseCache: {
      "https://github.com/Azure/azure-rest-api-specs/tree/main/specification/hand-written/data-plane/HandWritten.Analytics/preview/2026-02-01-preview": 200,
    },
  },
])("Hand-written, existing $label API version", async ({ path, responseCache }) => {
  const { stdout, exitCode, githubOutput } = await checkAllUnder(
    path,
    responseCache,
    path.includes("resource-manager"),
  );

  expect(stdout).toContain("was not generated from TypeSpec");
  expect(stdout).toContain("'main' contains path");
  expect(stdout.toLowerCase()).toContain("warning");
  expect(stdout).toContain("are required to convert");
  expect(exitCode).toBe(0);
  if (path.includes("resource-manager")) {
    expect(githubOutput).toContain("brownfield=true");
  }
});

test.concurrent("Hand-written, unexpected response checking main", async ({ expect }) => {
  const { stdout, exitCode } = await checkAllUnder(
    "specification/hand-written/resource-manager/Microsoft.HandWritten/HandWritten/stable",
    {
      "https://github.com/Azure/azure-rest-api-specs/tree/main/specification/hand-written/resource-manager/Microsoft.HandWritten/HandWritten/stable/2026-01-01": 519,
    },
  );

  expect(stdout).toContain("was not generated from TypeSpec");
  expect(stdout).toContain("Unexpected response");
  expect(exitCode).toBe(1);
});

const generatedSwagger =
  '{"info":{"x-typespec-generated":[{"emitter":"@azure-tools/typespec-autorest"}]}}';
const migratedService = "migrated/resource-manager/Microsoft.Migrated/Service";

test.concurrent.each([false, true])(
  "Preserves existing API-version behavior after migration (suppressed=%s)",
  async (suppressed) => {
    const apiVersion = `${migratedService}/stable/2025-01-01`;
    const { stdout, exitCode, githubOutput } = await checkFixtures(
      {
        "migrated/tspconfig.yaml": "{}",
        [`${migratedService}/stable/2026-01-01/generated.json`]: generatedSwagger,
        [`${apiVersion}/handwritten.json`]: "{}",
        ...(suppressed
          ? {
              [`${migratedService}/suppressions.yaml`]:
                "- tool: TypeSpecRequirement\n  path: ./stable/2025-01-01/*.json\n  reason: Legacy exemption\n",
            }
          : {}),
      },
      {
        [`https://github.com/Azure/azure-rest-api-specs/tree/main/specification/${apiVersion}`]: 200,
      },
      true,
    );
    expect(exitCode).toBe(0);
    expect(stdout).toContain(suppressed ? "Suppressed" : "not required to use TypeSpec");
    expect(githubOutput).toBe(suppressed ? "brownfield=false\n" : "brownfield=true\n");
  },
);

test.concurrent.each([
  { service: migratedService, first: "stable/2026-01-01", target: "stable/2025-01-01" },
  {
    service: migratedService,
    first: "Preview/2026-01-01-preview",
    target: "stable/2027-01-01",
  },
  {
    service: "migrated/data-plane/Microsoft.Migrated/Service",
    first: "stable/2026-01-01",
    target: "preview/2027-01-01-preview",
  },
])(
  "Rejects suppressed new API version $target in $service when $first uses TypeSpec",
  async ({ service, first, target }) => {
    const apiVersion = `${service}/${target}`;
    const { stdout, exitCode, githubOutput } = await checkFixtures(
      {
        "migrated/tspconfig.yaml": "{}",
        [`${service}/${first}/generated.json`]: generatedSwagger,
        [`${apiVersion}/handwritten.json`]: "{}",
        [`${service}/suppressions.yaml`]: `- tool: TypeSpecRequirement\n  path: ./${target}/*.json\n  reason: Legacy exemption\n`,
      },
      {
        [`https://github.com/Azure/azure-rest-api-specs/tree/main/specification/${apiVersion}`]: 404,
      },
      true,
    );
    expect(exitCode).toBe(1);
    expect(stdout).toContain("suppressions cannot permit new handwritten API versions");
    expect(stdout).not.toContain("Suppressed:");
    expect(githubOutput).toBe("brownfield=false\n");
  },
);

test.concurrent("Preserves brownfield output when a new API version's suppression is rejected", async ({
  expect,
}) => {
  const existingVersion = `${migratedService}/stable/2025-01-01`;
  const apiVersion = `${migratedService}/preview/2027-01-01-preview`;
  const { stdout, exitCode, githubOutput } = await checkFixtures(
    {
      "migrated/tspconfig.yaml": "{}",
      [`${migratedService}/stable/2026-01-01/generated.json`]: generatedSwagger,
      [`${existingVersion}/handwritten.json`]: "{}",
      [`${apiVersion}/handwritten.json`]: "{}",
      [`${migratedService}/suppressions.yaml`]:
        "- tool: TypeSpecRequirement\n  path: ./preview/2027-01-01-preview/*.json\n  reason: Legacy exemption\n",
    },
    {
      [`https://github.com/Azure/azure-rest-api-specs/tree/main/specification/${existingVersion}`]: 200,
      [`https://github.com/Azure/azure-rest-api-specs/tree/main/specification/${apiVersion}`]: 404,
    },
    true,
  );
  expect(exitCode).toBe(1);
  expect(stdout).toContain("suppressions cannot permit new handwritten API versions");
  expect(githubOutput).toBe("brownfield=true\n");
});

test.concurrent("Preserves suppressions for generated Swagger without tspconfig.yaml", async ({
  expect,
}) => {
  const { stdout, exitCode } = await checkFixtures({
    [`${migratedService}/stable/2027-01-01/generated.json`]: generatedSwagger,
    [`${migratedService}/suppressions.yaml`]:
      "- tool: TypeSpecRequirement\n  path: ./stable/2027-01-01/*.json\n  reason: Legacy exemption\n",
  });
  expect(exitCode).toBe(0);
  expect(stdout).toContain("Suppressed:");
});

test.concurrent.each([
  "migrated/resource-manager/Microsoft.Migrated/OtherService",
  "migrated/data-plane/Microsoft.Migrated/Service",
  "migrated/resource-manager/Microsoft.Other/Service",
])("Does not share migration state with %s", async (otherService) => {
  const apiVersion = `${migratedService}/stable/2027-01-01`;
  const { stdout, exitCode } = await checkFixtures(
    {
      "migrated/tspconfig.yaml": "{}",
      [`${otherService}/stable/2026-01-01/generated.json`]: generatedSwagger,
      [`${apiVersion}/handwritten.json`]: "{}",
      [`${migratedService}/suppressions.yaml`]:
        "- tool: TypeSpecRequirement\n  path: ./stable/2027-01-01/*.json\n  reason: Legacy exemption\n",
    },
    {
      [`https://github.com/Azure/azure-rest-api-specs/tree/main/specification/${apiVersion}`]: 404,
    },
  );
  expect(exitCode).toBe(0);
  expect(stdout).toContain("Suppressed:");
});

test.concurrent("Does not infer migration from examples, common types, or tspconfig alone", async ({
  expect,
}) => {
  const apiVersion = `${migratedService}/stable/2027-01-01`;
  const { stdout, exitCode } = await checkFixtures(
    {
      "migrated/tspconfig.yaml": "{}",
      [`${migratedService}/stable/2026-01-01/examples/generated.json`]: generatedSwagger,
      [`${migratedService}/stable/2026-01-01/common/generated.json`]: generatedSwagger,
      [`${apiVersion}/handwritten.json`]: "{}",
      [`${migratedService}/suppressions.yaml`]:
        "- tool: TypeSpecRequirement\n  path: ./stable/2027-01-01/*.json\n  reason: Legacy exemption\n",
    },
    {
      [`https://github.com/Azure/azure-rest-api-specs/tree/main/specification/${apiVersion}`]: 404,
    },
  );
  expect(exitCode).toBe(0);
  expect(stdout).toContain("Suppressed:");
  expect(stdout).not.toContain("Checking github.com");
});
