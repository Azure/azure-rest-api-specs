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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface DiagnosticResourcesOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,

        /**
         * The fully qualified Azure Resource manager identifier of the resource.
         */
        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path(#{ allowReserved: true })
        scope: string,

        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        /**
         * Unique resource name for insight resources
         */
        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("diagnostics")
        @minLength(1)
        @maxLength(100)
        @pattern("^[A-Za-z0-9-+@()_]+$")
        diagnosticsResourceName: string,
      }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface DiagnosticResources {
  /**
   * Get the diagnostics using the 'diagnosticsResourceName' you chose while creating the diagnostic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<DiagnosticResource>;

  /**
   * Creates a diagnostic for the specific resource using solutionId from discovery solutions. <br/>Diagnostics are powerful solutions that access product resources or other relevant data and provide the root cause of the issue and the steps to address the issue.<br/><br/>
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is DiagnosticResourcesOps.CreateOrUpdateAsync<
    DiagnosticResource,
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
