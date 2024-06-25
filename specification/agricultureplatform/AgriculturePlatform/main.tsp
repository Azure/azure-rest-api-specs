import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.AgriculturePlatform")
@service({
  title: "Microsoft.AgriculturePlatform"
})

@versioned(Microsoft.AgriculturePlatform.Versions)
namespace Microsoft.AgriculturePlatform;

@doc("Supported API versions for the Microsoft.AgriculturePlatform resource provider.")
enum Versions {
  @doc("The 2024-06-01-preview version.")
  @Versioning.useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_06_01_preview: "2024-06-01-preview",
}


interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A AgriculturePlatform resource")
model AgriServiceResource is TrackedResource<AgriServiceResourceProperties> {
  @doc("The name of the AgriService resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("agriServiceResourceName")
  @segment("agriService")
  @visibility("read")
  @path
  name: string;

  ...ManagedServiceIdentityProperty;
  ...ResourceSkuProperty;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  string,
  /** Resource has been created. */
  Succeeded:"Succeeded",
  /** Resource creation failed. */
  Failed:"Failed",
  /** Resource creation was canceled. */
  Canceled:"Canceled",
  /** The resource is being provisioned */
  Provisioning:"Provisioning",
  /** The resource is updating */
  Updating:"Updating",
  /** The resource is being deleted */
  Deleting:"Deleting",
  /** The resource create request has been accepted */
  Accepted:"Accepted"
}

@doc("Details of the Agriculture AgriDataManager.")
model AgriServiceResourceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("Config of the AgriService instance.")
  @visibility("read")
  config?: AgriServiceConfig;

  @visibility("read")
  @doc("Managed On Behalf Of Configuration.")
  managedOnBehalfOfConfiguration?: ManagedOnBehalfOfConfiguration;
}

@doc("Config of the AgriService instance.")
model AgriServiceConfig { // include all resources which will be created here in MOBO, properties, endpoints etc. 
  @doc("Instance URI of the AgriService instance.")
  @visibility("read")
  @minLength(2)
  @maxLength(256)
  instanceUri?: string;

  @doc("Cosmos DB endpoint of the AgriService instance.")
  @visibility("read")
  @minLength(2)
  @maxLength(256)
  cosmosDbEndpoint?: string;

  @doc("Storage account endpoint of AgriService instance.")
  @visibility("read")
  @minLength(2)
  @maxLength(256)
  storageAccountEndpoint?: string;

  @doc("Key vault endpoint of AgriService instance.")
  @visibility("read")
  @minLength(2)
  @maxLength(256)
  keyVaultEndpoint?: string;

  @doc("Redis instance endpoint of AgriService instance.")
  @visibility("read")
  @minLength(2)
  @maxLength(256)
  redisEndpoint?: string;

  @doc("Version of AgriService instance.")
  @visibility("read")
  @minLength(2)
  @maxLength(256)
  version?: string;
}

@doc("Configuration of the managed on behalf of resource.")
model ManagedOnBehalfOfConfiguration {
    @visibility("read")
    @doc("Associated MoboBrokerResources.")
    moboBrokerResources: MoboBrokerResource[];
}

@doc("MoboBroker resource.")
model MoboBrokerResource {
  @visibility("read")
   @doc("Resource Id of MoboBrokerResource")
  id: string;
}

@armResourceOperations(AgriServiceResource)
interface AgriService  {
  get is ArmResourceRead<AgriServiceResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AgriServiceResource>;
  update is ArmResourcePatchAsync<AgriServiceResource, AgriServiceResourceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<AgriServiceResource>;
  listByResourceGroup is ArmResourceListByParent<AgriServiceResource>;
  listBySubscription is ArmListBySubscription<AgriServiceResource>;
}