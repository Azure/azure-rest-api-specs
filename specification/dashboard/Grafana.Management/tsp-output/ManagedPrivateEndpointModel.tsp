import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedGrafana.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Dashboard;
/**
 * The managed private endpoint resource type.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ManagedGrafana)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  ManagedPrivateEndpointModelProperties
)
model ManagedPrivateEndpointModel extends TrackedResourceBase {
  /**
   * The managed private endpoint name of Azure Managed Grafana.
   */
  @path
  @key("managedPrivateEndpointName")
  @segment("managedPrivateEndpoints")
  @visibility("read")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ManagedPrivateEndpointModelProperties;
}

@armResourceOperations
interface ManagedPrivateEndpointModels {
  /**
   * Get a specific managed private endpoint of a grafana resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedPrivateEndpoints_Get")
  get is ArmResourceRead<ManagedPrivateEndpointModel>;

  /**
   * Create or update a managed private endpoint for a grafana resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedPrivateEndpoints_Create")
  create is ArmResourceCreateOrReplaceAsync<ManagedPrivateEndpointModel>;

  /**
   * Update a managed private endpoint for an existing grafana resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("ManagedPrivateEndpoints_Update")
  update is ArmCustomPatchAsync<
    ManagedPrivateEndpointModel,
    ManagedPrivateEndpointUpdateParameters,
    BaseParameters<ManagedPrivateEndpointModel>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete a managed private endpoint for a grafana resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedPrivateEndpoints_Delete")
  delete is ArmResourceDeleteAsync<
    ManagedPrivateEndpointModel,
    BaseParameters<ManagedPrivateEndpointModel>,
    ArmAsyncOperationHeader
  >;

  /**
   * List all managed private endpoints of a grafana resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedPrivateEndpoints_List")
  list is ArmResourceListByParent<ManagedPrivateEndpointModel>;
}

@@projectedName(ManagedPrivateEndpointModels.create::parameters.resource,
  "json",
  "requestBodyParameters"
);
@@extension(ManagedPrivateEndpointModels.create::parameters.resource,
  "x-ms-client-name",
  "requestBodyParameters"
);
@@doc(ManagedPrivateEndpointModels.create::parameters.resource,
  "The managed private endpoint to be created or updated."
);
@@projectedName(ManagedPrivateEndpointModels.update::parameters.properties,
  "json",
  "requestBodyParameters"
);
@@extension(ManagedPrivateEndpointModels.update::parameters.properties,
  "x-ms-client-name",
  "requestBodyParameters"
);
@@doc(ManagedPrivateEndpointModels.update::parameters.properties,
  "Properties that can be updated to an existing managed private endpoint."
);
