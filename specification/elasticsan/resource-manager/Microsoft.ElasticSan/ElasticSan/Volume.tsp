import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VolumeGroup.tsp";
import "@typespec/versioning";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

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
      @added(Versions.v2026_05_01_preview)
      @query("deleteType")
      deleteType?: DeleteType;

      /**
       * Optional, used to delete a source volume together with its dependent clones (see activeCloneCount). Allowed values are only true or false. Default value is false. Without it, deleting a volume that has dependent clones is rejected; the delete is also rejected if any dependent clone is attached.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Header name follows the existing x-ms-delete-snapshots and x-ms-force-delete convention on this operation."
      @added(Versions.v2026_10_01_preview)
      @header
      @clientName("deleteClones", "csharp") // this could be temporary because we cannot reference this parameter through ::parameter syntax.
      `x-ms-delete-clones`?: `x-ms-delete-clones`;
    },
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
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
      @added(Versions.v2026_05_01_preview)
      @header
      @clientName("accessSoftDeletedResources", "csharp") // this could be temporary because we cannot reference this parameter through ::parameter syntax.
      `x-ms-access-soft-deleted-resources`?: `x-ms-access-soft-deleted-resources`;

      /**
       * Lists the dependent clones of a source volume: Thin clones, and Full clones whose backfill has not completed.
       *
       * The filter must be exactly
       * $filter="creationData/sourceId eq '<source volume ARM id>' and creationData/createSource eq 'Volume'".
       * Both clauses are required, values must be enclosed in single quotes, and 'Volume' is currently the
       * only supported creationData/createSource value. The source volume must be in the same volume group
       * as the listed scope. Any other property, operator, value or extra clause is rejected.
       *
       * Results are always live volumes: $filter cannot be combined with x-ms-access-soft-deleted-resources.
       */
      @added(Versions.v2026_10_01_preview)
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<VolumeList>
  >;
}

/**
 * Restore Soft Deleted Volumes. The volume name is obtained by using the API to list soft deleted volumes by volume group
 */
@added(Versions.v2026_05_01_preview)
@action("restore")
@tag("Restore Volumes")
op restoreVolume is ArmResourceActionAsync<Volume, void, Volume>;

@@maxLength(Volume.name, 63);
@@minLength(Volume.name, 3);
@@doc(Volume.name, "The name of the Volume.");
@@doc(Volume.properties, "Properties of Volume.");
@@doc(Volumes.create::parameters.resource, "Volume object.");
@@doc(Volumes.update::parameters.properties, "Volume object.");
