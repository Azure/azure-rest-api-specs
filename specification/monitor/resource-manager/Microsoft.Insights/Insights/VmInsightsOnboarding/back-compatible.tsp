import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using VmInsightsOnboarding;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(WorkspaceInfo.properties);

@@clientLocation(
  VMInsightsOnboardingStatuses.getOnboardingStatus,
  "VMInsights"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VMInsightsOnboardingStatus.properties);
