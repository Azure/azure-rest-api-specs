import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;
@doc("Represents a SourceControl in Azure Security Insights.")
model SourceControl is ProxyResource<SourceControlProperties> {
  @doc("Source control Id")
  @path
  @key("sourceControlId")
  @segment("sourcecontrols")
  name: string;
}

@armResourceOperations
interface SourceControls {
  @doc("Gets a source control byt its identifier.")
  get is ArmResourceRead<SourceControl>;
  @doc("Creates a source control.")
  create is ArmResourceCreateOrReplaceSync<SourceControl>;
  @doc("Delete a source control.")
  delete is ArmResourceDeleteSync<SourceControl>;
  @doc("Gets all source controls, without source control items.")
  list is ArmResourceListByParent<SourceControl>;
}
