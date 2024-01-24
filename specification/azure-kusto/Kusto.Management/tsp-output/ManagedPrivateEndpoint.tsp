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

namespace Microsoft.Kusto;
/**
 * Class representing a managed private endpoint.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Cluster)
@Azure.ResourceManager.Private.armResourceInternal(
  ManagedPrivateEndpointProperties
)
@includeInapplicableMetadataInPayload(false)
model ManagedPrivateEndpoint extends ProxyResourceBase {
  /**
   * The name of the managed private endpoint.
   */
  @pattern("^.*$")
  @path
  @key("managedPrivateEndpointName")
  @segment("managedPrivateEndpoints")
  name: string;

  /**
   * A managed private endpoint.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ManagedPrivateEndpointProperties;
}

@armResourceOperations
interface ManagedPrivateEndpoints {
  /**
   * Gets a managed private endpoint.
   */
  get is ArmResourceRead<ManagedPrivateEndpoint>;

  /**
   * Creates a managed private endpoint.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedPrivateEndpoint>;

  /**
   * Updates a managed private endpoint.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<ManagedPrivateEndpoint, ManagedPrivateEndpoint>;

  /**
   * Deletes a managed private endpoint.
   */
  delete is ArmResourceDeleteAsync<ManagedPrivateEndpoint>;

  /**
   * Returns the list of managed private endpoints.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedPrivateEndpoints_List")
  list is ArmResourceListByParent<ManagedPrivateEndpoint>;
}

@@projectedName(ManagedPrivateEndpoints.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ManagedPrivateEndpoints.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedPrivateEndpoints.createOrUpdate::parameters.resource,
  "The managed private endpoint parameters."
);
@@projectedName(ManagedPrivateEndpoints.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ManagedPrivateEndpoints.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedPrivateEndpoints.update::parameters.properties,
  "The managed private endpoint parameters."
);
