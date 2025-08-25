import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VolumeGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Azure.ClientGenerator.Core;

namespace Microsoft.ElasticSan;
/**
 * Response for Volume request.
 */
@parentResource(VolumeGroup)
model Volume is Azure.ResourceManager.ProxyResource<VolumeProperties, false> {
  ...ResourceNameParameter<
    Resource = Volume,
    KeyName = "volumeName",
    SegmentName = "volumes",
    NamePattern = "^[a-z0-9]+(-[a-z0-9A-Z]+)*$"
  >;
}

@armResourceOperations
interface Volumes {
  /**
   * Get an Volume.
   */
  get is ArmResourceRead<Volume>;

  /**
   * Create a Volume.
   */
  create is ArmResourceCreateOrReplaceAsync<
    Volume,
    LroHeaders = ArmLroLocationHeader<FinalResult = Volume> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update an Volume.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Volume, PatchModel = VolumeUpdate>;

  /**
   * Delete an Volume.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Volume,
    Parameters = {
      /**
       * Optional, used to delete snapshots under volume. Allowed value are only true or false. Default value is false.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      @clientName("deleteSnapshots", "csharp") // this could be temporary because we cannot reference this parameter through ::parameter syntax.
      `x-ms-delete-snapshots`?: `x-ms-delete-snapshots`;

      /**
       * Optional, used to delete volume if active sessions present. Allowed value are only true or false. Default value is false.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      @clientName("forceDelete", "csharp") // this could be temporary because we cannot reference this parameter through ::parameter syntax.
      `x-ms-force-delete`?: `x-ms-force-delete`;

      /**
       * Optional. Specifies that the delete operation should be a permanent delete for the soft deleted volume. The value of deleteType can only be 'permanent'.
       */
      @query("deleteType")
      deleteType?: DeleteType;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List Volumes in a VolumeGroup.
   */
  listByVolumeGroup is ArmResourceListByParent<
    Volume,
    Parameters = {
      /**
       * Optional, returns only soft deleted volumes if set to true. If set to false or if not specified, returns only active volumes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      @clientName("accessSoftDeletedResources", "csharp") // this could be temporary because we cannot reference this parameter through ::parameter syntax.
      `x-ms-access-soft-deleted-resources`?: `x-ms-access-soft-deleted-resources`;
    },
    Response = ArmResponse<VolumeList>
  >;
}

/**
 * Restore Soft Deleted Volumes. The volume name is obtained by using the API to list soft deleted volumes by volume group
 */
@action("restore")
@tag("Restore Volumes")
op restoreVolume is ArmResourceActionAsync<Volume, void, Volume>;

@@maxLength(Volume.name, 63);
@@minLength(Volume.name, 3);
@@doc(Volume.name, "The name of the Volume.");
@@doc(Volume.properties, "Properties of Volume.");
@@doc(Volumes.create::parameters.resource, "Volume object.");
@@doc(Volumes.update::parameters.properties, "Volume object.");
