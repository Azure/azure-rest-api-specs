import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Help;
/**
 * Diagnostic resource
 */
model DiagnosticResource
  is Azure.ResourceManager.ExtensionResource<DiagnosticResourceProperties> {
  ...ResourceNameParameter<
    Resource = DiagnosticResource,
    KeyName = "diagnosticsResourceName",
    SegmentName = "diagnostics",
    NamePattern = "^[A-Za-z0-9-+@()_]+$"
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface DiagnosticResources {
  /**
   * Get the diagnostics using the 'diagnosticsResourceName' you chose while creating the diagnostic.
   */
  get is Extension.Read<Extension.ScopeParameter, DiagnosticResource>;

  /**
   * Creates a diagnostic for the specific resource using solutionId from discovery solutions. <br/>Diagnostics are powerful solutions that access product resources or other relevant data and provide the root cause of the issue and the steps to address the issue.<br/><br/>
   */
  create is Legacy.ExtensionOperations.CreateOrUpdateAsync<
    DiagnosticResource,
    Parameters = {
      ...ApiVersionParameter;
      ...Extension.ScopeParameter;
      ...Legacy.Provider;

      /**
       * Unique resource name for insight resources
       */
      @path
      @segment("diagnostics")
      @minLength(1)
      @maxLength(100)
      @pattern("^[A-Za-z0-9-+@()_]+$")
      diagnosticsResourceName: string;
    },
    OptionalRequestBody = true
  >;
}

@@maxLength(DiagnosticResource.name, 100);
@@minLength(DiagnosticResource.name, 1);
@@doc(DiagnosticResource.name, "Unique resource name for insight resources");
@@doc(DiagnosticResource.properties, "Diagnostic Resource properties.");
@@doc(DiagnosticResources.create::parameters.resource,
  "The required request body for this insightResource invocation."
);
