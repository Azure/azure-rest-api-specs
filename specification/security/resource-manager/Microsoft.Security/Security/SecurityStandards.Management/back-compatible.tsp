import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Security;

@@clientName(SecurityStandards.createOrUpdate::parameters.resource, "standard");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SecurityStandard.properties);

@@clientName(StandardAssignments.create::parameters.resource,
  "standardAssignment"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(StandardAssignment.properties);

@@clientName(CustomRecommendations.createOrUpdate::parameters.resource,
  "customRecommendationBody"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CustomRecommendation.properties);
