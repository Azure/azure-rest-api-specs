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
@doc("L3Network represents a network that utilizes a single isolation domain set up for layer-3 resources.")
model L3Network is TrackedResource<L3NetworkProperties> {
  @doc("The name of the L3 network.")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @path
  @key("l3NetworkName")
  @segment("l3Networks")
  name: string;

  @doc("The extended location of the cluster associated with the resource.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface L3Networks {
  @doc("Get properties of the provided layer 3 (L3) network.")
  get is ArmResourceRead<L3Network>;

  @doc("Create a new layer 3 (L3) network or update the properties of the existing network.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    L3Network,
    BaseParameters<L3Network>,
    ArmAsyncOperationHeader
  >;

  @doc("Update tags associated with the provided layer 3 (L3) network.")
  update is ArmCustomPatchSync<L3Network, L3NetworkPatchParameters>;

  @doc("Delete the provided layer 3 (L3) network.")
  delete is ArmResourceDeleteAsync<
    L3Network,
    BaseParameters<L3Network>,
    ArmLroLocationHeader
  >;

  @doc("Get a list of layer 3 (L3) networks in the provided resource group.")
  listByResourceGroup is ArmResourceListByParent<L3Network>;

  @doc("Get a list of layer 3 (L3) networks in the provided subscription.")
  listBySubscription is ArmListBySubscription<L3Network>;
}

@@projectedName(L3Networks.createOrUpdate::parameters.resource,
  "json",
  "l3NetworkParameters"
);
@@extension(L3Networks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "l3NetworkParameters"
);
@@doc(L3Networks.createOrUpdate::parameters.resource, "The request body.");
@@projectedName(L3Networks.update::parameters.properties,
  "json",
  "l3NetworkUpdateParameters"
);
@@extension(L3Networks.update::parameters.properties,
  "x-ms-client-name",
  "l3NetworkUpdateParameters"
);
@@doc(L3Networks.update::parameters.properties, "The request body.");
