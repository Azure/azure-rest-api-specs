import { execa } from 'execa';
import { join } from 'path';
import { test } from 'vitest';

async function tspClient(...args: string[]) {
  const repoRoot = join(__dirname, '..', '..', '..', '..');
  const execArgs = ["exec", "--no", "--", "tsp-client"]
  return await execa("npm", execArgs.concat(args), {cwd: repoRoot, reject: false});
}

test.concurrent("Usage", async ({ expect }) => {
  const { stdout, exitCode } = await tspClient();
  
  expect(stdout).toContain("Usage");
  expect(exitCode).not.toBe(0);
});
