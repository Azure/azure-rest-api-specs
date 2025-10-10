import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Communication;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CommunicationServiceResourceUpdate.properties);

@@clientName(DomainPropertiesVerificationStates.Domain, "domain");
@@clientName(DomainPropertiesVerificationStates.DKIM, "dkim");
@@clientName(DomainPropertiesVerificationStates.DKIM2, "dkim2");
@@clientName(DomainPropertiesVerificationStates.DMARC, "dmarc");

@@clientName(DomainPropertiesVerificationRecords.Domain, "domain");
@@clientName(DomainPropertiesVerificationRecords.DKIM, "dkim");
@@clientName(DomainPropertiesVerificationRecords.DKIM2, "dkim2");
@@clientName(DomainPropertiesVerificationRecords.DMARC, "dmarc");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(UpdateDomainRequestParameters.properties);

@@clientName(CommunicationServices.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(CommunicationServices.update::parameters.properties, "parameters");
@@clientName(CommunicationServices.linkNotificationHub::parameters.body,
  "linkNotificationHubParameters"
);
@@clientName(CommunicationServices.regenerateKey::parameters.body,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CommunicationServiceResource.properties);

@@clientName(Domains.createOrUpdate::parameters.resource, "parameters");
@@clientName(Domains.update::parameters.properties, "parameters");
@@clientName(Domains.initiateVerification::parameters.body, "parameters");
@@clientName(Domains.cancelVerification::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DomainResource.properties);

@@clientName(EmailServices.createOrUpdate::parameters.resource, "parameters");
@@clientName(EmailServices.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(EmailServiceResource.properties);

@@clientName(SenderUsernames.createOrUpdate::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SenderUsernameResource.properties);

@@clientName(CommunicationServices.checkNameAvailability::parameters.body,
  "nameAvailabilityParameters"
);
