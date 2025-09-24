import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ElasticSan.tsp";

using TypeSpec.Rest;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ElasticSan;
/**
 * Response for Volume Group request.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Private.armResourceInternal(VolumeGroupProperties)
@TypeSpec.Http.Private.includeInapplicableMetadataInPayload(false)
@parentResource(ElasticSan)
model VolumeGroup extends Foundations.ProxyResource {
  ...ResourceNameParameter<
    Resource = VolumeGroup,
    KeyName = "volumeGroupName",
    SegmentName = "volumegroups",
    NamePattern = "^[A-Za-z0-9]+((-|_)[a-z0-9A-Z]+)*$"
  >;

  /**
   * The identity of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Identity;

  /**
   * Properties of VolumeGroup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(true)
  properties?: VolumeGroupProperties;
}

@armResourceOperations
interface VolumeGroups {
  /**
   * Get an VolumeGroups.
   */
  get is ArmResourceRead<VolumeGroup>;

  /**
   * Create a Volume Group.
   */
  create is ArmResourceCreateOrReplaceAsync<
    VolumeGroup,
    LroHeaders = ArmLroLocationHeader<FinalResult = VolumeGroup> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update an VolumeGroup.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<VolumeGroup, PatchModel = VolumeGroupUpdate>;

  /**
   * Delete an VolumeGroup.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    VolumeGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List VolumeGroups.
   */
  listByElasticSan is ArmResourceListByParent<
    VolumeGroup,
    Parameters = {
      /**
       * Optional, returns only soft deleted volume groups if set to true. If set to false or if not specified, returns only active volume groups.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      @clientName("accessSoftDeletedResources", "csharp") // this could be temporary because we cannot reference this parameter through ::parameter syntax.
      `x-ms-access-soft-deleted-resources`?: `x-ms-access-soft-deleted-resources`;
    },
    Response = ArmResponse<VolumeGroupList>
  >;

  /**
   * Validate whether a disk snapshot backup can be taken for list of volumes.
   */
  preBackup is ArmResourceActionAsync<
    VolumeGroup,
    VolumeNameList,
    PreValidationResponse
  >;

  /**
   * Validate whether a list of backed up disk snapshots can be restored into ElasticSan volumes.
   */
  preRestore is ArmResourceActionAsync<
    VolumeGroup,
    DiskSnapshotList,
    PreValidationResponse
  >;
}

@@maxLength(VolumeGroup.name, 63);
@@minLength(VolumeGroup.name, 3);
@@doc(VolumeGroup.name, "The name of the VolumeGroup.");
@@doc(VolumeGroup.properties, "Properties of VolumeGroup.");
@@doc(VolumeGroups.create::parameters.resource, "Volume Group object.");
@@doc(VolumeGroups.update::parameters.properties, "Volume Group object.");
@@doc(VolumeGroups.preBackup::parameters.body,
  "Volume Name List (currently only one volume name in the list is supported. Server would return error if list is bigger)"
);
@@doc(VolumeGroups.preRestore::parameters.body,
  "Disk Snapshot List (currently only one Disk Snapshot in the list is supported and that the Disk Snapshot must be in same azure region as the ElasticSan. Server would return error if list is bigger)"
);
