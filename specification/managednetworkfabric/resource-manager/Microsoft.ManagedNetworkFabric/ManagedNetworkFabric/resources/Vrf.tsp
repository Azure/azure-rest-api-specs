import "../models/common.tsp";
import "../models/Vrf.tsp";
import "./Fabric.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Resource extends the ARM TrackedResource base type, which requires inheritance."
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("Defines the Vrf resource. A Vrf is an isolated L3 routing domain rooted in a Fabric.")
@parentResource(Fabric)
@Azure.ResourceManager.Private.armResourceInternal(VrfProperties)
@Http.Private.includeInapplicableMetadataInPayload(false)
@added(Versions.v2026_07_15_preview)
model Vrf extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the Vrf.")
  @pattern("^[A-Za-z][A-Za-z0-9-]*$")
  @minLength(1)
  @maxLength(64)
  @path
  @key("vrfName")
  @segment("vrfs")
  @visibility(Lifecycle.Read)
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  @doc("The Vrf properties.")
  properties: VrfProperties;
}

@armResourceOperations
@added(Versions.v2026_07_15_preview)
interface Vrfs {
  @doc("Gets the specified Vrf.")
  get is ArmResourceRead<Vrf>;

  @doc("Creates a Vrf.")
  create is ArmResourceCreateOrReplaceAsync<Vrf>;

  @doc("Updates a Vrf.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Vrf, VrfPatch>;

  @doc("Deletes the specified Vrf.")
  delete is ArmResourceDeleteWithoutOkAsync<Vrf>;

  @doc("Lists Vrfs by Fabric.")
  listByFabric is ArmResourceListByParent<Vrf>;
}

@@doc(Vrfs.create::parameters.resource, "Request payload.");
@@doc(Vrfs.update::parameters.properties, "Vrf properties to update.");
