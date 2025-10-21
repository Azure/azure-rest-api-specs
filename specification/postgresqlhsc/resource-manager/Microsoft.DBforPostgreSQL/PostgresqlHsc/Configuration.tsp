import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Microsoft.DBforPostgreSQL;
/**
 * Represents configuration details for coordinator and node.
 */
@parentResource(Cluster)
model Configuration
  is Azure.ResourceManager.ProxyResource<ConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = Configuration,
    KeyName = "configurationName",
    SegmentName = "configurations",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface Configurations {
  /**
   * Gets information of a configuration for coordinator and nodes.
   */
  get is ArmResourceRead<Configuration>;

  /**
   * List all the configurations of a cluster.
   */
  @list
  listByCluster is ArmResourceListByParent<
    Configuration,
    Response = ClusterConfigurationListResult
  >;

  /**
   * List all the configurations of a server in cluster.
   */
  @get
  @action("configurations")
  @list
  listByServer is ArmResourceActionSync<
    ClusterServer,
    void,
    ArmResponse<ResourceListResult<ServerConfiguration>>
  >;
}

/**
 * Pagination result of configurations.
 */
model ClusterConfigurationListResult {
  /**
   * The list of configurations.
   */
  @doc("The list of configurations.")
  @pageItems
  value?: Configuration[];

  /**
   * The link to the next page of results.
   */
  @doc("The link to the next page of results.")
  @nextLink
  nextLink?: string;
}

@@maxLength(Configuration.name, 90);
@@minLength(Configuration.name, 1);
@@doc(Configuration.name, "The name of the cluster configuration.");
@@doc(Configuration.properties, "The properties of configuration.");
