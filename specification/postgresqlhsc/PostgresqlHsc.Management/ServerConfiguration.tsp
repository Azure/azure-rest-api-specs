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
interface ServerConfigurationOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Cluster,
          KeyName = "clusterName",
          SegmentName = "serverGroupsv2",
          NamePattern = "^(?![0-9]+$)(?!-)[a-z0-9-]{3,40}(?<!-)$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = ServerConfiguration,
        KeyName = "configurationName",
        SegmentName = "nodeConfigurations",
        NamePattern = "^[-\\w\\._]+$"
      >>
    > {}

@armResourceOperations
interface ServerConfigurations {
  /**
   * Gets information of a configuration for worker nodes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Configurations_GetNode")
  getNode is ServerConfigurationOps.Read<ServerConfiguration>;

  /**
   * Updates configuration of worker nodes in a cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("Configurations_UpdateOnNode")
  updateOnNode is ServerConfigurationOps.CreateOrUpdateSync<
    ServerConfiguration,
    Response = ArmResourceUpdatedResponse<ServerConfiguration>
  >;
}
@armResourceOperations
interface ServerConfigurationOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Cluster,
          KeyName = "clusterName",
          SegmentName = "serverGroupsv2",
          NamePattern = "^(?![0-9]+$)(?!-)[a-z0-9-]{3,40}(?<!-)$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = ServerConfiguration,
        KeyName = "configurationName",
        SegmentName = "coordinatorConfigurations",
        NamePattern = "^[-\\w\\._]+$"
      >>
    > {}

@armResourceOperations
interface ServerConfigurationOperationGroup {
  /**
   * Gets information of a configuration for coordinator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServerConfigurations_GetCoordinator")
  getCoordinator is ServerConfigurationOperationGroupOps.Read<ServerConfiguration>;

  /**
   * Updates configuration of coordinator in a cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServerConfigurations_UpdateOnCoordinator")
  updateOnCoordinator is ServerConfigurationOperationGroupOps.CreateOrUpdateAsync<ServerConfiguration>;
}

@@doc(ServerConfiguration.name, "The name of the ServerConfiguration");
@@doc(ServerConfiguration.properties, "The properties of a configuration.");
@@doc(ServerConfigurations.updateOnNode::parameters.resource,
  "The required parameters for updating a cluster configuration."
);
@@doc(ServerConfigurationOperationGroup.updateOnCoordinator::parameters.resource,
  "The required parameters for updating a cluster configuration."
);
