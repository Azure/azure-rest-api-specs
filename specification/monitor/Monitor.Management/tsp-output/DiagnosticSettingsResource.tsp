import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
/**
 * The diagnostic setting resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(DiagnosticSettings)
model DiagnosticSettingsResource extends ExtensionResourceBase {
  /**
   * The name of the diagnostic setting.
   */
  @path
  @key("name")
  @segment("diagnosticSettings")
  @visibility("read")
  name: string;

  /**
   * Properties of a Diagnostic Settings Resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: DiagnosticSettings;
}

@armResourceOperations
interface DiagnosticSettingsResources {
  /**
   * Gets the active diagnostic settings for the specified resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DiagnosticSettings_Get")
  get is ArmResourceRead<DiagnosticSettingsResource>;

  /**
   * Creates or updates diagnostic settings for the specified resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DiagnosticSettings_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DiagnosticSettingsResource>;

  /**
   * Deletes existing diagnostic settings for the specified resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DiagnosticSettings_Delete")
  delete is ArmResourceDeleteSync<DiagnosticSettingsResource>;

  /**
   * Gets the active diagnostic settings list for the specified resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DiagnosticSettings_List")
  list is ArmResourceListByParent<DiagnosticSettingsResource>;
}

@@projectedName(DiagnosticSettingsResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(DiagnosticSettingsResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(DiagnosticSettingsResources.createOrUpdate::parameters.resource,
  "Parameters supplied to the operation."
);
