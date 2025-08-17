import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./disconnectedOperations.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.Edge;

@doc("Hardware settings resource.")
@parentResource(DisconnectedOperation)
@added(Microsoft.Edge.Versions.v2025_08_01)
model HardwareSettings is ProxyResource<HardwareSettingsProperties> {
  ...ResourceNameParameter<HardwareSettings>;
}

@armResourceOperations
@added(Microsoft.Edge.Versions.v2025_08_01)
interface HardwareSettingsOperations {
  @doc("List by parent")
  listByParent is ArmResourceListByParent<HardwareSettings>;

  @doc("Get the hardware settings resource")
  get is ArmResourceRead<HardwareSettings>;

  @doc("Create or update hardware settings")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<HardwareSettings>;

  @doc("Delete hardware settings")
  delete is ArmResourceDeleteWithoutOkAsync<HardwareSettings>;
}
