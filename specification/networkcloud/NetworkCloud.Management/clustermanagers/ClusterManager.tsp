import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./ClusterManager_models.tsp";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.NetworkCloud;
/**
 * The name of the cluster manager.
 */
model ClusterManagerNameParameter
  is ResourceNameParameter<
    Resource = ClusterManager,
    KeyName = "clusterManagerName",
    SegmentName = "clusterManagers",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$"
  >;

/**
 * ClusterManager represents a control-plane to manage one or more on-premises clusters.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "legacy resource using legacy features"
model ClusterManager is TrackedResource<ClusterManagerProperties, false> {
  ...ClusterManagerNameParameter;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...ManagedServiceIdentityProperty;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Unable to use template due to Versioning.@added not being applicable to ...spread operations"
  @added(Versions.v2026_01_01_preview)
  @doc("The kind of the cluster manager.")
  @pattern("^[-\\w\\._,\\(\\\\\\)]+$")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind?: DeploymentType;
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
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = ClusterManager>
  >;

  /**
   * Patch properties of the provided cluster manager, or update the tags assigned to the cluster manager. Properties and tag updates can be done independently.
   */
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchSync<
    ClusterManager,
    PatchModel = ClusterManagerPatchParameters,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided cluster manager.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ClusterManager,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of cluster managers in the provided resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    ClusterManager,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<ClusterManagerList>
  >;

  /**
   * Get a list of cluster managers in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<
    ClusterManager,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<ClusterManagerList>
  >;

  /**
   * Update the private endpoint connection for the Azure Relay namespace managed by the specified cluster manager. Use this operation to approve or reject a pending private endpoint connection request for the relay namespace managed by the cluster manager.
   */
  @added(Versions.v2026_01_01_preview)
  updateRelayPrivateEndpointConnection is ActionAsync<
    ClusterManager,
    ClusterManagerUpdateRelayPrivateEndpointConnectionParameters,
    OperationStatusResult,
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
