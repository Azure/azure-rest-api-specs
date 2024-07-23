import { execa } from 'execa';
import { join } from 'path';
import { test } from 'vitest';

async function checkAllUnder(path: string, responseCache?: string) {
  const repoRoot = join(__dirname, '..', '..', '..', '..');
  const script = join('eng', 'scripts', 'TypeSpec-Requirement.ps1');

  let command = `${script} -CheckAllUnder ${join(__dirname, path)}`;
  if (responseCache) {
    command += ` -_ResponseCache ${responseCache}`;
  }

  return await execa("pwsh", ["-Command", command], { cwd: repoRoot, reject: false });
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
  const { stderr, exitCode } = await checkAllUnder("specification/no-tspconfig");

  expect(stderr).toContain("no files named 'tspconfig.yaml'");
  expect(exitCode).toBe(1);
});

test.concurrent("Generated from TypeSpec", async ({ expect }) => {
  const { stdout, exitCode } = await checkAllUnder("specification/typespec-generated");

  expect(stdout).toContain("was generated from TypeSpec");
  expect(exitCode).toBe(0);
});

test.concurrent("Hand-written, exists in main", async ({ expect }) => {
  const { stdout, exitCode } = await checkAllUnder(
    "specification/hand-written",
    '@{"https://github.com/Azure/azure-rest-api-specs/tree/main/specification/hand-written/resource-manager/Microsoft.HandWritten/stable"=200}'
  );

  expect(stdout).toContain("was not generated from TypeSpec");
  expect(stdout).toContain("'main' contains path");
  expect(exitCode).toBe(0);
});

test.concurrent("Hand-written, does not exist in main", async ({ expect }) => {
  const { stdout, exitCode } = await checkAllUnder(
    "specification/hand-written",
    '@{"https://github.com/Azure/azure-rest-api-specs/tree/main/specification/hand-written/resource-manager/Microsoft.HandWritten/stable"=404}'
  );

  expect(stdout).toContain("was not generated from TypeSpec");
  expect(stdout).toContain("'main' does not contain path");
  expect(exitCode).toBe(1);
});

test.concurrent("Hand-written, unexpected response checking main", async ({ expect }) => {
  const { stdout, stderr, exitCode } = await checkAllUnder(
    "specification/hand-written",
    '@{"https://github.com/Azure/azure-rest-api-specs/tree/main/specification/hand-written/resource-manager/Microsoft.HandWritten/stable"=519}'
  );

  expect(stdout).toContain("was not generated from TypeSpec");
  expect(stderr).toContain("Unexpected response");
  expect(exitCode).toBe(1);
});
