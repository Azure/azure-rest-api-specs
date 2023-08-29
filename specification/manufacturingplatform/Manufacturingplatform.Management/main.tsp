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

@armProviderNamespace("Microsoft.ManufacturingPlatform")
@service({
  title: "Microsoft.ManufacturingPlatform",
  version: "2023-02-01-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.ManufacturingPlatform;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("A ManufacturingPlatformProviderHub resource")
model MdsResource is TrackedResource<MdsResourceProperties> {
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("mdsResourceName")
  @segment("manufacturingDataServices")
  @doc("Name.")
  @path
  @visibility("read")
  name: string;

  ...ManagedServiceIdentity;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("Initial provisioning in progress")
  Provisioning,

  @doc("Update in progress")
  Updating,

  @doc("Deletion in progress")
  Deleting,

  @doc("Change accepted for processing")
  Accepted,
}

@doc("Details of the ManufacturingPlatform MdsResource.")
model MdsResourceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("Mds Resource Version.")
  @visibility("read", "create", "update")
  version?: string;

  @visibility("read", "create", "update")
  @doc("Enable Teams Notification.")
  enableTeamsNotification?: boolean;

  @visibility("read", "create", "update")
  @doc("Enable Copilot.")
  enableCopilot?: boolean;

  @visibility("read", "create")
  @doc("AAD Application Id.")
  @pattern("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$")
  aadApplicationId: string;

  @visibility("read", "create")
  @doc("AKS Admin Group Id.")
  @pattern("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$")
  aksAdminGroupId: string;

  @visibility("read", "create")
  @doc("Continuous Export Period.")
  continuousExportPeriod: int32;

  @visibility("read")
  @doc("Service Url")
  serviceUrl?: string;

  @visibility("read")
  @doc("Profile of AKS Created.")
  aksProfile?: AksProfile;

  @visibility("read")
  @doc("Profile of Storage Created.")
  storageProfile?: StorageProfile;

  @visibility("read")
  @doc("Profile of Database Created.")
  databaseProfile?: DatabaseProfile;

  @visibility("read")
  @doc("Profile of Adx Created.")
  adxProfile?: AdxProfile;

  @visibility("read")
  @doc("Profile of Adt Created.")
  adtProfile?: AdtProfile;

  @visibility("read")
  @doc("Profile of Akv Created.")
  akvProfile?: AkvProfile;

  @visibility("read")
  @doc("Profile of Azure Redis Created.")
  redisProfile?: RedisProfile;

  @visibility("read")
  @doc("Profile of Synapse Created.")
  synapseProfile?: SynapseProfile;

  @visibility("read")
  @doc("Profile of Monitoring Resource Created.")
  monitoringProfile?: MonitoringProfile;

  @visibility("read")
  @doc("Profile of EventHub Resource.")
  eventHubProfile?: EventHubProfile;

  @visibility("read")
  @doc("Profile of Function App Resource.")
  functionAppProfile?: FunctionAppProfile;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "AI is a well-known abbreviation"
  @visibility("read")
  @doc("Profile of OpenAI Resource.")
  openAIProfile?: OpenAIProfile;

  @visibility("read")
  @doc("Configuration of the managed resource group associated with the resource.")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;
}

@doc("The properties related to Aks Resource")
model AksProfile {
  @doc("Resource Id of AKS Resource")
  @visibility("read")
  id?: string;
}

@doc("The properties related to Storage Resource")
model StorageProfile {
  @doc("Resource Id of Storage Resource")
  @visibility("read")
  id?: string;
}

@doc("The properties related to Database Resource")
model DatabaseProfile {
  @doc("Resource Id of Cosmos Resource")
  @visibility("read")
  cosmosId?: string;
}

@doc("The properties related to Azure Data Explorer (Adx) Resource")
model AdxProfile {
  @doc("Resource Id of Adx Resource")
  @visibility("read")
  id?: string;

  @doc("Uri of Adx Resource")
  @visibility("read")
  uri?: string;

  @doc("Data Ingestion Uri of Adx Resource")
  @visibility("read")
  dataIngestionUri?: string;
}

@doc("The properties related to Azure Digital Twin (Adt) Resource")
model AdtProfile {
  @doc("Resource Id of Adt Resource")
  @visibility("read")
  id?: string;

  @doc("Host Name")
  @visibility("read")
  hostName?: string;
}

@doc("The properties related to Azure Key Vault (Akv) Resource")
model AkvProfile {
  @doc("Resource Id of Akv Resource")
  @visibility("read")
  id?: string;
}

@doc("The properties related to Azure Redis Cache Resource")
model RedisProfile {
  @doc("Resource Id of Azure Redis Cache Resource")
  @visibility("read")
  id?: string;
}

@doc("The properties related to Monitoring Resource")
model MonitoringProfile {
  @doc("Resource Id of Application Insights Resource")
  @visibility("read")
  id?: string;
}

@doc("The properties related to Synapse Resource")
model SynapseProfile {
  @doc("Resource Id of Synapse Resource")
  @visibility("read")
  id?: string;

  @doc("Synapse Development Endpoint")
  @visibility("read")
  devEndpoint?: string;
}

@doc("The properties related to EventHub Resource")
model EventHubProfile {
  @doc("Resource Id of Ingestion Instance EventHub Resource")
  @visibility("read")
  ingestionInstanceId?: string;

  @doc("Resource Id of Data History Instance EventHub Resource")
  @visibility("read")
  dhInstanceId?: string;

  @doc("Host Name")
  @visibility("read")
  hostName?: string;
}

@doc("The properties related to Azure Function App Resource")
model FunctionAppProfile {
  @doc("Resource Id of Azure Function App Resource")
  @visibility("read")
  id?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "AI is a well-known abbreviation"
@doc("The properties related to OpenAI Resource")
model OpenAIProfile {
  @doc("Resource Id of OpenAI Resource")
  @visibility("read")
  id?: string;
}

@doc("Configuration of the managed resource group associated with the resource.")
model ManagedResourceGroupConfiguration {
  @doc("The resource group name.")
  name: string;

  @doc("The resource group location.")
  location: string;
}

@armResourceOperations(MdsResource)
interface ManufacturingDataServices {
  get is ArmResourceRead<MdsResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MdsResource>;
  update is ArmResourcePatchAsync<MdsResource, MdsResourceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<MdsResource>;
  listByResourceGroup is ArmResourceListByParent<MdsResource>;
  listBySubscription is ArmListBySubscription<MdsResource>;

  @doc("Returns the list of available versions")
  listAvailableVersions is ArmResourceListActionSync<
    MdsResource,
    AvailableVersionListResult
  >;
}

// note this is a template for an empty body resource action, which will be added to the library at some point
#suppress "@azure-tools/typespec-azure-core/documentation-required" "This is a template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-outside-interface" "This is a template"
@armResourceAction(TResource)
@post
op ArmResourceListActionSync<
  TResource extends Azure.ResourceManager.Foundations.ArmResource,
  TResponse extends {},
  TBaseParameters = Azure.ResourceManager.Foundations.BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,
): ArmResponse<TResponse> | ErrorResponse;

@doc("The list of available versions")
model AvailableVersionListResult {
  @doc("The list of versions")
  @OpenAPI.extension("x-ms-identifiers", [])
  versions: ApplicationVersion[];
}

@doc("Information about application versions")
model ApplicationVersion {
  @doc("Application Version")
  version: string;

  @doc("Is Latest")
  isLatest: boolean;

  @doc("Is Preview")
  isPreview: boolean;
}
