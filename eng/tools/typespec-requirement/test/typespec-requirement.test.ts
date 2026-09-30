import { execa } from "execa";
import { mkdtemp, readFile, rm } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { expect, test } from "vitest";

async function checkAllUnder(
  path: string,
  responseCache: Record<string, number | undefined> = {},
  captureGithubOutput = false,
) {
  const repoRoot = join(import.meta.dirname, "..", "..", "..", "..");
  const script = join(repoRoot, "eng", "tools", "typespec-requirement", "src", "index.ts");
  const outputDirectory = captureGithubOutput
    ? await mkdtemp(join(tmpdir(), "typespec-requirement-"))
    : undefined;
  const outputFile = outputDirectory ? join(outputDirectory, "github-output") : undefined;

  try {
    const result = await execa(
      process.execPath,
      [
        script,
        "--check-all-under",
        join(import.meta.dirname, path),
        "--response-cache",
        JSON.stringify(responseCache),
      ],
      {
        cwd: repoRoot,
        reject: false,
        env: outputFile ? { ...process.env, GITHUB_OUTPUT: outputFile } : process.env,
      },
    );
    return {
      stdout: result.stdout + result.stderr,
      exitCode: result.exitCode,
      githubOutput: outputFile ? await readFile(outputFile, "utf8").catch(() => "") : "",
    };
  } finally {
    if (outputDirectory) {
      await rm(outputDirectory, { recursive: true, force: true });
    }
  }
}

test.concurrent("No files to check", async ({ expect }) => {
  const { stdout, exitCode } = await checkAllUnder("specification/empty");

  expect(stdout).toMatchInlineSnapshot(`"No OpenAPI files found to check"`);
  expect(exitCode).toBe(0);
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
