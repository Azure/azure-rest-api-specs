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

namespace Microsoft.LoadTestService.Draft;

@doc("A ContosoProviderHub resource")
model LoadTestResource is TrackedResource<LoadTestProperties> {
  @doc("Name of employee")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
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

model OutboundEnvironmentEndpoint {
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

model SystemData {
  createdBy: string;
  createdByType: CreatedByType;
  createdAt: string;
  lastModifiedBy: string;
  lastModifiedType: CreatedByType;
  lastModifiedAt: utcDateTime;
}

model Resource {
  id: string;
  name: string;
  type: string;
  systemData: SystemData;
}

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
