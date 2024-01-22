import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.DBforPostgreSQL;

interface ConfigurationsOperations {
  /**
   * Gets information of a configuration for worker nodes.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforPostgreSQL/serverGroupsv2/{clusterName}/nodeConfigurations/{configurationName}")
  @get
  getNode is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
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
       * The name of the cluster.
       */
      @maxLength(40)
      @minLength(3)
      @pattern("^(?![0-9]+$)(?!-)[a-z0-9-]{3,40}(?<!-)$")
      @path
      clusterName: string;

      /**
       * The name of the cluster configuration.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      configurationName: string;
    },
    ServerConfiguration
  >;

  /**
   * Updates configuration of worker nodes in a cluster
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforPostgreSQL/serverGroupsv2/{clusterName}/nodeConfigurations/{configurationName}")
  @put
  updateOnNode is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription. The value must be an UUID.
       */
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
       * The name of the cluster.
       */
      @maxLength(40)
      @minLength(3)
      @pattern("^(?![0-9]+$)(?!-)[a-z0-9-]{3,40}(?<!-)$")
      @path
      clusterName: string;

      /**
       * The name of the cluster configuration.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      configurationName: string;

      /**
       * The required parameters for updating a cluster configuration.
       */
      @body
      parameters: ServerConfiguration;
    },
    ServerConfiguration
  >;
}
