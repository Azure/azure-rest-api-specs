import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HardwareSecurityModules;
/**
 * Resource information with extended details.
 */
model CloudHsmCluster
  is Azure.ResourceManager.TrackedResource<CloudHsmClusterProperties> {
  ...ResourceNameParameter<
    Resource = CloudHsmCluster,
    KeyName = "cloudHsmClusterName",
    SegmentName = "cloudHsmClusters",
    NamePattern = "^[a-zA-Z0-9-]{3,23}$"
  >;

  /**
   * Managed service identity (system assigned and/or user assigned identities)
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * SKU details
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sku?: CloudHsmClusterSku;
}

@armResourceOperations
interface CloudHsmClusters {
  /**
   * Gets the specified Cloud HSM Cluster
   */
  get is ArmResourceRead<CloudHsmCluster>;

  /**
   * Create or Update a Cloud HSM Cluster in the specified subscription.
   */
  @Azure.Core.useFinalStateVia("original-uri")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CloudHsmCluster>;

  /**
   * Update a Cloud HSM Cluster in the specified subscription.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    CloudHsmCluster,
    PatchModel = CloudHsmClusterPatchParameters
  >;

  /**
   * Deletes the specified Cloud HSM Cluster
   */
  delete is ArmResourceDeleteWithoutOkAsync<CloudHsmCluster>;

  /**
   * The List operation gets information about the Cloud HSM Clusters associated with the subscription and within the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    CloudHsmCluster,
    Parameters = {
      /**
       * The page-continuation token to use with a paged version of this API
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;

  /**
   * The List operation gets information about the Cloud HSM Clusters associated with the subscription.
   */
  listBySubscription is ArmListBySubscription<
    CloudHsmCluster,
    Parameters = {
      /**
       * The page-continuation token to use with a paged version of this API
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;

  /**
   * Pre Backup operation to validate whether the customer can perform a backup on the Cloud HSM Cluster resource in the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  validateBackupProperties is ArmResourceActionAsync<
    CloudHsmCluster,
    BackupRequestProperties,
    ArmResponse<BackupResult> & Azure.Core.RequestIdResponseHeader,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = BackupResult> &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader &
      Azure.Core.RequestIdResponseHeader,
    OptionalRequestBody = true
  >;

  /**
   * Create a backup of the Cloud HSM Cluster in the specified subscription
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  backup is ArmResourceActionAsync<
    CloudHsmCluster,
    BackupRequestProperties,
    ArmResponse<BackupResult> & Azure.Core.RequestIdResponseHeader,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = BackupResult> &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader &
      Azure.Core.RequestIdResponseHeader,
    OptionalRequestBody = true
  >;

  /**
   * Queued validating pre restore operation
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  validateRestoreProperties is ArmResourceActionAsync<
    CloudHsmCluster,
    RestoreRequestProperties,
    ArmResponse<RestoreResult> & Azure.Core.RequestIdResponseHeader,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = RestoreResult> &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader &
      Azure.Core.RequestIdResponseHeader,
    OptionalRequestBody = true
  >;

  /**
   * Restores all key materials of a specified Cloud HSM Cluster
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  restore is ArmResourceActionAsync<
    CloudHsmCluster,
    RestoreRequestProperties,
    ArmResponse<RestoreResult> & Azure.Core.RequestIdResponseHeader,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = RestoreResult> &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader &
      Azure.Core.RequestIdResponseHeader
  >;

  /**
   * Gets the private link resources supported for the Cloud Hsm Cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("privateLinkResources")
  @list
  listByCloudHsmCluster is ArmResourceActionSync<
    CloudHsmCluster,
    void,
    CommonTypes.PrivateLinkResourceListResult
  >;

  /**
   * Gets the backup operation status of the specified Cloud HSM Cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  cloudHsmClusterBackupStatusGet(
    ...ResourceInstanceParameters<
      Resource,
      Azure.ResourceManager.Foundations.DefaultBaseParameters<CloudHsmCluster>
    >,

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    @segment("cloudHsmClusters")
    @minLength(3)
    @maxLength(23)
    @pattern("^[a-zA-Z0-9-]{3,23}$")
    cloudHsmClusterName: string,

    /**
     * Identifier for the backup operation
     */
    @path
    @segment("backupOperationStatus")
    jobId: string,
  ): (BackupResult &
    Azure.Core.RequestIdResponseHeader) | ArmAcceptedResponse<ExtraHeaders = {
    @header("Location")
    @doc("The Location header contains the URL where the status of the long running operation can be checked.")
    location?: string;
  } & Azure.Core.RequestIdResponseHeader> | ErrorResponse;
  /**
   * Gets the restore operation status of the specified Cloud HSM Cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  cloudHsmClusterRestoreStatusGet(
    ...ResourceInstanceParameters<
      Resource,
      Azure.ResourceManager.Foundations.DefaultBaseParameters<CloudHsmCluster>
    >,

    /**
     * Name of the Cloud HSM Cluster
     */
    @path
    @segment("cloudHsmClusters")
    @minLength(3)
    @maxLength(23)
    @pattern("^[a-zA-Z0-9-]{3,23}$")
    cloudHsmClusterName: string,

    /**
     * Identifier for the restore operation
     */
    @path
    @segment("restoreOperationStatus")
    jobId: string,
  ): (RestoreResult &
    Azure.Core.RequestIdResponseHeader) | ArmAcceptedResponse<ExtraHeaders = {
    @header("Location")
    @doc("The Location header contains the URL where the status of the long running operation can be checked.")
    location?: string;
  } & Azure.Core.RequestIdResponseHeader> | ErrorResponse;
}

@@maxLength(CloudHsmCluster.name, 23);
@@minLength(CloudHsmCluster.name, 3);
@@doc(CloudHsmCluster.name,
  "The name of the Cloud HSM Cluster within the specified resource group. Cloud HSM Cluster names must be between 3 and 23 characters in length."
);
@@doc(CloudHsmCluster.properties, "Properties of the Cloud HSM Cluster");
@@doc(CloudHsmClusters.createOrUpdate::parameters.resource,
  "Parameters to create Cloud HSM Cluster"
);
@@doc(CloudHsmClusters.update::parameters.properties,
  "Parameters to create Cloud HSM Cluster"
);
@@doc(CloudHsmClusters.restore::parameters.body,
  "Restore Operation Required properties"
);
@@doc(CloudHsmClusters.validateRestoreProperties::parameters.body,
  "Optional Parameters to validate prior performing a restore operation."
);
@@doc(CloudHsmClusters.backup::parameters.body, "Azure storage Resource Uri");
@@doc(CloudHsmClusters.validateBackupProperties::parameters.body,
  "Backup Operation Required properties"
);
