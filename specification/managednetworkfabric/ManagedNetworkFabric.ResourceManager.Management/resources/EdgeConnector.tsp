import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("EdgeConnector represents the mechanism by which a collection of on-prem infrastructure (Fabric) is connected to Azure.")
@Http.Private.includeInapplicableMetadataInPayload(false)
@added(Versions.v2026_01_15_preview)
model EdgeConnector extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the EdgeConnector.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  @path
  @key("edgeConnectorName")
  @segment("edgeConnectors")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("EdgeConnector properties.")
  properties: EdgeConnectorProperties;
}

@armResourceOperations
@added(Versions.v2026_01_15_preview)
interface EdgeConnectors {
  @doc("Gets the specified EdgeConnector.")
  get is ArmResourceRead<EdgeConnector>;

  @doc("Creates an EdgeConnector.")
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
@@doc(EdgeConnectors.update::parameters.properties,
  "EdgeConnector properties to update."
);
