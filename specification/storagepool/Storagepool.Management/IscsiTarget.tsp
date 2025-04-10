import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DiskPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StoragePool;
/**
 * Response for iSCSI Target requests.
 */
@parentResource(DiskPool)
model IscsiTarget
  is Azure.ResourceManager.ProxyResource<IscsiTargetProperties, false> {
  ...ResourceNameParameter<
    Resource = IscsiTarget,
    KeyName = "iscsiTargetName",
    SegmentName = "iscsiTargets",
    NamePattern = ""
  >;

  /**
   * Azure resource id. Indicates if this resource is managed by another Azure resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  managedBy?: string;

  /**
   * List of Azure resource ids that manage this resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  managedByExtended?: string[];
}

@armResourceOperations
interface IscsiTargets {
  /**
   * Get an iSCSI Target.
   */
  get is ArmResourceRead<IscsiTarget>;

  /**
   * Create or Update an iSCSI Target.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<IscsiTarget>;

  /**
   * Update an iSCSI Target.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    IscsiTarget,
    PatchModel = IscsiTargetUpdate,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete an iSCSI Target.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    IscsiTarget,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Get iSCSI Targets in a Disk pool.
   */
  listByDiskPool is ArmResourceListByParent<
    IscsiTarget,
    Response = ArmResponse<IscsiTargetList>
  >;
}

@@doc(IscsiTarget.name, "The name of the iSCSI Target.");
@@doc(IscsiTarget.properties, "Properties for iSCSI Target operations.");
@@doc(IscsiTargets.createOrUpdate::parameters.resource,
  "Request payload for iSCSI Target create operation."
);
@@doc(IscsiTargets.update::parameters.properties,
  "Request payload for iSCSI Target update operation."
);
