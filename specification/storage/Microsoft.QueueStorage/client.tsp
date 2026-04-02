import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using Azure.ClientGenerator.Core;
using Storage.Queues;

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
@@clientName(Storage.Queues.SentMessage, "SentMessageInternal", "rust");

@@alternateType(Storage.Queues.ListOfSentMessage,
  {
    identity: "crate::models::SentMessage",
  },
  "rust"
);

@@scope(Storage.Queues.Service.getUserDelegationKey, "!rust");

/** ----- This section overrides the setAccessPolicy operation for Rust to require the queueAcl body ----- */
/** sets the permissions for the specified queue. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
@put
@route("?comp=acl")
op setAccessPolicyRequiredQueueAcl is StorageOperationNoBody<
  {
    /** The media type of the requestbody */
    @header("Content-Type")
    contentType?: "application/xml";

    ...TimeoutParameter;

    /** The access control list for the queue. */
    #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Existing API"
    @bodyRoot
    queueAcl: SignedIdentifiers;
  },
  {
    @statusCode statusCode: 204;
  }
>;

@@override(Queue.setAccessPolicy, setAccessPolicyRequiredQueueAcl, "rust");

/** ----- This section overrides the setMetadata operations for Rust to require the metadata headers ----- */
alias MetadataHeadersRequired = {
  /** The metadata headers. */
  @alternateType(Record<string>, "rust")
  @header("x-ms-meta")
  metadata: string;
};

/** Operation sets one or more user-defined name-value pairs for the specified queue. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
@put
@route("?comp=metadata")
op setMetadataRequiredMetadataQueue is StorageOperationNoBody<
  {
    ...TimeoutParameter;
    ...MetadataHeadersRequired;
  },
  {
    @statusCode statusCode: 204;
  }
>;

@@override(Queue.setMetadata, setMetadataRequiredMetadataQueue, "rust");
