import "../models/common.tsp";
import "../models/Vlan.tsp";
import "./Fabric.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Resource extends the ARM TrackedResource base type, which requires inheritance."
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("Defines the Vlan resource. Vlans declare an L2 segment within a Fabric.")
@parentResource(Fabric)
@Azure.ResourceManager.Private.armResourceInternal(VlanProperties)
@Http.Private.includeInapplicableMetadataInPayload(false)
@added(Versions.v2026_07_15_preview)
model Vlan extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the Vlan.")
  @pattern("^[A-Za-z][A-Za-z0-9-]*$")
  @minLength(1)
  @maxLength(64)
  @path
  @key("vlanName")
  @segment("vlans")
  @visibility(Lifecycle.Read)
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  @doc("The Vlan properties.")
  properties: VlanProperties;
}

@armResourceOperations
@added(Versions.v2026_07_15_preview)
interface Vlans {
  @doc("Gets the specified Vlan.")
  get is ArmResourceRead<Vlan>;

  @doc("Creates a Vlan.")
  create is ArmResourceCreateOrReplaceAsync<Vlan>;

  @doc("Updates a Vlan.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Vlan, VlanPatch>;

  @doc("Deletes the specified Vlan.")
  delete is ArmResourceDeleteWithoutOkAsync<Vlan>;

  @doc("Lists Vlans by Fabric.")
  listByFabric is ArmResourceListByParent<Vlan>;
}

@@doc(Vlans.create::parameters.resource, "Request payload.");
@@doc(Vlans.update::parameters.properties, "Vlan properties to update.");
