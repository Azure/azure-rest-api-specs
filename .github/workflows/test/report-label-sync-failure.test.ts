import { Octokit } from "@octokit/rest";
import { describe, expect, it, vi } from "vitest";
import { reportLabelSyncFailure } from "../src/report-label-sync-failure.ts";
import { createMockContext, createMockCore } from "./mocks.ts";

const repo = { owner: "Azure", repo: "azure-rest-api-specs" };
const prefix = `/repos/${repo.owner}/${repo.repo}`;
const marker = "<!-- sync-repo-labels-failure -->";

interface Issue {
  number: number;
  title: string;
  body: string | null;
  html_url: string;
  pull_request?: { url: string };
}

function fixture() {
  const state = {
    issues: [] as Issue[],
    jobs: [
      {
        name: "sync",
        html_url: "https://github.com/Azure/azure-rest-api-specs/actions/runs/123/job/456",
        conclusion: "failure",
        steps: [{ name: "Apply audited changes", conclusion: "failure" }],
      },
    ],
    failure: "",
    requests: [] as { method: string; url: URL; body: { title?: string; body?: string } }[],
  };
  const fetch = vi.fn<typeof globalThis.fetch>(async (input, init) => {
    const url = new URL(input instanceof Request ? input.url : input.toString());
    const response = (data: unknown, status = 200, headers: Record<string, string> = {}) =>
      Object.defineProperty(
        new Response(JSON.stringify(data), {
          status,
          headers: { "content-type": "application/json", ...headers },
        }),
        "url",
        { value: url.href },
      );
    const method = init?.method ?? "GET";
    const body = JSON.parse(init?.body ? await new Response(init.body).text() : "{}") as {
      title?: string;
      body?: string;
    };
    state.requests.push({ method, url, body });
    if (`${method} ${url.pathname}` === state.failure) {
      return response({ message: "Injected failure" }, 403);
    }
    if (url.pathname.includes("/jobs")) {
      return response({ total_count: state.jobs.length, jobs: state.jobs });
    }
    if (url.pathname === `${prefix}/issues` && method === "GET") {
      const page = Number(url.searchParams.get("page") ?? 1);
      const count = Number(url.searchParams.get("per_page"));
      const headers: Record<string, string> = {};
      if (page * count < state.issues.length) {
        headers.link = `<https://api.github.com${prefix}/issues?per_page=${count}&page=${page + 1}>; rel="next"`;
      }
      return response(state.issues.slice((page - 1) * count, page * count), 200, headers);
    }
    if (url.pathname === `${prefix}/issues` && method === "POST") {
      const issue = {
        number: state.issues.length + 1,
        title: body.title!,
        body: body.body!,
        html_url: `https://github.com/${repo.owner}/${repo.repo}/issues/${state.issues.length + 1}`,
      };
      state.issues.push(issue);
      return response(issue, 201);
    }
    if (url.pathname.startsWith(`${prefix}/issues/`) && method === "PATCH") {
      const issue = state.issues.find(({ number }) => url.pathname.endsWith(`/${number}`));
      if (!issue) throw new Error(`Unknown issue: ${url.pathname}`);
      issue.body = body.body!;
      return response(issue);
    }
    throw new Error(`Unexpected request: ${method} ${url.toString()}`);
  });
  const core = createMockCore();
  core.info.mockImplementation(() => {});
  const args = {
    github: new Octokit({ auth: "test", request: { fetch } }),
    context: {
      ...createMockContext(),
      repo,
      issue: { ...repo, number: 0 },
      serverUrl: "https://github.com",
      eventName: "schedule",
      runId: 123,
      runAttempt: 2,
      runNumber: 10,
    },
    core,
  };
  const writes = () => state.requests.filter(({ method }) => method !== "GET");
  return { args, state, writes };
}

describe("label sync failure issues", () => {
  it("creates a tracking issue with the exact run attempt and failed step, without duplicate writes", async () => {
    const f = fixture();
    expect(await reportLabelSyncFailure(f.args)).toBe(
      "https://github.com/Azure/azure-rest-api-specs/issues/1",
    );
    expect(f.state.issues[0].body).toContain(marker);
    expect(f.state.issues[0].body).toContain("/actions/runs/123/attempts/2");
    expect(f.state.issues[0].body).toContain("Apply audited changes");
    const jobsRequest = f.state.requests[0];
    expect(jobsRequest.url.pathname).toBe(`${prefix}/actions/runs/123/attempts/2/jobs`);
    const lookup = f.state.requests.find(({ url }) => url.pathname === `${prefix}/issues`)!;
    expect(lookup.url.searchParams.get("state")).toBe("open");
    expect(lookup.url.searchParams.get("creator")).toBe("github-actions[bot]");

    await reportLabelSyncFailure(f.args);
    expect(f.writes().map(({ method }) => method)).toEqual(["POST"]);
  });

  it("reports job timeouts even when no step is marked as failed", async () => {
    const f = fixture();
    f.state.jobs[0].conclusion = "timed_out";
    f.state.jobs[0].steps = [];

    await reportLabelSyncFailure(f.args);

    expect(f.state.issues[0].body).toContain("/actions/runs/123/job/456");
    expect(f.state.issues[0].body).toContain("timed_out");
  });

  it("finds an existing issue beyond the first page by marker, not title, ignoring PRs", async () => {
    const f = fixture();
    f.state.issues = Array.from({ length: 201 }, (_, index) => ({
      number: index + 1,
      title: "Repository label synchronization is failing",
      body: null,
      html_url: `https://github.com/${repo.owner}/${repo.repo}/issues/${index + 1}`,
    }));
    f.state.issues[0] = {
      ...f.state.issues[0],
      body: marker,
      pull_request: { url: "https://api.github.com/repos/Azure/azure-rest-api-specs/pulls/1" },
    };
    f.state.issues[100].title = "Edited by a maintainer";
    f.state.issues[100].body = `${marker}\nPrevious failure`;

    await reportLabelSyncFailure(f.args);

    expect(f.writes().map(({ method, url }) => `${method} ${url.pathname}`)).toEqual([
      `PATCH ${prefix}/issues/101`,
    ]);
    expect(f.state.issues[100].title).toBe("Edited by a maintainer");
    expect(f.state.issues[100].body).toContain("/actions/runs/123/attempts/2");
    expect(
      f.state.requests.filter(
        ({ method, url }) => method === "GET" && url.pathname === `${prefix}/issues`,
      ),
    ).toHaveLength(2);
  });

  it.each(["lookup", "update"])(
    "surfaces %s failures instead of creating duplicate issues",
    async (failure) => {
      const f = fixture();
      f.state.issues = [
        {
          number: 1,
          title: "Existing issue",
          body: marker,
          html_url: "https://github.com/Azure/azure-rest-api-specs/issues/1",
        },
      ];
      f.state.failure = failure === "lookup" ? `GET ${prefix}/issues` : `PATCH ${prefix}/issues/1`;

      await expect(reportLabelSyncFailure(f.args)).rejects.toThrow("Injected failure");
      expect(f.writes().some(({ method }) => method === "POST")).toBe(false);
    },
  );
});
