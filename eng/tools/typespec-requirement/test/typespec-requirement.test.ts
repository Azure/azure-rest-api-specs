import { execa } from "execa";
import { join } from "path";
import { expect, test } from "vitest";

async function checkAllUnder(path: string, responseCache?: string) {
  const repoRoot = join(__dirname, "..", "..", "..", "..");
  const script = join("eng", "scripts", "TypeSpec-Requirement.ps1");

  let command = `${script} -CheckAllUnder ${join(__dirname, path)}`;
  if (responseCache) {
    command += ` -_ResponseCache ${responseCache}`;
  }

  const result = await execa("pwsh", ["-Command", command], { cwd: repoRoot, reject: false });
  return {
    // Merge stdout and stderr, since script writes to stdout in CI but stderr on dev machine
    stdout: result.stdout + result.stderr,
    exitCode: result.exitCode,
  };
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
  const { stdout, exitCode } = await checkAllUnder("specification/parse-error");

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
    responseCache:
      '@{"https://github.com/Azure/azure-rest-api-specs/tree/main/specification/hand-written/resource-manager/Microsoft.HandWritten/HandWritten/stable/2026-01-01"=404}',
  },
  {
    label: "resource-manager preview",
    path: "specification/hand-written/resource-manager/Microsoft.HandWritten/HandWritten/preview",
    responseCache:
      '@{"https://github.com/Azure/azure-rest-api-specs/tree/main/specification/hand-written/resource-manager/Microsoft.HandWritten/HandWritten/preview/2026-02-01-preview"=404}',
  },
  {
    label: "data-plane stable",
    path: "specification/hand-written/data-plane/HandWritten.Analytics/stable",
    responseCache:
      '@{"https://github.com/Azure/azure-rest-api-specs/tree/main/specification/hand-written/data-plane/HandWritten.Analytics/stable/2026-01-01"=404}',
  },
  {
    label: "data-plane preview",
    path: "specification/hand-written/data-plane/HandWritten.Analytics/preview",
    responseCache:
      '@{"https://github.com/Azure/azure-rest-api-specs/tree/main/specification/hand-written/data-plane/HandWritten.Analytics/preview/2026-02-01-preview"=404}',
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
    responseCache:
      '@{"https://github.com/Azure/azure-rest-api-specs/tree/main/specification/hand-written/resource-manager/Microsoft.HandWritten/HandWritten/stable/2026-01-01"=200}',
  },
  {
    label: "resource-manager preview",
    path: "specification/hand-written/resource-manager/Microsoft.HandWritten/HandWritten/preview",
    responseCache:
      '@{"https://github.com/Azure/azure-rest-api-specs/tree/main/specification/hand-written/resource-manager/Microsoft.HandWritten/HandWritten/preview/2026-02-01-preview"=200}',
  },
  {
    label: "data-plane stable",
    path: "specification/hand-written/data-plane/HandWritten.Analytics/stable",
    responseCache:
      '@{"https://github.com/Azure/azure-rest-api-specs/tree/main/specification/hand-written/data-plane/HandWritten.Analytics/stable/2026-01-01"=200}',
  },
  {
    label: "data-plane preview",
    path: "specification/hand-written/data-plane/HandWritten.Analytics/preview",
    responseCache:
      '@{"https://github.com/Azure/azure-rest-api-specs/tree/main/specification/hand-written/data-plane/HandWritten.Analytics/preview/2026-02-01-preview"=200}',
  },
])("Hand-written, existing $label API version", async ({ path, responseCache }) => {
  const { stdout, exitCode } = await checkAllUnder(path, responseCache);

  expect(stdout).toContain("was not generated from TypeSpec");
  expect(stdout).toContain("'main' contains path");
  expect(stdout.toLowerCase()).toContain("warning");
  expect(stdout).toContain("are required to convert");
  expect(exitCode).toBe(0);
});

test.concurrent("Hand-written, unexpected response checking main", async ({ expect }) => {
  const { stdout, exitCode } = await checkAllUnder(
    "specification/hand-written/resource-manager/Microsoft.HandWritten/HandWritten/stable",
    '@{"https://github.com/Azure/azure-rest-api-specs/tree/main/specification/hand-written/resource-manager/Microsoft.HandWritten/HandWritten/stable/2026-01-01"=519}',
  );

  expect(stdout).toContain("was not generated from TypeSpec");
  expect(stdout).toContain("Unexpected response");
  expect(exitCode).toBe(1);
});
