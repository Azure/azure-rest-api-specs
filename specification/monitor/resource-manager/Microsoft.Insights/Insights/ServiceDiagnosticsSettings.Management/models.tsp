import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace microsoft.insights;

/**
 * The diagnostic settings for service.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  metrics?: MetricSettings[];

  /**
   * the list of logs settings.
   */
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
 * Specifies the retention policy for the log.
 */
model RetentionPolicy {
  /**
   * a value indicating whether the retention policy is enabled.
   */
  enabled: boolean;

  /**
   * the number of days for the retention in days. A value of 0 will retain the events indefinitely.
   */
  @minValue(0)
  days: int32;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Describes the format of Error response.
 */
@error
model ErrorResponse {
  /**
   * Error code
   */
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  message?: string;
}

/**
 * Service diagnostic setting resource for patch operations
 */
model ServiceDiagnosticSettingsResourcePatch {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The service diagnostics settings for an update operation.
   */
  properties?: ServiceDiagnosticSettings;
}
