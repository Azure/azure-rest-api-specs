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
/**
 * The remote support settings of a device.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@parentResource(DataBoxEdgeDevice)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  DiagnosticRemoteSupportSettingsProperties
)
model DiagnosticRemoteSupportSettings extends ProxyResourceBase {
  @key("diagnosticRemoteSupportSetting")
  @segment("diagnosticRemoteSupportSettings")
  @visibility("read")
  name: string;

  /**
   * Properties of the remote support  settings.
   */
  @extension("x-ms-client-flatten", true)
  properties: DiagnosticRemoteSupportSettingsProperties;
}

@armResourceOperations
@projectedName("client", "DiagnosticRemoteSupportSettings")
interface DiagnosticRemoteSupportSettingsOperationGroup {
  /**
   * Gets the diagnostic remote support settings of the specified Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DiagnosticSettings_GetDiagnosticRemoteSupportSettings")
  getDiagnosticRemoteSupportSettings is ArmResourceRead<DiagnosticRemoteSupportSettings>;

  /**
   * Updates the diagnostic remote support settings on a Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DiagnosticSettings_UpdateDiagnosticRemoteSupportSettings")
  updateDiagnosticRemoteSupportSettings is ArmResourceCreateOrReplaceAsync<DiagnosticRemoteSupportSettings>;
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
