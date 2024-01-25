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
/**
 * Config Server resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@parentResource(ServiceResource)
@includeInapplicableMetadataInPayload(false)
model ConfigServerResource extends ProxyResource {
  @key("configServer")
  @segment("configServers")
  @visibility("read")
  name: string;

  /**
   * Properties of the Config Server resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: ConfigServerProperties;
}

@armResourceOperations
interface ConfigServerResources {
  /**
   * Get the config server and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConfigServers_Get")
  get is ArmResourceRead<ConfigServerResource>;

  /**
   * Update the config server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConfigServers_UpdatePut")
  updatePut is ArmResourceCreateOrReplaceAsync<ConfigServerResource>;

  /**
   * Update the config server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
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
