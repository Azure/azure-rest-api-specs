import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DiagnosticCategory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Definition of Analysis
 */
@parentResource(DiagnosticCategory)
model AnalysisDefinition
  is Azure.ResourceManager.ProxyResource<AnalysisDefinitionProperties> {
  ...ResourceNameParameter<
    Resource = AnalysisDefinition,
    KeyName = "analysisName",
    SegmentName = "analyses",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AnalysisDefinitionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Site Name */
        @path
        @segment("sites")
        @key
        siteName: string,

        /** Diagnostic Category */
        @path
        @segment("diagnostics")
        @key
        diagnosticCategory: string,
      },
      {
        /** Analysis Name */
        @path
        @segment("analyses")
        @key
        analysisName: string,
      }
    > {}

@armResourceOperations
interface AnalysisDefinitions {
  /**
   * Description for Get Site Analysis
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Diagnostics_GetSiteAnalysis")
  getSiteAnalysis is AnalysisDefinitionOps.Read<
    AnalysisDefinition,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get Site Analyses
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Diagnostics_ListSiteAnalyses")
  listSiteAnalyses is AnalysisDefinitionOps.List<
    AnalysisDefinition,
    Response = ArmResponse<DiagnosticAnalysisCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Execute Analysis
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Diagnostics_ExecuteSiteAnalysis")
  @action("execute")
  executeSiteAnalysis is AnalysisDefinitionOps.ActionSync<
    AnalysisDefinition,
    void,
    ArmResponse<DiagnosticAnalysis>,
    Parameters = {
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
    },
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface AnalysisDefinitionOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Site Name */
        @path
        @segment("sites")
        @key
        siteName: string,

        /** Slot - optional */
        @path
        @segment("slots")
        @key
        slot: string,

        /** Diagnostic Category */
        @path
        @segment("diagnostics")
        @key
        diagnosticCategory: string,
      },
      {
        /** Analysis Name */
        @path
        @segment("analyses")
        @key
        analysisName: string,
      }
    > {}

@armResourceOperations
interface AnalysisDefinitionOperationGroup {
  /**
   * Description for Get Site Analysis
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Diagnostics_GetSiteAnalysisSlot")
  getSiteAnalysisSlot is AnalysisDefinitionOperationGroupOps.Read<
    AnalysisDefinition,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get Site Analyses
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Diagnostics_ListSiteAnalysesSlot")
  listSiteAnalysesSlot is AnalysisDefinitionOperationGroupOps.List<
    AnalysisDefinition,
    Response = ArmResponse<DiagnosticAnalysisCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Execute Analysis
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Diagnostics_ExecuteSiteAnalysisSlot")
  @action("execute")
  executeSiteAnalysisSlot is AnalysisDefinitionOperationGroupOps.ActionSync<
    AnalysisDefinition,
    void,
    ArmResponse<DiagnosticAnalysis>,
    Parameters = {
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
    },
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(AnalysisDefinition.name, "Analysis Name");
@@doc(AnalysisDefinition.properties,
  "AnalysisDefinition resource specific properties"
);
