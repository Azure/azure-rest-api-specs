import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Security;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SecureScoreItemProperties.score);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CloudError.error);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SecureScoreControlDetails.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SecureScoreControlScoreDetails.score);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SecureScoreControlDefinitionItem.properties);

@@clientLocation(SecureScoreItems.get, "SecureScores");
@@clientLocation(SecureScoreItems.list, "SecureScores");
@@clientLocation(SecureScoreItems.listBySecureScore, "SecureScoreControls");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SecureScoreItem.properties);

@@clientLocation(SecureScoreControlsOperationGroup.list, "SecureScoreControls");

@@clientLocation(SecureScoreControlDefinitionsOperationGroup.list,
  "SecureScoreControlDefinitions"
);
@@clientLocation(SecureScoreControlDefinitionsOperationGroup.listBySubscription,
  "SecureScoreControlDefinitions"
);
