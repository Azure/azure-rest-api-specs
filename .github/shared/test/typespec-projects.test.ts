import * as fs from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "pathe";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { ConsoleLogger } from "../src/logger.ts";
import { findTypeSpecProjects, findChangedTypeSpecProjects } from "../src/typespec-projects.ts";

vi.mock("node:fs/promises", async (importOriginal) => {
  const actual = await importOriginal<typeof import("node:fs/promises")>();
  return { ...actual, readdir: vi.fn(actual.readdir), stat: vi.fn(actual.stat) };
});

let root: string;

async function addProject(path: string, config = "tspconfig.yaml") {
  const folder = join(root, path);
  await fs.mkdir(folder, { recursive: true });
  await fs.writeFile(join(folder, config), "");
  return folder;
}

beforeEach(async () => {
  root = await fs.mkdtemp(join(tmpdir(), "specs-shared-typespec-projects-"));
});

afterEach(async () => {
  vi.restoreAllMocks();
  await fs.rm(root, { recursive: true, force: true });
});

describe("findTypeSpecProjects", () => {
  it("discovers sorted, unique projects including invalid config extensions, not directories or dependencies", async () => {
    const last = await addProject("z");
    const first = await addProject("a", "tspconfig.yml");
    await addProject("a");
    const nested = await addProject("a/nested");
    const afterNested = await addProject("aZ");
    await addProject("node_modules/dependency");
    await addProject("a/node_modules/dependency");
    await fs.mkdir(join(root, "not-a-project", "tspconfig.yaml"), { recursive: true });

    await expect(findTypeSpecProjects(root)).resolves.toEqual([first, nested, afterNested, last]);
  });
});

describe("findChangedTypeSpecProjects with service scope", () => {
  it("selects every project in affected services for nested models, shared libraries, and Swagger changes", async () => {
    const parent = await addProject("specification/first/Project");
    const nested = await addProject("specification/first/Project/models/Nested");
    const sibling = await addProject("specification/first/Sibling");
    const management = await addProject("specification/second/Service.Management");
    const dataPlane = await addProject("specification/second/Service");
    const swaggerProject = await addProject("specification/third/Project");
    await addProject("specification/unaffected/Other");

    const modelFile = "specification/first/Project/models/model.tsp";
    const clientFile = "specification/first/Project/client.tsp";
    const sharedFile = "specification/second/Service.Shared/model.tsp";
    const swaggerFile = "specification/third/resource-manager/stable/v1/service.json";

    const projects = await findChangedTypeSpecProjects(
      root,
      [
        swaggerFile,
        modelFile,
        clientFile,
        sharedFile,
        "documentation/readme.md",
        "specification/README.md",
        "specification-other/service/main.tsp",
        "package.json",
      ],
      { scope: "service" },
    );

    expect([...projects]).toEqual([
      [parent, [modelFile, clientFile]],
      [nested, [modelFile, clientFile]],
      [sibling, [modelFile, clientFile]],
      [dataPlane, [sharedFile]],
      [management, [sharedFile]],
      [swaggerProject, [swaggerFile]],
    ]);
  });

  it("includes surviving services for deleted paths and reports missing or non-directory services", async () => {
    const existing = await addProject("specification/service/Existing");
    await fs.writeFile(join(root, "specification/not-directory"), "");
    vi.spyOn(console, "debug").mockImplementation(() => {});

    await expect(
      findChangedTypeSpecProjects(
        root,
        [
          "specification/service/Deleted/models/deleted.tsp",
          "specification/removed/Project/main.tsp",
          "specification/removed/Project/tspconfig.yaml",
          "specification/not-directory/main.tsp",
        ],
        { scope: "service", logger: new ConsoleLogger(true) },
      ).then((projects) => [...projects.keys()]),
    ).resolves.toEqual([existing]);
    expect(vi.mocked(console.debug).mock.calls).toEqual([
      ["Cannot find directory specification/not-directory"],
      ["Cannot find directory specification/removed"],
    ]);
  });

  it("returns an empty selection when no files changed", async () => {
    await expect(findChangedTypeSpecProjects(root, [], { scope: "service" })).resolves.toEqual(
      new Map(),
    );
  });

  it.each([
    Object.assign(new Error("Permission denied"), { code: "EACCES" }),
    new Error("Unexpected filesystem failure"),
    "Unexpected rejection",
  ])(
    "propagates filesystem failures instead of returning an empty selection: %s",
    async (error) => {
      vi.mocked(fs.stat).mockRejectedValueOnce(error);

      await expect(
        findChangedTypeSpecProjects(root, ["specification/service/Project/main.tsp"], {
          scope: "service",
        }),
      ).rejects.toBe(error);
    },
  );
});

describe("findChangedTypeSpecProjects with project scope", () => {
  it("selects only the nearest old-layout project and preserves its changed-file association", async () => {
    await addProject("specification/service/Parent");
    const nested = await addProject("specification/service/Parent/Nested");
    await addProject("specification/service/Sibling");
    await addProject("specification/service/Parent/Nested/Child");
    const files = [
      "specification/service/Parent/Nested/main.tsp",
      "specification/service/Parent/Nested/client.tsp",
    ];

    await expect(findChangedTypeSpecProjects(root, files, { scope: "project" })).resolves.toEqual(
      new Map([[nested, files]]),
    );
  });

  it.each(["resource-manager", "data-plane"])(
    "selects ancestor configs in the %s layout without adding sibling or descendant projects",
    async (plane) => {
      const parent = await addProject(`specification/service/${plane}/Parent`);
      const nested = await addProject(`specification/service/${plane}/Parent/Nested`);
      await addProject(`specification/service/${plane}/Sibling`);
      await addProject(`specification/service/${plane}/Parent/Nested/Child`);
      await fs.mkdir(join(nested, "models"));
      const parentFile = `specification/service/${plane}/Parent/main.tsp`;
      const nestedFile = `specification/service/${plane}/Parent/Nested/main.tsp`;
      const modelFile = `specification/service/${plane}/Parent/Nested/models/model.tsp`;

      const projects = await findChangedTypeSpecProjects(
        root,
        [nestedFile, modelFile, parentFile],
        {
          scope: "project",
        },
      );

      expect([...projects]).toEqual([
        [parent, [nestedFile, modelFile, parentFile]],
        [nested, [nestedFile, modelFile]],
      ]);
    },
  );

  it("does not discover projects for a service-level README or invalid config filename", async () => {
    await addProject("specification/service/Sibling");
    await addProject("specification/service/Invalid", "tspconfig.yml");
    await fs.mkdir(join(root, "specification/service/Directory/tspconfig.yaml"), {
      recursive: true,
    });

    await expect(
      findChangedTypeSpecProjects(
        root,
        [
          "specification/service/readme.md",
          "specification/service/Invalid/main.tsp",
          "specification/service/Directory/main.tsp",
          "documentation/readme.md",
        ],
        { scope: "project" },
      ),
    ).resolves.toEqual(new Map());
  });

  it("reports missing directories without searching above them", async () => {
    await addProject("specification/service/Parent");
    vi.spyOn(console, "warn").mockImplementation(() => {});

    await expect(
      findChangedTypeSpecProjects(root, ["specification/service/Parent/Removed/main.tsp"], {
        scope: "project",
      }),
    ).resolves.toEqual(new Map());
    expect(console.warn).toHaveBeenCalledExactlyOnceWith(
      "Cannot find directory specification/service/Parent/Removed",
    );
  });

  it.each([
    Object.assign(new Error("Permission denied"), { code: "EACCES" }),
    new Error("Unexpected filesystem failure"),
    "Unexpected rejection",
  ])("propagates directory-read failures: %s", async (error) => {
    vi.mocked(fs.readdir).mockRejectedValueOnce(error);

    await expect(
      findChangedTypeSpecProjects(root, ["specification/service/Project/main.tsp"], {
        scope: "project",
      }),
    ).rejects.toBe(error);
  });
});
