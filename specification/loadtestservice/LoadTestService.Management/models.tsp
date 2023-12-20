import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;
using Autorest;
using Azure.ResourceManager.Foundations;

namespace Microsoft.LoadTestService.Draft;

@doc("A ContosoProviderHub resource")
model LoadTestResource is TrackedResource<LoadTestProperties> {
  @doc("Load Test name")
  @key("loadTestName")
  @path
  @segment("loadTests")
  name: string;
}

enum ResourceState{
  Succeeded: "Succeeded",
  Failed: "Failed",
  Canceled: "Canceled",
  Deleted: "Deleted"
}

//need to update this
enum Type{
  SystemAssigned: "SystemAssigned",
  UserAssigned: "UserAssigned"
}

model EndpointDetail {
  @visibility("read")
  @doc("The port an endpoint is connected to.")
  port: int32;
}

model EndpointDependency {
  domainName: string;
  description: string;
  endpointDetails: EndpointDetail;

}

@parentResource(LoadTestResource)
@resource("outboundNetworkDependenciesEndpoints")
model OutboundEnvironmentEndpoint extends ArmResource{
  @key
  category: string;
  endpoints: EndpointDependency;
}


model Identity{
  type?: Type;

  resourceId?: string;
}

model EncryptionProperties{
  @doc("All identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault.")
  identity?: Identity;

  @doc("key encryption key Url, versioned. Ex: https://contosovault.vault.azure.net/keys/contosokek/562a4bb76b524a1493a6afe8e536ee78 or https://contosovault.vault.azure.net/keys/contosokek.")
  keyUrl?: string;
}

model QuotaResourceProperties {
  @minValue(0)
  @doc("Current quota limit of the quota bucket.")
  limit: int32;
  
  @doc("Current quota usage of the quota bucket.")
  @minValue(0)
  usage: int32;

  @doc("Resource provisioning state.")
  @visibility("read")
  provisioningState: ResourceState;
}

enum CreatedByType {
  User: "User",
  Application: "Application",
  ManagedIdentity: "ManagedIdentity ",
  Key: "Key"
}

// model SystemData {
//   createdBy: string;
//   createdByType: CreatedByType;
//   createdAt: string;
//   lastModifiedBy: string;
//   lastModifiedType: CreatedByType;
//   lastModifiedAt: utcDateTime;
// }

// model Resource {
//   id: string;
//   type: string;
//   systemData: SystemData;
// }

@doc("The location of quota resource")
@subscriptionResource
model Location {
  @doc("The location of quota in ARM Normalized format like eastus, southeastasia etc.")
  @key("location")
  @path
  @segment("locations")
  @visibility("query", "read", "update")
  name: string;
}

@doc("A quota resource")
@parentResource(Location)
model QuotaResource is ProxyResource<QuotaResourceProperties> {
  @doc("The quota name.")
  @key("quotaBucketName")
  @path
  @segment("quotas")
  name: string;
}

@doc("LoadTest resource properties.")
model LoadTestProperties{
  @maxLength(512)
  @doc("Description of the resource.")
  description?: string;

  @visibility("read")
  @doc("Resource provisioning state.")
  provisioningState?: ResourceState;

  @visibility("read")
  @maxLength(2083)
  @doc("Resource data plane URI.")
  dataPlaneURI?: string;

  @doc("CMK Encryption property.")
  encryption?: EncryptionProperties;
}

@doc("Check quota availability response properties.")
model CheckQuotaAvailabilityResponse extends ArmResource {
  @doc("Check quota availability response properties.")
  properties?: CheckQuotaAvailabilityResponseProperties;
}

model CheckQuotaAvailabilityResponseProperties {
  @doc("True/False indicating whether the quota request be granted based on availability.")
  isAvailable?: boolean;

  @doc("Message indicating additional details to add to quota support request.")
  availabilityStatus?: string;
}

@doc("Request object of new quota for a quota bucket.")
model QuotaBucketRequest extends ArmResource{
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
  dimensions?: Dimensions;
}

@doc("Dimensions for new quota request.")
model Dimensions {
  @doc("Subscription Id dimension for new quota request of the quota bucket.")
  @minLength(1)
  subscriptionId?: string;

  @doc("Location dimension for new quota request of the quota bucket.")
  @minLength(1)
  location?: string;
}