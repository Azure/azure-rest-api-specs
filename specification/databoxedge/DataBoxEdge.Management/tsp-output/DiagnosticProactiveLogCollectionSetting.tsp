import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataBoxEdge;
@doc("The diagnostic proactive log collection settings of a device.")
@parentResource(DataBoxEdgeDevice)
@singleton("default")
model DiagnosticProactiveLogCollectionSetting
  is ProxyResource<ProactiveLogCollectionSettingsProperties> {
  @key("default")
  @segment("diagnosticProactiveLogCollectionSettings")
  name: string;
}

@armResourceOperations
interface DiagnosticProactiveLogCollectionSettings {
  @doc("Gets the proactive log collection settings of the specified Data Box Edge/Data Box Gateway device.")
  getDiagnosticProactiveLogCollectionSettings is ArmResourceRead<DiagnosticProactiveLogCollectionSetting>;
  @doc("Updates the proactive log collection settings on a Data Box Edge/Data Box Gateway device.")
  updateDiagnosticProactiveLogCollectionSettings is ArmResourceCreateOrUpdateAsync<DiagnosticProactiveLogCollectionSetting>;
}
