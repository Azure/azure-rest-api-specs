import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("Represents a physical network deployment hosting infrastructure network configuration.")
@Http.Private.includeInapplicableMetadataInPayload(false)
@added(Versions.v2026_01_15_preview)
model Fabric extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the Fabric.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  @path
  @key("fabricName")
  @segment("fabrics")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Fabric properties.")
  properties: FabricProperties;
}

@armResourceOperations
@added(Versions.v2026_01_15_preview)
interface Fabrics {
  @doc("Gets the specified Fabric.")
  get is ArmResourceRead<Fabric>;

  @doc("Creates a Fabric.")
  create is ArmResourceCreateOrReplaceAsync<Fabric>;

  @doc("Updates a Fabric.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Fabric, FabricPatch>;

  @doc("Deletes the specified Fabric.")
  delete is ArmResourceDeleteWithoutOkAsync<Fabric>;

  @doc("Lists Fabrics by resource group.")
  listByResourceGroup is ArmResourceListByParent<Fabric>;

  @doc("Lists Fabrics by subscription.")
  listBySubscription is ArmListBySubscription<Fabric>;
}

@@doc(Fabrics.create::parameters.resource, "Request payload.");
@@doc(Fabrics.update::parameters.properties, "Fabric properties to update.");
