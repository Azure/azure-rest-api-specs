import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * A Disk.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model Disk extends Resource {
  @visibility(Lifecycle.Read)
  @path
  @key
  @segment("disks")
  name: string;

  properties: DiskProperties;
}

@armResourceOperations
interface DiskOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the lab. */
        @path @segment("labs") labName: string,

        /** The name of the user profile. */
        @path @segment("users") userName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = Disk,
        KeyName = "name",
        SegmentName = "disks",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface Disks {
  /**
   * Get disk.
   */
  get is DiskOps.Read<
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
  createOrUpdate is DiskOps.CreateOrUpdateAsync<
    Disk,
    LroHeaders = ArmLroLocationHeader<FinalResult = Disk> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Allows modifying tags of disks. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "Already contains tags"
  @patch(#{ implicitOptionality: false })
  update is DiskOps.CustomPatchSync<Disk, PatchModel = DiskFragment>;

  /**
   * Delete disk. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is DiskOps.DeleteWithoutOkAsync<
    Disk,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List disks in a given user profile.
   */
  list is DiskOps.List<
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
  attach is DiskOps.ActionAsync<Disk, AttachDiskProperties, OkResponse>;

  /**
   * Detach and break the lease of the disk attached to the virtual machine. This operation can take a while to complete.
   */
  detach is DiskOps.ActionAsync<Disk, DetachDiskProperties, OkResponse>;
}

@@doc(Disk.name, "The name of the disk.");
@@doc(Disk.properties, "The properties of the disk.");
@@doc(Disks.createOrUpdate::parameters.resource, "A Disk.");
@@doc(Disks.update::parameters.properties, "A Disk.");
@@doc(Disks.attach::parameters.body, "Properties of the disk to attach.");
@@doc(Disks.detach::parameters.body, "Properties of the disk to detach.");
