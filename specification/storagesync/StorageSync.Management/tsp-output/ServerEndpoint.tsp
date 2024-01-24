import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SyncGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageSync;
/**
 * Server Endpoint object.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(SyncGroup)
@Azure.ResourceManager.Private.armResourceInternal(ServerEndpointProperties)
@includeInapplicableMetadataInPayload(false)
model ServerEndpoint extends ProxyResourceBase {
  /**
   * Name of Server Endpoint object.
   */
  @path
  @key("serverEndpointName")
  @segment("serverEndpoints")
  name: string;

  /**
   * Server Endpoint properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ServerEndpointProperties;
}

@armResourceOperations
interface ServerEndpoints {
  /**
   * Get a ServerEndpoint.
   */
  get is ArmResourceRead<ServerEndpoint>;

  /**
   * Create a new ServerEndpoint.
   */
  create is ArmResourceCreateOrReplaceAsync<ServerEndpoint>;

  /**
   * Patch a given ServerEndpoint.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<ServerEndpoint, ServerEndpointUpdateParameters>;

  /**
   * Delete a given ServerEndpoint.
   */
  delete is ArmResourceDeleteAsync<ServerEndpoint>;

  /**
   * Get a ServerEndpoint list.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServerEndpoints_ListBySyncGroup")
  listBySyncGroup is ArmResourceListByParent<ServerEndpoint>;

  /**
   * Recall a server endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServerEndpoints_recallAction")
  recallAction is ArmResourceActionAsync<
    ServerEndpoint,
    RecallActionParameters,
    void
  >;
}

@@projectedName(ServerEndpoints.create::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServerEndpoints.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServerEndpoints.create::parameters.resource,
  "Body of Server Endpoint object."
);
@@projectedName(ServerEndpoints.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ServerEndpoints.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServerEndpoints.update::parameters.properties,
  "Any of the properties applicable in PUT request."
);
@@projectedName(ServerEndpoints.recallAction::parameters.body,
  "json",
  "parameters"
);
@@extension(ServerEndpoints.recallAction::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServerEndpoints.recallAction::parameters.body,
  "Body of Recall Action object."
);
