import { execFileSync } from "node:child_process";
import { readFile, writeFile } from "node:fs/promises";
import { afterEach, beforeEach, expect, it, vi } from "vitest";
import { main } from "../typespec-channel.mts";

vi.mock("node:child_process", () => ({ execFileSync: vi.fn() }));
vi.mock("node:fs/promises", () => ({ readFile: vi.fn(), writeFile: vi.fn() }));

beforeEach(() => {
  vi.resetAllMocks();
  vi.spyOn(process, "chdir").mockImplementation(() => {});
  vi.spyOn(console, "log").mockImplementation(() => {});
  vi.mocked(readFile).mockResolvedValue(
    'overrides:\n  "@typespec/asset-emitter": "0.79.1"\n  "other": "^1.0.0"\ncatalog:\n  "@typespec/compiler": "1.16.0"\n',
  );
});

afterEach(() => {
  vi.restoreAllMocks();
});

it.each(["1.16.0", "1.17.0-dev.10", "v1.16.0", "^1.16.0", "", "https://example.test/pkg.tgz"])(
  "rejects channel %s before restoring files or installing dependencies",
  async (channel) => {
    await expect(main([channel])).rejects.toThrow(
      "select exact versions with --set <package>=<version>",
    );
    expect(execFileSync).not.toHaveBeenCalled();
    expect(writeFile).not.toHaveBeenCalled();
    expect(process.chdir).not.toHaveBeenCalled();
  },
);

it("keeps the shared dist-tag while allowing independently versioned package overrides", async () => {
  await main([
    "next",
    "--set",
    "@typespec/compiler=1.17.0-dev.10",
    "--set",
    "@typespec/events=0.87.0-dev.0",
  ]);
  const workspace = vi.mocked(writeFile).mock.calls[0][1];
  expect(workspace).toContain('"@typespec/compiler": "1.17.0-dev.10"');
  expect(workspace).toContain('"@typespec/events": "0.87.0-dev.0"');
  expect(workspace).toContain('"@azure-tools/typespec-azure-core": "next"');
  expect(workspace).toContain('"other": "^1.0.0"');
  expect(workspace).not.toContain('"@typespec/asset-emitter": "0.79.1"');
  expect(execFileSync).toHaveBeenLastCalledWith(
    "pnpm",
    ["install", "--no-frozen-lockfile"],
    expect.any(Object),
  );
});

it("accepts a tarball override whose URL contains equals signs", async () => {
  const tarball = "https://example.test/compiler.tgz?build=123";
  await main(["next", "--set", `@typespec/compiler=${tarball}`]);
  expect(vi.mocked(writeFile).mock.calls[0][1]).toContain(`"@typespec/compiler": "${tarball}"`);
});

it("restores the stable lockfile without adding overrides", async () => {
  await main(["stable"]);
  expect(execFileSync).toHaveBeenNthCalledWith(
    1,
    "git",
    ["restore", "--", "pnpm-workspace.yaml", "pnpm-lock.yaml"],
    expect.any(Object),
  );
  expect(execFileSync).toHaveBeenLastCalledWith(
    "pnpm",
    ["install", "--frozen-lockfile"],
    expect.any(Object),
  );
  expect(writeFile).not.toHaveBeenCalled();
});

it.each(["@typespec/compiler", "@typespec/compiler="])(
  "rejects malformed override %s before touching the checkout",
  async (override) => {
    await expect(main(["next", "--set", override])).rejects.toThrow(
      "--set expects <package>=<spec>",
    );
    expect(execFileSync).not.toHaveBeenCalled();
  },
);
