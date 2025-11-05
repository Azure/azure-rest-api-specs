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

/** Microsoft.EntraidGovernance Resource Provider management API. */
@armProviderNamespace("Microsoft.EntraidGovernance")
@service(#{ title: "Microsoft.EntraidGovernance management service" })
@versioned(Microsoft.EntraidGovernance.Versions)
@doc("Microsoft Entraid Governance Resource Provider management API.")
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.EntraidGovernance;

/** The available API versions. */
enum Versions {
  /** 2025-10-17-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_10_17_preview: "2025-10-17-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Initial provisioning in progress")
  Provisioning: "Provisioning",

  @doc("Update in progress")
  Updating: "Updating",

  @doc("Deletion in progress")
  Deleting: "Deleting",

  @doc("Change accepted for processing")
  Accepted: "Accepted",
}

@doc("Entraid Governance SCIM API Consumption resource")
@added(Versions.v2025_10_17_preview)
model ScimApiConsumption is TrackedResource<ScimApiConsumptionProperties> {
  @doc("Singleton SCIM API Consumption resource")
  @key
  @pattern("default")
  @segment("scimApiConsumptions")
  @path
  name: string;
}

@doc("Details of the Entraid Governance SCIM API Consumption resource.")
@added(Versions.v2025_10_17_preview)
model ScimApiConsumptionProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@added(Versions.v2025_10_17_preview)
@armResourceOperations(ScimApiConsumption)
interface ScimApiConsumptions {
  get is ArmResourceRead<ScimApiConsumption>;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<ScimApiConsumption>;
  update is ArmCustomPatchSync<
    ScimApiConsumption,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ScimApiConsumption,
      ScimApiConsumptionProperties
    >
  >;
  delete is ArmResourceDeleteSync<ScimApiConsumption>;
  listByResourceGroup is ArmResourceListByParent<ScimApiConsumption>;
  listBySubscription is ArmListBySubscription<ScimApiConsumption>;
}
