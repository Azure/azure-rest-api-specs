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
@extensionResource
model DiagnosticResource
  is Azure.ResourceManager.ExtensionResource<DiagnosticResourceProperties> {
  ...ResourceNameParameter<
    Resource = DiagnosticResource,
    KeyName = "diagnosticsResourceName",
    SegmentName = "diagnostics",
    NamePattern = "^[A-Za-z0-9-+@()_]+$"
  >;
}

@armResourceOperations
interface DiagnosticResources {
  /**
   * Get the diagnostics using the 'diagnosticsResourceName' you chose while creating the diagnostic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Diagnostics_Get")
  get is ArmResourceRead<
    DiagnosticResource,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * scope = resourceUri of affected resource.<br/> For example: /subscriptions/0d0fcd2e-c4fd-4349-8497-200edb3923c6/resourcegroups/myresourceGroup/providers/Microsoft.KeyVault/vaults/test-keyvault-non-read
       */
      @path
      scope: string;

      /**
       * Unique resource name for insight resources
       */
      @maxLength(100)
      @minLength(1)
      @pattern("^[A-Za-z0-9-+@()_]+$")
      @path
      diagnosticsResourceName: string;
    }
  >;

  /**
   * Creates a diagnostic for the specific resource using solutionId from discovery solutions. <br/>Diagnostics are powerful solutions that access product resources or other relevant data and provide the root cause of the issue and the steps to address the issue.<br/><br/>
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Diagnostics_Create")
  create is ArmResourceCreateOrReplaceAsync<
    DiagnosticResource,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * scope = resourceUri of affected resource.<br/> For example: /subscriptions/0d0fcd2e-c4fd-4349-8497-200edb3923c6/resourcegroups/myresourceGroup/providers/Microsoft.KeyVault/vaults/test-keyvault-non-read
       */
      @path
      scope: string;

      /**
       * Unique resource name for insight resources
       */
      @maxLength(100)
      @minLength(1)
      @pattern("^[A-Za-z0-9-+@()_]+$")
      @path
      diagnosticsResourceName: string;
    }
  >;
}

@@maxLength(DiagnosticResource.name, 100);
@@minLength(DiagnosticResource.name, 1);
@@doc(DiagnosticResource.name, "Unique resource name for insight resources");
@@doc(DiagnosticResource.properties, "Diagnostic Resource properties.");
@@doc(DiagnosticResources.create::parameters.resource,
  "The required request body for this insightResource invocation."
);
