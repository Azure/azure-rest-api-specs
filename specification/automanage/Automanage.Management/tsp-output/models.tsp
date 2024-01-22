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

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Automanage configuration profile properties.
 */
model ConfigurationProfileProperties {
  /**
   * configuration dictionary of the configuration profile.
   */
  configuration?: Record<unknown>;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;
}

/**
 * Definition of the configuration profile.
 */
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
  tags?: Record<string>;
}

/**
 * Automanage configuration profile assignment properties.
 */
model ConfigurationProfileAssignmentProperties {
  /**
   * The Automanage configurationProfile ARM Resource URI.
   */
  configurationProfile?: string;

  /**
   * The target VM resource URI
   */
  @visibility("read")
  targetId?: string;

  /**
   * The status of onboarding, which only appears in the response.
   */
  @visibility("read")
  status?: string;
}

/**
 * Data related to the report detail.
 */
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
  @visibility("read")
  lastModifiedTime?: string;

  /**
   * Duration of the configuration profile assignment processing.
   */
  @visibility("read")
  duration?: duration;

  /**
   * Type of the configuration profile assignment processing (Initial/Consistency).
   */
  @visibility("read")
  type?: string;

  /**
   * The status of the configuration profile assignment.
   */
  @visibility("read")
  status?: string;

  /**
   * The configurationProfile linked to the assignment.
   */
  @visibility("read")
  configurationProfile?: string;

  /**
   * List of resources processed by the configuration profile assignment.
   */
  @visibility("read")
  resources?: ReportResource[];

  /**
   * Error message, if any, returned by the configuration profile assignment processing.
   */
  @visibility("read")
  error?: ErrorDetail;

  /**
   * Version of the report format
   */
  @visibility("read")
  reportFormatVersion?: string;
}

/**
 * Details about the resource processed by the configuration profile assignment
 */
model ReportResource {
  /**
   * Name of the resource.
   */
  @visibility("read")
  name?: string;

  /**
   * ARM id of the resource.
   */
  @visibility("read")
  id?: string;

  /**
   * Type of the resource.
   */
  @visibility("read")
  type?: string;

  /**
   * Status of the resource.
   */
  @visibility("read")
  status?: string;

  /**
   * Error message, if any, returned when deploying the resource.
   */
  @visibility("read")
  error?: ErrorDetail;
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
 * The Service Principal Id for the subscription.
 */
model ServicePrincipal extends ProxyResource {
  /**
   * The Service Principal properties for the subscription
   */
  properties?: ServicePrincipalProperties;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * The Service Principal properties for the subscription.
 */
model ServicePrincipalProperties {
  /**
   * The Service Principal Id for the subscription.
   */
  @visibility("read")
  servicePrincipalId?: string;

  /**
   * Returns the contributor RBAC Role exist or not for the Service Principal Id.
   */
  @visibility("read")
  authorizationSet?: boolean;
}
