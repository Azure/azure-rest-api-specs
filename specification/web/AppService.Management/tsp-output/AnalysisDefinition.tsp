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
/**
 * Definition of Analysis
 */
@parentResource(DiagnosticCategory)
model AnalysisDefinition is ProxyResource<AnalysisDefinitionProperties> {
  /**
   * Analysis Name
   */
  @path
  @key("analysisName")
  @segment("analyses")
  name: string;
}

@armResourceOperations
interface AnalysisDefinitions {
  /**
   * Description for Get Site Analysis
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Diagnostics_GetSiteAnalysis")
  getSiteAnalysis is ArmResourceRead<AnalysisDefinition>;

  /**
   * Description for Get Site Analyses
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Diagnostics_ListSiteAnalyses")
  listSiteAnalyses is ArmResourceListByParent<AnalysisDefinition>;

  /**
   * Description for Execute Analysis
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Diagnostics_ExecuteSiteAnalysis")
  executeSiteAnalysis is ArmResourceActionSync<
    AnalysisDefinition,
    void,
    DiagnosticAnalysis,
    {
      ...BaseParameters<AnalysisDefinition>;

      /**
       * Start Time
       */
      @query("startTime")
      startTime?: utcDateTime;

      /**
       * End Time
       */
      @query("endTime")
      endTime?: utcDateTime;

      /**
       * Time Grain
       */
      @pattern("PT[1-9][0-9]+[SMH]")
      @query("timeGrain")
      timeGrain?: string;
    }
  >;
}
