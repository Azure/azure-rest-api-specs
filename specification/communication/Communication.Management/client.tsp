import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Communication;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CommunicationServiceResourceUpdate.properties);

@@clientName(DomainPropertiesVerificationStates.Domain, "domain");
@@clientName(DomainPropertiesVerificationStates.DKIM, "dkim");
@@clientName(DomainPropertiesVerificationStates.DKIM2, "dkim2");
@@clientName(DomainPropertiesVerificationStates.DMARC, "dmarc");

@@clientName(DomainPropertiesVerificationRecords.Domain, "domain");
@@clientName(DomainPropertiesVerificationRecords.DKIM, "dkim");
@@clientName(DomainPropertiesVerificationRecords.DKIM2, "dkim2");
@@clientName(DomainPropertiesVerificationRecords.DMARC, "dmarc");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateDomainRequestParameters.properties);

@@clientName(CommunicationServiceResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(CommunicationServiceResources.update::parameters.properties,
  "parameters"
);
@@clientName(CommunicationServiceResources.regenerateKey::parameters.body,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CommunicationServiceResource.properties);

@@clientName(DomainResources.createOrUpdate::parameters.resource, "parameters");
@@clientName(DomainResources.update::parameters.properties, "parameters");
@@clientName(DomainResources.initiateVerification::parameters.body,
  "parameters"
);
@@clientName(DomainResources.cancelVerification::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DomainResource.properties);

@@clientName(EmailServiceResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(EmailServiceResources.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EmailServiceResource.properties);

@@clientName(SenderUsernameResources.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SenderUsernameResource.properties);

@@clientName(SmtpUsernameResources.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SmtpUsernameResource.properties);

@@clientName(SuppressionListResources.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SuppressionListResource.properties);

@@clientName(SuppressionListAddressResources.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SuppressionListAddressResource.properties);
