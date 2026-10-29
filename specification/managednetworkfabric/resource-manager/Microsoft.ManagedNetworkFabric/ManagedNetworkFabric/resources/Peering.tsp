import "../models/common.tsp";
import "../models/Peering.tsp";
import "./Vrf.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Resource extends the ARM TrackedResource base type, which requires inheritance."
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("Defines the Peering resource. A Peering is an upstream BGP session bound to a Vrf.")
@parentResource(Vrf)
@Azure.ResourceManager.Private.armResourceInternal(PeeringProperties)
@Http.Private.includeInapplicableMetadataInPayload(false)
@added(Versions.v2026_07_15_preview)
model Peering extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the Peering.")
  @pattern("^[A-Za-z][A-Za-z0-9-]*$")
  @minLength(1)
  @maxLength(64)
  @path
  @key("peeringName")
  @segment("peerings")
  @visibility(Lifecycle.Read)
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  @doc("The Peering properties.")
  properties: PeeringProperties;
}

@armResourceOperations
@added(Versions.v2026_07_15_preview)
interface Peerings {
  @doc("Gets the specified Peering.")
  get is ArmResourceRead<Peering>;

  @doc("Creates a Peering.")
  create is ArmResourceCreateOrReplaceAsync<Peering>;

  @doc("Updates a Peering.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Peering, PeeringPatch>;

  @doc("Deletes the specified Peering.")
  delete is ArmResourceDeleteWithoutOkAsync<Peering>;

  @doc("Lists Peerings by Vrf.")
  listByVrf is ArmResourceListByParent<Peering>;
}

@@doc(Peerings.create::parameters.resource, "Request payload.");
@@doc(Peerings.update::parameters.properties, "Peering properties to update.");
