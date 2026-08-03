import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A server configuration option
 */
@parentResource(ManagedInstance)
model ServerConfigurationOption
  is ProxyResource<ServerConfigurationOptionProperties> {
  /**
   * The name of the server configuration option.
   */
  @path
  @key("serverConfigurationOptionName")
  @segment("serverConfigurationOptions")
  name: ServerConfigurationOptionName;
}

@armResourceOperations
interface ServerConfigurationOptions {
  /**
   * Gets managed instance server configuration option.
   */
  get is ArmResourceRead<ServerConfigurationOption>;

  /**
   * Updates managed instance server configuration option.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ServerConfigurationOption>;

  /**
   * Gets a list of managed instance server configuration options.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServerConfigurationOptions_ListByManagedInstance")
  listByManagedInstance is ArmResourceListByParent<ServerConfigurationOption>;
}

@@projectedName(ServerConfigurationOptions.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServerConfigurationOptions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServerConfigurationOptions.createOrUpdate::parameters.resource,
  "Server configuration option parameters."
);
