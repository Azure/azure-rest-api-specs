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
@doc("The Endpoint resource, which contains information about file sources and targets.")
@parentResource(StorageMover)
model Endpoint is ProxyResource<EndpointBaseProperties> {
  @doc("The name of the Endpoint resource.")
  @path
  @key("endpointName")
  @segment("endpoints")
  name: string;
}

@armResourceOperations
interface Endpoints {
  @doc("Gets an Endpoint resource.")
  get is ArmResourceRead<Endpoint>;

  @doc("Creates or updates an Endpoint resource, which represents a data transfer source or destination.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Endpoint>;

  @doc("Updates properties for an Endpoint resource. Properties not specified in the request body will be unchanged.")
  update is ArmCustomPatchSync<Endpoint, EndpointBaseUpdateParameters>;

  @doc("Deletes an Endpoint resource.")
  delete is ArmResourceDeleteAsync<
    Endpoint,
    BaseParameters<Endpoint>,
    ArmLroLocationHeader
  >;

  @doc("Lists all Endpoints in a Storage Mover.")
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
