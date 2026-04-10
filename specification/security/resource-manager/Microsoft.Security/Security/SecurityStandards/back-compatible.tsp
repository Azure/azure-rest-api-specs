import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using SecurityStandardsAPI;

@@clientName(SecurityStandards.createOrUpdate::parameters.resource, "standard");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SecurityStandard.properties);

@@clientName(StandardAssignments.create::parameters.resource,
  "standardAssignment"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(StandardAssignment.properties);

@@clientName(CustomRecommendations.createOrUpdate::parameters.resource,
  "customRecommendationBody"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CustomRecommendation.properties);

