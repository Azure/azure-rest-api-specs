import "../models/common.tsp";
import "../models/Network.tsp";
import "./Vrf.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Resource extends the ARM TrackedResource base type, which requires inheritance."
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("Defines the Network resource. A Network is a routed L2 and L3 segment under a Vrf, bound to a sibling Vlan.")
@parentResource(Vrf)
@Azure.ResourceManager.Private.armResourceInternal(NetworkProperties)
@Http.Private.includeInapplicableMetadataInPayload(false)
@added(Versions.v2026_07_15_preview)
model Network extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the Network.")
  @pattern("^[A-Za-z][A-Za-z0-9-]*$")
  @minLength(1)
  @maxLength(64)
  @path
  @key("networkName")
  @segment("networks")
  @visibility(Lifecycle.Read)
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  @doc("The Network properties.")
  properties: NetworkProperties;
}

@armResourceOperations
@added(Versions.v2026_07_15_preview)
interface Networks {
  @doc("Gets the specified Network.")
  get is ArmResourceRead<Network>;

  @doc("Creates a Network.")
  create is ArmResourceCreateOrReplaceAsync<Network>;

  @doc("Updates a Network.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Network, NetworkPatch>;

  @doc("Deletes the specified Network.")
  delete is ArmResourceDeleteWithoutOkAsync<Network>;

  @doc("Lists Networks by Vrf.")
  listByVrf is ArmResourceListByParent<Network>;
}

@@doc(Networks.create::parameters.resource, "Request payload.");
@@doc(Networks.update::parameters.properties, "Network properties to update.");
