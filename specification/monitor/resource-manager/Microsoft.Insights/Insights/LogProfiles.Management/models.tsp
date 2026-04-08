import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.LogProfiles;

/**
 * The log profile properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LogProfileProperties {
  /**
   * the resource id of the storage account to which you would like to send the Activity Log.
   */
  storageAccountId?: string;

  /**
   * The service bus rule ID of the service bus namespace in which you would like to have Event Hubs created for streaming the Activity Log. The rule ID is of the format: '{service bus resource ID}/authorizationrules/{key name}'.
   */
  serviceBusRuleId?: string;

  /**
   * List of regions for which Activity Log events should be stored or streamed. It is a comma separated list of valid ARM locations including the 'global' location.
   */
  locations: string[];

  /**
   * the categories of the logs. These categories are created as is convenient to the user. Some values are: 'Write', 'Delete', and/or 'Action.'
   */
  categories: string[];

  /**
   * the retention policy for the events in the log.
   */
  retentionPolicy: RetentionPolicy;
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
 * The log profile resource for patch operations.
 */
model LogProfileResourcePatch {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The log profile properties for an update operation.
   */
  properties?: LogProfileProperties;
}

/**
 * Represents a collection of log profiles.
 */
model LogProfileCollection {
  /**
   * the values of the log profiles.
   */
  @pageItems
  value: LogProfileResource[];

  /**
   * the URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
}
