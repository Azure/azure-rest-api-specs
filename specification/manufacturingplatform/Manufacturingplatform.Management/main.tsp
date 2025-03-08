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
@service(#{ title: "Microsoft.ManufacturingPlatform" })
@versioned(Microsoft.ManufacturingPlatform.Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.ManufacturingPlatform;

@doc("Supported API versions for the Microsoft.ManufacturingPlatform resource provider.")
enum Versions {
  @doc("The 2025-03-01 version.")
  @Versioning.useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2025_03_01: "2025-03-01",
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("A ManufacturingPlatformProviderHub resource")
model MdsResource is TrackedResource<MdsResourceProperties> {
  @pattern("^[a-zA-Z0-9-]{3,23}$")
  @key("mdsResourceName")
  @segment("manufacturingDataServices")
  @doc("Name.")
  @path
  @visibility(Lifecycle.Read)
  name: string;

  ...ManagedServiceIdentityProperty;
  ...ResourceSkuProperty;
}

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
union ResourceState {
  string,

  /** Resource is in active state */
  Active: "Active",

  /** Resource is in inactive state */
  Inactive: "Inactive",
}

@doc("The redundancy state of the resource")
union RedundancyState {
  string,

  /** Resource is zone redundant */
  Zonal: "Zonal",

  /** Resource is not redundant */
  None: "None",
}

@doc("Details of the ManufacturingPlatform MdsResource.")
model MdsResourceProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("Mds Resource Version.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  version?: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Enable Copilot.")
  enableCopilot?: boolean;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Enable Diagnostic Settings.")
  enableDiagnosticSettings?: boolean;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("AAD Application Id.")
  @pattern("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$")
  aadApplicationId: string;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("AKS Admin Group Id.")
  @pattern("^[{]?[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}[}]?$|^$")
  aksAdminGroupId?: string = "00000000-0000-0000-0000-000000000000";

  @visibility(Lifecycle.Read)
  @doc("Service Url")
  serviceUrl?: string;

  @visibility(Lifecycle.Read)
  @doc("Profile of AKS Created.")
  aksProfile?: AksProfile;

  @visibility(Lifecycle.Read)
  @doc("Profile of Storage Created.")
  storageProfile?: StorageProfile;

  @visibility(Lifecycle.Read)
  @doc("Profile of Database Created.")
  databaseProfile?: DatabaseProfile;

  @visibility(Lifecycle.Read)
  @doc("Profile of Adx Created.")
  adxProfile?: AdxProfile;

  @visibility(Lifecycle.Read)
  @doc("Profile of Azure Redis Created.")
  redisProfile?: RedisProfile;

  @visibility(Lifecycle.Read)
  @doc("Profile of Monitoring Resource Created.")
  monitoringProfile?: MonitoringProfile;

  @visibility(Lifecycle.Read)
  @doc("Profile of EventHub Resource.")
  eventHubProfile?: EventHubProfile;

  @visibility(Lifecycle.Read)
  @doc("Profile of Function App Resource.")
  functionAppProfile?: FunctionAppProfile;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "AI is a well-known abbreviation"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Profile of OpenAI Resource.")
  openAIProfile?: OpenAIProfile;

  @visibility(Lifecycle.Read)
  @doc("Configuration of the managed resource group associated with the resource.")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  @visibility(Lifecycle.Read)
  @doc("Managed On Behalf Of Configuration.")
  managedOnBehalfOfConfiguration?: ManagedOnBehalfOfConfiguration;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Profile of CMK Settings.")
  cmkProfile?: CmkProfile;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Profile of Fabric resources.")
  fabricProfile?: FabricProfile;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "AI is a well-known abbreviation"
  @doc("Profile of User Managed OpenAI Resource.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  userManagedOpenAIProfile?: UserManagedOpenAIProfile;

  @doc("Deny Assignments exclusion list.")
  @visibility(Lifecycle.Read, Lifecycle.Update)
  denyAssignmentExclusions?: DenyAssignmentExclusion[];

  @doc("State of the resource")
  @visibility(Lifecycle.Read, Lifecycle.Update)
  resourceState?: ResourceState;

  @doc("Zone redundancy state for resources")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  redundancyState?: RedundancyState;
}

@doc("The properties related to Aks Resource")
model AksProfile {
  @doc("Resource Id of AKS Resource")
  @visibility(Lifecycle.Read)
  id?: string;
}

@doc("The properties related to Storage Resource")
model StorageProfile {
  @doc("Resource Id of Storage Resource")
  @visibility(Lifecycle.Read)
  id?: string;
}

@doc("The properties related to Database Resource")
model DatabaseProfile {
  @doc("Resource Id of Cosmos Resource")
  @visibility(Lifecycle.Read)
  cosmosId?: string;
}

@doc("The properties related to Azure Data Explorer (Adx) Resource")
model AdxProfile {
  @doc("Resource Id of Adx Resource")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("Uri of Adx Resource")
  @visibility(Lifecycle.Read)
  uri?: string;

  @doc("Data Ingestion Uri of Adx Resource")
  @visibility(Lifecycle.Read)
  dataIngestionUri?: string;
}

@doc("The properties related to Azure Redis Cache Resource")
model RedisProfile {
  @doc("Resource Id of Azure Redis Cache Resource")
  @visibility(Lifecycle.Read)
  id?: string;
}

@doc("The properties related to Monitoring Resource")
model MonitoringProfile {
  @doc("Resource Id of Application Insights Resource")
  @visibility(Lifecycle.Read)
  id?: string;
}

@doc("The properties related to EventHub Resource")
model EventHubProfile {
  @doc("Resource Id of Adx Instance")
  @visibility(Lifecycle.Read)
  adxInstanceId?: string;

  @doc("Host Name")
  @visibility(Lifecycle.Read)
  hostName?: string;
}

@doc("The properties related to Azure Function App Resource")
model FunctionAppProfile {
  @doc("Resource Id of Azure Function App Resource")
  @visibility(Lifecycle.Read)
  id?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "AI is a well-known abbreviation"
@doc("The properties related to OpenAI Resource")
model OpenAIProfile {
  @doc("Resource Id of OpenAI Resource")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("GPT Model Name")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  gptModelName?: string;

  @doc("GPT Model Version")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  gptModelVersion?: string;

  @doc("GPT Model Capacity")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  gptModelCapacity?: int32;

  @doc("GPT Model SKU Name")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  gptModelSkuName?: string;

  @doc("Embedding Model Name")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  embeddingModelName?: string;

  @doc("Embedding Model Version")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  embeddingModelVersion?: string;

  @doc("Embedding Model SKU Name")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  embeddingModelSkuName?: string;

  @doc("Embedding Model Capacity")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  embeddingModelCapacity?: int32;
}

@doc("The properties related to Deny Assignment Exclusions")
model DenyAssignmentExclusion {
  @doc("Object Id of Identity")
  @visibility(Lifecycle.Read, Lifecycle.Update)
  id: string;

  @doc("Type of Identity")
  @visibility(Lifecycle.Read, Lifecycle.Update)
  type: string;
}

@doc("Configuration of the managed resource group associated with the resource.")
model ManagedResourceGroupConfiguration {
  @doc("The resource group name.")
  name: string;

  @doc("The resource group location.")
  location: string;
}

@doc("Configuration of the managed on behalf of resource.")
model ManagedOnBehalfOfConfiguration {
  @visibility(Lifecycle.Read)
  @doc("Associated MoboBrokerResources.")
  moboBrokerResources: MoboBrokerResource[];
}

@doc("MoboBroker resource.")
model MoboBrokerResource {
  @visibility(Lifecycle.Read)
  @doc("Resource Id of MoboBrokerResource")
  id: string;
}

@doc("The properties related to CMK")
model CmkProfile {
  @doc("URI of Key in AKV")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  keyUri: string;
}

@doc("The properties related to Fabric")
model FabricProfile {
  @doc("Azure Key Vault Uri")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  keyUri: string;

  @doc("URI of One Lake")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  oneLakeUri: string;

  @doc("One Lake Path")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  oneLakePath: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "AI is a well-known abbreviation"
@doc("The properties related to User Managed OpenAI Resource")
model UserManagedOpenAIProfile {
  @doc("Resource Id of OpenAI Resource")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  id: string;

  @doc("GPT Model Deployment Name")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  gptModelDeploymentName: string;

  @doc("Embedding Model Deployment Name")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  embeddingModelDeploymentName: string;

  @doc("Embedding Model Type")
  @visibility(Lifecycle.Read)
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
  @OpenAPI.extension("x-ms-identifiers", #[])
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
