import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforPostgreSQL;
/**
 * Represents configuration details for coordinator and node.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Cluster)
@Azure.ResourceManager.Private.armResourceInternal(ConfigurationProperties)
@includeInapplicableMetadataInPayload(false)
model Configuration extends ProxyResourceBase {
  /**
   * The name of the cluster configuration.
   */
  @maxLength(90)
  @minLength(1)
  @pattern("^[-\\w\\._]+$")
  @path
  @key("configurationName")
  @segment("configurations")
  name: string;

  /**
   * The properties of configuration.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ConfigurationProperties;
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Configurations_ListByCluster")
  listByCluster is ArmResourceListByParent<Configuration>;
}
