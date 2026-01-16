import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.CloudDevicePlatform.V20260101Preview;

@added(Versions.v2026_01_01_preview)
@armResourceOperations
interface PartnerBusinessOperations {
  createOrUpdate is ArmResourceCreateOrReplaceSync<PartnerBusiness>;
  delete is ArmResourceDeleteSync<PartnerBusiness>;
  get is ArmResourceRead<PartnerBusiness>;
  listBySubscription is ArmListBySubscription<PartnerBusiness>;
}
