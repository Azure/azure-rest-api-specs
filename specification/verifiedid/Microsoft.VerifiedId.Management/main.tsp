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

@armProviderNamespace("Microsoft.VerifiedId")
@service(#{ title: "VerifiedIdMgmtClient" })
@versioned(Microsoft.VerifiedId.Versions)
@doc("VerifiedId Resource Provider management API.")
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.VerifiedId;

/**
 * Supported versions for Microsoft.VerifiedId.
 */
enum Versions {
  /**
   * The 2024-01-26-preview version of the Microsoft.VerifiedId resource provider.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2024_01_26_preview: "2024-01-26-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("A VerifiedId authority resource")
model Authority is TrackedResource<AuthorityProperties> {
  @doc("The ID of the authority")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  @key("authorityName")
  @segment("authorities")
  @path
  name: string;
}

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

@doc("Details of the VerifiedId Authority.")
model AuthorityProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations(Authority)
interface Authorities {
  get is ArmResourceRead<Authority>;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Authority,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  update is ArmCustomPatchSync<
    Authority,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Authority,
      AuthorityProperties
    >
  >;
  delete is ArmResourceDeleteSync<Authority>;
  listByResourceGroup is ArmResourceListByParent<Authority>;
  listBySubscription is ArmListBySubscription<Authority>;
}
