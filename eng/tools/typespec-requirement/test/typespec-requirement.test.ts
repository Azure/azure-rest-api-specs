import { execa } from 'execa';
import { join } from 'path';
import { test } from 'vitest';

async function checkAllUnder(path: string) {
  const repoRoot = join(__dirname, '..', '..', '..', '..');
  return await execa("pwsh",
    ["-File", join('eng', 'scripts', 'TypeSpec-Requirement.ps1'), "-CheckAllUnder", join(__dirname, path)],
    { cwd: repoRoot, reject: false });
}

test.concurrent("No files to check", async ({ expect }) => {
  const { stdout, exitCode } = await checkAllUnder("specification/empty");

  expect(stdout).toMatchInlineSnapshot(`"No OpenAPI files found to check"`);
  expect(exitCode).toBe(0);
});

test.concurrent("Suppression", async ({ expect }) => {
  const { stdout, exitCode } = await checkAllUnder("specification/suppression");

  expect(stdout).contains("Suppressed");
  expect(exitCode).toBe(0);
});

test.concurrent("Parse error", async ({ expect }) => {
  const { stdout, exitCode } = await checkAllUnder("specification/parse-error");

  expect(stdout).contains("cannot be parsed as JSON");
  expect(exitCode).toBe(1);
});

test.concurrent("No tspconfig.yaml", async ({ expect }) => {
  const { stderr, exitCode } = await checkAllUnder("specification/no-tspconfig");

  expect(stderr).contains("no files named 'tspconfig.yaml'");
  expect(exitCode).toBe(1);
});
