import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AppConfiguration;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateEndpointConnectionReference.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ConfigurationStoreUpdateParameters.properties
);

@@clientName(ConfigurationStores.create::parameters.resource,
  "configStoreCreationParameters"
);
@@clientName(ConfigurationStores.update::parameters.properties,
  "configStoreUpdateParameters"
);
@@clientName(ConfigurationStores.regenerateKey::parameters.body,
  "regenerateKeyParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ConfigurationStore.properties
);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "privateEndpointConnection"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateEndpointConnection.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateLinkResource.properties
);

@@clientName(KeyValues.createOrUpdate::parameters.resource,
  "keyValueParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(KeyValue.properties);

@@clientLocation(DeletedConfigurationStores.getDeleted, ConfigurationStores);
@@clientLocation(DeletedConfigurationStores.purgeDeleted, ConfigurationStores);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DeletedConfigurationStore.properties
);

@@clientName(Replicas.create::parameters.resource, "replicaCreationParameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Replica.properties);

@@clientName(Snapshots.create::parameters.resource, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Snapshot.properties);

@@clientLocation(ConfigurationStoresOperationGroup.listDeleted,
  ConfigurationStores
);

@@clientLocation(OperationsOperationGroup.checkNameAvailability, Operations);
@@clientLocation(OperationsOperationGroup.regionalCheckNameAvailability,
  Operations
);

@@clientName(OperationsOperationGroup.checkNameAvailability::parameters.body,
  "checkNameAvailabilityParameters"
);
@@clientName(OperationsOperationGroup.regionalCheckNameAvailability::parameters.body,
  "checkNameAvailabilityParameters"
);
