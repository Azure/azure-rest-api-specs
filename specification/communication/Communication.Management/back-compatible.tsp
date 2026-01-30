import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Communication;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CommunicationServiceResourceUpdate.properties);

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

@@clientName(SmtpUsernames.createOrUpdate::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SmtpUsernameResource.properties);

@@clientName(SuppressionLists.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SuppressionListResource.properties);

@@clientName(SuppressionListAddresses.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SuppressionListAddressResource.properties);

@@clientName(CommunicationServices.checkNameAvailability::parameters.body,
  "nameAvailabilityParameters"
);

@@visibility(CommunicationServiceResource.identity,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);
