import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforPostgreSQL;
/**
 * Represents a cluster.
 */
model Cluster is TrackedResource<ClusterProperties> {
  /**
   * The name of the cluster.
   */
  @maxLength(40)
  @minLength(3)
  @pattern("^(?![0-9]+$)(?!-)[a-z0-9-]{3,40}(?<!-)$")
  @path
  @key("clusterName")
  @segment("serverGroupsv2")
  name: string;
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
  create is ArmResourceCreateOrReplaceAsync<
    Cluster,
    BaseParameters<Cluster>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates an existing cluster. The request body can contain one or several properties from the cluster definition.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    Cluster,
    ClusterForUpdate,
    BaseParameters<Cluster>,
    ArmLroLocationHeader
  >;

  /**
   * Deletes a cluster together with servers in it.
   */
  delete is ArmResourceDeleteAsync<
    Cluster,
    BaseParameters<Cluster>,
    ArmLroLocationHeader
  >;

  /**
   * Lists all clusters in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Clusters_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Cluster>;

  /**
   * Lists all clusters in a subscription.
   */
  list is ArmListBySubscription<Cluster>;

  /**
   * Restarts all nodes in the cluster.
   */
  restart is ArmResourceActionNoResponseContentAsync<
    Cluster,
    void,
    BaseParameters<Cluster>,
    ArmLroLocationHeader
  >;

  /**
   * Starts stopped compute on all cluster nodes.
   */
  start is ArmResourceActionAsync<
    Cluster,
    void,
    void,
    BaseParameters<Cluster>,
    ArmLroLocationHeader
  >;

  /**
   * Stops compute on all cluster nodes.
   */
  stop is ArmResourceActionAsync<
    Cluster,
    void,
    void,
    BaseParameters<Cluster>,
    ArmLroLocationHeader
  >;

  /**
   * Promotes read replica cluster to an independent read-write cluster.
   */
  promoteReadReplica is ArmResourceActionNoResponseContentAsync<
    Cluster,
    void,
    BaseParameters<Cluster>,
    ArmLroLocationHeader
  >;

  /**
   * Checks availability of a cluster name. Cluster names should be globally unique; at least 3 characters and at most 40 characters long; they must only contain lowercase letters, numbers, and hyphens; and must not start or end with a hyphen.
   */
  checkNameAvailability is checkGlobalNameAvailability<
    NameAvailabilityRequest,
    NameAvailability
  >;
}

@@projectedName(Clusters.create::parameters.resource, "json", "parameters");
@@extension(Clusters.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Clusters.create::parameters.resource,
  "The required parameters for creating or updating a cluster."
);
@@projectedName(Clusters.update::parameters.properties, "json", "parameters");
@@extension(Clusters.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Clusters.update::parameters.properties,
  "The parameters for updating a cluster."
);
