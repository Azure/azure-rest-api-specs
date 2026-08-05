import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.DeviceRegistry;

//
// The Credential resource keeps the same shape (TrackedResource singleton) in the
// old lineage and the 2026-11 revival, so it is a single multi-window declaration
// (removed at 2026-04, re-added at 2026-11). Only the operation interface diverges
// (patch modeling and the listByResourceGroup -> listByNamespace rename), so the
// old interface is renamed to CredentialsV1 (@renamedFrom keeps its operationIds)
// and the 2026-11 interface reuses the clean Credentials name.
//

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "singleton"
@added(Versions.v2025_11_01_preview)
@removed(Versions.v2026_04_01)
@added(Versions.v2026_11_01_preview)
@doc("A Credential Resource")
@parentResource(Namespace)
model Credential is TrackedResource<CredentialProperties> {
  @doc("The name of the Credential tracked resource.")
  @key("credentialName")
  @segment("credentials")
  @path
  name: "default";
}

@added(Versions.v2025_11_01_preview)
@removed(Versions.v2026_04_01)
@added(Versions.v2026_11_01_preview)
@doc("Details of the Credential Resource.")
model CredentialProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @added(Versions.v2026_11_01_preview)
  @visibility(Lifecycle.Read)
  @doc("Globally unique, immutable, non-reusable identifier of the Credential resource.")
  uuid?: string;
}

@added(Versions.v2026_11_01_preview)
@armResourceOperations(Credential)
interface Credentials {
  @sharedRoute
  get is ArmResourceRead<Credential>;
  @sharedRoute
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Credential>;
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<Credential>;
  // Using 'ArmCustomPatchAsync' instead of 'ArmResourcePatchAsync' to define the correct patch payload for the resource.
  // This is a workaround to fix the patch payload that otherwise will expose the 'location' field (not present in patch),
  // since otherwise it extends the ARM TrackedResource type.
  @sharedRoute
  update is ArmCustomPatchAsync<
    Credential,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Credential,
      CredentialProperties
    >
  >;
  @sharedRoute
  listByNamespace is ArmResourceListByParent<Credential>;
  @sharedRoute
  @doc("A long-running resource action.")
  synchronize is ArmResourceActionNoResponseContentAsync<Credential, void>;
}

@added(Versions.v2025_11_01_preview)
@removed(Versions.v2026_04_01)
@renamedFrom(Versions.v2026_04_01, "Credentials")
@armResourceOperations(Credential)
interface CredentialsV1 {
  @sharedRoute
  get is ArmResourceRead<Credential>;
  @sharedRoute
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Credential>;
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<Credential>;
  // Using 'ArmCustomPatchAsync' instead of 'ArmResourcePatchAsync' to define the correct patch payload for the resource.
  // This is a workaround to fix the patch payload that otherwise will expose the 'location' field (not present in patch),
  // since otherwise it extends the ARM TrackedResource type.
  @sharedRoute
  update is ArmCustomPatchAsync<
    Credential,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Credential,
      CredentialProperties
    >
  >;
  @sharedRoute
  listByResourceGroup is ArmResourceListByParent<Credential>;
  @sharedRoute
  @doc("A long-running resource action.")
  synchronize is ArmResourceActionNoResponseContentAsync<Credential, void>;
}
