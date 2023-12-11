import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SiteDiagnostic.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Definition of Analysis")
@parentResource(SiteDiagnostic)
model SiteDiagnosticAnalysis is ProxyResource<AnalysisDefinitionProperties> {
  @doc("Analysis Name")
  @path
  @key("analysisName")
  @segment("analyses")
  name: string;
}

@armResourceOperations
interface SiteDiagnosticAnalyses {
  @doc("Description for Get Site Analysis")
  getSiteAnalysis is ArmResourceRead<SiteDiagnosticAnalysis>;
  @doc("Description for Get Site Analyses")
  listSiteAnalyses is ArmResourceListByParent<SiteDiagnosticAnalysis>;
  @doc("Description for Execute Analysis")
  executeSiteAnalysis is ArmResourceActionSync<
    SiteDiagnosticAnalysis,
    {},
    DiagnosticAnalysis,
    {
      ...BaseParameters<SiteDiagnosticAnalysis>;

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
