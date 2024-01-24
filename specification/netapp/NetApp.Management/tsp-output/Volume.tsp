import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./CapacityPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetApp;
/**
 * Volume resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(CapacityPool)
@Azure.ResourceManager.Private.armResourceInternal(VolumeProperties)
@includeInapplicableMetadataInPayload(false)
model Volume extends TrackedResourceBase {
  /**
   * The name of the volume
   */
  @maxLength(64)
  @minLength(1)
  @pattern("^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$")
  @path
  @key("volumeName")
  @segment("volumes")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility("read")
  etag?: string;

  /**
   * Availability Zone
   */
  @visibility("read", "create")
  zones?: string[];

  /**
   * Volume properties
   */
  @extension("x-ms-client-flatten", true)
  properties: VolumeProperties;
}

@armResourceOperations
interface Volumes {
  /**
   * Get the details of the specified volume
   */
  get is ArmResourceRead<Volume>;

  /**
   * Create or update the specified volume within the capacity pool
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Volume,
    BaseParameters<Volume>,
    ArmAsyncOperationHeader
  >;

  /**
   * Patch the specified volume
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    Volume,
    VolumePatch,
    BaseParameters<Volume>,
    ArmLroLocationHeader
  >;

  /**
   * Delete the specified volume
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Volume,
    {
      ...BaseParameters<Volume>;

      /**
       * An option to force delete the volume. Will cleanup resources connected to the particular volume
       */
      @query("forceDelete")
      forceDelete?: boolean;
    },
    ArmLroLocationHeader
  >;

  /**
   * List all volumes within the capacity pool
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Volumes_List")
  list is ArmResourceListByParent<Volume>;

  /**
   * This operation will populate availability zone information for a volume
   */
  populateAvailabilityZone is ArmResourceActionAsync<
    Volume,
    void,
    Volume,
    BaseParameters<Volume>,
    ArmLroLocationHeader
  >;

  /**
   * Revert a volume to the snapshot specified in the body
   */
  revert is ArmResourceActionAsync<
    Volume,
    VolumeRevert,
    void,
    BaseParameters<Volume>,
    ArmLroLocationHeader
  >;

  /**
   * Reset cifs password from volume
   */
  resetCifsPassword is ArmResourceActionAsync<Volume, void, void>;

  /**
   * Break all the file locks on a volume
   */
  breakFileLocks is ArmResourceActionAsync<
    Volume,
    BreakFileLocksRequest,
    void,
    BaseParameters<Volume>,
    ArmLroLocationHeader
  >;

  /**
   * Returns the list of group Ids for a specific LDAP User
   */
  listGetGroupIdListForLdapUser is ArmResourceActionAsync<
    Volume,
    GetGroupIdListForLdapUserRequest,
    GetGroupIdListForLdapUserResponse,
    BaseParameters<Volume>,
    ArmLroLocationHeader
  >;

  /**
   * Break the replication connection on the destination volume
   */
  breakReplication is ArmResourceActionAsync<
    Volume,
    BreakReplicationRequest,
    void,
    BaseParameters<Volume>,
    ArmLroLocationHeader
  >;

  /**
   * Re-establish a previously deleted replication between 2 volumes that have a common ad-hoc or policy-based snapshots
   */
  reestablishReplication is ArmResourceActionNoResponseContentAsync<
    Volume,
    ReestablishReplicationRequest,
    BaseParameters<Volume>,
    ArmLroLocationHeader
  >;

  /**
   * List all replications for a specified volume
   */
  listReplications is ArmResourceActionSync<Volume, void, ListReplications>;

  /**
   * Resync the connection on the destination volume. If the operation is ran on the source volume it will reverse-resync the connection and sync from destination to source.
   */
  resyncReplication is ArmResourceActionAsync<
    Volume,
    void,
    void,
    BaseParameters<Volume>,
    ArmLroLocationHeader
  >;

  /**
   * Delete the replication connection on the destination volume, and send release to the source replication
   */
  deleteReplication is ArmResourceActionAsync<
    Volume,
    void,
    void,
    BaseParameters<Volume>,
    ArmLroLocationHeader
  >;

  /**
   * Authorize the replication connection on the source volume
   */
  authorizeReplication is ArmResourceActionAsync<
    Volume,
    AuthorizeRequest,
    void,
    BaseParameters<Volume>,
    ArmLroLocationHeader
  >;

  /**
   * Re-Initializes the replication connection on the destination volume
   */
  reInitializeReplication is ArmResourceActionAsync<
    Volume,
    void,
    void,
    BaseParameters<Volume>,
    ArmLroLocationHeader
  >;

  /**
   * Moves volume to another pool
   */
  poolChange is ArmResourceActionAsync<
    Volume,
    PoolChangeRequest,
    void,
    BaseParameters<Volume>,
    ArmLroLocationHeader
  >;

  /**
   * Relocates volume to a new stamp
   */
  relocate is ArmResourceActionAsync<Volume, RelocateVolumeRequest, void>;

  /**
   * Finalizes the relocation of the volume and cleans up the old volume.
   */
  finalizeRelocation is ArmResourceActionAsync<Volume, void, void>;

  /**
   * Reverts the volume relocation process, cleans up the new volume and starts using the former-existing volume.
   */
  revertRelocation is ArmResourceActionAsync<Volume, void, void>;

  /**
   * Get the status of the replication
   */
  // FIXME: Volumes_ReplicationStatus could not be converted to a resource operation
  @summary("Get volume replication status")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetApp/netAppAccounts/{accountName}/capacityPools/{poolName}/volumes/{volumeName}/replicationStatus")
  @get
  replicationStatus is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the NetApp account
       */
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,127}$")
      @path
      accountName: string;

      /**
       * The name of the capacity pool
       */
      @maxLength(64)
      @minLength(1)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,63}$")
      @path
      poolName: string;

      /**
       * The name of the volume
       */
      @maxLength(64)
      @minLength(1)
      @pattern("^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$")
      @path
      volumeName: string;
    },
    ReplicationStatus
  >;

  /**
   * Get the status of the restore for a volume
   */
  // FIXME: Backups_GetVolumeRestoreStatus could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Backups_GetVolumeRestoreStatus")
  @summary("Get volume's restore status")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetApp/netAppAccounts/{accountName}/capacityPools/{poolName}/volumes/{volumeName}/restoreStatus")
  @get
  getVolumeRestoreStatus is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the NetApp account
       */
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,127}$")
      @path
      accountName: string;

      /**
       * The name of the capacity pool
       */
      @maxLength(64)
      @minLength(1)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,63}$")
      @path
      poolName: string;

      /**
       * The name of the volume
       */
      @maxLength(64)
      @minLength(1)
      @pattern("^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$")
      @path
      volumeName: string;
    },
    RestoreStatus
  >;
}

@@projectedName(Volumes.createOrUpdate::parameters.resource, "json", "body");
@@extension(Volumes.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(Volumes.createOrUpdate::parameters.resource,
  "Volume object supplied in the body of the operation."
);
@@projectedName(Volumes.update::parameters.properties, "json", "body");
@@extension(Volumes.update::parameters.properties, "x-ms-client-name", "body");
@@doc(Volumes.update::parameters.properties,
  "Volume object supplied in the body of the operation."
);
@@doc(Volumes.revert::parameters.body,
  "Object for snapshot to revert supplied in the body of the operation."
);
@@doc(Volumes.breakFileLocks::parameters.body,
  "Optional body to provide the ability to clear file locks with selected options"
);
@@doc(Volumes.listGetGroupIdListForLdapUser::parameters.body,
  "Returns group Id list for a specific LDAP user"
);
@@doc(Volumes.breakReplication::parameters.body,
  "Optional body to force break the replication."
);
@@doc(Volumes.reestablishReplication::parameters.body,
  "body for the id of the source volume."
);
@@doc(Volumes.authorizeReplication::parameters.body,
  "Authorize request object supplied in the body of the operation."
);
@@doc(Volumes.poolChange::parameters.body,
  "Move volume to the pool supplied in the body of the operation."
);
@@doc(Volumes.relocate::parameters.body, "Relocate volume request");
