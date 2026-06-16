import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace ServiceDiagnosticsSettingsApi;
/**
 * Description of a service diagnostic setting
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

alias ServiceDiagnosticSettingsResourcesOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /**
     * The fully qualified Azure Resource manager identifier of the resource.
     */
    @path(#{ allowReserved: true })
    resourceUri: string;
  },
  {
    ...Azure.ResourceManager.Legacy.Provider;
  },
  {
    ...Azure.ResourceManager.Legacy.Provider;

    /**
     * The name of the diagnostic setting.
     */
    @path
    @segment("diagnosticSettings")
    diagnosticSetting: "service";
  },
  "DiagnosticSetting"
>;

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface ServiceDiagnosticSettingsResources {
  /**
   * Gets the active diagnostic settings for the specified resource. **WARNING**: This method will be deprecated in future releases.
   */
  @tag("ServiceDiagnosticSettings")
  get is ServiceDiagnosticSettingsResourcesOps.Read<
    ServiceDiagnosticSettingsResource,
    ErrorType = Microsoft.Common.ErrorResponse
  >;

  /**
   * Create or update new diagnostic settings for the specified resource. **WARNING**: This method will be deprecated in future releases.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ServiceDiagnosticSettings")
  createOrUpdate is ServiceDiagnosticSettingsResourcesOps.CreateOrUpdateSync<
    ServiceDiagnosticSettingsResource,
    Response = ArmResourceUpdatedResponse<ServiceDiagnosticSettingsResource>,
    ErrorType = Microsoft.Common.ErrorResponse
  >;

  /**
   * Updates an existing ServiceDiagnosticSettingsResource. To update other fields use the CreateOrUpdate method. **WARNING**: This method will be deprecated in future releases.
   */
  @patch(#{ implicitOptionality: false })
  update is ServiceDiagnosticSettingsResourcesOps.CustomPatchSync<
    ServiceDiagnosticSettingsResource,
    PatchModel = ServiceDiagnosticSettingsResourcePatch,
    ErrorType = Microsoft.Common.ErrorResponse
  >;
}

@@doc(ServiceDiagnosticSettingsResource.name, "");
@@doc(
  ServiceDiagnosticSettingsResource.properties,
  "The service diagnostics settings of the resource."
);
@@doc(
  ServiceDiagnosticSettingsResources.createOrUpdate::parameters.resource,
  "Parameters supplied to the operation."
);
@@doc(
  ServiceDiagnosticSettingsResources.update::parameters.properties,
  "Parameters supplied to the operation."
);
@@key(Extension.ScopeParameter.scope, "resourceUri");
