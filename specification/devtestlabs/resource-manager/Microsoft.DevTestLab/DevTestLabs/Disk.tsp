import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.DevTestLab;
/**
 * A Disk.
 */
@parentResource(User)
model Disk is Azure.ResourceManager.ProxyResource<DiskProperties, false> {
  ...ResourceNameParameter<
    Resource = Disk,
    KeyName = "diskName",
    SegmentName = "disks",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface Disks {
  /**
   * Get disk.
   */
  get is ArmResourceRead<
    Disk,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=diskType)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create or replace an existing disk. This operation can take a while to complete.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Disk,
    LroHeaders = ArmLroLocationHeader<FinalResult = Disk> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Allows modifying tags of disks. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "Already contains tags"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Disk, PatchModel = DiskFragment>;

  /**
   * Delete disk. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Disk,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List disks in a given user profile.
   */
  list is ArmResourceListByParent<
    Disk,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=diskType)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')
       */
      @query("$filter")
      $filter?: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'
       */
      @query("$top")
      $top?: int32;

      /**
       * The ordering expression for the results, using OData notation. Example: '$orderby=name desc'
       */
      @query("$orderby")
      $orderby?: string;
    },
    Response = ArmResponse<DiskList>
  >;

  /**
   * Attach and create the lease of the disk to the virtual machine. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Legacy non-standard usage of operation response codes. Consider revising in a future API version."
  attach is ArmResourceActionAsync<
    Disk,
    AttachDiskProperties,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;
  /**
   * Detach and break the lease of the disk attached to the virtual machine. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Legacy non-standard usage of operation response codes. Consider revising in a future API version."
  detach is ArmResourceActionAsync<
    Disk,
    DetachDiskProperties,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;
}

@@doc(Disk.name, "The name of the disk.");
@@doc(Disk.properties, "The properties of the disk.");
@@doc(Disks.createOrUpdate::parameters.resource, "A Disk.");
@@doc(Disks.update::parameters.properties, "A Disk.");
@@doc(Disks.attach::parameters.body, "Properties of the disk to attach.");
@@doc(Disks.detach::parameters.body, "Properties of the disk to detach.");
