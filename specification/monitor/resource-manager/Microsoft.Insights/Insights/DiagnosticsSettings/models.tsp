import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace DiagnosticsSettings;

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
 * The type of the diagnostic settings category.
 */
union CategoryType {
  string,

  /**
   * Metrics
   */
  Metrics: "Metrics",

  /**
   * Logs
   */
  Logs: "Logs",
}

/**
 * The diagnostic settings.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DiagnosticSettings {
  /**
   * The resource ID of the storage account to which you would like to send Diagnostic Logs.
   */
  storageAccountId?: string;

  /**
   * The service bus rule Id of the diagnostic setting. This is here to maintain backwards compatibility.
   */
  serviceBusRuleId?: string;

  /**
   * The resource Id for the event hub authorization rule.
   */
  eventHubAuthorizationRuleId?: string;

  /**
   * The name of the event hub. If none is specified, the default event hub will be selected.
   */
  eventHubName?: string;

  /**
   * The list of metric settings.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  metrics?: MetricSettings[];

  /**
   * The list of logs settings.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  logs?: LogSettings[];

  /**
   * The full ARM resource ID of the Log Analytics workspace to which you would like to send Diagnostic Logs. Example: /subscriptions/4b9e8510-67ab-4e9a-95a9-e2f1e570ea9c/resourceGroups/insights-integration/providers/Microsoft.OperationalInsights/workspaces/viruela2
   */
  workspaceId?: string;

  /**
   * The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic Logs.
   */
  marketplacePartnerId?: string;

  /**
   * A string indicating whether the export to Log Analytics should use the default destination type, i.e. AzureDiagnostics, or use a destination type constructed as follows: <normalized service identity>_<normalized category name>. Possible values are: Dedicated and null (null is default.)
   */
  logAnalyticsDestinationType?: string;
}

/**
 * Part of MultiTenantDiagnosticSettings. Specifies the settings for a particular metric.
 */
model MetricSettings {
  /**
   * the timegrain of the metric in ISO8601 format.
   */
  timeGrain?: duration;

  /**
   * Name of a Diagnostic Metric category for a resource type this setting is applied to. To obtain the list of Diagnostic metric categories for a resource, first perform a GET diagnostic settings operation.
   */
  category?: string;

  /**
   * a value indicating whether this category is enabled.
   */
  enabled: boolean;

  /**
   * the retention policy for this category.
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
   * Name of a Diagnostic Log category group for a resource type this setting is applied to. To obtain the list of Diagnostic Log categories for a resource, first perform a GET diagnostic settings operation.
   */
  categoryGroup?: string;

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
 * Represents a collection of alert rule resources.
 */
model DiagnosticSettingsResourceCollection {
  /**
   * The collection of diagnostic settings resources;.
   */
  @pageItems
  value?: DiagnosticSettingsResource[];

  /**
   * The URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The diagnostic settings Category.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DiagnosticSettingsCategory {
  /**
   * The type of the diagnostic settings category.
   */
  categoryType?: CategoryType;

  /**
   * the collection of what category groups are supported.
   */
  categoryGroups?: string[];
}

/**
 * Represents a collection of diagnostic setting category resources.
 */
model DiagnosticSettingsCategoryResourceCollection {
  /**
   * The collection of diagnostic settings category resources.
   */
  @pageItems
  value?: DiagnosticSettingsCategoryResource[];

  /**
   * The URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
}
