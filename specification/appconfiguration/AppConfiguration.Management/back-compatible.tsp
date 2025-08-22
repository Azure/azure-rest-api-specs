import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AppConfiguration;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnectionReference.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ConfigurationStoreUpdateParameters.properties);

@@clientName(ConfigurationStores.create::parameters.resource,
  "configStoreCreationParameters"
);
@@clientName(ConfigurationStores.update::parameters.properties,
  "configStoreUpdateParameters"
);
@@clientName(ConfigurationStores.regenerateKey::parameters.body,
  "regenerateKeyParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ConfigurationStore.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "privateEndpointConnection"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

@@clientName(KeyValues.createOrUpdate::parameters.resource,
  "keyValueParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(KeyValue.properties);

@@clientLocation(DeletedConfigurationStores.getDeleted, ConfigurationStores);
@@clientLocation(DeletedConfigurationStores.purgeDeleted, ConfigurationStores);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DeletedConfigurationStore.properties);

@@clientName(Replicas.create::parameters.resource, "replicaCreationParameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Replica.properties);

@@clientName(Snapshots.create::parameters.resource, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Snapshot.properties);

@@clientLocation(ConfigurationStoresOperationGroup.listDeleted,
  ConfigurationStores
);

@@clientLocation(OperationsOperationGroup.checkNameAvailability, "Operations");
@@clientLocation(OperationsOperationGroup.regionalCheckNameAvailability,
  "Operations"
);
