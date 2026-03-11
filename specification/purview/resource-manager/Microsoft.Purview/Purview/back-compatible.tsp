import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Purview;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AccountUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Operation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Consent.properties);

@@clientName(Accounts.createOrUpdate::parameters.resource, "account");
@@clientName(Accounts.update::parameters.properties, "accountUpdateParameters");
@@clientName(Accounts.addRootCollectionAdmin::parameters.body,
  "collectionAdminUpdate"
);
@@clientLocation(Accounts.accountGet, "Features");
@@clientName(Accounts.accountGet::parameters.body, "featureRequest");
@@clientLocation(Accounts.list, "IngestionPrivateEndpointConnections");
@@clientLocation(Accounts.updateStatus, "IngestionPrivateEndpointConnections");
@@clientName(Accounts.updateStatus::parameters.body, "request");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Account.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "request"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateEndpointConnection.properties);

@@clientName(KafkaConfigurations.createOrUpdate::parameters.resource,
  "kafkaConfiguration"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(KafkaConfiguration.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateLinkResource.properties);

@@clientLocation(AccountsOperationGroup.checkNameAvailability, Accounts);

@@clientLocation(DefaultAccountsOperationGroup.get, "DefaultAccounts");
@@clientLocation(DefaultAccountsOperationGroup.remove, "DefaultAccounts");
@@clientLocation(DefaultAccountsOperationGroup.set, "DefaultAccounts");

@@clientLocation(FeaturesOperationGroup.subscriptionGet, "Features");

@@clientLocation(UsagesOperationGroup.get, "Usages");
@@clientName(DefaultAccountsOperationGroup.set::parameters.body,
  "defaultAccountPayload"
);
@@clientName(AccountsOperationGroup.checkNameAvailability::parameters.body,
  "checkNameAvailabilityRequest"
);
@@clientName(FeaturesOperationGroup.subscriptionGet::parameters.body,
  "featureRequest"
);
