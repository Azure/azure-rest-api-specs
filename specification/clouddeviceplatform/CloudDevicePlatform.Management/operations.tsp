import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.CloudDevicePlatform;

// Implements the required List Operations operation
interface Operations extends Azure.ResourceManager.Operations {}

@added(Versions.v2024_06_01_preview)
@armResourceOperations
interface DelegatedIdentities {
  createOrUpdate is ArmResourceCreateOrReplaceSync<DelegatedIdentity>;
  delete is ArmResourceDeleteSync<DelegatedIdentity>;
  get is ArmResourceRead<DelegatedIdentity>;
  listByResourceGroup is ArmResourceListByParent<DelegatedIdentity>;
  listBySubscription is ArmListBySubscription<DelegatedIdentity>;
  update is ArmCustomPatchSync<DelegatedIdentity, DelegatedIdentityUpdate>;
}
