import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
/**
 * The remote support settings of a device.
 */
@singleton("default")
@parentResource(DataBoxEdgeDevice)
model DiagnosticRemoteSupportSettings
  is Azure.ResourceManager.ProxyResource<
    DiagnosticRemoteSupportSettingsProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = DiagnosticRemoteSupportSettings,
    KeyName = "diagnosticRemoteSupportSetting",
    SegmentName = "diagnosticRemoteSupportSettings",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface DiagnosticRemoteSupportSettingsOperationGroup {
  /**
   * Gets the diagnostic remote support settings of the specified Data Box Edge/Data Box Gateway device.
   */
  getDiagnosticRemoteSupportSettings is ArmResourceRead<
    DiagnosticRemoteSupportSettings,
    Error = CloudError
  >;

  /**
   * Updates the diagnostic remote support settings on a Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  updateDiagnosticRemoteSupportSettings is ArmResourceCreateOrReplaceAsync<
    DiagnosticRemoteSupportSettings,
    Response = ArmResourceUpdatedResponse<DiagnosticRemoteSupportSettings> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = DiagnosticRemoteSupportSettings> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = CloudError
  >;
}

@@doc(DiagnosticRemoteSupportSettings.name, "");
@@doc(DiagnosticRemoteSupportSettings.properties,
  "Properties of the remote support  settings."
);
@@doc(DiagnosticRemoteSupportSettingsOperationGroup.updateDiagnosticRemoteSupportSettings::parameters.resource,
  "The diagnostic remote support settings."
);
