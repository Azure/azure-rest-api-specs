import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Help;

@@clientName(Solutions, "SelfhelpSolutions", "csharp");
@@clientName(ValidationScope.IpAddressFormat, "IPAddressFormat", "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "required for pageable"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(DiscoverySolutionNLPOperationGroup.discoverSolutions,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "required for pageable"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(DiscoverySolutionNLPOperationGroup.discoverSolutionsBySubscription,
  "csharp"
);

@@clientName(DiscoveryNlpRequest, "DiscoveryNlpContent", "csharp");
@@clientName(ResponseOption, "ResponseConfig", "csharp");
@@clientName(RestartTroubleshooterResponse,
  "RestartTroubleshooterResult",
  "csharp"
);
@@clientName(TroubleshooterResponse, "TroubleshooterResult", "csharp");
@@clientName(CheckNameAvailabilityResponse,
  "CheckNameAvailabilityResult",
  "csharp"
);

//SDK Validation
@@clientName(DiagnosticResource, "SelfHelpDiagnostic", "csharp");
@@clientName(SolutionResource, "SelfHelpSolution", "csharp");
@@clientName(SimplifiedSolutionsResource,
  "SelfHelpSimplifiedSolution",
  "csharp"
);
@@clientName(TroubleshooterResource, "SelfHelpTroubleshooter", "csharp");
@@clientName(SolutionMetadataResource, "SelfHelpSolutionMetadata", "csharp");
@@clientName(FilterGroup, "ChartFilterGroup", "csharp");
@@clientName(DiscoveryNlpResponse, "DiscoveryNlpResult", "csharp");
@@clientName(SearchResult, "KBSearchResult", "csharp");
@@clientName(WebResult, "KBWebResult", "csharp");
@@clientName(ReplacementMapsSelfHelp, "ReplacementMapsResult", "csharp");
@@clientName(Diagnostic, "SelfHelpDiagnosticInfo", "csharp");
@@clientName(Insight, "SelfHelpDiagnosticInsight", "csharp");
@@clientName(DiagnosticInvocation, "SelfHelpDiagnosticInvocation", "csharp");
@@clientName(DiscoveryResponse, "SelfHelpDiscoverySolutionResult", "csharp");
@@clientName(Error, "SelfHelpError", "csharp");
@@clientName(Filter, "SelfHelpFilter", "csharp");
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
  "SelfHelpNameAvailabilityContent",
  "csharp"
);
@@clientName(Section, "SelfHelpSection", "csharp");
@@clientName(SolutionResourceSelfHelp, "SelfHelpSolutionResult", "csharp");
@@clientName(Step, "SelfHelpStep", "csharp");
@@clientName(Video, "SelfHelpVideo", "csharp");
@@clientName(SolutionNlpMetadataResource, "SolutionNlpMetadata", "csharp");
@@clientName(ReplacementMaps, "SolutionReplacementMaps", "csharp");
@@clientName(SectionSelfHelp, "SolutionSection", "csharp");
@@clientName(TriggerCriterion, "SolutionTriggerCriterion", "csharp");
@@clientName(SolutionWarmUpRequestBody, "SolutionWarmUpContent", "csharp");
@@clientName(ContinueRequestBody, "TroubleshooterContinueContent", "csharp");
@@clientName(StepInput, "TroubleshooterStepInput", "csharp");
@@clientName(VideoGroup, "VideoGroupDetail", "csharp");
@@clientName(CheckNameAvailabilityResponse,
  "SelfHelpNameAvailabilityResult",
  "csharp"
);
@@clientName(ValidationScope, "TroubleshooterValidationScope", "csharp");
@@clientName(QuestionType, "TroubleshooterQuestionType", "csharp");
@@clientName(QuestionContentType,
  "TroubleshooterQuestionContentType",
  "csharp"
);
@@clientName(QuestionContentType,
  "TroubleshooterQuestionContentType ",
  "csharp"
);
@@clientName(ExecutionStatus, "TroubleshooterExecutionStatus ", "csharp");
@@clientName(Status, "SelfHelpDiagnosticStatus", "csharp");
@@clientName(Name, "SelfHelpName", "csharp");
@@clientName(Type, "SelfHelpType", "csharp");
@@clientName(SolutionType, "SelfHelpSolutionType", "csharp");
@@clientName(CheckNameAvailabilityResponse.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@alternateType(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest.type,
  Azure.Core.armResourceType,
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest.type,
  "ResourceType",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest.name,
  "ResourceName",
  "csharp"
);
@@clientName(ImportanceLevel, "SelfHelpImportanceLevel", "csharp");
@@clientName(Error.type, "ErrorType ", "csharp");
@@clientName(Step.type, "StepType", "csharp");
@@clientName(Insight.importanceLevel, "InsightImportanceLevel", "csharp");
@@alternateType(MetricsBasedChart.timeSpanDuration, duration, "csharp");
@@clientName(AggregationType, "ChartAggregationType", "csharp");
@@clientName(ResultType, "KBSearchResultType", "csharp");
@@clientName(AutomatedCheckResult.type, "ResultType", "csharp");
@@alternateType(DiagnosticResourceProperties.acceptedAt, utcDateTime, "csharp");
@@clientName(DiagnosticResourceProperties.acceptedAt, "AcceptedOn", "csharp");
@@clientName(DiagnosticProvisioningState,
  "SelfHelpProvisioningState",
  "csharp"
);
@@clientName(Confidence, "SelfHelpConfidence", "csharp");
@@clientName(ValidationScope.URLFormat, "UrlFormat", "csharp");
@@clientName(SolutionResourceSelfHelps.get,
  "GetSelfHelpSolutionById",
  "csharp"
);
@@clientName(CheckNameAvailabilityOperationGroup.checkNameAvailability,
  "CheckSelfHelpNameAvailability",
  "csharp"
);
@@clientName(DiscoverySolutionOperationGroup.list,
  "DiscoverSolutions",
  "csharp"
);
@@clientName(DiscoverySolutionNLPOperationGroup.discoverSolutions,
  "DiscoverSolutionsNlp",
  "csharp"
);
@@clientName(DiscoverySolutionNLPOperationGroup.discoverSolutionsBySubscription,
  "DiscoverSolutionsNlp",
  "csharp"
);
