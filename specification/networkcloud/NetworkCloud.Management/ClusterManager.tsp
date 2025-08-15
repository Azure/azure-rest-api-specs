import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetworkCloud;
/**
 * ClusterManager represents a control-plane to manage one or more on-premises clusters.
 */
model ClusterManager
  is Azure.ResourceManager.TrackedResource<ClusterManagerProperties, false> {
  ...ResourceNameParameter<
    Resource = ClusterManager,
    KeyName = "clusterManagerName",
    SegmentName = "clusterManagers",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface ClusterManagers {
  /**
   * Get the properties of the provided cluster manager.
   */
  get is ArmResourceRead<ClusterManager>;

  /**
   * Create a new cluster manager or update properties of the cluster manager if it exists.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ClusterManager,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      `If-None-Match`?: string;
    }
  >;

  /**
   * Patch properties of the provided cluster manager, or update the tags assigned to the cluster manager. Properties and tag updates can be done independently.
   */
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchSync<
    ClusterManager,
    PatchModel = ClusterManagerPatchParameters,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      `If-None-Match`?: string;
    },
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided cluster manager.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ClusterManager,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      `If-None-Match`?: string;
    },
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of cluster managers in the provided resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    ClusterManager,
    Response = ArmResponse<ClusterManagerList>
  >;

  /**
   * Get a list of cluster managers in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<
    ClusterManager,
    Response = ArmResponse<ClusterManagerList>
  >;
}

@@doc(ClusterManager.name, "The name of the cluster manager.");
@@encodedName(ClusterManager.eTag, "application/json", "etag");
@@doc(ClusterManager.properties, "The list of the resource properties.");
@@doc(ClusterManagers.createOrUpdate::parameters.resource, "The request body.");
@@doc(ClusterManagers.update::parameters.properties, "The request body.");
