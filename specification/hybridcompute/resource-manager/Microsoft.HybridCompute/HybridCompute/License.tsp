import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridCompute;
/**
 * Describes a license in a hybrid machine.
 */
model License is Azure.ResourceManager.TrackedResource<LicenseProperties> {
  ...ResourceNameParameter<
    Resource = License,
    KeyName = "licenseName",
    SegmentName = "licenses",
    NamePattern = "[a-zA-Z0-9-_\\.]+"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface Licenses {
  /**
   * Retrieves information about the view of a license.
   */
  @tag("licenses")
  get is ArmResourceRead<License>;

  /**
   * The operation to create or update a license.
   */
  @tag("licenses")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    License,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = License> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to update a license.
   */
  @tag("licenses")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    License,
    PatchModel = LicenseUpdate,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = License> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to delete a license.
   */
  @tag("licenses")
  delete is ArmResourceDeleteWithoutOkAsync<
    License,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader & ArmCombinedLroHeaders
  >;

  /**
   * The operation to get all licenses of a non-Azure machine
   */
  @tag("licenses")
  listByResourceGroup is ArmResourceListByParent<
    License,
    Response = LicensesListResult
  >;

  /**
   * The operation to get all licenses of a non-Azure machine
   */
  @tag("licenses")
  listBySubscription is ArmListBySubscription<
    License,
    Response = LicensesListResult
  >;
}

@@doc(License.name, "The name of the license.");
@@doc(License.properties, "Hybrid Compute License properties");
@@doc(
  Licenses.createOrUpdate::parameters.resource,
  "Parameters supplied to the Create license operation."
);
@@doc(
  Licenses.update::parameters.properties,
  "Parameters supplied to the Update license operation."
);
