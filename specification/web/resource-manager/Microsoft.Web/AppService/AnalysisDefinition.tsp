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

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
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
  @summary("Get Site Analysis")
  getSiteAnalysis is AnalysisDefinitionOps.Read<
    AnalysisDefinition,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get Site Analyses
   */
  @summary("Get Site Analyses")
  listSiteAnalyses is AnalysisDefinitionOps.List<
    AnalysisDefinition,
    Response = ArmResponse<DiagnosticAnalysisCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Execute Analysis
   */
  @summary("Execute Analysis")
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
  @summary("Get Site Analysis")
  getSiteAnalysisSlot is AnalysisDefinitionOperationGroupOps.Read<
    AnalysisDefinition,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get Site Analyses
   */
  @summary("Get Site Analyses")
  listSiteAnalysesSlot is AnalysisDefinitionOperationGroupOps.List<
    AnalysisDefinition,
    Response = ArmResponse<DiagnosticAnalysisCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Execute Analysis
   */
  @summary("Execute Analysis")
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
