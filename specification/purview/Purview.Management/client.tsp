import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Purview;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AccountUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Consent.properties);

@@clientName(Accounts.createOrUpdate::parameters.resource, "account");
@@clientName(Accounts.update::parameters.properties, "accountUpdateParameters");
@@clientName(Accounts.addRootCollectionAdmin::parameters.body,
  "collectionAdminUpdate"
);
@@clientName(Accounts.accountGet::parameters.body, "featureRequest");
@@clientName(Accounts.updateStatus::parameters.body, "request");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Account.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "request"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientName(KafkaConfigurations.createOrUpdate::parameters.resource,
  "kafkaConfiguration"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(KafkaConfiguration.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);
