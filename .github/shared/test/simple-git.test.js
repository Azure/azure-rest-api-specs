import path from 'path';
import os from 'os';
import { mkdtemp, rm } from 'fs/promises';
import { getRootFolder } from '../src/simple-git.js';
import { describe, expect, it } from "vitest";

describe('getRootFolder', () => {
  it('resolves to repo root from a nested folder', async () => {
    // Use __dirname (this test file directory) as input to getRootFolder
    const testDir = __dirname;
    const calculatedRoot = await getRootFolder(testDir);
    // Expect the repository root 3 levels up from this test file
    const expectedRoot = path.resolve(path.join(__dirname, '..', '..', '..'));
    expect(calculatedRoot).toBe(expectedRoot);
  });

  it('throws when directory is not a git repository', async () => {
    // Use async mkdtemp from fs/promises
    const tempDir = await mkdtemp(path.join(os.tmpdir(), 'non-git-'));
    await expect(getRootFolder(tempDir)).rejects.toThrow();
    // Cleanup the temp directory
    await rm(tempDir, { recursive: true, force: true });
  });
});