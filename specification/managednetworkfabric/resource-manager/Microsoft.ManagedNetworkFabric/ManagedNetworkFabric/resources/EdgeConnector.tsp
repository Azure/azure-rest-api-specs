import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;

@doc("EdgeConnector represents the mechanism by which a collection of on-prem infrastructure (Fabric) is connected to Azure.")
@added(Versions.v2026_01_15_preview)
model EdgeConnector is Azure.ResourceManager.TrackedResource<
  EdgeConnectorProperties,
  false
> {
  @doc("Name of the EdgeConnector.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("edgeConnectorName")
  @segment("edgeConnectors")
  @visibility(Lifecycle.Read)
  name: string;
}

@@doc(EdgeConnector.properties, "EdgeConnector properties.");

@armResourceOperations
@added(Versions.v2026_01_15_preview)
interface EdgeConnectors {
  @doc("Gets the specified EdgeConnector.")
  get is ArmResourceRead<EdgeConnector>;

  @doc("Creates or updates an EdgeConnector.")
  create is ArmResourceCreateOrReplaceAsync<EdgeConnector>;

  @doc("Updates an EdgeConnector.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<EdgeConnector, EdgeConnectorPatch>;

  @doc("Deletes the specified EdgeConnector.")
  delete is ArmResourceDeleteWithoutOkAsync<EdgeConnector>;

  @doc("Lists EdgeConnectors by resource group.")
  listByResourceGroup is ArmResourceListByParent<EdgeConnector>;

  @doc("Lists EdgeConnectors by subscription.")
  listBySubscription is ArmListBySubscription<EdgeConnector>;
}

@@doc(EdgeConnectors.create::parameters.resource, "Request payload.");
@@doc(
  EdgeConnectors.update::parameters.properties,
  "EdgeConnector properties to update."
);
