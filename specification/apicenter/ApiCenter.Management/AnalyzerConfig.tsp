import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Service.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ApiCenter;

@added(Versions.v2024_12_15_preview)
@doc("API analyzer configuration.")
model AnalyzerConfig is ProxyResource<AnalyzerConfigProperties> {
  @doc("The name of the configuration.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]{3,90}$")
  @path
  @key("analyzerConfigName")
  @segment("analyzerConfigs")
  name: string;
}

@armResourceOperations
@added(Versions.v2024_12_15_preview)
interface AnalyzerConfigs {
  @doc("Returns details of the API analyzer configuration.")
  get is ArmResourceRead<AnalyzerConfig>;

  @doc("Permanently deletes API analyzer configuration.")
  delete is ArmResourceDeleteSync<AnalyzerConfig>;

  @doc("Lists API analyzer configurations.")
  list is ArmResourceListByParent<AnalyzerConfig>;

  @doc("Creates new or updates existing API analyzer configuration.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AnalyzerConfig>;

  @doc("Imports the API analyzer ruleset.")
  importRuleset is ArmResourceActionAsync<
    AnalyzerConfig,
    RulesetImportRequest,
    CommonTypes.OperationStatusResult
  >;

  @doc("Exports the API analyzer ruleset.")
  exportRuleset is ArmResourceActionAsync<
    AnalyzerConfig,
    void,
    RulesetExportResult
  >;
}
