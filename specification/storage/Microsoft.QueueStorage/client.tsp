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
  },
  "rust"
);

@@clientInitialization(QueueClient,
  {
    initializedBy: InitializedBy.customizeCode,
  },
  "rust"
);

@@clientNamespace(Storage.Queues, "Azure.Storage.Queues");
@@clientNamespace(Storage.Queues.Service, "Azure.Storage.Queues");
@@clientNamespace(Storage.Queues.Queue, "Azure.Storage.Queues");

@@clientName(Storage.Queues.MetadataHeaders.metadata, "metadata", "rust");

@@scope(Storage.Queues.Service.getUserDelegationKey, "!rust");

@@alternateType(Storage.Queues.ListOfSentMessage,
  Storage.Queues.SentMessage,
  "rust"
);
// TODO: follow up why these don't preserve ListOfSentMessage as pub(crate)
@@access(Storage.Queues.ListOfSentMessage, Access.internal);
@@usage(Storage.Queues.ListOfSentMessage, Usage.output | Usage.xml);
