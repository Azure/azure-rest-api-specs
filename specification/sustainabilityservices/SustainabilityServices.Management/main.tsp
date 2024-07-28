import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.SustainabilityServices")
@service({
  title: "Microsoft.SustainabilityServices"
})

@versioned(Microsoft.SustainabilityServices.Versions)
namespace Microsoft.SustainabilityServices;

@doc("Supported API versions for the Microsoft.SustainabilityServices resource provider.")
enum Versions {
  @doc("The 2024-10-01-preview version.")
  @Versioning.useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_10_01_preview: "2024-10-01-preview",
}


interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A SustainabilityServicesProviderHub resource")
model CalculationResource is TrackedResource<CalculationResourceProperties> {
  @doc("The name of the Calculation Resource Name")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("calculationResourceName")
  @segment("calculations")
  @path
  name: string;

  ...ManagedServiceIdentity;
  ...ResourceSku;
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

@doc("Details of the SustainabilityServices Calculations.")
model CalculationResourceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("Calculation Resource Version.")
  @visibility("read", "create", "update")
  version?: string;

  @visibility("read", "create")
  @doc("Application Id for token claims.")
  @pattern("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$")
  tokenClaimsApplicationId: string;

  @doc("DDoS Protection Plan")
  @visibility("read", "create")
  ddosplan?: string;

  @visibility("read")
  @doc("Service Url")
  serviceUrl?: string;

  @visibility("read")
  @doc("Profile of Storage Created.")
  storageProfile?: StorageProfile;

  @visibility("read")
  @doc("Profile of AKV Created.")
  akvProfile?: AkvProfile;

  @visibility("read")
  @doc("Profile of App Service Created.")
  appServiceProfile?: AppServiceProfile;

  @visibility("read")
  @doc("Profile of Azure Redis Created.")
  redisProfile?: RedisProfile;

  @visibility("read")
  @doc("Profile of Monitoring Resource Created.")
  monitoringProfile?: MonitoringProfile;

  @visibility("read")
  @doc("Profile of Azure FrontDoor Resource Created.")
  azureFrontDoorProfile?: AzureFrontDoorProfile;
}

@doc("The properties related to Storage Resource")
model StorageProfile {
  @doc("Resource Id of Storage Resource")
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

@doc("The properties related to App Service Resource")
model AppServiceProfile {
  @doc("Resource Id of App service Resource")
  @visibility("read")
  id?: string;
}

@doc("The properties related to Azure Key Vault (Akv) Resource")
model AkvProfile {
  @doc("Resource Id of Akv Resource")
  @visibility("read")
  id?: string;
}

@doc("The properties related to Azure FrontDoor Resource")
model AzureFrontDoorProfile {
  @doc("Resource Id of AzureFrontDoor Resource")
  @visibility("read")
  id?: string;
  }

@armResourceOperations(CalculationResource)
interface Calculations  {
  get is ArmResourceRead<CalculationResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CalculationResource>;
  update is ArmResourcePatchAsync<CalculationResource, CalculationResourceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<CalculationResource>;
  listByResourceGroup is ArmResourceListByParent<CalculationResource>;
  listBySubscription is ArmListBySubscription<CalculationResource>;
}
