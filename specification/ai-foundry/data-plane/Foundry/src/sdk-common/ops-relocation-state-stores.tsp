using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects.Beta {
  namespace StateStores {
    model StoreClientOptions {
      /** The logical name of the state store. */
      name?: string;
    }

    interface Store {}
  }

  @@clientLocation(Azure.AI.Projects.StateStores.createStateStore, StateStores);
  @@clientLocation(Azure.AI.Projects.StateStores.listStateStores, StateStores);
  @@clientLocation(
    Azure.AI.Projects.StateStores.getStateStore,
    StateStores.Store
  );
  @@clientLocation(
    Azure.AI.Projects.StateStores.updateStateStore,
    StateStores.Store
  );
  @@clientLocation(
    Azure.AI.Projects.StateStores.deleteStateStore,
    StateStores.Store
  );
  @@clientLocation(
    Azure.AI.Projects.StateStores.createStateStoreItem,
    StateStores.Store
  );
  @@clientLocation(
    Azure.AI.Projects.StateStores.listStateStoreItemKeys,
    StateStores.Store
  );
  @@clientLocation(
    Azure.AI.Projects.StateStores.putStateStoreItem,
    StateStores.Store
  );
  @@clientLocation(
    Azure.AI.Projects.StateStores.getStateStoreItem,
    StateStores.Store
  );
  @@clientLocation(
    Azure.AI.Projects.StateStores.deleteStateStoreItem,
    StateStores.Store
  );

  @@clientInitialization(
    StateStores.Store,
    {
      parameters: StateStores.StoreClientOptions,
      initializedBy: InitializedBy.customizeCode,
    }
  );
}
