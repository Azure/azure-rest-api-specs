import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.CloudDevicePlatform.V20260101Preview;

@added(Versions.v2026_01_01_preview)
@armResourceOperations
interface PartnerBusinesses {
  createOrUpdate is ArmResourceCreateOrReplaceSync<PartnerBusiness>;
  delete is ArmResourceDeleteSync<PartnerBusiness>;
  get is ArmResourceRead<PartnerBusiness>;
  update is ArmCustomPatchSync<PartnerBusiness, PartnerBusinessUpdate>;
  listByResourceGroup is ArmResourceListByParent<PartnerBusiness>;
  listBySubscription is ArmListBySubscription<PartnerBusiness>;
}
