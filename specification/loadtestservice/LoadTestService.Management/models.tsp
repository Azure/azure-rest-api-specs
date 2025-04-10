import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.LoadTestService;

/**
 * Resources provisioning states.
 */
union ResourceState {
  string,

  /**
   * Resource has been created.
   */
  Succeeded: "Succeeded",

  /**
   * Resource creation failed.
   */
  Failed: "Failed",

  /**
   * Resource creation was canceled.
   */
  Canceled: "Canceled",

  /**
   * Deleted state.
   */
  Deleted: "Deleted",
}

/**
 * Managed identity type to use for accessing encryption key Url.
 */
union Type {
  string,

  /**
   * System assigned identity.
   */
  SystemAssigned: "SystemAssigned",

  /**
   * User assigned identity.
   */
  UserAssigned: "UserAssigned",
}

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
union ManagedServiceIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserAssigned: "UserAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `SystemAssigned,UserAssigned`: "SystemAssigned,UserAssigned",
}

/**
 * LoadTest resource properties.
 */
model LoadTestProperties {
  /**
   * Description of the resource.
   */
  @maxLength(512)
  description?: string;

  /**
   * Resource provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceState;

  /**
   * Resource data plane URI.
   */
  @visibility(Lifecycle.Read)
  @maxLength(2083)
  dataPlaneURI?: string;

  /**
   * CMK Encryption property.
   */
  encryption?: EncryptionProperties;
}

/**
 * Key and identity details for Customer Managed Key encryption of load test resource.
 */
model EncryptionProperties {
  /**
   * All identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault.
   */
  identity?: EncryptionPropertiesIdentity;

  /**
   * key encryption key Url, versioned. Ex: https://contosovault.vault.azure.net/keys/contosokek/562a4bb76b524a1493a6afe8e536ee78 or https://contosovault.vault.azure.net/keys/contosokek.
   */
  keyUrl?: string;
}

/**
 * All identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault.
 */
model EncryptionPropertiesIdentity {
  /**
   * Managed identity type to use for accessing encryption key Url.
   */
  type?: Type;

  /**
   * User assigned identity to use for accessing key encryption key Url. Ex: /subscriptions/fa5fc227-a624-475e-b696-cdd604c735bc/resourceGroups/<resource group>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myId.
   */
  resourceId?: string;
}

/**
 * Managed service identity (system assigned and/or user assigned identities)
 */
model ManagedServiceIdentity {
  /**
   * The service principal ID of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  principalId?: string;

  /**
   * The tenant ID of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  tenantId?: string;

  /**
   * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
   */
  type: ManagedServiceIdentityType;

  /**
   * The set of user assigned identities associated with the resource. The userAssignedIdentities dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}. The dictionary values can be empty objects ({}) in requests.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

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

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Quota bucket resource properties.
 */
model QuotaResourceProperties {
  /**
   * Current quota limit of the quota bucket.
   */
  limit?: int32;

  /**
   * Current quota usage of the quota bucket.
   */
  usage?: int32;

  /**
   * Resource provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceState;
}

/**
 * Request object of new quota for a quota bucket.
 */
model QuotaBucketRequest {
  /**
   * Request object of new quota for a quota bucket.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: QuotaBucketRequestProperties;
}

/**
 * New quota request request properties.
 */
model QuotaBucketRequestProperties {
  /**
   * Current quota usage of the quota bucket.
   */
  currentUsage?: int32;

  /**
   * Current quota limit of the quota bucket.
   */
  currentQuota?: int32;

  /**
   * New quota limit of the quota bucket.
   */
  newQuota?: int32;

  /**
   * Dimensions for new quota request.
   */
  dimensions?: QuotaBucketRequestPropertiesDimensions;
}

/**
 * Dimensions for new quota request.
 */
model QuotaBucketRequestPropertiesDimensions {
  /**
   * Subscription Id dimension for new quota request of the quota bucket.
   */
  @minLength(1)
  subscriptionId?: string;

  /**
   * Location dimension for new quota request of the quota bucket.
   */
  @minLength(1)
  location?: string;
}

/**
 * Check quota availability response object.
 */
model CheckQuotaAvailabilityResponse {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Check quota availability response properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: CheckQuotaAvailabilityResponseProperties;
}

/**
 * Check quota availability response properties.
 */
model CheckQuotaAvailabilityResponseProperties {
  /**
   * True/False indicating whether the quota request be granted based on availability.
   */
  isAvailable?: boolean;

  /**
   * Message indicating additional details to add to quota support request.
   */
  availabilityStatus?: string;
}

/**
 * The type used for update operations of the LoadTestResource.
 */
model LoadTestResourceUpdate {
  /**
   * The managed service identities assigned to this resource.
   */
  identity?: ManagedServiceIdentity;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The resource-specific properties for this resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: LoadTestResourceUpdateProperties;
}

/**
 * The updatable properties of the LoadTestResource.
 */
model LoadTestResourceUpdateProperties {
  /**
   * Description of the resource.
   */
  @maxLength(512)
  description?: string;

  /**
   * CMK Encryption property.
   */
  encryption?: EncryptionProperties;
}

/**
 * Values returned by the List operation.
 */
model PagedOutboundEnvironmentEndpoint
  is Azure.Core.Page<OutboundEnvironmentEndpoint>;

/**
 * A collection of related endpoints from the same service for which the Batch service requires outbound access.
 */
model OutboundEnvironmentEndpoint {
  /**
   * The type of service that Azure Load Testing connects to.
   */
  @visibility(Lifecycle.Read)
  category?: string;

  /**
   * The endpoints for this service to which the Batch service makes outbound calls.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["domainName"])
  endpoints?: EndpointDependency[];
}

/**
 * A domain name and connection details used to access a dependency.
 */
model EndpointDependency {
  /**
   * The domain name of the dependency. Domain names may be fully qualified or may contain a * wildcard.
   */
  @visibility(Lifecycle.Read)
  domainName: string;

  /**
   * Human-readable supplemental information about the dependency and when it is applicable.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The list of connection details for this endpoint.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["port"])
  endpointDetails?: EndpointDetail[];
}

/**
 * Details about the connection between the Batch service and the endpoint.
 */
model EndpointDetail {
  /**
   * The port an endpoint is connected to.
   */
  @visibility(Lifecycle.Read)
  port?: int32;
}
