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
@doc("VerifiedId Resource Provider management API.")
@versioned(Versions)
namespace Microsoft.VerifiedId;

enum Versions {
  @doc("2024-01-26-preview")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_01_26: "2024-01-26-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("A VerifiedId authority resource")
model Authority is TrackedResource<AuthorityProperties> {
  @doc("The ID of the authority")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  @key("name")
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Authority>;
  update is Azure.ResourceManager.ArmCustomPatchSync<
    Authority,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Authority,
      AuthorityProperties
    >
  >;
  delete is ArmResourceDeleteSync<Authority>;
  @list
  listByResourceGroup is ArmResourceListByParent<Authority>;
  @list
  listBySubscription is ArmListBySubscription<Authority>;
}
