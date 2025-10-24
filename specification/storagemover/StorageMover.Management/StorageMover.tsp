import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageMover;
/**
 * The Storage Mover resource, which is a container for a group of Agents, Projects, and Endpoints.
 */
model StorageMover
  is Azure.ResourceManager.TrackedResource<StorageMoverProperties> {
  ...ResourceNameParameter<
    Resource = StorageMover,
    KeyName = "storageMoverName",
    SegmentName = "storageMovers",
    NamePattern = ""
  >;
}

@armResourceOperations
interface StorageMovers {
  /**
   * Gets a Storage Mover resource.
   */
  get is ArmResourceRead<StorageMover>;

  /**
   * Creates or updates a top-level Storage Mover resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    StorageMover,
    Response = ArmResourceUpdatedResponse<StorageMover>
  >;

  /**
   * Updates properties for a Storage Mover resource. Properties not specified in the request body will be unchanged.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    StorageMover,
    PatchModel = StorageMoverUpdateParameters
  >;

  /**
   * Deletes a Storage Mover resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    StorageMover,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all Storage Movers in a resource group.
   */
  list is ArmResourceListByParent<
    StorageMover,
    Response = ArmResponse<StorageMoverList>
  >;

  /**
   * Lists all Storage Movers in a subscription.
   */
  listBySubscription is ArmListBySubscription<
    StorageMover,
    Response = ArmResponse<StorageMoverList>
  >;
}

@@doc(StorageMover.name, "The name of the Storage Mover resource.");
@@doc(StorageMover.properties,
  "The resource specific properties for the Storage Mover resource."
);
@@doc(StorageMovers.createOrUpdate::parameters.resource, "");
@@doc(StorageMovers.update::parameters.properties, "");
