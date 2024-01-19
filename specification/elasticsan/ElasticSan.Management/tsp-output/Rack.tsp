import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetworkCloud;
@doc("Rack represents the hardware of the rack and is dependent upon the cluster for lifecycle.")
model Rack is TrackedResource<RackProperties> {
  @doc("The name of the rack.")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @path
  @key("rackName")
  @segment("racks")
  name: string;

  @doc("The extended location of the cluster associated with the resource.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface Racks {
  @doc("Get properties of the provided rack.")
  get is ArmResourceRead<Rack>;

  @doc("Patch properties of the provided rack, or update the tags associated with the rack. Properties and tag updates can be done independently.")
  update is ArmCustomPatchAsync<
    Rack,
    RackPatchParameters,
    BaseParameters<Rack>,
    ArmAsyncOperationHeader
  >;

  @doc("Get a list of racks in the provided resource group.")
  listByResourceGroup is ArmResourceListByParent<Rack>;

  @doc("Get a list of racks in the provided subscription.")
  listBySubscription is ArmListBySubscription<Rack>;
}

@@projectedName(Racks.update::parameters.properties,
  "json",
  "rackUpdateParameters"
);
@@extension(Racks.update::parameters.properties,
  "x-ms-client-name",
  "rackUpdateParameters"
);
@@doc(Racks.update::parameters.properties, "The request body.");
