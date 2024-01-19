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

@doc("Resources provisioning states.")
enum ResourceState {
  Succeeded,
  Failed,
  Canceled,
  Deleted,
}

@doc("Managed identity type to use for accessing encryption key Url")
enum Type {
  SystemAssigned,
  UserAssigned,
}

@doc("Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).")
enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

@doc("Quota bucket resource properties.")
model QuotaResourceProperties {
  @doc("Current quota limit of the quota bucket.")
  limit?: int32;

  @doc("Current quota usage of the quota bucket.")
  usage?: int32;

  @doc("Resource provisioning state.")
  @visibility("read")
  provisioningState?: ResourceState;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Request object of new quota for a quota bucket.")
model QuotaBucketRequest extends Resource {
  @doc("New quota request request properties.")
  properties?: QuotaBucketRequestProperties;
}

@doc("New quota request request properties.")
model QuotaBucketRequestProperties {
  @doc("Current quota usage of the quota bucket.")
  currentUsage?: int32;

  @doc("Current quota limit of the quota bucket.")
  currentQuota?: int32;

  @doc("New quota limit of the quota bucket.")
  newQuota?: int32;

  @doc("Dimensions for new quota request.")
  dimensions?: QuotaBucketRequestPropertiesDimensions;
}

@doc("Dimensions for new quota request.")
model QuotaBucketRequestPropertiesDimensions {
  @doc("Subscription Id dimension for new quota request of the quota bucket.")
  @minLength(1)
  subscriptionId?: string;

  @doc("Location dimension for new quota request of the quota bucket.")
  @minLength(1)
  location?: string;
}

@doc("Check quota availability response object.")
model CheckQuotaAvailabilityResponse extends Resource {
  @doc("Check quota availability response properties.")
  properties?: CheckQuotaAvailabilityResponseProperties;
}

@doc("Check quota availability response properties.")
model CheckQuotaAvailabilityResponseProperties {
  @doc("True/False indicating whether the quota request be granted based on availability.")
  isAvailable?: boolean;

  @doc("Message indicating additional details to add to quota support request.")
  availabilityStatus?: string;
}

@doc("LoadTest resource properties.")
model LoadTestProperties {
  @doc("Description of the resource.")
  @maxLength(512)
  description?: string;

  @doc("Resource provisioning state.")
  @visibility("read")
  provisioningState?: ResourceState;

  @doc("Resource data plane URI.")
  @visibility("read")
  @maxLength(2083)
  dataPlaneURI?: string;

  @doc("CMK Encryption property.")
  encryption?: EncryptionProperties;
}

@doc("Key and identity details for Customer Managed Key encryption of load test resource")
model EncryptionProperties {
  @doc("All identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault.")
  identity?: EncryptionPropertiesIdentity;

  @doc("key encryption key Url, versioned. Ex: https://contosovault.vault.azure.net/keys/contosokek/562a4bb76b524a1493a6afe8e536ee78 or https://contosovault.vault.azure.net/keys/contosokek.")
  keyUrl?: string;
}

@doc("All identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault.")
model EncryptionPropertiesIdentity {
  @doc("Managed identity type to use for accessing encryption key Url")
  @projectedName("json", "type")
  identityType?: Type;

  @doc("user assigned identity to use for accessing key encryption key Url. Ex: /subscriptions/fa5fc227-a624-475e-b696-cdd604c735bc/resourceGroups/<resource group>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myId")
  resourceId?: string;
}

@doc("LoadTest resource patch request body.")
model LoadTestResourcePatchRequestBody {
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The type of identity used for the resource.")
  identity?: ManagedServiceIdentity;

  @doc("Load Test resource properties")
  properties?: LoadTestResourcePatchRequestBodyProperties;
}

@doc("Load Test resource properties")
model LoadTestResourcePatchRequestBodyProperties {
  @doc("Description of the resource.")
  @maxLength(512)
  description?: string;

  @doc("CMK Encryption property.")
  encryption?: EncryptionProperties;
}

@doc("Values returned by the List operation.")
model OutboundEnvironmentEndpointCollection
  is Azure.Core.Page<OutboundEnvironmentEndpoint>;

@doc("A collection of related endpoints from the same service for which the Batch service requires outbound access.")
model OutboundEnvironmentEndpoint {
  @doc("The type of service that Azure Load Testing connects to.")
  @visibility("read")
  category?: string;

  @doc("The endpoints for this service to which the Batch service makes outbound calls.")
  @visibility("read")
  endpoints?: EndpointDependency[];
}

@doc("A domain name and connection details used to access a dependency.")
model EndpointDependency {
  @doc("The domain name of the dependency. Domain names may be fully qualified or may contain a * wildcard.")
  @visibility("read")
  domainName?: string;

  @doc("Human-readable supplemental information about the dependency and when it is applicable.")
  @visibility("read")
  description?: string;

  @doc("The list of connection details for this endpoint.")
  @visibility("read")
  endpointDetails?: EndpointDetail[];
}

@doc("Details about the connection between the Batch service and the endpoint.")
model EndpointDetail {
  @doc("The port an endpoint is connected to.")
  @visibility("read")
  port?: int32;
}
