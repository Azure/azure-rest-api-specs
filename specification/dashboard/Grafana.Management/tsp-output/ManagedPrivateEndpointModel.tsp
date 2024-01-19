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
@doc("The managed private endpoint resource type.")
@parentResource(ManagedGrafana)
model ManagedPrivateEndpointModel
  is TrackedResource<ManagedPrivateEndpointModelProperties> {
  @doc("The managed private endpoint name of Azure Managed Grafana.")
  @path
  @key("managedPrivateEndpointName")
  @segment("managedPrivateEndpoints")
  name: string;
}

@armResourceOperations
interface ManagedPrivateEndpointModels {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a specific managed private endpoint of a grafana resource.")
  @operationId("ManagedPrivateEndpoints_Get")
  get is ArmResourceRead<ManagedPrivateEndpointModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a managed private endpoint for a grafana resource.")
  @operationId("ManagedPrivateEndpoints_Create")
  create is ArmResourceCreateOrUpdateAsync<ManagedPrivateEndpointModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update a managed private endpoint for an existing grafana resource.")
  @operationId("ManagedPrivateEndpoints_Update")
  update is ArmCustomPatchAsync<
    ManagedPrivateEndpointModel,
    ManagedPrivateEndpointUpdateParameters,
    BaseParameters<ManagedPrivateEndpointModel>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a managed private endpoint for a grafana resource.")
  @operationId("ManagedPrivateEndpoints_Delete")
  delete is ArmResourceDeleteAsync<
    ManagedPrivateEndpointModel,
    BaseParameters<ManagedPrivateEndpointModel>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all managed private endpoints of a grafana resource.")
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
