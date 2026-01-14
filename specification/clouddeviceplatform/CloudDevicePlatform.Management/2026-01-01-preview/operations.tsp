import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.CloudDevicePlatform.V20260101Preview;

@added(Versions.v2026_01_01_preview)
@armResourceOperations
interface DelegatedIdentityOperations {
  createOrUpdate is ArmResourceCreateOrReplaceSync<DelegatedIdentityV20260101Preview>;
  delete is ArmResourceDeleteSync<DelegatedIdentityV20260101Preview>;
  get is ArmResourceRead<DelegatedIdentityV20260101Preview>;
  update is ArmCustomPatchSync<DelegatedIdentityV20260101Preview, DelegatedIdentityUpdate>;
  listByParent is ArmResourceListByParent<DelegatedIdentityV20260101Preview>;
}

@added(Versions.v2026_01_01_preview)
@armResourceOperations
interface PartnerBusinessOperations {
  createOrUpdate is ArmResourceCreateOrReplaceSync<PartnerBusiness>;
  delete is ArmResourceDeleteSync<PartnerBusiness>;
  get is ArmResourceRead<PartnerBusiness>;
  update is ArmCustomPatchSync<PartnerBusiness, PartnerBusinessUpdate>;
  listBySubscription is ArmListBySubscription<PartnerBusiness>;
}
