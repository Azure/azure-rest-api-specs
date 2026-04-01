import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Security;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CloudError.error);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SecurityAssessment.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SecurityAssessmentMetadata.properties);

@@clientLocation(SecurityAssessmentMetadataResponses.get, AssessmentsMetadata);
@@clientLocation(SecurityAssessmentMetadataResponses.list, AssessmentsMetadata);
@@clientName(AssessmentsMetadata.createInSubscription::parameters.resource,
  "assessmentMetadata"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SecurityAssessmentMetadataResponse.properties);

@@clientLocation(SecurityAssessmentResponses.get, "Assessments");
@@clientLocation(SecurityAssessmentResponses.createOrUpdate, "Assessments");
@@clientName(SecurityAssessmentResponses.createOrUpdate::parameters.resource,
  "assessment"
);
@@clientLocation(SecurityAssessmentResponses.delete, "Assessments");
@@clientLocation(SecurityAssessmentResponses.list, "Assessments");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SecurityAssessmentResponse.properties);
