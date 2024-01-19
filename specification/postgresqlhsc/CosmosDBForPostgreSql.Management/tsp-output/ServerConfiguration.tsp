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
@doc("Represents a configuration.")
@parentResource(Cluster)
model ServerConfiguration is ProxyResource<ServerConfigurationProperties> {
  @doc("The name of the cluster configuration.")
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets information of a configuration for coordinator.")
  @operationId("Configurations_GetCoordinator")
  getCoordinator is ArmResourceRead<ServerConfiguration>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates configuration of coordinator in a cluster")
  @operationId("Configurations_UpdateOnCoordinator")
  updateOnCoordinator is ArmResourceCreateOrUpdateAsync<
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
