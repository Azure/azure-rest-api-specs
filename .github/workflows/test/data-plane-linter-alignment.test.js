import { mkdir, mkdtemp, writeFile } from "fs/promises";
import { tmpdir } from "os";
import { dirname, join } from "path";
import { describe, expect, it } from "vitest";
import checkDataPlaneLinterAlignment, {
  COVERAGE_FILE,
  getPinnedVersion,
  getVerifiedVersion,
} from "../src/data-plane-linter-alignment.js";
import { createMockCore } from "./mocks.js";

/**
 * Writes a minimal repo layout (package.json + coverage map) into a temp dir.
 *
 * @param {string} pinnedVersion version in package.json devDependencies
 * @param {string} verifiedVersion version in the coverage map header
 * @returns {Promise<string>} the temp repo root
 */
async function createFixtureRepo(pinnedVersion, verifiedVersion) {
  const root = await mkdtemp(join(tmpdir(), "dp-linter-align-"));

  await writeFile(
    join(root, "package.json"),
    JSON.stringify({
      devDependencies: { "@azure-tools/typespec-azure-core": pinnedVersion },
    }),
  );

  const coveragePath = join(root, COVERAGE_FILE);
  await mkdir(dirname(coveragePath), { recursive: true });
  await writeFile(
    coveragePath,
    [
      "<!-- Upstream alignment: 2026-07-24",
      "     Verified against:",
      `       - @azure-tools/typespec-azure-core ${verifiedVersion}`,
      `       - @azure-tools/typespec-azure-rulesets ${verifiedVersion} (data-plane ruleset)`,
      "-->",
      "",
      "# Data-Plane Linter Rule Coverage Map",
    ].join("\n"),
  );

  return root;
}

describe("getPinnedVersion", () => {
  it("reads devDependencies", () => {
    const content = JSON.stringify({
      devDependencies: { "@azure-tools/typespec-azure-core": "0.70.0" },
    });

    expect(getPinnedVersion(content)).toBe("0.70.0");
  });

  it("reads dependencies", () => {
    const content = JSON.stringify({
      dependencies: { "@azure-tools/typespec-azure-core": "0.71.0" },
    });

    expect(getPinnedVersion(content)).toBe("0.71.0");
  });

  it("strips range prefixes", () => {
    const content = JSON.stringify({
      devDependencies: { "@azure-tools/typespec-azure-core": "^0.70.0" },
    });

    expect(getPinnedVersion(content)).toBe("0.70.0");
  });

  it("throws when the package is absent", () => {
    expect(() => getPinnedVersion(JSON.stringify({ devDependencies: {} }))).toThrow(
      /not a dependency/,
    );
  });
});

describe("getVerifiedVersion", () => {
  it("reads the version from the header comment", () => {
    const content = "<!-- Verified against:\n - @azure-tools/typespec-azure-core 0.70.0\n-->";

    expect(getVerifiedVersion(content)).toBe("0.70.0");
  });

  it("throws when the header does not name the package", () => {
    expect(() => getVerifiedVersion("# No header here")).toThrow(/Could not find/);
  });
});

describe("checkDataPlaneLinterAlignment", () => {
  it("passes when the versions match", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo("0.70.0", "0.70.0");

    await expect(checkDataPlaneLinterAlignment({ core, rootDir })).resolves.toBe(true);

    expect(core.setFailed).not.toBeCalled();
  });

  it("fails when the versions differ", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo("0.71.0", "0.70.0");

    await expect(checkDataPlaneLinterAlignment({ core, rootDir })).resolves.toBe(false);

    expect(core.setFailed).toBeCalledWith(expect.stringContaining("0.71.0"));
    expect(core.setFailed).toBeCalledWith(expect.stringContaining("0.70.0"));
  });

  it("tolerates a range prefix in package.json", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo("^0.70.0", "0.70.0");

    await expect(checkDataPlaneLinterAlignment({ core, rootDir })).resolves.toBe(true);
  });

  it("stays aligned in the real repository", async () => {
    const core = createMockCore();
    // .github/workflows/test -> repo root
    const rootDir = join(import.meta.dirname, "..", "..", "..");

    await expect(checkDataPlaneLinterAlignment({ core, rootDir })).resolves.toBe(true);

    expect(core.setFailed).not.toBeCalled();
  });
});
