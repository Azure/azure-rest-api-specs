import { SpanStatusCode } from "@opentelemetry/api";
import { ExportResultCode } from "@opentelemetry/core";
import { InMemorySpanExporter } from "@opentelemetry/sdk-trace-base";
import { mkdir, mkdtemp, realpath, rm, symlink } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join, posix, win32 } from "node:path";
import { setTimeout } from "node:timers/promises";
import { simpleGit } from "simple-git";
import { afterEach, beforeEach, expect, it, vi, type MockInstance } from "vitest";
import { runRules } from "../src/index.ts";
import {
  createAzureMonitorExporter,
  createTelemetry,
  getProjectPath,
  isTelemetryEnabled,
  relativeProjectPath,
} from "../src/telemetry.ts";

const connectionString =
  "InstrumentationKey=00000000-0000-0000-0000-000000000001;IngestionEndpoint=https://tsv.invalid";
let exporter: InMemorySpanExporter;
let root: string;
let shutdown: MockInstance<() => Promise<void>>;

beforeEach(async () => {
  vi.stubEnv("AZSDKTOOLS_COLLECT_TELEMETRY", "true");
  vi.stubEnv("TSV_APPLICATIONINSIGHTS_CONNECTION_STRING", undefined);
  vi.stubEnv("TSV_TELEMETRY_TRACEPARENT", undefined);
  vi.stubEnv("TSV_TELEMETRY_DEBUG", "true");
  vi.stubEnv("APPLICATION_INSIGHTS_NO_STATSBEAT", undefined);
  vi.stubEnv("APPLICATIONINSIGHTS_OPENTELEMETRY_RESOURCE_METRIC_DISABLED", undefined);
  vi.spyOn(console, "log").mockImplementation(() => {});
  vi.spyOn(console, "error").mockImplementation(() => {});
  exporter = new InMemorySpanExporter();
  shutdown = vi.spyOn(exporter, "shutdown").mockResolvedValue();
  root = await realpath(await mkdtemp(join(tmpdir(), "tsv-telemetry-")));
});

afterEach(async () => {
  vi.restoreAllMocks();
  vi.unstubAllEnvs();
  await rm(root, { recursive: true, force: true });
});

it.each([
  [undefined, true],
  ["", true],
  ["true", true],
  ["TrUe", true],
  [" true ", true],
  ["false", false],
  ["False", false],
  ["0", false],
  ["1", false],
  ["yes", false],
  [" ", false],
])("honors the shared collection flag %s", (value, expected) => {
  vi.stubEnv("AZSDKTOOLS_COLLECT_TELEMETRY", value);
  expect(isTelemetryEnabled()).toBe(expected);
});

it("does not initialize or export when opted out", async () => {
  vi.stubEnv("AZSDKTOOLS_COLLECT_TELEMETRY", "false");
  vi.stubEnv("TSV_APPLICATIONINSIGHTS_CONNECTION_STRING", "invalid configuration");
  const exportSpy = vi.spyOn(exporter, "export");
  expect(await createTelemetry(exporter)).toBeUndefined();
  expect(exportSpy).not.toHaveBeenCalled();
  expect(shutdown).not.toHaveBeenCalled();
  expect(console.error).not.toHaveBeenCalled();
});

it("surfaces invalid configuration without echoing it", async () => {
  vi.stubEnv("TSV_APPLICATIONINSIGHTS_CONNECTION_STRING", "do-not-log-this");
  expect(await createTelemetry()).toBeUndefined();
  expect(console.error).toHaveBeenCalledWith(
    "[tsv:telemetry] SDK initialization failed; telemetry is not exported.",
  );
  expect(console.error).not.toHaveBeenCalledWith(expect.stringContaining("do-not-log-this"));
});

it.each([
  ["/repo", "/repo/specification/service/Project", "specification/service/Project", posix],
  ["/repo", "/repo/other", undefined, posix],
  ["/repo", "/else/specification/service", undefined, posix],
  ["/repo", "/repo/specification/../../private", undefined, posix],
  ["/repo", "/repo/specification", undefined, posix],
  ["/repo", "/repo/specification/name\nvalue", undefined, posix],
  ["C:\\repo", "C:\\repo\\specification\\service\\Project", "specification/service/Project", win32],
  ["C:\\repo", "D:\\specification\\private", undefined, win32],
  ["C:\\repo", "C:\\repo\\specification\\..\\..\\private", undefined, win32],
  ["\\\\host\\repo", "\\\\host\\repo\\specification\\service", "specification/service", win32],
  ["\\\\host\\repo", "\\\\other\\repo\\specification\\service", undefined, win32],
])("normalizes only contained specification paths: %s / %s", (base, folder, expected, platform) => {
  expect(relativeProjectPath(base, folder, platform)).toBe(expected);
});

it("resolves git roots and omits symlink escapes or folders outside git", async () => {
  const repo = join(root, "repo");
  const project = join(repo, "specification", "service", "Project");
  const outside = join(root, "outside");
  await mkdir(project, { recursive: true });
  await mkdir(outside);
  await simpleGit(repo).init();
  expect(await getProjectPath(project)).toBe("specification/service/Project");
  expect(await getProjectPath(outside)).toBeUndefined();
  await symlink(outside, join(repo, "specification", "escape"), "junction");
  expect(await getProjectPath(join(repo, "specification", "escape"))).toBeUndefined();
  const externalProject = join(outside, "specification", "PrivateProject");
  await mkdir(externalProject, { recursive: true });
  await simpleGit(outside).init();
  await symlink(externalProject, join(repo, "specification", "external-repo"), "junction");
  expect(await getProjectPath(join(repo, "specification", "external-repo"))).toBeUndefined();
});

it("records rules and suppression without changing fail-fast results", async () => {
  const telemetry = (await createTelemetry(exporter))!;
  telemetry.command.mode = "project";
  const result = await runRules(
    [
      { name: "Suppressed", description: "", suppressable: true, execute: vi.fn() },
      {
        name: "InternalSuppression",
        description: "",
        execute: () => Promise.resolve({ success: true, suppressed: true }),
      },
      { name: "Passed", description: "", execute: () => Promise.resolve({ success: true }) },
      {
        name: "Failed",
        description: "",
        execute: () => Promise.resolve({ success: false, errorOutput: "private diagnostic" }),
      },
      { name: "NotReached", description: "", execute: vi.fn() },
    ],
    root,
    [{ tool: "TypeSpecValidation", paths: ["."], rules: ["Suppressed"], reason: "private reason" }],
    telemetry,
  );
  expect(result).toEqual({
    success: false,
    suppressed: ["Suppressed"],
    executed: ["InternalSuppression", "Passed", "Failed"],
    failed: ["Failed"],
  });
  telemetry.command.outcome = "validation_failed";
  await telemetry.shutdown(1);
  const spans = exporter.getFinishedSpans();
  expect(spans.map((span) => span.attributes["tsv.outcome"])).toEqual([
    "suppressed",
    "suppressed",
    "success",
    "failure",
    "validation_failed",
  ]);
  const command = spans.at(-1)!;
  expect(command.attributes).toMatchObject({
    "tsv.rules.succeeded": 1,
    "tsv.rules.failed": 1,
    "tsv.rules.suppressed": 2,
    "tsv.rules.not_reached": 1,
    "tsv.exit_code": 1,
  });
  expect(command.status.code).toBe(SpanStatusCode.ERROR);
  for (const span of spans.slice(0, -1)) {
    expect(span.parentSpanContext?.spanId).toBe(command.spanContext().spanId);
  }
  expect(JSON.stringify(spans.map((span) => span.attributes))).not.toContain("private");
});

it("records a thrown rule error and rethrows the original failure", async () => {
  const telemetry = (await createTelemetry(exporter))!;
  const error = new Error("private failure");
  await expect(
    runRules(
      [
        {
          name: "Throwing",
          description: "",
          execute: () => Promise.reject(error),
        },
        { name: "NotReached", description: "", execute: vi.fn() },
      ],
      root,
      [],
      telemetry,
    ),
  ).rejects.toBe(error);
  telemetry.command.outcome = "error";
  await telemetry.shutdown(1);
  expect(exporter.getFinishedSpans().map((span) => span.attributes["tsv.outcome"])).toEqual([
    "error",
    "error",
  ]);
  expect(exporter.getFinishedSpans()[0].events).toEqual([]);
});

it("propagates batch context only to direct TSV children", async () => {
  const telemetry = (await createTelemetry(exporter))!;
  const childEnv = telemetry.childEnvironment();
  expect(childEnv.TSV_TELEMETRY_TRACEPARENT).toMatch(/^00-[0-9a-f]{32}-[0-9a-f]{16}-01$/);
  vi.stubEnv("TSV_TELEMETRY_TRACEPARENT", childEnv.TSV_TELEMETRY_TRACEPARENT);
  const child = (await createTelemetry(exporter))!;
  expect(process.env.TSV_TELEMETRY_TRACEPARENT).toBeUndefined();
  child.command.outcome = "suppressed";
  telemetry.command.outcome = "success";
  await child.shutdown(0);
  await telemetry.shutdown(0);
  const [childSpan, parentSpan] = exporter.getFinishedSpans();
  expect(childSpan.parentSpanContext?.spanId).toBe(parentSpan.spanContext().spanId);
  expect(childSpan.spanContext().traceId).toBe(parentSpan.spanContext().traceId);
  expect(childSpan.attributes["tsv.batch_child"]).toBe(true);
  expect(parentSpan.attributes["tsv.batch_child"]).toBe(false);
});

it("measures elapsed rule duration and shuts down only once", async () => {
  const telemetry = (await createTelemetry(exporter))!;
  telemetry.command.ruleCount = 1;
  const rule = telemetry.startRule("Compile");
  await setTimeout(15);
  rule.end("success");
  await telemetry.shutdown(0);
  await telemetry.shutdown(0);
  const duration = exporter.getFinishedSpans()[0].duration;
  expect(duration[0] * 1e3 + duration[1] / 1e6).toBeGreaterThanOrEqual(10);
  expect(shutdown).toHaveBeenCalledOnce();
});

it("reports export failures with sanitized debug-only diagnostics", async () => {
  vi.spyOn(exporter, "export").mockImplementation((_spans, callback) => {
    callback({ code: ExportResultCode.FAILED, error: new Error("private export failure") });
  });
  const telemetry = (await createTelemetry(exporter))!;
  await expect(telemetry.shutdown(0)).resolves.toBeUndefined();
  expect(console.error).toHaveBeenCalledWith(
    "[tsv:telemetry] SDK export failed; telemetry may have been dropped.",
  );
  expect(console.error).not.toHaveBeenCalledWith(expect.stringContaining("private"));
});

it("isolates SDK shutdown failure", async () => {
  shutdown.mockRejectedValue(new Error("private failure"));
  const telemetry = (await createTelemetry(exporter))!;
  await expect(telemetry.shutdown(1)).resolves.toBeUndefined();
  expect(console.error).toHaveBeenCalledWith(
    "[tsv:telemetry] SDK shutdown failed; telemetry may have been dropped.",
  );
});

it.each([undefined, "", connectionString])(
  "exports only the approved payload with destination override %s",
  async (override) => {
    vi.stubEnv("TSV_APPLICATIONINSIGHTS_CONNECTION_STRING", override);
    vi.stubEnv("OTEL_RESOURCE_ATTRIBUTES", "user.name=private-user,host.name=private-host");
    vi.stubEnv("OTEL_SERVICE_NAME", "private-service");
    vi.stubEnv("APPLICATIONINSIGHTS_CONNECTION_STRING", "do-not-use");
    const requests: { url: string; body: string; timeout: number }[] = [];
    const realExporter = await createAzureMonitorExporter(undefined, {
      sendRequest(request) {
        if (typeof request.body !== "string") throw new Error("Expected serialized envelope");
        requests.push({ url: request.url, body: request.body, timeout: request.timeout });
        return Promise.resolve({
          request,
          status: 200,
          headers: request.headers,
          bodyAsText: "{}",
        });
      },
    });
    const telemetry = (await createTelemetry(realExporter))!;
    const project = join(root, "specification", "service", "Project");
    await mkdir(project, { recursive: true });
    await simpleGit(root).init();
    await telemetry.setProject(project);
    telemetry.command.mode = "project";
    telemetry.command.ruleCount = 1;
    telemetry.command.outcome = "success";
    telemetry.startRule("Compile").end("success");
    await telemetry.shutdown(0);
    expect(requests).toHaveLength(1);
    expect(requests[0].url).toBe(
      override
        ? "https://tsv.invalid/v2.1/track"
        : "https://westus-0.in.applicationinsights.azure.com/v2.1/track",
    );
    expect(requests[0].timeout).toBe(2000);
    const envelopes = JSON.parse(requests[0].body) as {
      iKey: string;
      tags: Record<string, string>;
      data: { baseType: string; baseData: { name: string; properties: Record<string, unknown> } };
    }[];
    expect(envelopes).toHaveLength(2);
    for (const envelope of envelopes) {
      expect(envelope.iKey).toBe(
        override ? "00000000-0000-0000-0000-000000000001" : "88fc2996-ed66-4816-95d7-f6a29b997b50",
      );
      expect(envelope.data.baseType).toBe("RemoteDependencyData");
      expect(envelope.tags["ai.cloud.role"]).toBe("typespec-validation");
      expect(envelope.tags["ai.cloud.roleInstance"]).toBe("tsv");
      expect(envelope.data.baseData.properties["tsv.project"]).toBe(
        "specification/service/Project",
      );
      expect(Object.keys(envelope.tags).sort()).toEqual(
        [
          "ai.application.ver",
          "ai.cloud.role",
          "ai.cloud.roleInstance",
          "ai.device.osVersion",
          "ai.internal.sdkVersion",
          "ai.operation.id",
          "ai.operation.parentId",
        ]
          .filter((key) => key !== "ai.operation.parentId" || envelope.tags[key] !== undefined)
          .sort(),
      );
    }
    expect(envelopes[0].data.baseData).toMatchObject({
      name: "tsv.rule",
      properties: {
        "tsv.rule": "Compile",
        "tsv.outcome": "success",
        "tsv.project": "specification/service/Project",
      },
    });
    expect(Object.keys(envelopes[0].data.baseData.properties).sort()).toEqual([
      "tsv.outcome",
      "tsv.project",
      "tsv.rule",
    ]);
    expect(requests[0].body).not.toContain(root);
    expect(requests[0].body).not.toContain("private");
    expect(requests[0].body).not.toContain("do-not-use");
    expect(process.env.APPLICATION_INSIGHTS_NO_STATSBEAT).toBeUndefined();
  },
);
