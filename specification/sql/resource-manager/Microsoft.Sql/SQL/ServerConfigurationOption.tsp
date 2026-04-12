import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A server configuration option
 */
@parentResource(ManagedInstance)
model ServerConfigurationOption
  is Azure.ResourceManager.ProxyResource<ServerConfigurationOptionProperties> {
  ...ResourceNameParameter<
    Resource = ServerConfigurationOption,
    KeyName = "serverConfigurationOptionName",
    SegmentName = "serverConfigurationOptions",
    NamePattern = "",
    Type = ServerConfigurationOptionName
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface ServerConfigurationOptions {
  /**
   * Gets managed instance server configuration option.
   */
  get is ArmResourceRead<ServerConfigurationOption>;

  /**
   * Updates managed instance server configuration option.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServerConfigurationOption,
    Response = ArmResourceUpdatedResponse<ServerConfigurationOption> &
      ArmLroLocationHeader<FinalResult = ServerConfigurationOption>
  >;

  /**
   * Gets a list of managed instance server configuration options.
   */
  listByManagedInstance is ArmResourceListByParent<ServerConfigurationOption>;
}

@@doc(ServerConfigurationOption.name,
  "The name of the server configuration option."
);
@@doc(ServerConfigurationOption.properties, "Resource properties.");
@@doc(ServerConfigurationOptions.createOrUpdate::parameters.resource,
  "Server configuration option parameters."
);
