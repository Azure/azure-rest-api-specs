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

  /**
   * Resource ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  /**
   * The kind of the cluster manager.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind?: DeploymentType;
}

@armResourceOperations
interface ClusterManagers {
  /**
   * Get the properties of the provided cluster manager.
   */
  @summary("Retrieve the cluster manager.")
  get is ArmResourceRead<ClusterManager>;

  /**
   * Create a new cluster manager or update properties of the cluster manager if it exists.
   */
  @summary("Create or update the cluster manager.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ClusterManager,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-None-Match`?: string;

      /**
       * Set to True to enable UserRPs to call into their extension endpoints using their services First Party Application.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `X-Ms-Userrp-Extension-Callback-Enabled`?: boolean;
    }
  >;

  /**
   * Patch properties of the provided cluster manager, or update the tags assigned to the cluster manager. Properties and tag updates can be done independently.
   */
  @summary("Patch the cluster manager.")
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchSync<
    ClusterManager,
    PatchModel = ClusterManagerPatchParameters,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-None-Match`?: string;

      /**
       * Set to True to enable UserRPs to call into their extension endpoints using their services First Party Application.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `X-Ms-Userrp-Extension-Callback-Enabled`?: boolean;
    },
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided cluster manager.
   */
  @summary("Delete the cluster manager.")
  delete is ArmResourceDeleteWithoutOkAsync<
    ClusterManager,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-None-Match`?: string;

      /**
       * Set to True to enable UserRPs to call into their extension endpoints using their services First Party Application.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `X-Ms-Userrp-Extension-Callback-Enabled`?: boolean;
    },
    Response = ArmResponse<OperationStatusResult> | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of cluster managers in the provided resource group.
   */
  @summary("List cluster managers in the resource group.")
  listByResourceGroup is ArmResourceListByParent<
    ClusterManager,
    Parameters = {
      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;

      /**
       * The opaque token that the server returns to indicate where to continue listing resources from. This is used for paging through large result sets.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<ClusterManagerList>
  >;

  /**
   * Get a list of cluster managers in the provided subscription.
   */
  @summary("List cluster managers in the subscription.")
  listBySubscription is ArmListBySubscription<
    ClusterManager,
    Parameters = {
      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;

      /**
       * The opaque token that the server returns to indicate where to continue listing resources from. This is used for paging through large result sets.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<ClusterManagerList>
  >;

  /**
   * Update the private endpoint connection for the Azure Relay namespace managed by the specified cluster manager. Use this operation to approve or reject a pending private endpoint connection request for the relay namespace managed by the cluster manager.
   */
  @summary("Approve or reject a relay private endpoint connection.")
  updateRelayPrivateEndpointConnection is ArmResourceActionAsyncBase<
    ClusterManager,
    ClusterManagerUpdateRelayPrivateEndpointConnectionParameters,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ClusterManager>,
    OptionalRequestBody = true
  >;
}

@@doc(ClusterManager.name, "The name of the cluster manager.");
@@doc(ClusterManager.properties, "The list of the resource properties.");
@@doc(ClusterManagers.createOrUpdate::parameters.resource, "The request body.");
@@doc(ClusterManagers.update::parameters.properties, "The request body.");
@@doc(ClusterManagers.updateRelayPrivateEndpointConnection::parameters.body,
  "The request body."
);
