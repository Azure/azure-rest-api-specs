import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
/**
 * The diagnostic setting resource.
 */
@extensionResource
model DiagnosticSettingsResource
  is Azure.ResourceManager.ExtensionResource<DiagnosticSettings> {
  ...ResourceNameParameter<
    Resource = DiagnosticSettingsResource,
    KeyName = "name",
    SegmentName = "diagnosticSettings",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface DiagnosticSettingsResources {
  /**
   * Gets the active diagnostic settings for the specified resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DiagnosticSettings_Get")
  @tag("DiagnosticSettings")
  get is Extension.Read<
    Extension.ScopeParameter,
    DiagnosticSettingsResource,
    Error = ErrorResponse
  >;

  /**
   * Creates or updates diagnostic settings for the specified resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("DiagnosticSettings_CreateOrUpdate")
  @tag("DiagnosticSettings")
  createOrUpdate is Extension.CreateOrReplaceSync<
    Extension.ScopeParameter,
    DiagnosticSettingsResource,
    Response = ArmResourceUpdatedResponse<DiagnosticSettingsResource>,
    Error = ErrorResponse
  >;

  /**
   * Deletes existing diagnostic settings for the specified resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DiagnosticSettings_Delete")
  @tag("DiagnosticSettings")
  delete is Extension.DeleteSync<
    Extension.ScopeParameter,
    DiagnosticSettingsResource,
    Error = ErrorResponse
  >;

  /**
   * Gets the active diagnostic settings list for the specified resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DiagnosticSettings_List")
  @tag("DiagnosticSettings")
  list is Extension.ListByTarget<
    Extension.ScopeParameter,
    DiagnosticSettingsResource,
    Response = ArmResponse<DiagnosticSettingsResourceCollection>,
    Error = ErrorResponse
  >;
}

@@doc(DiagnosticSettingsResource.name, "The name of the diagnostic setting.");
@@doc(
  DiagnosticSettingsResource.properties,
  "Properties of a Diagnostic Settings Resource."
);
@@doc(
  DiagnosticSettingsResources.createOrUpdate::parameters.resource,
  "Parameters supplied to the operation."
);
@@key(Extension.ScopeParameter.scope, "resourceUri");
