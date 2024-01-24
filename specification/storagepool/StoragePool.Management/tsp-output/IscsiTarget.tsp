import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DiskPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StoragePool;
/**
 * Response for iSCSI Target requests.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(DiskPool)
@Azure.ResourceManager.Private.armResourceInternal(IscsiTargetProperties)
@includeInapplicableMetadataInPayload(false)
model IscsiTarget extends ProxyResource {
  /**
   * The name of the iSCSI Target.
   */
  @path
  @key("iscsiTargetName")
  @segment("iscsiTargets")
  name: string;

  /**
   * Azure resource id. Indicates if this resource is managed by another Azure resource.
   */
  @visibility("read")
  managedBy?: string;

  /**
   * List of Azure resource ids that manage this resource.
   */
  @visibility("read")
  managedByExtended?: string[];

  /**
   * Properties for iSCSI Target operations.
   */
  @extension("x-ms-client-flatten", true)
  properties: IscsiTargetProperties;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    IscsiTarget,
    BaseParameters<IscsiTarget>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update an iSCSI Target.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    IscsiTarget,
    IscsiTargetUpdate,
    BaseParameters<IscsiTarget>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete an iSCSI Target.
   */
  delete is ArmResourceDeleteAsync<
    IscsiTarget,
    BaseParameters<IscsiTarget>,
    ArmAsyncOperationHeader
  >;

  /**
   * Get iSCSI Targets in a Disk pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IscsiTargets_ListByDiskPool")
  listByDiskPool is ArmResourceListByParent<IscsiTarget>;
}

@@projectedName(IscsiTargets.createOrUpdate::parameters.resource,
  "json",
  "iscsiTargetCreatePayload"
);
@@extension(IscsiTargets.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "iscsiTargetCreatePayload"
);
@@doc(IscsiTargets.createOrUpdate::parameters.resource,
  "Request payload for iSCSI Target create operation."
);
@@projectedName(IscsiTargets.update::parameters.properties,
  "json",
  "iscsiTargetUpdatePayload"
);
@@extension(IscsiTargets.update::parameters.properties,
  "x-ms-client-name",
  "iscsiTargetUpdatePayload"
);
@@doc(IscsiTargets.update::parameters.properties,
  "Request payload for iSCSI Target update operation."
);
