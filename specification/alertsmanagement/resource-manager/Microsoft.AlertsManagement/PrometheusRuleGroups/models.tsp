import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AlertsManagement;

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * Represents a collection of alert rule resources.
 */
model PrometheusRuleGroupResourceCollection {
  /**
   * the values for the alert rule resources.
   */
  @pageItems
  value?: PrometheusRuleGroupResource[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * An Azure Prometheus rule group.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrometheusRuleGroupProperties {
  /**
   * Rule group description.
   */
  description?: string;

  /**
   * Enable/disable rule group.
   */
  enabled?: boolean;

  /**
   * Apply rule to data from a specific cluster.
   */
  clusterName?: string;

  /**
   * Target Azure Monitor workspaces resource ids. This api-version is currently limited to creating with one scope. This may change in future.
   */
  scopes: string[];

  /**
   * The interval in which to run the Prometheus rule group represented in ISO 8601 duration format. Should be between 1 and 15 minutes
   */
  interval?: duration;

  /**
   * Defines the rules in the Prometheus rule group.
   */
  @identifiers(#[])
  rules: PrometheusRule[];
}

/**
 * An Azure Prometheus alerting or recording rule.
 */
model PrometheusRule {
  /**
   * Recorded metrics name.
   */
  record?: string;

  /**
   * Alert rule name.
   */
  alert?: string;

  /**
   * Enable/disable rule.
   */
  enabled?: boolean;

  /**
   * The PromQL expression to evaluate. https://prometheus.io/docs/prometheus/latest/querying/basics/. Evaluated periodically as given by 'interval', and the result recorded as a new set of time series with the metric name as given by 'record'.
   */
  expression: string;

  /**
   * Labels to add or overwrite before storing the result.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  labels?: Record<string>;

  /**
   * The severity of the alerts fired by the rule. Must be between 0 and 4.
   */
  severity?: int32;

  /**
   * The amount of time alert must be active before firing.
   */
  for?: duration;

  /**
   * The annotations clause specifies a set of informational labels that can be used to store longer additional information such as alert descriptions or runbook links. The annotation values can be templated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  annotations?: Record<string>;

  /**
   * Actions that are performed when the alert rule becomes active, and when an alert condition is resolved.
   */
  @identifiers(#[])
  actions?: PrometheusRuleGroupAction[];

  /**
   * Defines the configuration for resolving fired alerts. Only relevant for alerts.
   */
  resolveConfiguration?: PrometheusRuleResolveConfiguration;
}

/**
 * An alert action. Only relevant for alerts.
 */
model PrometheusRuleGroupAction {
  /**
   * The resource id of the action group to use.
   */
  actionGroupId?: string;

  /**
   * The properties of an action group object.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  actionProperties?: Record<string>;
}

/**
 * Specifies the Prometheus alert rule configuration.
 */
model PrometheusRuleResolveConfiguration {
  /**
   * Enable alert auto-resolution.
   */
  autoResolved?: boolean;

  /**
   * Alert auto-resolution timeout.
   */
  timeToResolve?: duration;
}

/**
 * The Prometheus rule group resource for patch operations.
 */
model PrometheusRuleGroupResourcePatchParameters {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: PrometheusRuleGroupResourcePatchParametersProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrometheusRuleGroupResourcePatchParametersProperties {
  /**
   * the flag that indicates whether the Prometheus rule group is enabled.
   */
  enabled?: boolean;
}
