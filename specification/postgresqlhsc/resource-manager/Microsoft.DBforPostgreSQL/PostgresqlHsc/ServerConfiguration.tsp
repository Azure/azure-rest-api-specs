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

namespace Microsoft.DBforPostgreSQL;
/**
 * Represents a configuration.
 */
@parentResource(Cluster)
model ServerConfiguration
  is Azure.ResourceManager.ProxyResource<ServerConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = ServerConfiguration,
    KeyName = "configurationName",
    SegmentName = "nodeConfigurations",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface NodeConfigurations {
  /**
   * Gets information of a configuration for worker nodes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  getNode is NodeConfigurationOps.Read<ServerConfiguration>;

  /**
   * Updates configuration of worker nodes in a cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  updateOnNode is NodeConfigurationOps.CreateOrUpdateAsync<
    ServerConfiguration,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = ServerConfiguration> &
      ArmLroLocationHeader<FinalResult = ServerConfiguration>
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "For backward compatibility"
@armResourceOperations
interface CoordinatorConfigurations {
  /**
   * Gets information of a configuration for coordinator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  getCoordinator is CoordinatorConfigurationOps.Read<ServerConfiguration>;

  /**
   * Updates configuration of coordinator in a cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  updateOnCoordinator is CoordinatorConfigurationOps.CreateOrUpdateAsync<
    ServerConfiguration,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = ServerConfiguration> &
      ArmLroLocationHeader<FinalResult = ServerConfiguration>
  >;
}

@armResourceOperations
interface NodeConfigurationOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the cluster. */
        @path
        @minLength(3)
        @maxLength(40)
        @segment("serverGroupsv2")
        @key
        @pattern("^(?![0-9]+$)(?!-)[a-z0-9-]{3,40}(?<!-)$")
        clusterName: string,
      },
      {
        /** The name of the cluster configuration. */
        @path
        @minLength(1)
        @maxLength(90)
        @segment("nodeConfigurations")
        @key
        @pattern("^[-\\w\\._]+$")
        configurationName: string,
      }
    > {}

@armResourceOperations
interface CoordinatorConfigurationOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the cluster. */
        @path
        @minLength(3)
        @maxLength(40)
        @segment("serverGroupsv2")
        @key
        @pattern("^(?![0-9]+$)(?!-)[a-z0-9-]{3,40}(?<!-)$")
        clusterName: string,
      },
      {
        /** The name of the cluster configuration. */
        @path
        @minLength(1)
        @maxLength(90)
        @segment("coordinatorConfigurations")
        @key
        @pattern("^[-\\w\\._]+$")
        configurationName: string,
      }
    > {}

@@doc(ServerConfiguration.name, "The name of the ServerConfiguration");
@@doc(ServerConfiguration.properties, "The properties of a configuration.");
@@maxLength(ServerConfiguration.name, 90);
@@minLength(ServerConfiguration.name, 1);
@@doc(NodeConfigurations.updateOnNode::parameters.resource,
  "The required parameters for updating a cluster configuration."
);
@@doc(CoordinatorConfigurations.updateOnCoordinator::parameters.resource,
  "The required parameters for updating a cluster configuration."
);
