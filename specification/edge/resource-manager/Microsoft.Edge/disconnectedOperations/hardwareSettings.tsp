import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./disconnectedOperations.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Edge;

@doc("Hardware settings resource.")
@parentResource(DisconnectedOperation)
@added(Microsoft.Edge.Versions.v2026_03_15)
model HardwareSetting is ProxyResource<HardwareSettingProperties> {
  ...ResourceNameParameter<HardwareSetting>;
}

@armResourceOperations
@added(Microsoft.Edge.Versions.v2026_03_15)
interface HardwareSettings {
  @doc("List by parent")
  listByParent is ArmResourceListByParent<HardwareSetting>;

  @doc("Get the hardware settings resource")
  get is ArmResourceRead<HardwareSetting>;

  @doc("Create or update hardware settings")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<HardwareSetting>;

  @doc("Delete hardware settings")
  delete is ArmResourceDeleteWithoutOkAsync<HardwareSetting>;
}
