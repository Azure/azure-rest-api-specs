// FIXTURE (positive, version pair -- NEW stable version).
// Seeded violations against stable-2025-01-01.tsp: DP-VERSION-01 (property
// removed, union narrowed, optional request property made required, type
// changed) and DP-VERSION-03 (no @added / @removed / @renamedFrom anywhere).
// Not a real service. Not under specification/; not compiled by CI.

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service(#{ title: "Alert Registry" })
@versioned(Versions)
@server("https://{endpoint}", "Alert Registry service", { endpoint: string })
namespace AlertRegistry;

enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2025_01_01: "2025-01-01",

  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2026_01_01: "2026-01-01",
}

@doc("An alert rule.")
@resource("alertRules")
model AlertRule {
  @doc("The unique name of the alert rule.")
  @key
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Human-readable description of what the rule detects.")
  description: string;

  @doc("Severity assigned to alerts raised by this rule.")
  severity: AlertSeverity;

  // BREAKING (DP-VERSION-01): type changed int32 -> float64.
  @doc("Threshold above which the rule fires, in events per minute.")
  thresholdPerMinute: float64;

  @doc("Whether the rule is currently evaluated.")
  enabled: boolean;

  // BREAKING (DP-VERSION-01): `lastEvaluatedAt` was removed from the response
  // model with no @removed decorator, so existing callers lose the field.
}

// BREAKING (DP-VERSION-01): the union was open in 2025-01-01 and is closed
// here, and the `Informational` member was dropped. Values the service may
// still emit no longer deserialize.
@doc("Severity of an alert.")
union AlertSeverity {
  @doc("A condition worth investigating.")
  Warning: "Warning",

  @doc("A condition requiring immediate attention.")
  Critical: "Critical",
}

@doc("Payload for creating an alert rule.")
model AlertRuleCreate {
  @doc("Human-readable description of what the rule detects.")
  description: string;

  @doc("Severity assigned to alerts raised by this rule.")
  severity: AlertSeverity;

  @doc("Threshold above which the rule fires, in events per minute.")
  thresholdPerMinute: float64;

  // BREAKING (DP-VERSION-01): optional request property made required.
  @doc("Notification channel identifier.")
  notificationChannel: string;
}

interface AlertRules {
  @doc("Gets an alert rule.")
  get is StandardResourceOperations.ResourceRead<AlertRule>;

  @doc("Creates or updates an alert rule.")
  createOrUpdate is StandardResourceOperations.ResourceCreateOrUpdate<AlertRule>;

  @doc("Lists alert rules.")
  list is StandardResourceOperations.ResourceList<AlertRule>;
}
