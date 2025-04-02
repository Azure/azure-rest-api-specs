import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Insights;

@doc("Common fields for metric alert rule actions")
model MetricAlertRuleAction {
  @doc("The resource ID of the action group")
  actionGroupId: string;
}

@doc("Base properties for all metric alerts")
model MetricAlertsPropertiesBase {
  @doc("The description of the metric alert")
  @maxLength(4096)
  description?: string;

  @doc("The severity of the metric alert")
  @minValue(0)
  @maxValue(4)
  severity: int32;

  @doc("Indicates whether this alert rule is enabled")
  enabled: boolean;

  @doc("The list of resource id's being monitored")
  scopes: string[];

  @doc("The frequency with which the metric alert is evaluated")
  evaluationFrequency: string;

  @doc("Indicates whether the alert should be auto resolved")
  autoMitigate?: boolean;

  @doc("The resource type of the target resource")
  targetResourceType?: string;

  @doc("The region of the target resource")
  targetResourceRegion?: string;

  @doc("The actions to take when the alert fires")
  actions?: MetricAlertRuleAction[];

  @doc("Custom properties for the alert. When provided, must contain at least one property.")
  customProperties?: Record<string>;

  @doc("Properties to customize alert actions. When provided, must contain at least one property.")
  actionProperties?: Record<string>;
}

@doc("Metric alert rule criteria")
model MetricAlertRuleCriteria {
  @doc("The threshold value that activates the alert")
  threshold?: float64;

  @doc("The operator used to compare the metric value against the threshold")
  operator?:
    | "Equals"
    | "NotEquals"
    | "GreaterThan"
    | "GreaterThanOrEqual"
    | "LessThan"
    | "LessThanOrEqual";
}

@doc("Query resolve configuration")
model QueryResolveConfiguration {
  @doc("Indicates whether the alert should be auto resolved")
  autoResolved?: boolean;

  @doc("The time after which the alert should be auto resolved")
  timeToResolve?: string;
}

@doc("Metric query criteria")
model MetricQueryCriteria {
  @doc("The query used to evaluate the alert rule")
  query?: string;
}

@doc("Properties specific to metric-based alerts")
model MetricAlertsMetricProperties extends MetricAlertsPropertiesBase {
  @doc("The period of time that is used to monitor alert activity")
  windowSize: string;

  @doc("The criteria that defines the alert conditions")
  criteria: MetricAlertRuleCriteria;
}

@doc("Properties specific to query-based alerts")
model MetricAlertsQueryProperties extends MetricAlertsPropertiesBase {
  @doc("The resolve configuration for query-based alerts")
  resolveConfiguration?: QueryResolveConfiguration;

  @doc("The criteria that defines the alert conditions")
  criteria: MetricQueryCriteria;
}

@discriminator("kind")
@doc("Properties for the metric alert resource")
model MetricAlertProperties {
  @doc("Indicates the type of metric alert")
  kind: "Metric" | "Query";
}

@discriminator("kind")
model MetricProperties extends MetricAlertProperties {
  kind: "Metric";
  ...MetricAlertsMetricProperties;
}

@discriminator("kind")
model QueryProperties extends MetricAlertProperties {
  kind: "Query";
  ...MetricAlertsQueryProperties;
}

@doc("Metric alert resource")
@resource("metricAlerts")
model MetricAlertResource extends Azure.ResourceManager.Foundations.Resource {
  @key
  @segment("metricAlerts")
  name: string;

  @doc("The properties of the metric alert")
  properties: MetricAlertProperties;
}

@doc("Model for patch operations")
model MetricAlertResourcePatch {
  @doc("Resource tags")
  tags?: Record<string>;

  @doc("Properties that can be modified in a patch operation")
  properties?: {
    @doc("Indicates whether this alert rule is enabled")
    enabled?: boolean;

    @doc("The actions to take when the alert fires")
    actions?: MetricAlertRuleAction[];
  };
}

@doc("Collection of metric alert resources")
model MetricAlertResourceCollection {
  @doc("List of metric alert rules")
  @body
  value: MetricAlertResource[];
}
