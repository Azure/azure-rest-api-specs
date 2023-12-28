import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DiagnosticCategory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Definition of Analysis")
@parentResource(DiagnosticCategory)
model AnalysisDefinition is ProxyResource<AnalysisDefinitionProperties> {
  @doc("Analysis Name")
  @key("analysisName")
  @segment("analyses")
  name: string;
}

@armResourceOperations
interface Diagnostics {
  @doc("Description for Get Site Analysis")
  getSiteAnalysis is ArmResourceRead<AnalysisDefinition>;
  @doc("Description for Get Site Analyses")
  listSiteAnalyses is ArmResourceListByParent<AnalysisDefinition>;
  @doc("Description for Execute Analysis")
  executeSiteAnalysis is ArmResourceActionSync<
    AnalysisDefinition,
    void,
    DiagnosticAnalysis,
    {
      ...BaseParameters<AnalysisDefinition>;

      @doc("Start Time")
      @query("startTime")
      startTime?: utcDateTime;

      @doc("End Time")
      @query("endTime")
      endTime?: utcDateTime;

      @doc("Time Grain")
      @pattern("PT[1-9][0-9]+[SMH]")
      @query("timeGrain")
      timeGrain?: string;
    }
  >;
}
