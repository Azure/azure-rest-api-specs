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

@armResourceOperations
interface Licenses {
  /**
   * Retrieves information about the view of a license.
   */
  get is ArmResourceRead<License>;

  /**
   * The operation to create or update a license.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    License,
    Response = ArmResourceUpdatedResponse<License> &
      ArmLroLocationHeader<FinalResult = License> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to update a license.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    License,
    PatchModel = LicenseUpdate,
    Response = ArmResponse<License> &
      ArmLroLocationHeader<FinalResult = License> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to delete a license.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    License,
    Response = (ArmDeletedResponse &
      ArmLroLocationHeader<FinalResult = License> &
      Azure.Core.Foundations.RetryAfterHeader) | ArmDeletedNoContentResponse
  >;

  /**
   * The operation to get all licenses of a non-Azure machine
   */
  listByResourceGroup is ArmResourceListByParent<License>;

  /**
   * The operation to get all licenses of a non-Azure machine
   */
  listBySubscription is ArmListBySubscription<License>;
}

@@doc(License.name, "The name of the license.");
@@doc(License.properties, "Hybrid Compute License properties");
@@doc(Licenses.createOrUpdate::parameters.resource,
  "Parameters supplied to the Create license operation."
);
@@doc(Licenses.update::parameters.properties,
  "Parameters supplied to the Update license operation."
);
