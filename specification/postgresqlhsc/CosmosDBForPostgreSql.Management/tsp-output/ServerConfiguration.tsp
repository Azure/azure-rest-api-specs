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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Cluster)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  ServerConfigurationProperties
)
model ServerConfiguration extends ProxyResourceBase {
  /**
   * The name of the cluster configuration.
   */
  @maxLength(90)
  @minLength(1)
  @pattern("^[-\\w\\._]+$")
  @path
  @key("configurationName")
  @segment("coordinatorConfigurations")
  @visibility("read")
  name: string;

  /**
   * The properties of a configuration.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ServerConfigurationProperties;
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
