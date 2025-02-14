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

@armProviderNamespace("Microsoft.ManufacturingPlatform")
@service({
  title: "Microsoft.ManufacturingPlatform",
})
@versioned(Microsoft.ManufacturingPlatform.Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
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
  @pattern("^[a-zA-Z0-9-]{3,23}$")
  @key("mdsResourceName")
  @segment("manufacturingDataServices")
  @doc("Name.")
  @path
  @visibility("read")
  name: string;

  ...ManagedServiceIdentityProperty;
  ...ResourceSkuProperty;
}

@@added(MdsResource.sku, Versions.v2024_02_01_preview);

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  string,

  /** Resource has been created. */
  Succeeded: "Succeeded",

  /** Resource creation failed. */
  Failed: "Failed",

  /** Resource creation was canceled. */
  Canceled: "Canceled",

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  /** The resource is updating */
  Updating: "Updating",

  /** The resource is being deleted */
  Deleting: "Deleting",

  /** The resource create request has been accepted */
  Accepted: "Accepted",
}

@doc("The current state of the resource")
@added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
union ResourceState {
  string,

  /** Resource is in active state */
  Active: "Active",

  /** Resource is in inactive state */
  Inactive: "Inactive",
}

@doc("The redundancy state of the resource")
@added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
union RedundancyState {
  string,

  /** Resource is zone redundant */
  Zonal: "Zonal",

  /** Resource is not redundant */
  None: "None",
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

  @visibility("read", "create", "update")
  @added(Versions.v2024_02_01_preview)
  @doc("Enable Diagnostic Settings.")
  enableDiagnosticSettings?: boolean;

  @visibility("read", "create")
  @doc("AAD Application Id.")
  @pattern("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$")
  aadApplicationId: string;

  @visibility("read", "create")
  @doc("AKS Admin Group Id.")
  @pattern("^[{]?[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}[}]?$|^$")
  @madeOptional(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  aksAdminGroupId?: string = "00000000-0000-0000-0000-000000000000";

  @visibility("read", "create")
  @doc("Continuous Export Period.")
  @madeOptional(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  continuousExportPeriod?: int32 = 0;

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

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "This is removed in 2024-02-01-preview version"
  @visibility("read")
  @doc("Profile of Akv Created.")
  @removed(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  akvProfile?: AkvProfile;

  @visibility("read")
  @doc("Profile of Azure Redis Created.")
  redisProfile?: RedisProfile;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "This is removed in 2024-02-01-preview version"
  @visibility("read")
  @doc("Profile of Adt Created.")
  @removed(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  adtProfile?: AdtProfile;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "This is removed in 2024-02-01-preview version"
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
  @visibility("read", "create", "update")
  @doc("Profile of OpenAI Resource.")
  openAIProfile?: OpenAIProfile;

  @visibility("read")
  @doc("Configuration of the managed resource group associated with the resource.")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  @visibility("read")
  @doc("Managed On Behalf Of Configuration.")
  @added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  managedOnBehalfOfConfiguration?: ManagedOnBehalfOfConfiguration;

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

  #suppress "@azure-tools/typespec-azure-core/casing-style" "AI is a well-known abbreviation"
  @doc("Profile of User Managed OpenAI Resource.")
  @added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  @visibility("read", "create", "update")
  userManagedOpenAIProfile?: UserManagedOpenAIProfile;

  @doc("Deny Assignments exclusion list.")
  @added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  @visibility("read", "update")
  denyAssignmentExclusions?: DenyAssignmentExclusion[];

  @doc("State of the resource")
  @added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  @visibility("read", "update")
  resourceState?: ResourceState;

  @doc("Zone redundancy state for resources")
  @added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  @visibility("read", "create")
  redundancyState?: RedundancyState;
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

#suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "This is removed in 2024-02-01-preview version"
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
  @visibility("read", "create")
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

#suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "This is removed in 2024-02-01-preview version"
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

#suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "This is removed in 2024-02-01-preview version"
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
  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "This is removed in 2024-02-01-preview version"
  @doc("Resource Id of Ingestion Instance EventHub Resource")
  @visibility("read")
  @removed(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  ingestionInstanceId?: string;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "This is removed in 2024-02-01-preview version"
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

  @added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  @doc("GPT Model Name")
  @visibility("read", "create", "update")
  gptModelName?: string;

  @added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  @doc("GPT Model Version")
  @visibility("read", "create", "update")
  gptModelVersion?: string;

  @added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  @doc("GPT Model Capacity")
  @visibility("read", "create", "update")
  gptModelCapacity?: int32;

  @added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  @doc("GPT Model SKU Name")
  @visibility("read", "create", "update")
  gptModelSkuName?: string;

  @added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  @doc("Embedding Model Name")
  @visibility("read", "create")
  embeddingModelName?: string;

  @added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  @doc("Embedding Model Version")
  @visibility("read", "create")
  embeddingModelVersion?: string;

  @added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  @doc("Embedding Model SKU Name")
  @visibility("read", "create", "update")
  embeddingModelSkuName?: string;

  @added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
  @doc("Embedding Model Capacity")
  @visibility("read", "create", "update")
  embeddingModelCapacity?: int32;
}

@added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
@doc("The properties related to Deny Assignment Exclusions")
model DenyAssignmentExclusion {
  @doc("Object Id of Identity")
  @visibility("read", "update")
  id: string;

  @doc("Type of Identity")
  @visibility("read", "update")
  type: string;
}

@doc("Configuration of the managed resource group associated with the resource.")
model ManagedResourceGroupConfiguration {
  @doc("The resource group name.")
  name: string;

  @doc("The resource group location.")
  location: string;
}

@added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
@doc("Configuration of the managed on behalf of resource.")
model ManagedOnBehalfOfConfiguration {
  @visibility("read")
  @doc("Associated MoboBrokerResources.")
  moboBrokerResources: MoboBrokerResource[];
}

@added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
@doc("MoboBroker resource.")
model MoboBrokerResource {
  @visibility("read")
  @doc("Resource Id of MoboBrokerResource")
  id: string;
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
  @visibility("read", "create")
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "AI is a well-known abbreviation"
@doc("The properties related to User Managed OpenAI Resource")
@added(Microsoft.ManufacturingPlatform.Versions.v2024_02_01_preview)
model UserManagedOpenAIProfile {
  @doc("Resource Id of OpenAI Resource")
  @visibility("read", "create", "update")
  id: string;

  @doc("GPT Model Deployment Name")
  @visibility("read", "create", "update")
  gptModelDeploymentName: string;

  @doc("Embedding Model Deployment Name")
  @visibility("read", "create", "update")
  embeddingModelDeploymentName: string;

  @doc("Embedding Model Type")
  @visibility("read")
  embeddingModelType?: string;
}

@armResourceOperations(MdsResource)
interface ManufacturingDataServices {
  get is ArmResourceRead<MdsResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MdsResource>;
  // update is ArmResourcePatchAsync<MdsResource, MdsResourceProperties>;
  //temporary fix until typespec fix the issue of generating update classes
  update is ArmCustomPatchAsync<
    MdsResource,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      MdsResource,
      MdsResourceProperties
    >
  >;
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "This is a template"
@armResourceAction(TResource)
@post
op ArmResourceListActionSync<
  TResource extends Azure.ResourceManager.Foundations.Resource,
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

  @doc("Is Deprecated")
  isDeprecated: boolean;
}
