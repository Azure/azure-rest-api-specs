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

@armProviderNamespace("Microsoft.SustainabilityServices")
@service(#{ title: "Microsoft.SustainabilityServices" })
@versioned(Microsoft.SustainabilityServices.Versions)
namespace Microsoft.SustainabilityServices;

@doc("Supported API versions for the Microsoft.SustainabilityServices resource provider.")
enum Versions {
  @doc("The 2024-10-01-preview version.")
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

  /** Initial provisioning in progress */
  Provisioning: "Provisioning",

  /** Update in progress */
  Updating: "Updating",

  /** Deletion in progress */
  Deleting: "Deleting",

  /** Change accepted for processing */
  Accepted: "Accepted",
}

@doc("Details of the SustainabilityServices Calculations.")
model CalculationResourceProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("Calculation Resource Version.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  version?: string;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Application Id for token claims.")
  @pattern("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$")
  tokenClaimsApplicationId: string;

  @doc("DDoS Protection Plan")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ddosPlan?: string;

  @visibility(Lifecycle.Read)
  @doc("Service Url")
  serviceUrl?: string;

  @visibility(Lifecycle.Read)
  @doc("Profile of Storage Created.")
  storageProfile?: StorageProfile;

  @visibility(Lifecycle.Read)
  @doc("Profile of AKV Created.")
  akvProfile?: AkvProfile;

  @visibility(Lifecycle.Read)
  @doc("Profile of App Service Created.")
  appServiceProfile?: AppServiceProfile;

  @visibility(Lifecycle.Read)
  @doc("Profile of Azure Redis Created.")
  redisProfile?: RedisProfile;

  @visibility(Lifecycle.Read)
  @doc("Profile of Monitoring Resource Created.")
  monitoringProfile?: MonitoringProfile;

  @visibility(Lifecycle.Read)
  @doc("Profile of Azure FrontDoor Resource Created.")
  azureFrontDoorProfile?: AzureFrontDoorProfile;

  @doc("Caching Type.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  cachingType?: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Enable Public Access.")
  enablePublicEndpoint?: boolean;

  @visibility(Lifecycle.Read)
  @doc("Managed On Behalf Of Configuration.")
  managedOnBehalfOfConfiguration?: ManagedOnBehalfOfConfiguration;

  @doc("Deny Assignments exclusion list.")
  @visibility(Lifecycle.Read, Lifecycle.Update)
  denyAssignmentExclusions?: DenyAssignmentExclusion[];
}

@doc("The properties related to Storage Resource")
model StorageProfile {
  @doc("Resource Id of Storage Resource")
  @visibility(Lifecycle.Read)
  id?: string;
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

@doc("The properties related to App Service Resource")
model AppServiceProfile {
  @doc("Resource Id of App service Resource")
  @visibility(Lifecycle.Read)
  id?: string;
}

@doc("The properties related to Azure Key Vault (Akv) Resource")
model AkvProfile {
  @doc("Resource Id of Akv Resource")
  @visibility(Lifecycle.Read)
  id?: string;
}

@doc("The properties related to Azure FrontDoor Resource")
model AzureFrontDoorProfile {
  @doc("Resource Id of AzureFrontDoor Resource")
  @visibility(Lifecycle.Read)
  id?: string;
}

@doc("Configuration of the managed on behalf of resource.")
model ManagedOnBehalfOfConfiguration {
  @visibility(Lifecycle.Read)
  @doc("Associated MoboBrokerResources.")
  moboBrokerResources: MoboBrokerResource[];
}

@doc("MoboBroker resource.")
model MoboBrokerResource {
  @doc("Mobo Broker Resource Id")
  @visibility(Lifecycle.Read)
  id: string;
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

@armResourceOperations(CalculationResource)
interface Calculations {
  get is ArmResourceRead<CalculationResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CalculationResource>;
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<
    CalculationResource,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      CalculationResource,
      CalculationResourceProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<CalculationResource>;
  listByResourceGroup is ArmResourceListByParent<CalculationResource>;
  listBySubscription is ArmListBySubscription<CalculationResource>;
}
