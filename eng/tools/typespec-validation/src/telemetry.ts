import { isFullGitSha } from "@azure-tools/specs-shared/git";
import { execFile } from "@azure-tools/specs-shared/exec";
import type { AzureMonitorExporterOptions } from "@azure/monitor-opentelemetry-exporter";
import type { SpanExporter } from "@opentelemetry/sdk-trace-base";
import { readFile, realpath } from "node:fs/promises";
import path, { type PlatformPath } from "node:path";

export type CommandOutcome =
  | "success"
  | "validation_failed"
  | "suppressed"
  | "invalid_input"
  | "error";
type RuleOutcome = "success" | "failure" | "suppressed" | "error";

export interface BatchTelemetry {
  discovered: number;
  selected: number;
  suppressed: number;
  launched: number;
  zeroExit: number;
  nonzeroExit: number;
  completed: boolean;
}

export interface TsvTelemetry {
  command: {
    mode: "unknown" | "project" | "all";
    outcome: CommandOutcome;
    checkingAllSpecs: boolean;
    ruleCount: number;
  };
  batch?: BatchTelemetry;
  setProject(folder: string): Promise<void>;
  startRule(name: string): { end(outcome: RuleOutcome): void };
  childEnvironment(): NodeJS.ProcessEnv;
  shutdown(exitCode: number): Promise<void>;
}

const traceParentVariable = "TSV_TELEMETRY_TRACEPARENT";

function debug(message: string) {
  if (process.env.TSV_TELEMETRY_DEBUG === "true") {
    console.error(`[tsv:telemetry] ${message}`);
  }
}

export function isTelemetryEnabled(value = process.env.AZSDKTOOLS_COLLECT_TELEMETRY): boolean {
  return value === undefined || value === "" || value.trim().toLowerCase() === "true";
}

export function relativeProjectPath(
  root: string,
  folder: string,
  platform: PlatformPath = path,
): string | undefined {
  const relative = platform.relative(root, folder);
  const segments = relative.split(platform.sep);
  if (
    platform.isAbsolute(relative) ||
    segments[0] !== "specification" ||
    segments.length < 2 ||
    relative.length > 1024 ||
    [...relative].some((character) => character.charCodeAt(0) < 32 || character === "\u007f")
  ) {
    return undefined;
  }
  return segments.join("/");
}

export async function getProjectPath(folder: string): Promise<string | undefined> {
  try {
    // Avoid simple-git's globally enabled debug output for telemetry-only work.
    const { stdout } = await execFile("git", ["rev-parse", "--show-toplevel"], { cwd: folder });
    const root = await realpath(stdout.trim());
    // Git follows cwd symlinks and could otherwise identify a different repository.
    if (!relativeProjectPath(root, path.resolve(folder))) return undefined;
    const resolved = await realpath(folder);
    return relativeProjectPath(root, resolved);
  } catch {
    debug("Project path omitted: repository or real path could not be resolved.");
    return undefined;
  }
}

export async function createAzureMonitorExporter(
  connectionString: string,
  httpClient?: AzureMonitorExporterOptions["httpClient"],
): Promise<SpanExporter> {
  const { AzureMonitorTraceExporter } = await import("@azure/monitor-opentelemetry-exporter");
  // The exporter reads these settings synchronously in its constructor.
  const settings = {
    APPLICATION_INSIGHTS_NO_STATSBEAT: process.env.APPLICATION_INSIGHTS_NO_STATSBEAT,
    APPLICATIONINSIGHTS_OPENTELEMETRY_RESOURCE_METRIC_DISABLED:
      process.env.APPLICATIONINSIGHTS_OPENTELEMETRY_RESOURCE_METRIC_DISABLED,
  };
  process.env.APPLICATION_INSIGHTS_NO_STATSBEAT = "true";
  process.env.APPLICATIONINSIGHTS_OPENTELEMETRY_RESOURCE_METRIC_DISABLED = "true";
  try {
    return new AzureMonitorTraceExporter({
      connectionString,
      disableOfflineStorage: true,
      httpClient,
      retryOptions: { maxRetries: 0 },
      additionalPolicies: [
        {
          position: "perCall",
          policy: {
            name: "tsvTelemetryTimeout",
            sendRequest(request, next) {
              request.timeout = 2000;
              return next(request);
            },
          },
        },
      ],
    });
  } finally {
    for (const [key, value] of Object.entries(settings)) {
      if (value === undefined) delete process.env[key];
      else process.env[key] = value;
    }
  }
}

export async function createTelemetry(exporter?: SpanExporter): Promise<TsvTelemetry | undefined> {
  const parent = process.env[traceParentVariable];
  // Only TSV's direct children inherit this context, not compilers or other tools.
  delete process.env[traceParentVariable];
  if (!isTelemetryEnabled()) return undefined;

  const connectionString = process.env.TSV_APPLICATIONINSIGHTS_CONNECTION_STRING;
  if (!exporter && !connectionString) {
    debug("No TSV Application Insights destination configured; telemetry is not exported.");
    return undefined;
  }

  try {
    const [
      { ROOT_CONTEXT, trace, SpanStatusCode, defaultTextMapGetter, defaultTextMapSetter },
      { W3CTraceContextPropagator, ExportResultCode },
      sdk,
      resources,
    ] = await Promise.all([
      import("@opentelemetry/api"),
      import("@opentelemetry/core"),
      import("@opentelemetry/sdk-trace-base"),
      import("@opentelemetry/resources"),
    ]);
    const packageJson: unknown = JSON.parse(
      await readFile(new URL("../package.json", import.meta.url), "utf8"),
    );
    if (
      typeof packageJson !== "object" ||
      packageJson === null ||
      !("version" in packageJson) ||
      typeof packageJson.version !== "string"
    ) {
      throw new Error("Invalid TSV package version");
    }
    const activeExporter = exporter ?? (await createAzureMonitorExporter(connectionString!));
    const provider = new sdk.BasicTracerProvider({
      resource: resources.resourceFromAttributes({
        "service.name": "typespec-validation",
        // Azure Monitor otherwise falls back to the machine's hostname.
        "service.instance.id": "tsv",
        "service.version": packageJson.version,
      }),
      sampler: new sdk.AlwaysOnSampler(),
      spanProcessors: [
        new sdk.BatchSpanProcessor(
          {
            export(spans, callback) {
              return activeExporter.export(spans, (result) => {
                if (result.code !== ExportResultCode.SUCCESS) {
                  debug("SDK export failed; telemetry may have been dropped.");
                }
                callback(result);
              });
            },
            shutdown: () => activeExporter.shutdown(),
          },
          { exportTimeoutMillis: 3000 },
        ),
      ],
    });
    const propagator = new W3CTraceContextPropagator();
    const parentContext = propagator.extract(
      ROOT_CONTEXT,
      { traceparent: parent },
      defaultTextMapGetter,
    );
    const tracer = provider.getTracer("tsv", packageJson.version);
    const commandSpan = tracer.startSpan(
      "tsv.command",
      {
        attributes: {
          "tsv.schema_version": 1,
          "tsv.batch_child": trace.getSpanContext(parentContext) !== undefined,
          "tsv.environment":
            process.env.GITHUB_ACTIONS === "true"
              ? "github"
              : process.env.TF_BUILD?.toLowerCase() === "true"
                ? "azure-pipelines"
                : process.env.CI
                  ? "ci"
                  : "local",
          "tsv.node_version": process.versions.node,
          "tsv.os": process.platform,
        },
      },
      parentContext,
    );
    const revision = process.env.GITHUB_SHA ?? process.env.BUILD_SOURCEVERSION;
    if (revision && isFullGitSha(revision)) commandSpan.setAttribute("tsv.revision", revision);
    const commandContext = trace.setSpan(ROOT_CONTEXT, commandSpan);
    let projectPath: string | undefined;
    const counts: Record<RuleOutcome, number> = {
      success: 0,
      failure: 0,
      suppressed: 0,
      error: 0,
    };
    let stopped = false;
    const telemetry: TsvTelemetry = {
      command: {
        mode: "unknown",
        outcome: "invalid_input",
        checkingAllSpecs: false,
        ruleCount: 0,
      },
      async setProject(folder) {
        projectPath = await getProjectPath(folder);
        if (projectPath) commandSpan.setAttribute("tsv.project", projectPath);
      },
      startRule(name) {
        const span = tracer.startSpan(
          "tsv.rule",
          { attributes: { "tsv.rule": name, "tsv.project": projectPath } },
          commandContext,
        );
        return {
          end(outcome) {
            counts[outcome]++;
            span.setAttribute("tsv.outcome", outcome);
            span.setStatus({
              code:
                outcome === "failure" || outcome === "error"
                  ? SpanStatusCode.ERROR
                  : SpanStatusCode.OK,
            });
            span.end();
          },
        };
      },
      childEnvironment() {
        const carrier: Record<string, string> = {};
        propagator.inject(commandContext, carrier, defaultTextMapSetter);
        return { ...process.env, [traceParentVariable]: carrier.traceparent };
      },
      async shutdown(exitCode) {
        if (stopped) return;
        stopped = true;
        const { mode, outcome, checkingAllSpecs, ruleCount } = telemetry.command;
        commandSpan.setAttributes({
          "tsv.mode": mode,
          "tsv.outcome": outcome,
          "tsv.exit_code": exitCode,
          "tsv.checking_all_specs": checkingAllSpecs,
          "tsv.rules.succeeded": counts.success,
          "tsv.rules.failed": counts.failure,
          "tsv.rules.errors": counts.error,
          "tsv.rules.suppressed": counts.suppressed,
          "tsv.rules.not_reached":
            ruleCount - counts.success - counts.failure - counts.error - counts.suppressed,
        });
        if (telemetry.batch) {
          const batch = telemetry.batch;
          commandSpan.setAttributes({
            "tsv.projects.discovered": batch.discovered,
            "tsv.projects.selected": batch.selected,
            "tsv.projects.suppressed_before_launch": batch.suppressed,
            "tsv.projects.launched": batch.launched,
            "tsv.projects.zero_exit": batch.zeroExit,
            "tsv.projects.nonzero_exit": batch.nonzeroExit,
            "tsv.batch_completed": batch.completed,
          });
        }
        commandSpan.setStatus({
          code:
            outcome === "success" || outcome === "suppressed"
              ? SpanStatusCode.OK
              : SpanStatusCode.ERROR,
        });
        commandSpan.end();
        try {
          await provider.shutdown();
        } catch {
          debug("SDK shutdown failed; telemetry may have been dropped.");
        }
      },
    };
    return telemetry;
  } catch {
    debug("SDK initialization failed; telemetry is not exported.");
    return undefined;
  }
}
