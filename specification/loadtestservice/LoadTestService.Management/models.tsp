import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;
using Azure.ResourceManager.Private;

namespace Microsoft.LoadTestService;

@doc("LoadTest details.")
model LoadTestResource is TrackedResource<LoadTestProperties> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "Existing API"
  @doc("Load Test name")
  @key("loadTestName")
  @path
  @segment("loadTests")
  name: string;

  ...ManagedServiceIdentityProperty;
}

@extensionResource
@doc("LoadTest mapping resource details")
@added(APIVersions.v2023_12_01_preview)
model LoadTestMappingResource is ProxyResource<LoadTestMappingProperties> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "Existing API"
  @doc("Load Test Mapping name")
  @key("loadTestMappingName")
  @path
  @segment("loadTestMappings")
  @pattern("^[A-Za-z0-9]+(-[A-Za-z0-9]+)*$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Operations on the resource are sync"
@doc("Azure LoadTest mapping resource properties.")
@added(APIVersions.v2023_12_01_preview)
model LoadTestMappingProperties {
  @doc("Mapped source resource Id.")
  @maxLength(1024)
  sourceResourceId?: string;

  @doc("Mapped Azure Load Test resource Id.")
  @maxLength(1024)
  azureLoadTestingResourceId?: string;

  @doc("Mapped Azure Load Test resource test-id.")
  @maxLength(256)
  testId?: string;
}

@extensionResource
@doc("LoadTest profile mapping resource details")
@added(APIVersions.v2023_12_01_preview)
model LoadTestProfileMappingResource
  is ProxyResource<LoadTestProfileMappingProperties> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "Existing API"
  @doc("Load Test Profile Mapping name")
  @key("loadTestProfileMappingName")
  @path
  @segment("loadTestProfileMappings")
  @pattern("^[A-Za-z0-9]+(-[A-Za-z0-9]+)*$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Operations on the resource are sync"
@doc("Azure LoadTest profile mapping resource properties.")
@added(APIVersions.v2023_12_01_preview)
model LoadTestProfileMappingProperties {
  @doc("Mapped source resource Id.")
  @maxLength(1024)
  sourceResourceId?: string;

  @doc("Mapped Azure Load Test resource Id.")
  @maxLength(1024)
  azureLoadTestingResourceId?: string;

  @doc("Mapped Azure Load Test resource test-profile-id.")
  @maxLength(60)
  testProfileId?: string;
}

@doc("Resources provisioning states.")
union ResourceState {
  string,

  @doc("Deleted state.")
  Deleted: "Deleted",

  ResourceProvisioningState,
}

// can be renamed but since the type is already used in published docs, it will be a breaking change.
@doc("Managed identity type to use for accessing encryption key Url.")
union type {
  string,

  @doc("System assigned identity.")
  SystemAssigned: "SystemAssigned",

  @doc("User assigned identity.")
  UserAssigned: "UserAssigned",
}

@doc("Details about the connection between the Batch service and the endpoint.")
model EndpointDetail {
  @visibility("read")
  @doc("The port an endpoint is connected to.")
  port?: int32;
}

@doc("A domain name and connection details used to access a dependency.")
model EndpointDependency {
  @doc("The domain name of the dependency. Domain names may be fully qualified or may contain a * wildcard.")
  @visibility("read")
  @key
  domainName: string;

  @doc("Human-readable supplemental information about the dependency and when it is applicable.")
  @visibility("read")
  description?: string;

  @doc("The list of connection details for this endpoint.")
  @visibility("read")
  @extension("x-ms-identifiers", ["port"])
  endpointDetails?: EndpointDetail[];
}

@doc("A collection of related endpoints from the same service for which the Batch service requires outbound access.")
model OutboundEnvironmentEndpoint {
  @doc("The type of service that Azure Load Testing connects to.")
  @visibility("read")
  category?: string;

  @doc("The endpoints for this service to which the Batch service makes outbound calls.")
  @visibility("read")
  @extension("x-ms-identifiers", ["domainName"])
  endpoints?: EndpointDependency[];
}

@doc("All identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault.")
model EncryptionPropertiesIdentity {
  @doc("Managed identity type to use for accessing encryption key Url.")
  type?: type;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "We need resourceId to be nullable."
  @doc("User assigned identity to use for accessing key encryption key Url. Ex: /subscriptions/fa5fc227-a624-475e-b696-cdd604c735bc/resourceGroups/<resource group>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myId.")
  resourceId?: string | null;
}

@doc("Key and identity details for Customer Managed Key encryption of load test resource.")
model EncryptionProperties {
  @doc("All identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault.")
  identity?: EncryptionPropertiesIdentity;

  @doc("key encryption key Url, versioned. Ex: https://contosovault.vault.azure.net/keys/contosokek/562a4bb76b524a1493a6afe8e536ee78 or https://contosovault.vault.azure.net/keys/contosokek.")
  keyUrl?: string;
}

@doc("Quota bucket resource properties.")
model QuotaResourceProperties {
  @minValue(0)
  @doc("Current quota limit of the quota bucket.")
  limit?: int32;

  @doc("Current quota usage of the quota bucket.")
  @minValue(0)
  usage?: int32;

  @doc("Resource provisioning state.")
  @visibility("read")
  provisioningState?: ResourceState;
}

@doc("Quota bucket details object.")
@parentResource(ArmLocationResource<"Subscription">)
model QuotaResource is ProxyResource<QuotaResourceProperties> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "Existing API"
  @doc("The quota name.")
  @key("quotaBucketName")
  @path
  @segment("quotas")
  name: string;
}

@doc("LoadTest resource properties.")
model LoadTestProperties {
  @maxLength(512)
  @doc("Description of the resource.")
  description?: string;

  @visibility("read")
  @doc("Resource provisioning state.")
  provisioningState?: ResourceState;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "URI is an abbervation and should be upper case"
  @visibility("read")
  @maxLength(2083)
  @doc("Resource data plane URI.")
  dataPlaneURI?: string;

  @doc("CMK Encryption property.")
  encryption?: EncryptionProperties;
}

@doc("Check quota availability response object.")
model CheckQuotaAvailabilityResponse {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: Azure.ResourceManager.Foundations.SystemData;

  @doc("The name of the resource.")
  @visibility("read")
  name?: string;

  #suppress "deprecated" "Legacy flatten"
  @doc("Check quota availability response properties.")
  @Azure.ClientGenerator.Core.flattenProperty
  properties?: CheckQuotaAvailabilityResponseProperties;
}

@doc("Check quota availability response properties.")
model CheckQuotaAvailabilityResponseProperties {
  @doc("True/False indicating whether the quota request be granted based on availability.")
  isAvailable?: boolean;

  @doc("Message indicating additional details to add to quota support request.")
  availabilityStatus?: string;
}

@doc("Request object of new quota for a quota bucket.")
model QuotaBucketRequest {
  #suppress "deprecated" "Legacy flatten"
  @Azure.ClientGenerator.Core.flattenProperty
  @doc("Request object of new quota for a quota bucket.")
  properties?: QuotaBucketRequestProperties;
}

@doc("New quota request request properties.")
model QuotaBucketRequestProperties {
  @doc("Current quota usage of the quota bucket.")
  @minValue(0)
  currentUsage?: int32;

  @doc("Current quota limit of the quota bucket.")
  @minValue(0)
  currentQuota?: int32;

  @doc("New quota limit of the quota bucket.")
  @minValue(0)
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

@doc("Values returned by the List operation.")
model PagedOutboundEnvironmentEndpoint
  is Azure.Core.Page<OutboundEnvironmentEndpoint>;
