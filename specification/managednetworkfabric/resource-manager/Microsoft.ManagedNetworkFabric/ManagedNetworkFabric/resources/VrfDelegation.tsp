import "../models/common.tsp";
import "../models/VrfDelegation.tsp";
import "./Vrf.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Resource extends the ARM TrackedResource base type, which requires inheritance."
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("Defines the VrfDelegation resource. A VrfDelegation is a provider-side allocation of one concrete Vrf under a Fabric delegation authorization.")
@parentResource(Vrf)
@Http.Private.includeInapplicableMetadataInPayload(false)
@added(Versions.v2026_07_15_preview)
model VrfDelegation extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the VrfDelegation.")
  @pattern("^[A-Za-z][A-Za-z0-9-]*$")
  @minLength(1)
  @maxLength(64)
  @path
  @key("delegationName")
  @segment("delegations")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The VrfDelegation properties.")
  properties: VrfDelegationProperties;
}

@armResourceOperations
@added(Versions.v2026_07_15_preview)
interface VrfDelegations {
  @doc("Gets the specified VrfDelegation.")
  get is ArmResourceRead<VrfDelegation>;

  @doc("Creates a VrfDelegation.")
  create is ArmResourceCreateOrReplaceAsync<VrfDelegation>;

  @doc("Updates a VrfDelegation.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<VrfDelegation, VrfDelegationPatch>;

  @doc("Deletes the specified VrfDelegation.")
  delete is ArmResourceDeleteWithoutOkAsync<VrfDelegation>;

  @doc("Lists VrfDelegations by Vrf.")
  listByVrf is ArmResourceListByParent<VrfDelegation>;
}

@@doc(VrfDelegations.create::parameters.resource, "Request payload.");
@@doc(
  VrfDelegations.update::parameters.properties,
  "VrfDelegation properties to update."
);
