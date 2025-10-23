import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforPostgreSQL;
/**
 * Represents a cluster.
 */
model Cluster is Azure.ResourceManager.TrackedResource<ClusterProperties> {
  ...ResourceNameParameter<
    Resource = Cluster,
    KeyName = "clusterName",
    SegmentName = "serverGroupsv2",
    NamePattern = "^(?![0-9]+$)(?!-)[a-z0-9-]{3,40}(?<!-)$"
  >;

  /**
   * Describes the identity of the cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: IdentityProperties;
}

@armResourceOperations
interface Clusters {
  /**
   * Gets information about a cluster such as compute and storage configuration and cluster lifecycle metadata such as cluster creation date and time.
   */
  get is ArmResourceRead<Cluster>;

  /**
   * Creates a new cluster with servers.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    Cluster,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = Cluster>
  >;

  /**
   * Updates an existing cluster. The request body can contain one or several properties from the cluster definition.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @Azure.Core.useFinalStateVia("location")
  update is ArmCustomPatchAsync<
    Cluster,
    PatchModel = ClusterForUpdate,
    Response = ArmResponse<Cluster> | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = Cluster>> & {
      @bodyRoot
      _: Cluster;
    })
  >;

  /**
   * Deletes a cluster together with servers in it.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Cluster,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all clusters in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<Cluster>;

  /**
   * Lists all clusters in a subscription.
   */
  list is ArmListBySubscription<Cluster>;

  /**
   * Promotes read replica cluster to an independent read-write cluster.
   */
  @action("promote")
  @Azure.Core.useFinalStateVia("location")
  promoteReadReplica is ArmResourceActionAsyncBase<
    Cluster,
    PromoteRequest,
    ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    OptionalRequestBody = true
  >;

  /**
   * Restarts all nodes in the cluster.
   */
  @Azure.Core.useFinalStateVia("location")
  restart is ArmResourceActionAsyncBase<
    Cluster,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;

  /**
   * Starts stopped compute on all cluster nodes.
   */
  @Azure.Core.useFinalStateVia("location")
  start is ArmResourceActionAsync<
    Cluster,
    void,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader & ArmLroLocationHeader
  >;

  /**
   * Stops compute on all cluster nodes.
   */
  @Azure.Core.useFinalStateVia("location")
  stop is ArmResourceActionAsync<
    Cluster,
    void,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader & ArmLroLocationHeader
  >;
}

@@maxLength(Cluster.name, 40);
@@minLength(Cluster.name, 3);
@@doc(Cluster.name, "The name of the cluster.");
@@doc(Cluster.properties, "Properties of the cluster.");
@@doc(Clusters.create::parameters.resource,
  "The required parameters for creating or updating a cluster."
);
@@doc(Clusters.update::parameters.properties,
  "The parameters for updating a cluster."
);
@@doc(Clusters.promoteReadReplica::parameters.body,
  "The parameter for enabling geo-redundant backup while promoting read replica."
);
