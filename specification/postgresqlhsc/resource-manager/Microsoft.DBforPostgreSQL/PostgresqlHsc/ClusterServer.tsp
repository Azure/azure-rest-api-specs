import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.DBforPostgreSQL;
/**
 * Represents a server in a cluster.
 */
@parentResource(Cluster)
model ClusterServer
  is Azure.ResourceManager.ProxyResource<ClusterServerProperties> {
  ...ResourceNameParameter<
    Resource = ClusterServer,
    KeyName = "serverName",
    SegmentName = "servers",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface Servers {
  /**
   * Gets information about a server in cluster.
   */
  get is ArmResourceRead<ClusterServer>;

  /**
   * Lists servers of a cluster.
   */
  listByCluster is ArmResourceListByParent<
    ClusterServer,
    Response = ArmResponse<ResourceListResult<ClusterServer>>
  >;
}

@@maxLength(ClusterServer.name, 90);
@@minLength(ClusterServer.name, 1);
@@doc(ClusterServer.name, "The name of the server.");
@@doc(ClusterServer.properties, "The properties of a server in a cluster.");
