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
 * Represents a configuration.
 */
@parentResource(Cluster)
model ServerConfiguration is ProxyResource<ServerConfigurationProperties> {
  /**
   * The name of the cluster configuration.
   */
  @maxLength(90)
  @minLength(1)
  @pattern("^[-\\w\\._]+$")
  @path
  @key("configurationName")
  @segment("coordinatorConfigurations")
  name: string;
}

@armResourceOperations
interface ServerConfigurations {
  /**
   * Gets information of a configuration for coordinator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Configurations_GetCoordinator")
  getCoordinator is ArmResourceRead<ServerConfiguration>;

  /**
   * Updates configuration of coordinator in a cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Configurations_UpdateOnCoordinator")
  updateOnCoordinator is ArmResourceCreateOrReplaceAsync<
    ServerConfiguration,
    BaseParameters<ServerConfiguration>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(ServerConfigurations.updateOnCoordinator::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServerConfigurations.updateOnCoordinator::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServerConfigurations.updateOnCoordinator::parameters.resource,
  "The required parameters for updating a cluster configuration."
);
