import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ClientGenerator.Core;
using Microsoft.Help;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SolutionMetadataResource.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SolutionPatchRequestBody.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SolutionNlpMetadataResource.properties
);

@@clientName(DiagnosticResources.create::parameters.resource,
  "diagnosticResourceRequest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DiagnosticResource.properties
);

@@clientName(SolutionResources.create::parameters.resource,
  "solutionRequestBody"
);
@@clientName(SolutionResources.update::parameters.properties,
  "solutionPatchRequestBody"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SolutionResource.properties
);

@@clientName(SimplifiedSolutionsResources.create::parameters.resource,
  "simplifiedSolutionsRequestBody"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SimplifiedSolutionsResource.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(TroubleshooterResource.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SolutionResourceSelfHelp.properties
);

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

@@usage(SolutionResourceSelfHelp, Usage.input);
@@usage(SolutionMetadataResource, Usage.input);
@@usage(SolutionNlpMetadataResource, Usage.input);

@@clientLocation(DiscoverySolutionNLPOperationGroup.discoverSolutionsBySubscription::parameters.subscriptionId,
  DiscoverySolutionNLPOperationGroup.discoverSolutionsBySubscription
);
