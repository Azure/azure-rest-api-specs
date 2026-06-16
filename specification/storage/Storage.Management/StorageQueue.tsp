import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./QueueServiceProperties.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Storage;

@parentResource(QueueServiceProperties)
model StorageQueue is Azure.ResourceManager.ProxyResource<QueueProperties> {
  ...ResourceNameParameter<
    Resource = StorageQueue,
    KeyName = "queueName",
    SegmentName = "queues",
    NamePattern = "^[a-z0-9]([a-z0-9]|(-(?!-))){1,61}[a-z0-9]$"
  >;
}

@armResourceOperations
interface StorageQueues {
  /**
   * Gets the queue with the specified queue name, under the specified account if it exists.
   */
  get is ArmResourceRead<StorageQueue, Error = CloudError>;

  /**
   * Creates a new queue with the specified queue name, under the specified account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is ArmResourceCreateOrReplaceSync<
    StorageQueue,
    Response = ArmResourceUpdatedResponse<StorageQueue>,
    Error = CloudError
  >;

  /**
   * Creates a new queue with the specified queue name, under the specified account.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    StorageQueue,
    PatchModel = StorageQueue,
    Error = CloudError
  >;

  /**
   * Deletes the queue with the specified queue name, under the specified account if it exists.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteSync<
    StorageQueue,
    Response = ArmDeletedNoContentResponse,
    Error = CloudError
  >;
}

@@maxLength(StorageQueue.name, 63);
@@minLength(StorageQueue.name, 3);
@@doc(StorageQueue.name,
  "A queue name must be unique within a storage account and must be between 3 and 63 characters.The name must comprise of lowercase alphanumeric and dash(-) characters only, it should begin and end with an alphanumeric character and it cannot have two consecutive dash(-) characters."
);
@@doc(StorageQueue.properties, "Queue resource properties.");
@@doc(StorageQueues.create::parameters.resource,
  "Queue properties and metadata to be created with"
);
@@doc(StorageQueues.update::parameters.properties,
  "Queue properties and metadata to be created with"
);
