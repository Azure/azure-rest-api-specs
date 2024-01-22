import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.LoadTestService;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Resources provisioning states.
 */
enum ResourceState {
  Succeeded,
  Failed,
  Canceled,
  Deleted,
}

/**
 * Managed identity type to use for accessing encryption key Url
 */
enum Type {
  SystemAssigned,
  UserAssigned,
}

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
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
  @visibility("read")
  provisioningState?: ResourceState;
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

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Request object of new quota for a quota bucket.
 */
model QuotaBucketRequest extends Resource {
  /**
   * New quota request request properties.
   */
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
model CheckQuotaAvailabilityResponse extends Resource {
  /**
   * Check quota availability response properties.
   */
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
  @visibility("read")
  provisioningState?: ResourceState;

  /**
   * Resource data plane URI.
   */
  @visibility("read")
  @maxLength(2083)
  dataPlaneURI?: string;

  /**
   * CMK Encryption property.
   */
  encryption?: EncryptionProperties;
}

/**
 * Key and identity details for Customer Managed Key encryption of load test resource
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
   * Managed identity type to use for accessing encryption key Url
   */
  @projectedName("json", "type")
  identityType?: Type;

  /**
   * user assigned identity to use for accessing key encryption key Url. Ex: /subscriptions/fa5fc227-a624-475e-b696-cdd604c735bc/resourceGroups/<resource group>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myId
   */
  resourceId?: string;
}

/**
 * LoadTest resource patch request body.
 */
model LoadTestResourcePatchRequestBody {
  /**
   * Resource tags.
   */
  tags?: Record<string>;

  /**
   * The type of identity used for the resource.
   */
  identity?: ManagedServiceIdentity;

  /**
   * Load Test resource properties
   */
  properties?: LoadTestResourcePatchRequestBodyProperties;
}

/**
 * Load Test resource properties
 */
model LoadTestResourcePatchRequestBodyProperties {
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
model OutboundEnvironmentEndpointCollection
  is Azure.Core.Page<OutboundEnvironmentEndpoint>;

/**
 * A collection of related endpoints from the same service for which the Batch service requires outbound access.
 */
model OutboundEnvironmentEndpoint {
  /**
   * The type of service that Azure Load Testing connects to.
   */
  @visibility("read")
  category?: string;

  /**
   * The endpoints for this service to which the Batch service makes outbound calls.
   */
  @visibility("read")
  endpoints?: EndpointDependency[];
}

/**
 * A domain name and connection details used to access a dependency.
 */
model EndpointDependency {
  /**
   * The domain name of the dependency. Domain names may be fully qualified or may contain a * wildcard.
   */
  @visibility("read")
  domainName?: string;

  /**
   * Human-readable supplemental information about the dependency and when it is applicable.
   */
  @visibility("read")
  description?: string;

  /**
   * The list of connection details for this endpoint.
   */
  @visibility("read")
  endpointDetails?: EndpointDetail[];
}

/**
 * Details about the connection between the Batch service and the endpoint.
 */
model EndpointDetail {
  /**
   * The port an endpoint is connected to.
   */
  @visibility("read")
  port?: int32;
}
