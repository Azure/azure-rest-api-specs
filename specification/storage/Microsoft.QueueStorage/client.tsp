import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Customizations;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@client(
  {
    service: Storage.Queues,
  },
  "rust"
)
interface QueueServiceClient extends Storage.Queues.Service {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@client(
  {
    service: Storage.Queues,
  },
  "rust"
)
interface QueueClient extends Storage.Queues.Queue {}

@@clientInitialization(QueueServiceClient,
  {
    initializedBy: InitializedBy.customizeCode,
  }
);

@@clientInitialization(QueueClient,
  {
    initializedBy: InitializedBy.customizeCode,
  }
);

@@clientNamespace(Storage.Queues, "Azure.Storage.Queues");
@@clientNamespace(Storage.Queues.Service, "Azure.Storage.Queues");
@@clientNamespace(Storage.Queues.Queue, "Azure.Storage.Queues");

@@clientName(Storage.Queues.MetadataHeaders.metadata, "metadata", "rust");

@@clientName(Storage.Queues.Queue.sendMessage, "sendMessageInternal", "rust");

@@scope(Storage.Queues.Service.getUserDelegationKey, "!rust");
