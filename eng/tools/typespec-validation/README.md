# TypeSpec Validation

TSV validates TypeSpec projects in this repository. See the
[TypeSpec Validation guide](https://github.com/Azure/azure-rest-api-specs/wiki/TypeSpec-Validation)
for commands, validation rules, and suppressions.

## Telemetry

TSV supports usage and performance telemetry through Azure Monitor OpenTelemetry.
The collection setting defaults to enabled for local and CI runs. Set
`AZSDKTOOLS_COLLECT_TELEMETRY=false` to opt out:

```sh
AZSDKTOOLS_COLLECT_TELEMETRY=false pnpm tsv specification/contosowidgetmanager/Contoso.Management
```

```powershell
$env:AZSDKTOOLS_COLLECT_TELEMETRY = "false"
pnpm tsv specification/contosowidgetmanager/Contoso.Management
```

Telemetry is sent to TSV's dedicated Application Insights resource by default.
Set `TSV_APPLICATIONINSIGHTS_CONNECTION_STRING` to select an alternate instance
for testing. An unset or empty value uses TSV's default destination.
TSV does not use another application's
`APPLICATIONINSIGHTS_CONNECTION_STRING` or the Azure SDK MCP destination.

Collected data is limited to:

- Command and top-level rule durations, outcomes, and suppression counts.
- Repository-relative project paths under `specification/`. Paths outside that
  directory, unresolved paths, and symlink escapes are omitted.
- TSV, Node, SDK, and OS versions; execution environment (local, GitHub Actions,
  Azure Pipelines, or other CI); and an available CI commit SHA.
- Native `--all` discovery/selection counts, pre-launch suppression counts, child
  exit counts, and batch completion. Trace IDs correlate a batch with its TSV children.

TSV does not collect persistent user/device IDs, hostnames, absolute paths, raw
arguments, arbitrary context values, source contents, diagnostic output, exception
messages/stacks, or suppression reasons. SDK host detection, automatic dependency
instrumentation, Statsbeat, and resource metrics are not enabled. No telemetry
files are persisted.

The SDK buffers and exports spans independently in each TSV process. Delivery is
best effort: telemetry failures do not change validation results. SDK requests
have a two-second timeout with no HTTP retries, and the batch processor has a
three-second export timeout. Shutdown uses the SDK lifecycle, not a custom uploader.
Set `TSV_TELEMETRY_DEBUG=true` for sanitized telemetry diagnostics on stderr.

Telemetry observes only TSV code. The current PowerShell CI orchestrator's
pre-launch suppressions, sharding, and total job duration are not included.

### Schema

Schema version `1` uses service name `typespec-validation`. Explicit internal
spans appear in Application Insights as dependencies (`dependencies`, or
`AppDependencies` in workspace queries).

| Span          | Attributes                                                                                                                                                                                                |
| ------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `tsv.command` | `tsv.schema_version`, `tsv.mode`, `tsv.outcome`, `tsv.exit_code`, `tsv.checking_all_specs`, `tsv.batch_child`, `tsv.environment`, `tsv.node_version`, `tsv.os`, optional `tsv.project` and `tsv.revision` |
| `tsv.rule`    | `tsv.rule`, `tsv.outcome`, optional `tsv.project`                                                                                                                                                         |

Command rule counters are `tsv.rules.succeeded`, `failed`, `errors`, `suppressed`,
and `not_reached`. Suppression counts include whole top-level rules, not sub-rules.
A successful rule result can include internal checks that were not applicable.
Rules not reached after a failure do not have execution spans.

Native batch attributes are `tsv.projects.discovered`, `selected`,
`suppressed_before_launch`, `launched`, `zero_exit`, and `nonzero_exit`, plus
`tsv.batch_completed`. Discovered counts precede sharding; selected counts follow it.
A zero-exit child may have been suppressed internally and is not necessarily a
successful validation. An aborted batch is not marked complete.

Command outcomes are `success`, `validation_failed`, `suppressed`, `invalid_input`,
and `error`. Rule outcomes are `success`, `failure`, `suppressed`, and `error`.
Numeric counters are stored in custom dimensions by the exporter and can be
converted with `toint()`.

For example, group top-level invocations by outcome, excluding batch children:

```kusto
dependencies
| where cloud_RoleName == "typespec-validation" and name == "tsv.command"
| where tostring(customDimensions["tsv.batch_child"]) == "false"
| summarize invocations = count() by outcome = tostring(customDimensions["tsv.outcome"])
```

For rule performance:

```kusto
dependencies
| where cloud_RoleName == "typespec-validation" and name == "tsv.rule"
| where tostring(customDimensions["tsv.outcome"]) != "suppressed"
| summarize p50 = percentile(duration, 50), p95 = percentile(duration, 95)
    by ruleName = tostring(customDimensions["tsv.rule"]),
       projectPath = tostring(customDimensions["tsv.project"])
```

The package's Vitest configuration opts out by default, including subprocesses.
Telemetry tests use in-memory exporters, a mocked Azure HTTP client, or loopback
connections with a synthetic instrumentation key. Tests must not contact a live
Application Insights resource.
