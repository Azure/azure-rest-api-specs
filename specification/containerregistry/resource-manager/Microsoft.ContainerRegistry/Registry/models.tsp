import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using Azure.ResourceManager;
namespace Microsoft.ContainerRegistry;

/**
 * The provisioning state of the archive at the time the operation was called.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * The type of identity that last modified the resource.
 */
union LastModifiedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * Whether or not zone redundancy is enabled for this container registry
 */
union ZoneRedundancy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * The identity type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

/**
 * Managed identity for the resource.
 */
model IdentityProperties {
  /**
   * The principal ID of resource identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The identity type.
   */
  type?: ResourceIdentityType;

  /**
   * The list of user identities associated with the resource. The user identity
   * dictionary key references will be ARM resource ids in the form:
   * '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/
   *     providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserIdentityProperties>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model UserIdentityProperties {
  /**
   * The principal id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * The definition of a container registry operation.
 */
model OperationDefinition {
  /**
   * The origin information of the container registry operation.
   */
  origin?: string;

  /**
   * Operation name: {provider}/{resource}/{operation}.
   */
  name?: string;

  /**
   * The display information for the container registry operation.
   */
  display?: OperationDisplayDefinition;

  /**
   * The properties information for the container registry operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: OperationPropertiesDefinition;

  /**
   * This property indicates if the operation is an action or a data action
   * ref: https://docs.microsoft.com/en-us/azure/role-based-access-control/role-definitions#management-and-data-operations
   */
  isDataAction?: boolean;
}

/**
 * The display information for a container registry operation.
 */
model OperationDisplayDefinition {
  /**
   * The resource provider name: Microsoft.ContainerRegistry.
   */
  provider?: string;

  /**
   * The resource on which the operation is performed.
   */
  resource?: string;

  /**
   * The operation that users can perform.
   */
  operation?: string;

  /**
   * The description for the operation.
   */
  description?: string;
}

/**
 * The definition of Azure Monitoring properties.
 */
model OperationPropertiesDefinition {
  /**
   * The definition of Azure Monitoring service.
   */
  serviceSpecification?: OperationServiceSpecificationDefinition;
}

/**
 * The definition of Azure Monitoring list.
 */
model OperationServiceSpecificationDefinition {
  /**
   * A list of Azure Monitoring metrics definition.
   */
  @identifiers(#["name"])
  metricSpecifications?: OperationMetricSpecificationDefinition[];

  /**
   * A list of Azure Monitoring log definitions.
   */
  @identifiers(#["name"])
  logSpecifications?: OperationLogSpecificationDefinition[];
}

/**
 * The definition of Azure Monitoring metric.
 */
model OperationMetricSpecificationDefinition {
  /**
   * Metric name.
   */
  name?: string;

  /**
   * Metric display name.
   */
  displayName?: string;

  /**
   * Metric description.
   */
  displayDescription?: string;

  /**
   * Metric unit.
   */
  unit?: string;

  /**
   * Metric aggregation type.
   */
  aggregationType?: string;

  /**
   * Internal metric name.
   */
  internalMetricName?: string;
}

/**
 * The definition of Azure Monitoring log.
 */
model OperationLogSpecificationDefinition {
  /**
   * Log name.
   */
  name?: string;

  /**
   * Log display name.
   */
  displayName?: string;

  /**
   * Log blob duration.
   */
  blobDuration?: string;
}

/**
 * The result of a request to list container registry operations.
 */
model OperationListResult {
  /**
   * The list of container registry operations. Since this list may be incomplete, the nextLink field should be used to request the next list of operations.
   */
  @pageItems
  value?: OperationDefinition[];

  /**
   * The URI that can be used to request the next list of container registry operations.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The Active Directory Object that will be used for authenticating the token of a container registry.
 */
model ActiveDirectoryObject {
  /**
   * The user/group/application object ID for Active Directory Object that will be used for authenticating the token of a container registry.
   */
  objectId?: string;

  /**
   * The tenant ID of user/group/application object Active Directory Object that will be used for authenticating the token of a container registry.
   */
  tenantId?: string;
}
