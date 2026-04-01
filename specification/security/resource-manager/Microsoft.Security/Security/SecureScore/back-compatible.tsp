import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Security;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SecureScoreItemProperties.score);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CloudError.error);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SecureScoreControlDetails.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SecureScoreControlScoreDetails.score);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SecureScoreControlDefinitionItem.properties);

@@clientLocation(SecureScoreItems.get, "SecureScores");
@@clientLocation(SecureScoreItems.list, "SecureScores");
@@clientLocation(SecureScoreItems.listBySecureScore, "SecureScoreControls");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SecureScoreItem.properties);

@@clientLocation(SecureScoreControlsOperationGroup.list, "SecureScoreControls");

@@clientLocation(SecureScoreControlDefinitionsOperationGroup.list,
  "SecureScoreControlDefinitions"
);
@@clientLocation(SecureScoreControlDefinitionsOperationGroup.listBySubscription,
  "SecureScoreControlDefinitions"
);
@@visibility(SecureScoreItem.properties, Lifecycle.Read);
