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
  title: "Microsoft.ManufacturingPlatform"
})

@versioned(Microsoft.ManufacturingPlatform.Versions)
namespace Microsoft.ManufacturingPlatform;


@doc("Supported API versions for the Microsoft.ManufacturingPlatform resource provider.")
enum Versions {
  @doc("The 2023-02-01-preview version.")
  @Versioning.useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_02_01_preview: "2023-02-01-preview",

  @doc("The 2024-02-01-preview version.")
  @Versioning.useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2024_02_01_preview: "2024-02-01-preview",
}

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
  ...ResourceSku;
}

@@added(MdsResource.sku ,Versions.v2024_02_01_preview);

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
  @madeOptional(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  aksAdminGroupId?: string = "00000000-0000-0000-0000-000000000000";
 
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

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "This is a preview version"
  @visibility("read")
  @doc("Profile of Akv Created.")
  @removed(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  akvProfile?: AkvProfile;

  @visibility("read")
  @doc("Profile of Azure Redis Created.")
  redisProfile?: RedisProfile;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "This is a preview version"
  @visibility("read")
  @doc("Profile of Adt Created.")
  @removed(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  adtProfile?: AdtProfile;
  
  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "This is a preview version"
  @visibility("read")
  @doc("Profile of Synapse Created.")
  @removed(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
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

  @visibility("read", "create", "update")
  @added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  @doc("Profile of Azure Machine Learning Resource.")
  amlProfile?: AmlProfile;

  @doc("Profile of User Managed Database.")
  @added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  @visibility("read", "create")
  userManagedDatabaseProfile?: UserManagedDatabaseProfile;
 
  @doc("Profile of User Managed Adx.")
  @added(Versions.v2024_02_01_preview)
  @visibility("read", "create")
  userManagedAdxProfile?: UserManagedAdxProfile;

  @visibility("read", "create")
  @added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  @doc("Profile of CMK Settings.")
  cmkProfile?: CmkProfile;

  @visibility("read", "create", "update")
  @added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  @doc("Profile of Fabric resources.")
  fabricProfile?: FabricProfile;
 
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


#suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "This is a preview version"
@doc("The properties related to Azure Digital Twin (Adt) Resource")
@removed(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
model AdtProfile {
  
  @doc("Resource Id of Adt Resource")
  @visibility("read")
  id?: string;
  
  @doc("Host Name")
  @visibility("read")
  hostName?: string;

}

@doc("The properties related to User Managed Database Resource")
@added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
model UserManagedDatabaseProfile {

  @doc("Resource Id of Cosmos Resource")
  @visibility("read","create")
  cosmosId: string;
  
}

@doc("The properties related to User Managed Azure Data Explorer (Adx) Resource")
@added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
model UserManagedAdxProfile {

  @doc("Resource Id of Adx Resource")
  @visibility("read", "create")
  id: string;

  @doc("Uri of Adx Resource")
  @visibility("read")
  uri?: string;

  @doc("Data Ingestion Uri of Adx Resource")
  @visibility("read")
  dataIngestionUri?: string;

}

#suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "This is a preview version"
@doc("The properties related to Azure Key Vault (Akv) Resource")
@removed(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
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

#suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "This is a preview version"
@doc("The properties related to Synapse Resource")
@removed(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
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

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "This is a preview version"
  @doc("Resource Id of Ingestion Instance EventHub Resource")
  @visibility("read")
  @removed(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  ingestionInstanceId?: string;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "This is a preview version"
  @doc("Resource Id of Data History Instance EventHub Resource")
  @visibility("read")
  @removed(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  dhInstanceId?: string;

  @doc("Resource Id of Adx Instance")
  @visibility("read")
  @added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  adxInstanceId?: string;

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

@doc("The properties related to Azure Machine Learning Resource")
@added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
model AmlProfile {
  
  @doc("Resource Id of Azure Machine Learning Resource")
  @visibility("read", "create", "update")
  id: string;

  @doc("Custom Ner Service Uri")
  @visibility("read", "create", "update")
  customNerServiceUri: string;
}

@doc("The properties related to CMK")
@added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
model CmkProfile {
  
  @doc("URI of Key in AKV")
  @visibility("read","create")
  keyUri: string;
}

@doc("The properties related to Fabric")
@added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
model FabricProfile {
  
  @doc("Azure Key Vault Uri")
  @visibility("read", "create", "update")
  keyUri: string;
  
  @doc("URI of One Lake")
  @visibility("read", "create", "update")
  oneLakeUri: string;
   
  @doc("One Lake Path")
  @visibility("read", "create", "update")
  oneLakePath: string;
  
}


@armResourceOperations(MdsResource)
interface ManufacturingDataServices  {
  get is ArmResourceRead<MdsResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MdsResource>;
  update is ArmResourcePatchAsync<MdsResource, MdsResourceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<MdsResource>;
  listByResourceGroup is ArmResourceListByParent<MdsResource>;
  listBySubscription is ArmListBySubscription<MdsResource>;

  @doc("Returns the list of available versions")
  listAvailableVersions is ArmResourceListActionSync<MdsResource, AvailableVersionListResult>;

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
  ...ResourceInstanceParameters<TResource, TBaseParameters>
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