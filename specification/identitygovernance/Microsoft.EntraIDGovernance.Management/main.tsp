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
  /** 2025-02-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2021_10_01_preview: "2025-02-01-preview",

  /** 2025-02-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_06_13_preview: "2025-06-13-preview",
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

@doc("Entraid Guest Governance Usage resource")
@added(Versions.v2025_06_13_preview)
model GuestGovernanceUsage is TrackedResource<GuestGovernanceUsageProperties> {
  @doc("The Tenant ID having the guest governance usage resource")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  @key("name")
  @segment("guestGovernanceUsage")
  @path
  name: string;
}

@doc("Details of the Entraid Governance Guest Governance Usage resource.")
@added(Versions.v2025_06_13_preview)
model GuestGovernanceUsageProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@added(Versions.v2025_06_13_preview)
@armResourceOperations(GuestGovernanceUsage)
interface GuestGovernanceUsages {
  get is ArmResourceRead<GuestGovernanceUsage>;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<GuestGovernanceUsage>;
  update is ArmCustomPatchSync<
    GuestGovernanceUsage,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      GuestGovernanceUsage,
      GuestGovernanceUsageProperties
    >
  >;
  delete is ArmResourceDeleteSync<GuestGovernanceUsage>;
  listByResourceGroup is ArmResourceListByParent<GuestGovernanceUsage>;
  listBySubscription is ArmListBySubscription<GuestGovernanceUsage>;
}
