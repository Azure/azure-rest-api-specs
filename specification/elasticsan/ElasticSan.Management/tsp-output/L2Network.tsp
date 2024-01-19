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
@doc("L2Network represents a network that utilizes a single isolation domain set up for layer-2 resources.")
model L2Network is TrackedResource<L2NetworkProperties> {
  @doc("The name of the L2 network.")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @path
  @key("l2NetworkName")
  @segment("l2Networks")
  name: string;

  @doc("The extended location of the cluster associated with the resource.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface L2Networks {
  @doc("Get properties of the provided layer 2 (L2) network.")
  get is ArmResourceRead<L2Network>;

  @doc("Create a new layer 2 (L2) network or update the properties of the existing network.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    L2Network,
    BaseParameters<L2Network>,
    ArmAsyncOperationHeader
  >;

  @doc("Update tags associated with the provided layer 2 (L2) network.")
  update is ArmCustomPatchSync<L2Network, L2NetworkPatchParameters>;

  @doc("Delete the provided layer 2 (L2) network.")
  delete is ArmResourceDeleteAsync<
    L2Network,
    BaseParameters<L2Network>,
    ArmLroLocationHeader
  >;

  @doc("Get a list of layer 2 (L2) networks in the provided resource group.")
  listByResourceGroup is ArmResourceListByParent<L2Network>;

  @doc("Get a list of layer 2 (L2) networks in the provided subscription.")
  listBySubscription is ArmListBySubscription<L2Network>;
}

@@projectedName(L2Networks.createOrUpdate::parameters.resource,
  "json",
  "l2NetworkParameters"
);
@@extension(L2Networks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "l2NetworkParameters"
);
@@doc(L2Networks.createOrUpdate::parameters.resource, "The request body.");
@@projectedName(L2Networks.update::parameters.properties,
  "json",
  "l2NetworkUpdateParameters"
);
@@extension(L2Networks.update::parameters.properties,
  "x-ms-client-name",
  "l2NetworkUpdateParameters"
);
@@doc(L2Networks.update::parameters.properties, "The request body.");
