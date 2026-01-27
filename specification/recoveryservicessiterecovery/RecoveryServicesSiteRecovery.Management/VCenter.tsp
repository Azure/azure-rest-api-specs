import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Fabric.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * vCenter definition.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Fabric)
model VCenter is Azure.ResourceManager.ProxyResource<VCenterProperties> {
  ...ResourceNameParameter<
    Resource = VCenter,
    KeyName = "vcenterName",
    SegmentName = "replicationvCenters",
    NamePattern = ""
  >;

  /**
   * Resource Location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface VCenters {
  /**
   * Gets the details of a registered vCenter server(Add vCenter server).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the details of a vCenter.")
  get is ArmResourceRead<VCenter, Error = never>;

  /**
   * The operation to create a vCenter object..
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Add vCenter.")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    VCenter,
    Request = AddVCenterRequest,
    Response = ArmResourceUpdatedResponse<VCenter> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = VCenter> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = never
  >;

  /**
   * The operation to update a registered vCenter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  @summary("Update vCenter operation.")
  update is ArmCustomPatchAsync<
    VCenter,
    PatchModel = UpdateVCenterRequest,
    Error = never
  >;

  /**
   * The operation to remove(unregister) a registered vCenter server from the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Remove vcenter operation.")
  delete is ArmResourceDeleteWithoutOkAsync<VCenter, Error = never>;

  /**
   * Lists the vCenter servers registered in a fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the list of vCenter registered under a fabric.")
  listByReplicationFabrics is ArmResourceListByParent<
    VCenter,
    Response = ArmResponse<VCenterCollection>,
    Error = never
  >;
}

@@doc(VCenter.name, "vcenter name.");
@@doc(VCenter.properties, "VCenter related data.");
@@doc(VCenters.create::parameters.resource,
  "The input to the add vCenter operation."
);
@@doc(VCenters.update::parameters.properties,
  "The input to the update vCenter operation."
);
