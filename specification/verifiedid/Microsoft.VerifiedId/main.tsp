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
@service({
  title: "VerifiedIdMgmtClient",
  version: "2024-01-26-preview",
})
@doc("VerifiedId Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.VerifiedId;

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

@doc("Details of the VerifiedId Authority.")
model AuthorityProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations(Authority)
interface Authorities {
  get is ArmResourceRead<Authority>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Authority>;
  update is ArmResourcePatchSync<Authority, AuthorityProperties>;
  delete is ArmResourceDeleteSync<Authority>;
  listByResourceGroup is ArmResourceListByParent<Authority>;
  listBySubscription is ArmListBySubscription<Authority>;
}
