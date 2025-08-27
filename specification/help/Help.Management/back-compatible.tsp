import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using Microsoft.Help;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SolutionMetadataResource.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SolutionPatchRequestBody.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SolutionNlpMetadataResource.properties);

@@clientName(DiagnosticResources.create::parameters.resource,
  "diagnosticResourceRequest"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DiagnosticResource.properties);

@@clientName(SolutionResources.create::parameters.resource,
  "solutionRequestBody"
);
@@clientName(SolutionResources.update::parameters.properties,
  "solutionPatchRequestBody"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SolutionResource.properties);

@@clientName(SimplifiedSolutionsResources.create::parameters.resource,
  "simplifiedSolutionsRequestBody"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SimplifiedSolutionsResource.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(TroubleshooterResource.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SolutionResourceSelfHelp.properties);

@@clientName(DiagnosticResources.create::parameters.resource,
  "diagnosticResourceRequest"
);

@@clientName(SimplifiedSolutionsResources.create::parameters.resource,
  "simplifiedSolutionsRequestBody"
);

@@clientName(SolutionResources.create::parameters.resource,
  "solutionRequestBody"
);

@@clientName(SolutionResources.update::parameters.properties,
  "solutionPatchRequestBody"
);
@@clientName(TroubleshooterResources.create::parameters.resource,
  "createTroubleshooterRequestBody"
);
@@clientName(DiscoverySolutionNLPOperationGroup.discoverSolutions::parameters.body,
  "discoverSolutionRequest"
);
@@clientName(DiscoverySolutionNLPOperationGroup.discoverSolutionsBySubscription::parameters.body,
  "discoverSolutionRequest"
);
@@clientName(DiscoveryNlpRequest, "DiscoveryNlpContent", "csharp");
@@clientName(ResponseOption, "ResponseConfig", "csharp");
@@clientName(RestartTroubleshooterResponse,
  "RestartTroubleshooterResult",
  "csharp"
);
@@clientName(TroubleshooterResponse, "TroubleshooterResult", "csharp");
@@clientName(ResponseOption, "ResponseConfig", "csharp");
@@clientName(CheckNameAvailabilityResponse,
  "CheckNameAvailabilityResult",
  "csharp"
);
@@clientName(RestartTroubleshooterResponse,
  "RestartTroubleshooterResult",
  "csharp"
);
@@clientName(SolutionResources.warmUp::parameters.body,
  "solutionWarmUpRequestBody"
);
@@clientName(TroubleshooterResources.continue::parameters.body,
  "continueRequestBody"
);

@@clientName(CheckNameAvailabilityOperationGroup.checkNameAvailability::parameters.body,
  "CheckNameAvailabilityRequest"
);
@@Azure.ClientGenerator.Core.clientName(Azure.ResourceManager.Foundations.BaseParameters.resourceUri,
  "scope"
);

// @@clientLocation decorators for operations with @operationId
@@clientLocation(CheckNameAvailabilityOperationGroup.checkNameAvailability,
  "CheckNameAvailability"
);
@@clientName(CheckNameAvailabilityOperationGroup.checkNameAvailability,
  "CheckAvailability"
);
@@clientLocation(DiscoverySolutionOperationGroup.list, "DiscoverySolution");
@@clientLocation(DiscoverySolutionNLPOperationGroup.discoverSolutions,
  "DiscoverySolutionNLP",
  "!csharp"
);
@@clientLocation(DiscoverySolutionNLPOperationGroup.discoverSolutionsBySubscription,
  "DiscoverySolutionNLP"
);
@@clientLocation(DiagnosticResources.get, "Diagnostics", "!csharp");
@@clientLocation(DiagnosticResources.create, "Diagnostics", "!csharp");
@@clientLocation(SolutionResources.get, "Solution", "!csharp");
@@clientLocation(SolutionResources.create, "Solution", "!csharp");
@@clientLocation(SolutionResources.update, "Solution", "!csharp");
@@clientLocation(SolutionResources.warmUp, "Solution", "!csharp");
@@clientLocation(SimplifiedSolutionsResources.get,
  "SimplifiedSolutions",
  "!csharp"
);
@@clientLocation(SimplifiedSolutionsResources.create,
  "SimplifiedSolutions",
  "!csharp"
);
@@clientLocation(TroubleshooterResources.get, "Troubleshooters", "!csharp");
@@clientLocation(TroubleshooterResources.create, "Troubleshooters", "!csharp");
@@clientLocation(TroubleshooterResources.continue,
  "Troubleshooters",
  "!csharp"
);
@@clientLocation(TroubleshooterResources.end, "Troubleshooters", "!csharp");
@@clientLocation(TroubleshooterResources.restart, "Troubleshooters", "!csharp");
@@clientLocation(SolutionResourceSelfHelps.get, "SolutionSelfHelp");

//SDK Validation
@@clientName(DiagnosticResource, "SelfHelpDiagnostic", "csharp");
@@clientName(SolutionResource, "SelfHelpSolution", "csharp");
@@clientName(SimplifiedSolutionsResource,
  "SelfHelpSimplifiedSolutions",
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
  armResourceType,
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
@@usage(SolutionResourceSelfHelp, Usage.input);
@@usage(SolutionMetadataResource, Usage.input);
@@usage(SolutionNlpMetadataResource, Usage.input);
