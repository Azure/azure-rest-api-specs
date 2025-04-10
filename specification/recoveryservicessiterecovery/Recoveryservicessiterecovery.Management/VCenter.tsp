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
@parentResource(Fabric)
model VCenter is Azure.ResourceManager.ProxyResource<VCenterProperties> {
  ...ResourceNameParameter<
    Resource = VCenter,
    KeyName = "vcenterName",
    SegmentName = "replicationvCenters",
    NamePattern = ""
  >;
}

@armResourceOperations
interface VCenters {
  /**
   * Gets the details of a registered vCenter server(Add vCenter server).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationvCenters_Get")
  get is ArmResourceRead<VCenter>;

  /**
   * The operation to create a vCenter object..
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ReplicationvCenters_Create")
  create is ArmResourceCreateOrReplaceAsync<
    VCenter,
    Response = ArmResourceUpdatedResponse<VCenter> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to update a registered vCenter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("ReplicationvCenters_Update")
  update is ArmCustomPatchAsync<VCenter, PatchModel = UpdateVCenterRequest>;

  /**
   * The operation to remove(unregister) a registered vCenter server from the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationvCenters_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<VCenter>;

  /**
   * Lists the vCenter servers registered in a fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationvCenters_ListByReplicationFabrics")
  listByReplicationFabrics is ArmResourceListByParent<
    VCenter,
    Response = ArmResponse<VCenterCollection>
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
