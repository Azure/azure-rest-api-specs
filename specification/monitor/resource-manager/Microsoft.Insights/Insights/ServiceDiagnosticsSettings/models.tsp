import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Microsoft.Common;

namespace Microsoft.ServiceDiagnosticsSettings;

/**
 * The diagnostic settings for service.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ServiceDiagnosticSettings {
  /**
   * The resource ID of the storage account to which you would like to send Diagnostic Logs.
   */
  storageAccountId?: string;

  /**
   * The service bus rule ID of the service bus namespace in which you would like to have Event Hubs created for streaming Diagnostic Logs. The rule ID is of the format: '{service bus resource ID}/authorizationrules/{key name}'.
   */
  serviceBusRuleId?: string;

  /**
   * The resource Id for the event hub namespace authorization rule.
   */
  eventHubAuthorizationRuleId?: string;

  /**
   * the list of metric settings.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  metrics?: MetricSettings[];

  /**
   * the list of logs settings.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  logs?: LogSettings[];

  /**
   * The workspace ID (resource ID of a Log Analytics workspace) for a Log Analytics workspace to which you would like to send Diagnostic Logs. Example: /subscriptions/4b9e8510-67ab-4e9a-95a9-e2f1e570ea9c/resourceGroups/insights-integration/providers/Microsoft.OperationalInsights/workspaces/viruela2
   */
  workspaceId?: string;
}

/**
 * Part of MultiTenantDiagnosticSettings. Specifies the settings for a particular metric.
 */
model MetricSettings {
  /**
   * the timegrain of the metric in ISO8601 format.
   */
  timeGrain: duration;

  /**
   * a value indicating whether this timegrain is enabled.
   */
  enabled: boolean;

  /**
   * the retention policy for this timegrain.
   */
  retentionPolicy?: RetentionPolicy;
}

/**
 * Part of MultiTenantDiagnosticSettings. Specifies the settings for a particular log.
 */
model LogSettings {
  /**
   * Name of a Diagnostic Log category for a resource type this setting is applied to. To obtain the list of Diagnostic Log categories for a resource, first perform a GET diagnostic settings operation.
   */
  category?: string;

  /**
   * a value indicating whether this log is enabled.
   */
  enabled: boolean;

  /**
   * the retention policy for this log.
   */
  retentionPolicy?: RetentionPolicy;
}

/**
 * An azure resource object
 */
model Resource {
  /**
   * Azure resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Azure resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Azure resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource location
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Service diagnostic setting resource for patch operations
 */
model ServiceDiagnosticSettingsResourcePatch {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The service diagnostics settings for an update operation.
   */
  properties?: ServiceDiagnosticSettings;
}
