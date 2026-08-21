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
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials,
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      scopes: ["https://alertregistry.azure.com/.default"],
    }
  ]>
)
@server("https://{endpoint}", "Alert Registry service", { endpoint: string })
namespace AlertRegistry;

enum Versions {
  v2025_01_01: "2025-01-01",
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

  @doc("Threshold above which the rule fires, in events per minute.")
  thresholdPerMinute: int32;

  @doc("Whether the rule is currently evaluated.")
  enabled: boolean;

  @doc("When the rule was most recently evaluated.")
  @visibility(Lifecycle.Read)
  lastEvaluatedAt: utcDateTime;
}

@doc("Severity of an alert.")
union AlertSeverity {
  string,

  @doc("Informational; no action required.")
  Informational: "Informational",

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
  thresholdPerMinute: int32;

  @doc("Notification channel identifier. Defaults to the workspace default.")
  notificationChannel?: string;
}

interface AlertRules {
  @doc("Gets an alert rule.")
  get is StandardResourceOperations.ResourceRead<AlertRule>;

  @doc("Creates or updates an alert rule.")
  createOrUpdate is StandardResourceOperations.ResourceCreateOrUpdate<AlertRule>;

  @doc("Lists alert rules.")
  list is StandardResourceOperations.ResourceList<AlertRule>;
}
