import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Storage resource payload.
 */
@parentResource(ServiceResource)
model StorageResource
  is Azure.ResourceManager.ProxyResource<StorageProperties> {
  ...ResourceNameParameter<
    Resource = StorageResource,
    KeyName = "storageName",
    SegmentName = "storages",
    NamePattern = ""
  >;
}

@armResourceOperations
interface StorageResources {
  /**
   * Get the storage resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Storages_Get")
  get is ArmResourceRead<StorageResource>;

  /**
   * Create or update storage resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("Storages_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    StorageResource,
    Response = ArmResourceUpdatedResponse<StorageResource> | ArmResourceCreatedResponse<
      StorageResource,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: StorageResource;
    })
  >;

  /**
   * Delete the storage resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Storages_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    StorageResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all the storages of one Azure Spring Apps resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Storages_List")
  list is ArmResourceListByParent<
    StorageResource,
    Response = ArmResponse<StorageResourceCollection>
  >;
}

@@doc(StorageResource.name, "The name of the storage resource.");
@@doc(StorageResource.properties,
  "Properties of the storage resource payload."
);
@@doc(StorageResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
