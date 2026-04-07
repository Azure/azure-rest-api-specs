import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Machine.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridCompute;
/**
 * Describes a license profile in a hybrid machine.
 */
@singleton("default")
@parentResource(Machine)
model LicenseProfile
  is Azure.ResourceManager.TrackedResource<LicenseProfileProperties> {
  ...ResourceNameParameter<
    Resource = LicenseProfile,
    KeyName = "licenseProfile",
    SegmentName = "licenseProfiles",
    NamePattern = ""
  >;
}

@armResourceOperations
interface LicenseProfiles {
  /**
   * Retrieves information about the view of a license profile.
   */
  get is ArmResourceRead<LicenseProfile>;

  /**
   * The operation to create or update a license profile.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    LicenseProfile,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = LicenseProfile> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to update a license profile.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    LicenseProfile,
    PatchModel = LicenseProfileUpdate,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = LicenseProfile> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to delete a license profile.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    LicenseProfile,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to get all license profiles of a non-Azure machine
   */
  list is ArmResourceListByParent<
    LicenseProfile,
    Response = LicenseProfilesListResult
  >;
}

@@doc(LicenseProfile.name, "");
@@doc(LicenseProfile.properties,
  "Describe the properties of a license profile."
);
@@doc(LicenseProfiles.createOrUpdate::parameters.resource,
  "Parameters supplied to the Create or Update license profile operation."
);
@@doc(LicenseProfiles.update::parameters.properties,
  "Parameters supplied to the Update license profile operation."
);
