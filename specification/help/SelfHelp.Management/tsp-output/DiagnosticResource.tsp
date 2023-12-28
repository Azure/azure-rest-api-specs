import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SelfHelp;
@doc("Diagnostic resource")
model DiagnosticResource is ExtensionResource<DiagnosticResourceProperties> {
  @doc("Unique resource name for insight resources")
  @maxLength(100)
  @minLength(1)
  @pattern("^[A-Za-z0-9-+@()_]+$")
  @key("diagnosticsResourceName")
  @segment("diagnostics")
  name: string;
}

@armResourceOperations
interface Diagnostics {
  @doc("Get the diagnostics using the 'diagnosticsResourceName' you chose while creating the diagnostic.")
  get is ArmResourceRead<DiagnosticResource>;
  @doc("Creates a diagnostic for the specific resource using solutionId and requiredInputs* from discovery solutions. &lt;br/&gt;Diagnostics tells you precisely the root cause of the issue and the steps to address it. You can get diagnostics once you discover the relevant solution for your Azure issue. &lt;br/&gt;&lt;br/&gt; &lt;b&gt;Note: &lt;/b&gt; requiredInputs’ from Discovery solutions response must be passed via ‘additionalParameters’ as an input to Diagnostics API.")
  create is ArmResourceCreateOrUpdateAsync<DiagnosticResource>;
}
