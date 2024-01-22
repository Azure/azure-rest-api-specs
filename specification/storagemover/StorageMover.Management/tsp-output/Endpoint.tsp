import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageMover.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageMover;
/**
 * The Endpoint resource, which contains information about file sources and targets.
 */
@parentResource(StorageMover)
model Endpoint is ProxyResource<EndpointBaseProperties> {
  /**
   * The name of the Endpoint resource.
   */
  @path
  @key("endpointName")
  @segment("endpoints")
  name: string;
}

@armResourceOperations
interface Endpoints {
  /**
   * Gets an Endpoint resource.
   */
  get is ArmResourceRead<Endpoint>;

  /**
   * Creates or updates an Endpoint resource, which represents a data transfer source or destination.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Endpoint>;

  /**
   * Updates properties for an Endpoint resource. Properties not specified in the request body will be unchanged.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Endpoint, EndpointBaseUpdateParameters>;

  /**
   * Deletes an Endpoint resource.
   */
  delete is ArmResourceDeleteAsync<
    Endpoint,
    BaseParameters<Endpoint>,
    ArmLroLocationHeader
  >;

  /**
   * Lists all Endpoints in a Storage Mover.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Endpoints_List")
  list is ArmResourceListByParent<Endpoint>;
}

@@projectedName(Endpoints.createOrUpdate::parameters.resource,
  "json",
  "endpoint"
);
@@extension(Endpoints.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "endpoint"
);
@@doc(Endpoints.createOrUpdate::parameters.resource, "");
@@projectedName(Endpoints.update::parameters.properties, "json", "endpoint");
@@extension(Endpoints.update::parameters.properties,
  "x-ms-client-name",
  "endpoint"
);
@@doc(Endpoints.update::parameters.properties, "");
