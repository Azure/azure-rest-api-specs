import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Automanage;

/**
 * Automanage configuration profile properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ConfigurationProfileProperties {
  /**
   * configuration dictionary of the configuration profile.
   */
  configuration?: Record<unknown>;
}

/**
 * The response of the list best practice operation.
 */
@pagedResult
model BestPracticeList {
  /**
   * Result of the list best practice operation.
   */
  @items
  value?: BestPractice[];
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Definition of the configuration profile.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ConfigurationProfileUpdate extends UpdateResource {
  /**
   * Properties of the configuration profile.
   */
  properties?: ConfigurationProfileProperties;
}

/**
 * Represents an update resource
 */
model UpdateResource {
  /**
   * The tags of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * The response of the list configuration profile operation.
 */
@pagedResult
model ConfigurationProfileList {
  /**
   * Result of the list ConfigurationProfile operation.
   */
  @items
  value?: ConfigurationProfile[];
}

/**
 * Automanage configuration profile assignment properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ConfigurationProfileAssignmentProperties {
  /**
   * The Automanage configurationProfile ARM Resource URI.
   */
  configurationProfile?: string;

  /**
   * The target VM resource URI
   */
  @visibility(Lifecycle.Read)
  targetId?: string;

  /**
   * The status of onboarding, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

/**
 * The response of the list configuration profile assignment operation.
 */
@pagedResult
model ConfigurationProfileAssignmentList {
  /**
   * Result of the list configuration profile assignment operation.
   */
  @items
  value?: ConfigurationProfileAssignment[];
}

/**
 * Data related to the report detail.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model AssignmentReportProperties {
  /**
   * Start time of the configuration profile assignment processing.
   */
  startTime?: string;

  /**
   * End time of the configuration profile assignment processing.
   */
  endTime?: string;

  /**
   * Last modified time of the configuration profile assignment processing.
   */
  @visibility(Lifecycle.Read)
  lastModifiedTime?: string;

  /**
   * Duration of the configuration profile assignment processing.
   */
  @visibility(Lifecycle.Read)
  duration?: duration;

  /**
   * Type of the configuration profile assignment processing (Initial/Consistency).
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The status of the configuration profile assignment.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The configurationProfile linked to the assignment.
   */
  @visibility(Lifecycle.Read)
  configurationProfile?: string;

  /**
   * List of resources processed by the configuration profile assignment.
   */
  @visibility(Lifecycle.Read)
  resources?: ReportResource[];

  /**
   * Error message, if any, returned by the configuration profile assignment processing.
   */
  @visibility(Lifecycle.Read)
  error?: ErrorDetail;

  /**
   * Version of the report format
   */
  @visibility(Lifecycle.Read)
  reportFormatVersion?: string;
}

/**
 * Details about the resource processed by the configuration profile assignment
 */
model ReportResource {
  /**
   * Name of the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * ARM id of the resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Status of the resource.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Error message, if any, returned when deploying the resource.
   */
  @visibility(Lifecycle.Read)
  error?: ErrorDetail;
}

/**
 * The response of the list report operation.
 */
@pagedResult
model ReportList {
  /**
   * Result of the list report operation.
   */
  @items
  value?: Report[];
}

/**
 * The list of ServicePrincipals.
 */
@pagedResult
model ServicePrincipalListResult {
  /**
   * The list of servicePrincipals.
   */
  @items
  value?: ServicePrincipal[];
}

/**
 * The Service Principal properties for the subscription.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ServicePrincipalProperties {
  /**
   * The Service Principal Id for the subscription.
   */
  @visibility(Lifecycle.Read)
  servicePrincipalId?: string;

  /**
   * Returns the contributor RBAC Role exist or not for the Service Principal Id.
   */
  @visibility(Lifecycle.Read)
  authorizationSet?: boolean;
}
