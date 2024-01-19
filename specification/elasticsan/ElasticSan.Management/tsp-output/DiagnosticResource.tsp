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

namespace Microsoft.Help;
@doc("Diagnostic resource")
model DiagnosticResource is ExtensionResource<DiagnosticResourceProperties> {
  @doc("Unique resource name for insight resources")
  @maxLength(100)
  @minLength(1)
  @pattern("^[A-Za-z0-9-+@()_]+$")
  @path
  @key("diagnosticsResourceName")
  @segment("diagnostics")
  name: string;
}

@armResourceOperations
interface DiagnosticResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the diagnostics using the 'diagnosticsResourceName' you chose while creating the diagnostic.")
  @operationId("Diagnostics_Get")
  get is ArmResourceRead<DiagnosticResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a diagnostic for the specific resource using solutionId and requiredInputs* from discovery solutions. &lt;br/&gt;Diagnostics tells you precisely the root cause of the issue and the steps to address it. You can get diagnostics once you discover the relevant solution for your Azure issue. &lt;br/&gt;&lt;br/&gt; &lt;b&gt;Note: &lt;/b&gt; requiredInputs’ from Discovery solutions response must be passed via ‘additionalParameters’ as an input to Diagnostics API.")
  @operationId("Diagnostics_Create")
  create is ArmResourceCreateOrUpdateAsync<
    DiagnosticResource,
    BaseParameters<DiagnosticResource>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(DiagnosticResources.create::parameters.resource,
  "json",
  "diagnosticResourceRequest"
);
@@extension(DiagnosticResources.create::parameters.resource,
  "x-ms-client-name",
  "diagnosticResourceRequest"
);
@@doc(DiagnosticResources.create::parameters.resource,
  "The required request body for this insightResource invocation."
);
