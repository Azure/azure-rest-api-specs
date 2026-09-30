import { Octokit } from "@octokit/rest";
import { mkdtemp, readFile, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { afterEach, describe, expect, it, vi } from "vitest";
import { parse, stringify } from "yaml";
import { z } from "zod";
import type { ExistingLabel, LabelCatalog } from "../src/label-catalog.ts";
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
const marker: ExistingLabel = {
  name: "label-deleted",
  color: "ededed",
  description: "Removed label",
  id: 1,
  node_id: "label-1",
};
const extra: ExistingLabel = {
  name: "unconfigured",
  color: "123456",
  description: "An old label",
  id: 2,
  node_id: "label-2",
};
interface Item {
  number: number;
  kind: "issue" | "pull_request";
  state: "OPEN" | "CLOSED" | "MERGED";
  labels: Set<string>;
}
interface Body {
  name?: string;
  color?: string;
  description?: string;
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
    labels: [{ name: marker.name, color: marker.color, description: marker.description ?? "" }],
  };
  const state = {
    catalog,
    labels: [structuredClone(marker), structuredClone(extra)],
    items: [] as Item[],
    failure: "",
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
    if (path === `${prefix}/contents/.github/labels.yaml`) {
      return response({
        type: "file",
        encoding: "base64",
        content: Buffer.from(stringify(state.catalog)).toString("base64"),
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
      };
      state.labels.push(label);
      return response(label, 201);
    }
    if (path.startsWith(`${prefix}/labels/`)) {
      const name = path.slice(`${prefix}/labels/`.length);
      const label = state.labels.find((entry) => entry.name === name);
      if (!label) return response({ message: "Not Found" }, 404);
      if (method === "PATCH") {
        Object.assign(label, { color: body.color, description: body.description });
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
    const catalogPath = join(directory, "labels.yaml");
    await writeFile(catalogPath, stringify(state.catalog));
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

describe("repository label synchronization", () => {
  it("paginates the complete live label inventory", async () => {
    const f = fixture();
    f.state.labels = Array.from({ length: 205 }, (_, index) => ({
      ...marker,
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
    expect(run.audit.replacements).toEqual([]);
    expect(f.state.requests.some((request) => request.path === "/graphql")).toBe(false);
  });

  it("creates and updates configured labels, then becomes a no-op", async () => {
    const f = fixture();
    f.state.labels = [{ ...marker, color: "ffffff" }];
    f.state.catalog.labels.push({ name: "new", color: "123456", description: "New label" });
    await (await f.prepare()).apply();
    expect(f.mutations().map(({ method }) => method)).toEqual(["POST", "PATCH"]);
    f.state.requests = [];
    await (await f.prepare()).apply();
    expect(f.mutations()).toEqual([]);
  });

  it("does not write in dry-run, even with replacement enabled", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "replace";
    f.state.labels = [extra];
    const run = await f.prepare(true);
    await run.apply();
    expect(run.audit.plan.create).toHaveLength(1);
    expect(run.audit.replacements).toHaveLength(1);
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
    f.state.catalog.unconfiguredLabels = "replace";
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

describe("disabled replacement implementation", () => {
  it("paginates issues and PRs in all states and preserves unrelated labels without comments", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "replace";
    f.state.items = Array.from({ length: 205 }, (_, i) => ({
      number: i + 1,
      kind: i < 102 ? "issue" : "pull_request",
      state: i % 2 ? "CLOSED" : i < 102 ? "OPEN" : "MERGED",
      labels: new Set([extra.name, "keep"]),
    }));
    f.state.items[0].labels.add(marker.name);
    const run = await f.prepare();
    expect(run.audit.replacements[0].items).toHaveLength(205);
    expect(f.state.requests.filter(({ path }) => path === "/graphql")).toHaveLength(4);
    await run.apply();
    expect(f.state.labels).toEqual([marker]);
    for (const item of f.state.items) expect(item.labels).toEqual(new Set([marker.name, "keep"]));
    expect(f.mutations().filter(({ path }) => path.includes("/issues/"))).toHaveLength(204);
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

  it("audits and deletes an unused label without adding a marker to any item", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "replace";
    const run = await f.prepare();
    expect(run.audit.replacements).toEqual([{ label: extra, items: [] }]);
    await run.apply();
    expect(f.mutations()).toHaveLength(1);
    expect(f.mutations()[0].method).toBe("DELETE");
    expect(await run.outcome()).toMatchObject({
      auditArtifactId: "456",
      operations: [{ action: "delete", label: extra.name, status: "completed" }],
    });
  });

  it("keeps the original on marker failure and safely resumes without re-marking items", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "replace";
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
    expect(f.state.items[0].labels).toEqual(new Set([extra.name, marker.name]));
    expect(f.mutations().some(({ method }) => method === "DELETE")).toBe(false);
    expect(await run.outcome()).toMatchObject({
      error: "Injected failure",
      operations: [
        { action: "mark", number: 1, status: "completed" },
        { action: "mark", number: 2, status: "failed" },
      ],
    });
    f.state.failure = "";
    f.state.requests = [];
    await (await f.prepare()).apply();
    expect(f.mutations().filter(({ method }) => method === "POST")).toHaveLength(1);
    expect(f.state.labels).toEqual([marker]);
  });

  it("preserves each original association when several labels affect one item", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "replace";
    const other = { ...extra, id: 3, node_id: "label-3", name: "other" };
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
    expect(run.audit.replacements.map(({ items }) => items.map(({ number }) => number))).toEqual([
      [1],
      [1],
    ]);
    await run.apply();
    expect(f.mutations().filter(({ method }) => method === "POST")).toHaveLength(1);
    expect(f.mutations().filter(({ method }) => method === "DELETE")).toHaveLength(2);
  });

  it("does not delete a label that was recreated with the same name", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "replace";
    const run = await f.prepare();
    f.state.labels[1].id = 999;
    await expect(run.apply()).rejects.toThrow("Label changed");
    expect(f.mutations()).toEqual([]);
  });

  it("stops when a new unaudited association appears during replacement", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "replace";
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

  it("does not delete if the marker disappears after it was applied", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "replace";
    f.state.items = [{ number: 1, kind: "issue", state: "OPEN", labels: new Set([extra.name]) }];
    const run = await f.prepare();
    f.state.afterMark = () => f.state.items[0].labels.delete(marker.name);
    await expect(run.apply()).rejects.toThrow("Replacement marker missing");
    expect(f.state.labels).toContainEqual(extra);
  });

  it("does not mark items whose original assignment was removed after discovery", async () => {
    const f = fixture();
    f.state.catalog.unconfiguredLabels = "replace";
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
    f.state.catalog.unconfiguredLabels = "replace";
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
    f.state.catalog.unconfiguredLabels = "replace";
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

describe("label workflow contract", () => {
  it("isolates PR validation and persists the audit before applying changes", async () => {
    const step = z.object({
      id: z.string().optional(),
      uses: z.string().optional(),
      if: z.string().optional(),
      with: z.record(z.string(), z.unknown()).optional(),
    });
    const job = z.object({
      if: z.string(),
      permissions: z.record(z.string(), z.string()).optional(),
      concurrency: z.object({ group: z.string(), "cancel-in-progress": z.boolean() }).optional(),
      steps: z.array(step),
    });
    const workflow = z
      .object({
        on: z.object({
          pull_request: z.object({ paths: z.array(z.string()) }),
          label: z.object({ types: z.array(z.string()) }),
          schedule: z.array(z.object({ cron: z.string() })),
          workflow_dispatch: z.object({
            inputs: z.record(z.string(), z.object({ default: z.boolean() })),
          }),
        }),
        permissions: z.record(z.string(), z.string()),
        jobs: z.object({ validate: job, sync: job }),
      })
      .parse(parse(await readFile(new URL("../sync-repo-labels.yaml", import.meta.url), "utf8")));
    expect(workflow.permissions).toEqual({ contents: "read" });
    expect(workflow.jobs.validate.permissions).toBeUndefined();
    expect(workflow.jobs.validate.if).toBe("github.event_name == 'pull_request'");
    expect(workflow.jobs.sync.if).toContain("github.event_name != 'pull_request'");
    expect(workflow.jobs.sync.if).toContain("github.repository == 'Azure/azure-rest-api-specs'");
    expect(workflow.jobs.sync.if).toContain("github.event.repository.default_branch");
    expect(workflow.jobs.sync.permissions).toEqual({ contents: "read", issues: "write" });
    expect(workflow.jobs.sync.concurrency).toEqual({
      group: "sync-repo-labels",
      "cancel-in-progress": false,
    });
    expect(workflow.on.label.types).toEqual(["created", "edited", "deleted"]);
    expect(workflow.on.schedule).not.toHaveLength(0);
    expect(Object.keys(workflow.on.workflow_dispatch.inputs)).toEqual(["dry-run"]);
    expect(workflow.on.workflow_dispatch.inputs["dry-run"].default).toBe(true);
    const steps = workflow.jobs.sync.steps;
    const audit = steps.findIndex((s) => s.id === "audit");
    const apply = steps.findIndex((s) => s.id === "apply");
    expect(audit).toBeGreaterThan(steps.findIndex((s) => s.id === "prepare"));
    expect(apply).toBeGreaterThan(audit);
    expect(steps[audit].with?.["if-no-files-found"]).toBe("error");
    expect(steps[apply].if).toBeUndefined();
    expect(steps.find((s) => s.id === "checkout")?.with?.ref).toBe(
      "${{ github.event.repository.default_branch }}",
    );
  });
});
