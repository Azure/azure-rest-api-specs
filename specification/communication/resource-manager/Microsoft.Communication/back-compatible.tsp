import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Communication;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CommunicationServiceResourceUpdate.properties);

@@clientName(DomainPropertiesVerificationStates.Domain, "domain");
@@clientName(DomainPropertiesVerificationStates.DKIM, "dkim");
@@clientName(DomainPropertiesVerificationStates.DKIM2, "dkim2");
@@clientName(DomainPropertiesVerificationStates.DMARC, "dmarc");

@@clientName(DomainPropertiesVerificationRecords.Domain, "domain");
@@clientName(DomainPropertiesVerificationRecords.DKIM, "dkim");
@@clientName(DomainPropertiesVerificationRecords.DKIM2, "dkim2");
@@clientName(DomainPropertiesVerificationRecords.DMARC, "dmarc");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(UpdateDomainRequestParameters.properties);

@@clientLocation(CommunicationServices.get, "CommunicationServices");
@@clientLocation(CommunicationServices.createOrUpdate, "CommunicationServices");
@@clientName(CommunicationServices.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(CommunicationServices.update, "CommunicationServices");
@@clientName(CommunicationServices.update::parameters.properties, "parameters");
@@clientLocation(CommunicationServices.delete, "CommunicationServices");
@@clientLocation(CommunicationServices.listByResourceGroup,
  "CommunicationServices"
);
@@clientLocation(CommunicationServices.listBySubscription,
  "CommunicationServices"
);
@@clientLocation(CommunicationServices.linkNotificationHub,
  "CommunicationServices"
);
@@clientName(CommunicationServices.linkNotificationHub::parameters.body,
  "linkNotificationHubParameters"
);
@@clientLocation(CommunicationServices.listKeys, "CommunicationServices");
@@clientLocation(CommunicationServices.regenerateKey, "CommunicationServices");
@@clientName(CommunicationServices.regenerateKey::parameters.body,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CommunicationServiceResource.properties);

@@clientLocation(Domains.get, "Domains");
@@clientLocation(Domains.createOrUpdate, "Domains");
@@clientName(Domains.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Domains.update, "Domains");
@@clientName(Domains.update::parameters.properties, "parameters");
@@clientLocation(Domains.delete, "Domains");
@@clientLocation(Domains.listByEmailServiceResource, "Domains");
@@clientLocation(Domains.initiateVerification, "Domains");
@@clientName(Domains.initiateVerification::parameters.body, "parameters");
@@clientLocation(Domains.cancelVerification, "Domains");
@@clientName(Domains.cancelVerification::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DomainResource.properties);

@@clientLocation(EmailServices.get, "EmailServices");
@@clientLocation(EmailServices.createOrUpdate, "EmailServices");
@@clientName(EmailServices.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(EmailServices.update, "EmailServices");
@@clientName(EmailServices.update::parameters.properties, "parameters");
@@clientLocation(EmailServices.delete, "EmailServices");
@@clientLocation(EmailServices.listByResourceGroup, "EmailServices");
@@clientLocation(EmailServices.listBySubscription, "EmailServices");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(EmailServiceResource.properties);

@@clientLocation(SenderUsernames.get, "SenderUsernames");
@@clientLocation(SenderUsernames.createOrUpdate, "SenderUsernames");
@@clientName(SenderUsernames.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(SenderUsernames.delete, "SenderUsernames");
@@clientLocation(SenderUsernames.listByDomains, "SenderUsernames");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SenderUsernameResource.properties);

@@clientName(CommunicationServices.checkNameAvailability::parameters.body,
  "nameAvailabilityParameters"
);
