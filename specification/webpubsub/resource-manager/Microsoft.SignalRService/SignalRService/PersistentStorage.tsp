import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./WebPubSubResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.SignalRService;
/**
 * A persistent storage
 */
@parentResource(WebPubSubResource)
model PersistentStorage
  is Azure.ResourceManager.ProxyResource<PersistentStorageProperties, false> {
  ...ResourceNameParameter<
    Resource = PersistentStorage,
    KeyName = "name",
    SegmentName = "persistentStorages",
    NamePattern = ""
  >;
}

/**
 * Persistent storages list
 */
model PersistentStorageList is Azure.Core.Page<PersistentStorage>;

/**
 * Properties of a persistent storage.
 */
model PersistentStorageProperties {
  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Reference to the storage account to be used for persistent storage.
   */
  storageAccount: ResourceReference;
}

@armResourceOperations
@added(Versions.v2025_12_01_preview)
interface PersistentStorages {
  /**
   * Get a persistent storage.
   */
  get is ArmResourceRead<PersistentStorage>;

  /**
   * Create or update a persistent storage.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    PersistentStorage,
    Response = ArmResourceCreatedResponse<
      PersistentStorage,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = PersistentStorage>
    > | ErrorResponse
  >;

  /**
   * Delete a persistent storage.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    PersistentStorage,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
      | ErrorResponse
  >;

  /**
   * List all persistent storages.
   */
  list is ArmResourceListByParent<
    PersistentStorage,
    Response = ArmResponse<PersistentStorageList>
  >;
}

@@doc(PersistentStorage.name, "Persistent storage name.");
@@doc(PersistentStorage.properties, "Properties of a persistent storage.");
@@doc(PersistentStorages.createOrUpdate::parameters.resource, "");
