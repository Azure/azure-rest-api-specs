import { availableParallelism } from "node:os";
import { afterEach, expect, it, vi } from "vitest";
import { main } from "../src/index.ts";
import { runAll, runChanged } from "../src/run-projects.ts";

vi.mock("node:os", { spy: true });
vi.mock("../src/run-projects.ts", () => ({
  runAll: vi.fn(),
  runChanged: vi.fn(),
}));

const argv = process.argv;

afterEach(() => {
  process.argv = argv;
  vi.unstubAllEnvs();
  vi.clearAllMocks();
});

it.each([
  { title: "scales all-project CI runs", mode: "--all", ci: true, cpus: 4, expected: 8 },
  { title: "scales changed-project CI runs", mode: "--changed", ci: true, cpus: 2, expected: 4 },
  { title: "keeps local runs sequential", mode: "--all", ci: false, cpus: 4, expected: 1 },
  { title: "keeps CI fixing sequential", mode: "--all", ci: true, cpus: 4, fix: true, expected: 1 },
  {
    title: "honors explicit CI overrides",
    mode: "--changed",
    ci: true,
    cpus: 4,
    explicit: "3",
    expected: 3,
  },
])("$title", async ({ mode, ci, cpus, fix, explicit, expected }) => {
  vi.stubEnv("GITHUB_ACTIONS", String(ci));
  vi.mocked(availableParallelism).mockReturnValue(cpus);
  vi.mocked(runAll).mockResolvedValue(true);
  vi.mocked(runChanged).mockResolvedValue(true);
  process.argv = [
    process.execPath,
    "tsv",
    mode,
    ...(fix ? ["--fix"] : []),
    ...(explicit ? [`--concurrency=${explicit}`] : []),
  ];

  await main();

  expect(mode === "--all" ? runAll : runChanged).toHaveBeenCalledExactlyOnceWith(
    expect.any(String),
    expect.objectContaining({ concurrency: expected, fix: fix ?? false }),
  );
});
