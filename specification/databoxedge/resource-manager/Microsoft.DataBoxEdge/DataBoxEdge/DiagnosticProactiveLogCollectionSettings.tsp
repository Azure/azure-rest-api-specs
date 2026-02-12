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
 * The diagnostic proactive log collection settings of a device.
 */
@singleton("default")
@parentResource(DataBoxEdgeDevice)
model DiagnosticProactiveLogCollectionSettings
  is Azure.ResourceManager.ProxyResource<
    ProactiveLogCollectionSettingsProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = DiagnosticProactiveLogCollectionSettings,
    KeyName = "diagnosticProactiveLogCollectionSetting",
    SegmentName = "diagnosticProactiveLogCollectionSettings",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface DiagnosticSettings {
  /**
   * Gets the proactive log collection settings of the specified Data Box Edge/Data Box Gateway device.
   */
  getDiagnosticProactiveLogCollectionSettings is ArmResourceRead<
    DiagnosticProactiveLogCollectionSettings,
    Error = CloudError
  >;

  /**
   * Updates the proactive log collection settings on a Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  updateDiagnosticProactiveLogCollectionSettings is ArmResourceCreateOrReplaceAsync<
    DiagnosticProactiveLogCollectionSettings,
    Response = ArmResourceUpdatedResponse<DiagnosticProactiveLogCollectionSettings> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = DiagnosticProactiveLogCollectionSettings> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = CloudError
  >;
}

@@doc(DiagnosticProactiveLogCollectionSettings.name, "");
@@doc(DiagnosticProactiveLogCollectionSettings.properties,
  "Properties of the diagnostic proactive log collection settings."
);
@@doc(DiagnosticSettings.updateDiagnosticProactiveLogCollectionSettings::parameters.resource,
  "The proactive log collection settings."
);
