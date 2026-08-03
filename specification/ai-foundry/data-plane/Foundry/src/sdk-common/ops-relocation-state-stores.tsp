using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects.Beta {
  interface StateStores {}
  @@clientLocation(Azure.AI.Projects.StateStores.createStateStore, StateStores);
  @@clientLocation(Azure.AI.Projects.StateStores.listStateStores, StateStores);
  @@clientLocation(Azure.AI.Projects.StateStores.getStateStore, StateStores);
  @@clientLocation(Azure.AI.Projects.StateStores.updateStateStore, StateStores);
  @@clientLocation(Azure.AI.Projects.StateStores.deleteStateStore, StateStores);
  @@clientLocation(
    Azure.AI.Projects.StateStores.createStateStoreItem,
    StateStores
  );
  @@clientLocation(
    Azure.AI.Projects.StateStores.listStateStoreItemKeys,
    StateStores
  );
  @@clientLocation(
    Azure.AI.Projects.StateStores.putStateStoreItem,
    StateStores
  );
  @@clientLocation(
    Azure.AI.Projects.StateStores.getStateStoreItem,
    StateStores
  );
  @@clientLocation(
    Azure.AI.Projects.StateStores.deleteStateStoreItem,
    StateStores
  );
}
