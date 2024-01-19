import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DiagnosticCategory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
@doc("Definition of Analysis")
@parentResource(DiagnosticCategory)
model AnalysisDefinition is ProxyResource<AnalysisDefinitionProperties> {
  @doc("Analysis Name")
  @path
  @key("analysisName")
  @segment("analyses")
  name: string;
}

@armResourceOperations
interface AnalysisDefinitions {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get Site Analysis")
  @operationId("Diagnostics_GetSiteAnalysis")
  getSiteAnalysis is ArmResourceRead<AnalysisDefinition>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get Site Analyses")
  @operationId("Diagnostics_ListSiteAnalyses")
  listSiteAnalyses is ArmResourceListByParent<AnalysisDefinition>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Execute Analysis")
  @operationId("Diagnostics_ExecuteSiteAnalysis")
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
