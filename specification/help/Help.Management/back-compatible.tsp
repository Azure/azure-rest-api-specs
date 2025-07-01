import "@azure-tools/typespec-client-generator-core";

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
  "DiscoverySolutionNLP"
);
@@clientLocation(DiscoverySolutionNLPOperationGroup.discoverSolutionsBySubscription,
  "DiscoverySolutionNLP"
);
@@clientLocation(DiagnosticResources.get, "Diagnostics");
@@clientLocation(DiagnosticResources.create, "Diagnostics");
@@clientLocation(SolutionResources.get, "Solution");
@@clientLocation(SolutionResources.create, "Solution");
@@clientLocation(SolutionResources.update, "Solution");
@@clientLocation(SolutionResources.warmUp, "Solution");
@@clientLocation(SimplifiedSolutionsResources.get, "SimplifiedSolutions");
@@clientLocation(SimplifiedSolutionsResources.create, "SimplifiedSolutions");
@@clientLocation(TroubleshooterResources.get, "Troubleshooters");
@@clientLocation(TroubleshooterResources.create, "Troubleshooters");
@@clientLocation(TroubleshooterResources.continue, "Troubleshooters");
@@clientLocation(TroubleshooterResources.end, "Troubleshooters");
@@clientLocation(TroubleshooterResources.restart, "Troubleshooters");
@@clientLocation(SolutionResourceSelfHelps.get, "SolutionSelfHelp");
