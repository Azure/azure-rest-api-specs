import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
@projectedName("client", "DiagnosticRemoteSupportSettings")
interface DiagnosticRemoteSupportSettingsOperationGroup {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the diagnostic remote support settings of the specified Data Box Edge/Data Box Gateway device.")
  @operationId("DiagnosticSettings_GetDiagnosticRemoteSupportSettings")
  getDiagnosticRemoteSupportSettings is ArmResourceRead<DiagnosticRemoteSupportSettings>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the diagnostic remote support settings on a Data Box Edge/Data Box Gateway device.")
  @operationId("DiagnosticSettings_UpdateDiagnosticRemoteSupportSettings")
  updateDiagnosticRemoteSupportSettings is ArmResourceCreateOrUpdateAsync<DiagnosticRemoteSupportSettings>;
}

@@projectedName(DiagnosticRemoteSupportSettingsOperationGroup.updateDiagnosticRemoteSupportSettings::parameters.resource,
  "json",
  "diagnosticRemoteSupportSettings"
);
@@extension(DiagnosticRemoteSupportSettingsOperationGroup.updateDiagnosticRemoteSupportSettings::parameters.resource,
  "x-ms-client-name",
  "diagnosticRemoteSupportSettings"
);
@@doc(DiagnosticRemoteSupportSettingsOperationGroup.updateDiagnosticRemoteSupportSettings::parameters.resource,
  "The diagnostic remote support settings."
);
