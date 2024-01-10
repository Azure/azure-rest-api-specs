import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DataBoxEdge;
@doc("The remote support settings of a device.")
@singleton("default")
@parentResource(DataBoxEdgeDevice)
model DiagnosticRemoteSupportSettings
  is ProxyResource<DiagnosticRemoteSupportSettingsProperties> {
  @key("diagnosticRemoteSupportSetting")
  @segment("diagnosticRemoteSupportSettings")
  name: string;
}

@armResourceOperations
@projectedName("client", "DiagnosticSettings")
interface DiagnosticRemoteSupportSettings_DiagnosticSettings {
  @doc("Gets the diagnostic remote support settings of the specified Data Box Edge/Data Box Gateway device.")
  getDiagnosticRemoteSupportSettings is ArmResourceRead<DiagnosticRemoteSupportSettings>;

  @doc("Updates the diagnostic remote support settings on a Data Box Edge/Data Box Gateway device.")
  updateDiagnosticRemoteSupportSettings is ArmResourceCreateOrUpdateAsync<DiagnosticRemoteSupportSettings>;
}
