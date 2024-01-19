import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
@doc("Config Server resource")
@singleton("default")
@parentResource(ServiceResource)
model ConfigServerResource is ProxyResource<ConfigServerProperties> {
  @key("configServer")
  @segment("configServers")
  name: string;
}

@armResourceOperations
interface ConfigServerResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the config server and its properties.")
  @operationId("ConfigServers_Get")
  get is ArmResourceRead<ConfigServerResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update the config server.")
  @operationId("ConfigServers_UpdatePut")
  updatePut is ArmResourceCreateOrUpdateAsync<ConfigServerResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update the config server.")
  @operationId("ConfigServers_UpdatePatch")
  updatePatch is ArmCustomPatchAsync<
    ConfigServerResource,
    ConfigServerResource
  >;
}

@@projectedName(ConfigServerResources.updatePut::parameters.resource,
  "json",
  "configServerResource"
);
@@extension(ConfigServerResources.updatePut::parameters.resource,
  "x-ms-client-name",
  "configServerResource"
);
@@doc(ConfigServerResources.updatePut::parameters.resource,
  "Parameters for the update operation"
);
@@projectedName(ConfigServerResources.updatePatch::parameters.properties,
  "json",
  "configServerResource"
);
@@extension(ConfigServerResources.updatePatch::parameters.properties,
  "x-ms-client-name",
  "configServerResource"
);
@@doc(ConfigServerResources.updatePatch::parameters.properties,
  "Parameters for the update operation"
);
