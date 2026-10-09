import { Octokit } from "@octokit/rest";
import { mkdir, mkdtemp, readFile, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { afterEach, describe, expect, it, vi } from "vitest";
import { stringify } from "yaml";
import type { ExistingLabel, LabelCatalog } from "../src/label-catalog.ts";
import { ARCHIVE_DESCRIPTION } from "../src/label-catalog.ts";
import {
  applyLabelSync,
  catalogHash,
  findLabelAssignments,
  listRepositoryLabels,
  prepareLabelSync,
} from "../src/sync-repo-labels.ts";
import { createMockContext, createMockCore } from "./mocks.ts";

const repo = { owner: "Azure", repo: "azure-rest-api-specs" };
const prefix = "/repos/Azure/azure-rest-api-specs";
const canonical: ExistingLabel = {
  name: "canonical",
  color: "123456",
  description: "Removed label",
  id: 1,
  node_id: "label-1",
  archived_at: null,
};
const extra: ExistingLabel = {
  name: "unconfigured",
  color: "123456",
  description: ARCHIVE_DESCRIPTION,
  id: 2,
  node_id: "label-2",
  archived_at: "2000-01-01T00:00:00Z",
};
interface Item {
  number: number;
  kind: "issue" | "pull_request";
  state: "OPEN" | "CLOSED" | "MERGED";
  labels: Set<string>;
}
interface Body {
  name?: string;
  new_name?: string;
  color?: string;
  description?: string;
  archived?: boolean;
  labels?: string[];
  query?: string;
  variables?: { id: string; cursor: string | null; count: number };
}
const directories: string[] = [];
afterEach(async () => {
  await Promise.all(directories.splice(0).map((dir) => rm(dir, { recursive: true, force: true })));
  vi.restoreAllMocks();
});

function fixture() {
  const catalog: LabelCatalog = {
    unconfiguredLabels: "preserve",
    labels: [
      { name: canonical.name, color: canonical.color, description: canonical.description ?? "" },
    ],
  };
  const state = {
    catalog,
    rootContent: undefined as string | undefined,
    fragments: new Map<string, string>(),
    sourceSha: "a".repeat(40),
    labels: [structuredClone(canonical), structuredClone(extra)],
    items: [] as Item[],
    failure: "",
    archiveUpdatesEnabled: true,
    renameUpdatesEnabled: true,
    afterMark: () => {},
    requests: [] as { method: string; path: string; body: Body }[],
    graphTransform: (value: unknown): unknown => value,
  };
  const response = (data: unknown, status = 200, headers: Record<string, string> = {}) =>
    new Response(status === 204 ? null : JSON.stringify(data), {
      status,
      headers: { "content-type": "application/json", ...headers },
    });
  const fetch = vi.fn<typeof globalThis.fetch>(async (input, init) => {
    const url = new URL(input instanceof Request ? input.url : input.toString());
    const path = decodeURIComponent(url.pathname);
    const method = init?.method ?? "GET";
    const body = JSON.parse(init?.body ? await new Response(init.body).text() : "{}") as Body;
    state.requests.push({ method, path, body });
    if (state.failure === `${method} ${path}`)
      return response({ message: "Injected failure" }, 403);
    if (path === `${prefix}/commits/main`) return response({ sha: state.sourceSha });
    if (path.startsWith(`${prefix}/contents/`)) {
      const file = path.slice(`${prefix}/contents/`.length);
      const content =
        file === ".github/labels.yaml"
          ? (state.rootContent ?? stringify(state.catalog))
          : state.fragments.get(file);
      if (content === undefined) return response({ message: "Not Found" }, 404);
      return response({
        type: "file",
        encoding: "base64",
        content: Buffer.from(content).toString("base64"),
      });
    }
    if (path === `${prefix}/labels` && method === "GET") {
      const page = Number(url.searchParams.get("page") ?? 1);
      const count = Number(url.searchParams.get("per_page"));
      const labels = state.labels.slice((page - 1) * count, page * count);
      const headers: Record<string, string> = {};
      if (page * count < state.labels.length) {
        headers.link = `<https://api.github.com${prefix}/labels?per_page=${count}&page=${page + 1}>; rel="next"`;
      }
      return response(labels, 200, headers);
    }
    if (path === `${prefix}/labels` && method === "POST") {
      const label = {
        id: 1000 + state.labels.length,
        node_id: `created-${state.labels.length}`,
        name: body.name!,
        color: body.color!,
        description: body.description ?? "",
        archived_at: null,
      };
      state.labels.push(label);
      return response(label, 201);
    }
    if (path.startsWith(`${prefix}/labels/`)) {
      const name = path.slice(`${prefix}/labels/`.length);
      const label = state.labels.find((entry) => entry.name.toLowerCase() === name.toLowerCase());
      if (!label) return response({ message: "Not Found" }, 404);
      if (method === "PATCH") {
        if (body.new_name !== undefined && state.renameUpdatesEnabled) {
          if (
            state.labels.some(
              (entry) =>
                entry.id !== label.id && entry.name.toLowerCase() === body.new_name!.toLowerCase(),
            )
          ) {
            return response({ message: "Label already exists" }, 422);
          }
          for (const item of state.items) {
            if (item.labels.delete(label.name)) item.labels.add(body.new_name);
          }
          label.name = body.new_name;
        }
        if (body.color !== undefined) label.color = body.color;
        if (body.description !== undefined) label.description = body.description;
        if (body.archived !== undefined && state.archiveUpdatesEnabled) {
          label.archived_at = body.archived
            ? (label.archived_at ?? new Date().toISOString())
            : null;
        }
      }
      if (method === "DELETE") {
        state.labels = state.labels.filter((entry) => entry !== label);
        for (const item of state.items) item.labels.delete(name);
        return response(null, 204);
      }
      return response(label);
    }
    const itemPath = new RegExp(`^${prefix}/issues/(\\d+)/labels$`).exec(path);
    if (itemPath) {
      const item = state.items.find((entry) => entry.number === Number(itemPath[1]));
      if (!item) return response({ message: "Not Found" }, 404);
      if (method === "POST") {
        for (const name of body.labels ?? []) item.labels.add(name);
        state.afterMark();
      }
      return response([...item.labels].map((name) => ({ name })));
    }
    if (path === "/graphql") {
      const { id, cursor, count } = body.variables!;
      const label = state.labels.find((entry) => entry.node_id === id);
      if (!label) return response({ data: { node: null } });
      const kind = body.query!.includes("items: issues") ? "issue" : "pull_request";
      const items = state.items.filter((item) => item.kind === kind && item.labels.has(label.name));
      const start = Number(cursor ?? 0);
      return response({
        data: state.graphTransform({
          node: {
            name: label.name,
            items: {
              totalCount: items.length,
              nodes: items.slice(start, start + count).map(({ number, state }) => ({
                number,
                state,
                url: `https://github.com/Azure/azure-rest-api-specs/issues/${number}`,
              })),
              pageInfo: {
                hasNextPage: start + count < items.length,
                endCursor: String(start + count),
              },
            },
          },
        }),
      });
    }
    throw new Error(`Unexpected request: ${method} ${url.toString()}`);
  });
  const github = new Octokit({ auth: "test", request: { fetch } });
  const core = createMockCore();
  vi.spyOn(core, "info").mockImplementation(() => {});
  vi.spyOn(core, "warning").mockImplementation(() => {});
  vi.spyOn(core, "error").mockImplementation(() => {});
  vi.spyOn(core, "setOutput").mockImplementation(() => {});
  const context = {
    ...createMockContext(),
    repo,
    issue: { ...repo, number: 0 },
    payload: {
      repository: {
        name: repo.repo,
        owner: { login: repo.owner, name: repo.owner },
        default_branch: "main",
      },
    },
    eventName: "workflow_dispatch",
    ref: "refs/heads/main",
    runId: 123,
    runAttempt: 1,
  };
  const args = { github, context, core };
  const mutations = () =>
    state.requests.filter(
      (request) =>
        request.path !== "/graphql" && ["POST", "PATCH", "DELETE"].includes(request.method),
    );
  async function prepare(dryRun = false) {
    const directory = await mkdtemp(join(tmpdir(), "label-sync-"));
    directories.push(directory);
    const catalogPath = join(directory, ".github", "labels.yaml");
    await mkdir(join(directory, ".github", "labels"), { recursive: true });
    await writeFile(catalogPath, state.rootContent ?? stringify(state.catalog));
    for (const [path, content] of state.fragments) await writeFile(join(directory, path), content);
    const audit = await prepareLabelSync(args, {
      catalogPath,
      auditDirectory: directory,
      sourceSha: "a".repeat(40),
      dryRun,
    });
    const auditHash = catalogHash(await readFile(join(directory, "before.json"), "utf8"));
    const options = { auditDirectory: directory, auditHash, artifactId: "456" };
    return {
      audit,
      options,
      apply: () => applyLabelSync(args, options),
      outcome: async (): Promise<unknown> =>
        JSON.parse(await readFile(join(directory, "outcome.json"), "utf8")),
    };
  }
  return { state, args, fetch, mutations, prepare };
}

describe("inherited catalog safety", () => {
  it("records all sources and refuses changed inherited definitions before any writes", async () => {
    const f = fixture();
    f.state.rootContent = stringify({
      unconfiguredLabels: "archive",
      extends: ["./labels/base.yaml"],
    });
    f.state.fragments.set(
      ".github/labels/base.yaml",
      stringify({ labels: f.state.catalog.labels }),
    );
    const run = await f.prepare();
    expect(run.audit.catalogSources.map((s) => s.path)).toEqual([
      ".github/labels.yaml",
      ".github/labels/base.yaml",
    ]);
    f.state.fragments.set(
      ".github/labels/base.yaml",
      stringify({
        labels: [{ ...f.state.catalog.labels[0], description: "Changed" }],
      }),
    );
    await expect(run.apply()).rejects.toThrow("catalog changed");
    expect(f.mutations()).toEqual([]);
  });

  it("fails when an inherited file disappears, rather than archiving its labels", async () => {
    const f = fixture();
    f.state.rootContent = stringify({
      unconfiguredLabels: "archive",
      extends: ["./labels/base.yaml"],
    });
    f.state.fragments.set(
      ".github/labels/base.yaml",
      stringify({ labels: f.state.catalog.labels }),
    );
    const run = await f.prepare();
    f.state.fragments.clear();
    await expect(run.apply()).rejects.toThrow("Not Found");
    expect(f.mutations()).toEqual([]);
  });
});

describe("native label archival", () => {
  it("archives an active unconfigured label once, preserving its assignments and archive timestamp", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    const active = { ...extra, description: "Original description", archived_at: null };
    f.state.labels[1] = active;
    f.state.items = [{ number: 1, kind: "issue", state: "CLOSED", labels: new Set([extra.name]) }];
    const run = await f.prepare();
    expect(run.audit.plan.archive).toEqual([{ before: active, name: "archived: unconfigured" }]);
    expect(run.audit.plan.delete).toEqual([]);
    expect(run.audit.deletions).toEqual([]);
    await run.apply();
    expect(f.state.labels[1]).toMatchObject({
      name: "archived: unconfigured",
      color: extra.color,
      description: ARCHIVE_DESCRIPTION,
      id: extra.id,
      node_id: extra.node_id,
    });
    const archivedAt = f.state.labels[1].archived_at;
    expect(archivedAt).not.toBeNull();
    expect(f.state.items[0].labels).toEqual(new Set(["archived: unconfigured"]));
    expect(f.mutations()).toEqual([
      {
        method: "PATCH",
        path: `${prefix}/labels/${extra.name}`,
        body: {
          new_name: "archived: unconfigured",
          archived: true,
          description: ARCHIVE_DESCRIPTION,
        },
      },
    ]);
    const archiveRequest = f.fetch.mock.calls.find(([, init]) => init?.method === "PATCH");
    expect(new Headers(archiveRequest?.[1]?.headers).get("x-github-api-version")).toBe(
      "2026-03-10",
    );
    expect(await run.outcome()).toMatchObject({
      operations: [
        {
          action: "archive",
          label: extra.name,
          newName: "archived: unconfigured",
          status: "completed",
        },
      ],
    });
    f.state.requests = [];
    await (await f.prepare()).apply();
    expect(f.mutations()).toEqual([]);
    expect(f.state.labels[1].archived_at).toBe(archivedAt);
    expect(f.state.requests.some(({ path }) => path === "/graphql")).toBe(false);
  });

  it.each(["migration", "dry-run"])("does not archive active labels during %s", async (mode) => {
    const f = fixture();
    f.state.labels[1].archived_at = null;
    if (mode === "dry-run") f.state.catalog.unconfiguredLabels = "archive";
    await (await f.prepare(mode === "dry-run")).apply();
    expect(f.mutations()).toEqual([]);
    expect(f.state.labels[1].archived_at).toBeNull();
  });

  it("restores an archived label added to the catalog instead of deleting it", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    f.state.catalog.labels.push({
      name: extra.name,
      color: "abcdef",
      description: "Restored to the catalog",
    });
    const run = await f.prepare();
    expect(run.audit.plan.delete).toEqual([]);
    await run.apply();
    expect(f.state.labels[1]).toMatchObject({
      archived_at: null,
      color: "abcdef",
      description: "Restored to the catalog",
    });
    expect(f.mutations().map(({ method, body }) => ({ method, body }))).toEqual([
      {
        method: "PATCH",
        body: {
          new_name: extra.name,
          color: "abcdef",
          description: "Restored to the catalog",
          archived: false,
        },
      },
    ]);
  });

  it("does not adopt manually archived labels or assign them a deletion warning", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    f.state.labels[1].description = "Manually archived";
    const run = await f.prepare();
    expect(run.audit.plan.archive).toEqual([]);
    expect(run.audit.plan.delete).toEqual([]);
    await run.apply();
    expect(f.mutations()).toEqual([]);
    expect(f.state.labels[1].description).toBe("Manually archived");
  });

  it("surfaces archive failures without deleting the label", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    f.state.labels[1].archived_at = null;
    const run = await f.prepare();
    f.state.failure = `PATCH ${prefix}/labels/${extra.name}`;
    await expect(run.apply()).rejects.toThrow("Injected failure");
    expect(f.state.labels[1].archived_at).toBeNull();
    expect(await run.outcome()).toMatchObject({
      error: "Injected failure",
      operations: [{ action: "archive", label: extra.name, status: "failed" }],
    });
  });

  it.each(["archive", "restore"])(
    "verifies GitHub actually performs the %s operation",
    async (operation) => {
      const f = fixture();
      f.state.catalog.unconfiguredLabels = "archive";
      if (operation === "archive") {
        f.state.labels[1].archived_at = null;
      } else {
        f.state.catalog.labels.push({
          name: extra.name,
          color: extra.color,
          description: "Restored label",
        });
      }
      const run = await f.prepare();
      f.state.archiveUpdatesEnabled = false;
      await expect(run.apply()).rejects.toThrow(
        operation === "archive" ? "GitHub did not archive" : "GitHub did not unarchive",
      );
      expect(f.mutations().some(({ method }) => method === "DELETE")).toBe(false);
    },
  );

  it.each(["unarchive", "archive timestamp", "warning"])(
    "blocks deletion if the %s changes after the audit",
    async (change) => {
      const f = fixture();
      f.state.catalog.unconfiguredLabels = "archive";
      const run = await f.prepare();
      if (change === "unarchive") f.state.labels[1].archived_at = null;
      if (change === "archive timestamp") f.state.labels[1].archived_at = "2001-01-01T00:00:00Z";
      if (change === "warning") f.state.labels[1].description = "Warning removed";
      await expect(run.apply()).rejects.toThrow("Label changed");
      expect(f.mutations()).toEqual([]);
    },
  );

  it("does not reset a label archived by someone else between discovery and apply", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    f.state.labels[1].archived_at = null;
    const run = await f.prepare();
    f.state.labels[1].archived_at = new Date().toISOString();
    await expect(run.apply()).rejects.toThrow("Label changed");
    expect(f.mutations()).toEqual([]);
  });

  it("rechecks native archive state immediately before deletion", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    f.state.catalog.labels[0].aliases = [extra.name];
    f.state.items = [{ number: 1, kind: "issue", state: "OPEN", labels: new Set([extra.name]) }];
    const run = await f.prepare();
    f.state.afterMark = () => {
      f.state.labels[1].archived_at = null;
    };
    await expect(run.apply()).rejects.toThrow("Label changed");
    expect(f.mutations().some(({ method }) => method === "DELETE")).toBe(false);
  });

  it("rejects an audited deletion that has not completed its grace period", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    f.state.labels[1].archived_at = new Date().toISOString();
    const run = await f.prepare();
    run.audit.plan.delete = [f.state.labels[1]];
    run.audit.deletions = [{ label: f.state.labels[1], items: [] }];
    const content = JSON.stringify(run.audit);
    await writeFile(join(run.options.auditDirectory, "before.json"), content);
    run.options.auditHash = catalogHash(content);
    await expect(run.apply()).rejects.toThrow("grace period");
    expect(f.mutations()).toEqual([]);
  });
});

describe("archive label names", () => {
  it.each(["preserve", "archive"] as const)(
    "restores the name and assignments on the same label in %s mode",
    async (policy) => {
      const f = fixture();
      f.state.catalog.unconfiguredLabels = policy;
      f.state.labels[1].name = "archived: unconfigured";
      f.state.items = [
        {
          number: 1,
          kind: "issue",
          state: "CLOSED",
          labels: new Set(["archived: unconfigured", "keep"]),
        },
        {
          number: 2,
          kind: "pull_request",
          state: "MERGED",
          labels: new Set(["archived: unconfigured"]),
        },
      ];
      f.state.catalog.labels.push({
        name: extra.name,
        color: "abcdef",
        description: "Restored",
      });
      const run = await f.prepare();
      expect(run.audit.plan.create).toEqual([]);
      expect(run.audit.plan.delete).toEqual([]);
      await run.apply();
      expect(f.state.labels[1]).toEqual({
        ...extra,
        description: "Restored",
        color: "abcdef",
        archived_at: null,
      });
      expect(f.state.items.map(({ labels }) => [...labels].sort())).toEqual([
        ["keep", extra.name],
        [extra.name],
      ]);
      expect(f.mutations()).toEqual([
        {
          method: "PATCH",
          path: `${prefix}/labels/archived: unconfigured`,
          body: { new_name: extra.name, color: "abcdef", description: "Restored", archived: false },
        },
      ]);
      f.state.requests = [];
      await (await f.prepare()).apply();
      expect(f.mutations()).toEqual([]);
    },
  );

  it("renames older managed archives without resetting archived_at", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    const archivedAt = new Date().toISOString();
    f.state.labels[1].archived_at = archivedAt;
    const run = await f.prepare();
    await run.apply();
    expect(f.state.labels[1].name).toBe("archived: unconfigured");
    expect(f.state.labels[1].archived_at).toBe(archivedAt);
    expect(f.mutations()[0].body).toEqual({
      new_name: "archived: unconfigured",
      description: ARCHIVE_DESCRIPTION,
    });
    f.state.requests = [];
    await (await f.prepare()).apply();
    expect(f.mutations()).toEqual([]);
  });

  it("archives a manually restored managed label without stacking prefixes", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    f.state.labels[1].name = "archived: unconfigured";
    f.state.labels[1].archived_at = null;
    await (await f.prepare()).apply();
    expect(f.state.labels[1].name).toBe("archived: unconfigured");
    expect(f.state.labels[1].archived_at).not.toBeNull();
    expect(f.mutations()).toHaveLength(1);
  });

  it("deletes an expired prefixed label without applying a replacement marker", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    f.state.labels[1].name = "archived: unconfigured";
    f.state.items = [
      {
        number: 1,
        kind: "issue",
        state: "CLOSED",
        labels: new Set(["archived: unconfigured", "keep"]),
      },
    ];
    const run = await f.prepare();
    expect(run.audit.deletions[0].label.name).toBe("archived: unconfigured");
    await run.apply();
    expect(f.state.labels).toEqual([canonical]);
    expect(f.state.items[0].labels).toEqual(new Set(["keep"]));
    expect(f.mutations().some(({ method }) => method === "POST")).toBe(false);
    expect(f.mutations().at(-1)).toMatchObject({
      method: "DELETE",
      path: `${prefix}/labels/archived: unconfigured`,
    });
  });

  it.each(["archive", "restore"])("fails if a name collision appears before %s", async (action) => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    let target = "archived: unconfigured";
    if (action === "archive") {
      f.state.labels[1].archived_at = null;
    } else {
      f.state.labels[1].name = target;
      target = extra.name;
      f.state.catalog.labels.push({
        name: extra.name,
        color: extra.color,
        description: "Restored",
      });
    }
    const run = await f.prepare();
    const before = structuredClone(f.state.labels[1]);
    f.state.labels.push({ ...canonical, id: 99, node_id: "collision", name: target.toUpperCase() });
    await expect(run.apply()).rejects.toThrow("Label name collision");
    expect(f.state.labels[1]).toEqual(before);
    expect(f.mutations()).toEqual([]);
  });

  it("propagates rename-target lookup failures instead of treating them as availability", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    f.state.labels[1].archived_at = null;
    const run = await f.prepare();
    f.state.failure = `GET ${prefix}/labels/archived: unconfigured`;
    await expect(run.apply()).rejects.toThrow("Injected failure");
    expect(f.mutations()).toEqual([]);
  });

  it("rejects an overlong archive name before persisting a plan or making writes", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    f.state.labels[1] = { ...extra, name: "x".repeat(41), archived_at: null };
    await expect(f.prepare()).rejects.toThrow("exceeds 50 characters");
    expect(f.mutations()).toEqual([]);
  });

  it.each(["archive", "restore"])("verifies GitHub actually renames during %s", async (action) => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    if (action === "archive") {
      f.state.labels[1].archived_at = null;
    } else {
      f.state.labels[1].name = "archived: unconfigured";
      f.state.catalog.labels.push({
        name: extra.name,
        color: extra.color,
        description: "Restored",
      });
    }
    const run = await f.prepare();
    f.state.renameUpdatesEnabled = false;
    await expect(run.apply()).rejects.toThrow(
      action === "archive" ? "GitHub did not archive" : "GitHub did not unarchive",
    );
    expect(f.mutations().some(({ method }) => method === "DELETE")).toBe(false);
  });
});

describe("repository label synchronization", () => {
  it("paginates the complete live label inventory", async () => {
    const f = fixture();
    f.state.labels = Array.from({ length: 205 }, (_, index) => ({
      ...canonical,
      id: index + 1,
      node_id: `label-${index}`,
      name: `label-${index}`,
    }));
    expect(await listRepositoryLabels(f.args.github, repo)).toHaveLength(205);
    expect(f.state.requests).toHaveLength(3);
    expect(f.mutations()).toEqual([]);
  });

  it("keeps unconfigured definitions and assignments during migration", async () => {
    const f = fixture();
    f.state.items = [{ number: 1, kind: "issue", state: "CLOSED", labels: new Set([extra.name]) }];
    const run = await f.prepare();
    await run.apply();
    expect(f.mutations()).toEqual([]);
    expect(f.args.core.warning).toHaveBeenCalledWith(expect.stringContaining(extra.name));
    expect(f.state.items[0].labels).toEqual(new Set([extra.name]));
    expect(run.audit.deletions).toEqual([]);
    expect(f.state.requests.some((request) => request.path === "/graphql")).toBe(false);
  });

  it("creates and updates configured labels, then becomes a no-op", async () => {
    const f = fixture();
    f.state.labels = [{ ...canonical, color: "ffffff" }];
    f.state.catalog.labels.push({ name: "new", color: "123456", description: "New label" });
    await (await f.prepare()).apply();
    expect(f.mutations().map(({ method }) => method)).toEqual(["POST", "PATCH"]);
    f.state.requests = [];
    await (await f.prepare()).apply();
    expect(f.mutations()).toEqual([]);
  });

  it("does not write in dry-run, even with archival and deletion enabled", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    f.state.labels = [extra];
    const run = await f.prepare(true);
    await run.apply();
    expect(run.audit.plan.create).toHaveLength(1);
    expect(run.audit.deletions).toHaveLength(1);
    expect(f.mutations()).toEqual([]);
    expect(await run.outcome()).toMatchObject({ dryRun: true, operations: [] });
  });

  it.each(["pull_request", "pull_request_target"])(
    "refuses privileged execution on %s",
    async (event) => {
      const f = fixture();
      f.args.context.eventName = event;
      await expect(f.prepare()).rejects.toThrow("upstream default branch");
      expect(f.state.requests).toEqual([]);
    },
  );

  it("refuses non-default-branch execution", async () => {
    const f = fixture();
    f.args.context.ref = "refs/heads/feature";
    await expect(f.prepare()).rejects.toThrow("upstream default branch");
  });

  it("refuses fork execution", async () => {
    const f = fixture();
    f.args.context.repo = { owner: "fork", repo: repo.repo };
    await expect(f.prepare()).rejects.toThrow("upstream default branch");
  });

  it("requires an uploaded audit before any mutation", async () => {
    const f = fixture();
    const run = await f.prepare();
    run.options.artifactId = "";
    await expect(run.apply()).rejects.toThrow("successfully uploaded");
    expect(f.mutations()).toEqual([]);
  });

  it("rejects a changed audit or a different run", async () => {
    const f = fixture();
    const run = await f.prepare();
    f.args.context.runId++;
    await expect(run.apply()).rejects.toThrow("does not belong");
    f.args.context.runId--;
    await writeFile(join(run.options.auditDirectory, "before.json"), "{}");
    await expect(run.apply()).rejects.toThrow("audit changed");
    expect(f.mutations()).toEqual([]);
  });

  it("refuses to apply an obsolete catalog", async () => {
    const f = fixture();
    const run = await f.prepare();
    f.state.catalog.unconfiguredLabels = "archive";
    await expect(run.apply()).rejects.toThrow("catalog changed");
    expect(f.mutations()).toEqual([]);
  });

  it("surfaces incomplete inventory reads instead of treating them as no labels", async () => {
    const f = fixture();
    f.state.failure = `GET ${prefix}/labels`;
    await expect(f.prepare()).rejects.toThrow("Injected failure");
    expect(f.mutations()).toEqual([]);
  });
});

describe("explicit alias migrations", () => {
  it("adds the canonical label to open and closed items before archiving the alias", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    f.state.catalog.labels[0].aliases = [extra.name];
    f.state.labels[1].archived_at = null;
    f.state.items = [
      { number: 1, kind: "pull_request", state: "OPEN", labels: new Set([extra.name, "keep"]) },
      { number: 2, kind: "issue", state: "CLOSED", labels: new Set([extra.name]) },
    ];
    const run = await f.prepare();
    expect(run.audit.migrations[0].items).toHaveLength(2);
    expect(run.audit.deletions).toEqual([]);
    await run.apply();
    expect(f.state.items.map(({ labels }) => [...labels].sort())).toEqual([
      ["archived: unconfigured", canonical.name, "keep"],
      ["archived: unconfigured", canonical.name],
    ]);
    expect(f.mutations().map(({ method }) => method)).toEqual(["POST", "POST", "PATCH"]);
    expect(f.state.labels[1].archived_at).not.toBeNull();
    f.state.requests = [];
    await (await f.prepare()).apply();
    expect(f.mutations()).toEqual([]);
  });
  it("never archives an active alias when canonical assignment fails", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    f.state.catalog.labels[0].aliases = [extra.name];
    f.state.labels[1].archived_at = null;
    f.state.items = [
      { number: 1, kind: "pull_request", state: "OPEN", labels: new Set([extra.name]) },
    ];
    const run = await f.prepare();
    f.state.failure = `POST ${prefix}/issues/1/labels`;
    await expect(run.apply()).rejects.toThrow("Injected failure");
    expect(f.state.labels[1].name).toBe(extra.name);
    expect(f.state.labels[1].archived_at).toBeNull();
  });
  it("does not migrate in a dry run", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    f.state.catalog.labels[0].aliases = [extra.name];
    f.state.items = [
      { number: 1, kind: "pull_request", state: "OPEN", labels: new Set([extra.name]) },
    ];
    const run = await f.prepare(true);
    expect(run.audit.migrations).toHaveLength(1);
    await run.apply();
    expect(f.mutations()).toEqual([]);
  });
  it("does not send alias metadata to GitHub when creating the canonical label", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    f.state.catalog.labels[0].aliases = [extra.name];
    f.state.labels = [structuredClone(extra)];
    await (await f.prepare()).apply();
    expect(f.mutations()[0].body).toEqual({
      name: canonical.name,
      color: canonical.color,
      description: canonical.description,
    });
  });
  it("refuses deletion when a new unaudited item appears even without alias migration", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    const run = await f.prepare();
    f.state.items.push({
      number: 1,
      kind: "issue",
      state: "CLOSED",
      labels: new Set([extra.name]),
    });
    await expect(run.apply()).rejects.toThrow("New unaudited assignment");
    expect(f.mutations()).toEqual([]);
  });
});

describe("expired archive deletion and alias migrations", () => {
  it("paginates issues and PRs in all states and preserves unrelated labels without comments", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    f.state.items = Array.from({ length: 205 }, (_, i) => ({
      number: i + 1,
      kind: i < 102 ? "issue" : "pull_request",
      state: i % 2 ? "CLOSED" : i < 102 ? "OPEN" : "MERGED",
      labels: new Set([extra.name, "keep"]),
    }));
    f.state.items[0].labels.add(canonical.name);
    const run = await f.prepare();
    expect(run.audit.deletions[0].items).toHaveLength(205);
    expect(f.state.requests.filter(({ path }) => path === "/graphql")).toHaveLength(4);
    await run.apply();
    expect(f.state.labels).toEqual([canonical]);
    expect(f.state.items[0].labels).toEqual(new Set([canonical.name, "keep"]));
    for (const item of f.state.items.slice(1)) expect(item.labels).toEqual(new Set(["keep"]));
    expect(f.mutations().filter(({ path }) => path.includes("/issues/"))).toHaveLength(0);
    expect(f.mutations().at(-1)).toMatchObject({
      method: "DELETE",
      path: `${prefix}/labels/${extra.name}`,
    });
    expect(f.state.requests.some(({ path }) => path.includes("comments"))).toBe(false);
    const queries = f.state.requests
      .filter(({ path }) => path === "/graphql")
      .map(({ body }) => body.query);
    expect(queries.some((query) => query?.includes("states: [OPEN, CLOSED]"))).toBe(true);
    expect(queries.some((query) => query?.includes("states: [OPEN, CLOSED, MERGED]"))).toBe(true);
  });

  it("audits and deletes an unused label without adding a canonical to any item", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    const run = await f.prepare();
    expect(run.audit.deletions).toEqual([{ label: extra, items: [] }]);
    await run.apply();
    expect(f.mutations()).toHaveLength(1);
    expect(f.mutations()[0].method).toBe("DELETE");
    expect(await run.outcome()).toMatchObject({
      auditArtifactId: "456",
      operations: [{ action: "delete", label: extra.name, status: "completed" }],
    });
  });

  it("keeps the original on canonical failure and safely resumes without re-marking items", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    f.state.catalog.labels[0].aliases = [extra.name];
    f.state.items = [1, 2].map((number) => ({
      number,
      kind: "issue",
      state: "OPEN",
      labels: new Set([extra.name]),
    }));
    f.state.failure = `POST ${prefix}/issues/2/labels`;
    const run = await f.prepare();
    await expect(run.apply()).rejects.toThrow("Injected failure");
    expect(f.state.labels).toContainEqual(extra);
    expect(f.state.items[0].labels).toEqual(new Set([extra.name, canonical.name]));
    expect(f.mutations().some(({ method }) => method === "DELETE")).toBe(false);
    expect(await run.outcome()).toMatchObject({
      error: "Injected failure",
      operations: [
        { action: "migrate", number: 1, status: "completed" },
        { action: "migrate", number: 2, status: "failed" },
      ],
    });
    f.state.failure = "";
    f.state.requests = [];
    await (await f.prepare()).apply();
    expect(f.mutations().filter(({ method }) => method === "POST")).toHaveLength(1);
    expect(f.state.labels).toEqual([canonical]);
  });

  it("preserves each original association when several labels affect one item", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    const other = { ...extra, id: 3, node_id: "label-3", name: "other" };
    f.state.catalog.labels[0].aliases = [extra.name, other.name];
    f.state.labels.push(other);
    f.state.items = [
      {
        number: 1,
        kind: "pull_request",
        state: "CLOSED",
        labels: new Set([extra.name, other.name]),
      },
    ];
    const run = await f.prepare();
    expect(run.audit.deletions.map(({ items }) => items.map(({ number }) => number))).toEqual([
      [1],
      [1],
    ]);
    await run.apply();
    expect(f.mutations().filter(({ method }) => method === "POST")).toHaveLength(1);
    expect(f.mutations().filter(({ method }) => method === "DELETE")).toHaveLength(2);
  });

  it("does not delete a label that was recreated with the same name", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    const run = await f.prepare();
    f.state.labels[1].id = 999;
    await expect(run.apply()).rejects.toThrow("Label changed");
    expect(f.mutations()).toEqual([]);
  });

  it("stops when a new unaudited association appears during replacement", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    f.state.catalog.labels[0].aliases = [extra.name];
    f.state.items = [{ number: 1, kind: "issue", state: "OPEN", labels: new Set([extra.name]) }];
    const run = await f.prepare();
    f.state.afterMark = () => {
      f.state.items.push({
        number: 2,
        kind: "issue",
        state: "CLOSED",
        labels: new Set([extra.name]),
      });
    };
    await expect(run.apply()).rejects.toThrow("New unaudited assignment");
    expect(f.state.labels).toContainEqual(extra);
  });

  it("does not delete if the canonical disappears after it was applied", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    f.state.catalog.labels[0].aliases = [extra.name];
    f.state.items = [{ number: 1, kind: "issue", state: "OPEN", labels: new Set([extra.name]) }];
    const run = await f.prepare();
    f.state.afterMark = () => f.state.items[0].labels.delete(canonical.name);
    await expect(run.apply()).rejects.toThrow("Canonical label canonical missing");
    expect(f.state.labels).toContainEqual(extra);
  });

  it("does not mark items whose original assignment was removed after discovery", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    f.state.items = [
      { number: 1, kind: "issue", state: "OPEN", labels: new Set([extra.name, "keep"]) },
    ];
    const run = await f.prepare();
    f.state.items[0].labels.delete(extra.name);
    await run.apply();
    expect(f.state.items[0].labels).toEqual(new Set(["keep"]));
    expect(f.mutations().map(({ method }) => method)).toEqual(["DELETE"]);
  });

  it("records a deletion failure without discarding the original label", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    const run = await f.prepare();
    f.state.failure = `DELETE ${prefix}/labels/${extra.name}`;
    await expect(run.apply()).rejects.toThrow("Injected failure");
    expect(f.state.labels).toContainEqual(extra);
    expect(await run.outcome()).toMatchObject({
      error: "Injected failure",
      operations: [{ action: "delete", label: extra.name, status: "failed" }],
    });
  });

  it("stops deletion if policy changes during replacement", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "archive";
    f.state.catalog.labels[0].aliases = [extra.name];
    f.state.items = [{ number: 1, kind: "issue", state: "OPEN", labels: new Set([extra.name]) }];
    const run = await f.prepare();
    f.state.afterMark = () => {
      f.state.catalog.unconfiguredLabels = "preserve";
    };
    await expect(run.apply()).rejects.toThrow("catalog changed");
    expect(f.state.labels).toContainEqual(extra);
  });

  it("rejects incomplete GraphQL responses before any mutations", async () => {
    const f = fixture();
    f.state.graphTransform = () => ({
      node: {
        name: extra.name,
        items: {
          totalCount: 1,
          nodes: [],
          pageInfo: { hasNextPage: true, endCursor: null },
        },
      },
    });
    await expect(findLabelAssignments(f.args.github, extra)).rejects.toThrow(
      "Incomplete assignment pagination",
    );
    expect(f.mutations()).toEqual([]);
  });

  it.each([
    { node: null },
    {
      node: {
        name: "renamed",
        items: {
          totalCount: 0,
          nodes: [],
          pageInfo: { hasNextPage: false, endCursor: null },
        },
      },
    },
    {
      node: {
        name: extra.name,
        items: {
          totalCount: 1,
          nodes: [],
          pageInfo: { hasNextPage: false, endCursor: null },
        },
      },
    },
  ])("rejects missing, renamed, or incompletely enumerated labels", async (response) => {
    const f = fixture();
    f.state.graphTransform = () => response;
    await expect(findLabelAssignments(f.args.github, extra)).rejects.toThrow();
    expect(f.mutations()).toEqual([]);
  });

  it("rejects a shrinking assignment count across pages", async () => {
    const f = fixture();
    let page = 0;
    f.state.graphTransform = () => ({
      node: {
        name: extra.name,
        items: {
          totalCount: page++ === 0 ? 1 : 0,
          nodes: [],
          pageInfo: { hasNextPage: true, endCursor: String(page) },
        },
      },
    });
    await expect(findLabelAssignments(f.args.github, extra)).rejects.toThrow("Assignments changed");
  });
});
