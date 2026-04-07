import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace microsoft.insights;
/**
 * Description of a service diagnostic setting
 */
@singleton("service")
@extensionResource
model ServiceDiagnosticSettingsResource
  is Azure.ResourceManager.ExtensionResource<ServiceDiagnosticSettings> {
  ...ResourceNameParameter<
    Resource = ServiceDiagnosticSettingsResource,
    KeyName = "diagnosticSetting",
    SegmentName = "diagnosticSettings",
    NamePattern = ""
  >;

  /**
   * Resource location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  tags?: Record<string>;
}

@armResourceOperations(#{ omitTags: true })
interface ServiceDiagnosticSettingsResources {
  /**
   * Gets the active diagnostic settings for the specified resource. **WARNING**: This method will be deprecated in future releases.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServiceDiagnosticSettings_Get")
  @tag("ServiceDiagnosticSettings")
  get is Extension.Read<
    Extension.ScopeParameter,
    ServiceDiagnosticSettingsResource,
    Error = ErrorResponse
  >;

  /**
   * Create or update new diagnostic settings for the specified resource. **WARNING**: This method will be deprecated in future releases.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ServiceDiagnosticSettings_CreateOrUpdate")
  @tag("ServiceDiagnosticSettings")
  createOrUpdate is Extension.CreateOrReplaceSync<
    Extension.ScopeParameter,
    ServiceDiagnosticSettingsResource,
    Response = ArmResourceUpdatedResponse<ServiceDiagnosticSettingsResource>,
    Error = ErrorResponse
  >;

  /**
   * Updates an existing ServiceDiagnosticSettingsResource. To update other fields use the CreateOrUpdate method. **WARNING**: This method will be deprecated in future releases.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServiceDiagnosticSettings_Update")
  @patch(#{ implicitOptionality: false })
  update is Extension.CustomPatchSync<
    Extension.ScopeParameter,
    ServiceDiagnosticSettingsResource,
    PatchModel = ServiceDiagnosticSettingsResourcePatch,
    Error = ErrorResponse
  >;
}

@@doc(ServiceDiagnosticSettingsResource.name, "");
@@doc(ServiceDiagnosticSettingsResource.properties,
  "The service diagnostics settings of the resource."
);
@@doc(ServiceDiagnosticSettingsResources.createOrUpdate::parameters.resource,
  "Parameters supplied to the operation."
);
@@doc(ServiceDiagnosticSettingsResources.update::parameters.properties,
  "Parameters supplied to the operation."
);
@@key(Extension.ScopeParameter.scope, "resourceUri");
