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
 * The diagnostic proactive log collection settings of a device.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@parentResource(DataBoxEdgeDevice)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  ProactiveLogCollectionSettingsProperties
)
model DiagnosticProactiveLogCollectionSettings extends ProxyResourceBase {
  @key("diagnosticProactiveLogCollectionSetting")
  @segment("diagnosticProactiveLogCollectionSettings")
  @visibility("read")
  name: string;

  /**
   * Properties of the diagnostic proactive log collection settings.
   */
  @extension("x-ms-client-flatten", true)
  properties: ProactiveLogCollectionSettingsProperties;
}

@armResourceOperations
@projectedName("client", "DiagnosticProactiveLogCollectionSettings")
interface DiagnosticProactiveLogCollectionSettingsOperationGroup {
  /**
   * Gets the proactive log collection settings of the specified Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DiagnosticSettings_GetDiagnosticProactiveLogCollectionSettings")
  getDiagnosticProactiveLogCollectionSettings is ArmResourceRead<DiagnosticProactiveLogCollectionSettings>;

  /**
   * Updates the proactive log collection settings on a Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DiagnosticSettings_UpdateDiagnosticProactiveLogCollectionSettings")
  updateDiagnosticProactiveLogCollectionSettings is ArmResourceCreateOrReplaceAsync<DiagnosticProactiveLogCollectionSettings>;
}

@@projectedName(DiagnosticProactiveLogCollectionSettingsOperationGroup.updateDiagnosticProactiveLogCollectionSettings::parameters.resource,
  "json",
  "proactiveLogCollectionSettings"
);
@@extension(DiagnosticProactiveLogCollectionSettingsOperationGroup.updateDiagnosticProactiveLogCollectionSettings::parameters.resource,
  "x-ms-client-name",
  "proactiveLogCollectionSettings"
);
@@doc(DiagnosticProactiveLogCollectionSettingsOperationGroup.updateDiagnosticProactiveLogCollectionSettings::parameters.resource,
  "The proactive log collection settings."
);
