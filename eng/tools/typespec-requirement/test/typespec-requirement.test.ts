import { execa } from 'execa';
import { join } from 'path';
import { test } from 'vitest';

async function checkAllUnder(path: string) {
  const typeSpecRequirementPS1 = join(__dirname, '..', '..', '..', 'scripts', 'TypeSpec-Requirement.ps1')
  return await execa("pwsh", ["-File", typeSpecRequirementPS1, "-CheckAllUnder", path]);
}

test.concurrent("No files to check", async ({ expect }) => {
  const { stdout, exitCode } = await checkAllUnder("specification/empty");

  expect(stdout).toMatchInlineSnapshot(`"No OpenAPI files found to check"`);
  expect(exitCode).toBe(0);
});

test.concurrent("No files to check 2", async ({ expect }) => {
  const { stdout, exitCode } = await checkAllUnder("specification/empty");

  expect(stdout).toMatchInlineSnapshot(`"No OpenAPI files found to check"`);
  expect(exitCode).toBe(0);
});
