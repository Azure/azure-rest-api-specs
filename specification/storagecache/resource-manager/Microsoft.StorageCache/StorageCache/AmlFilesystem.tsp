import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageCache;
/**
 * An AML file system instance. Follows Azure Resource Manager standards: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md
 */
model AmlFilesystem
  is Azure.ResourceManager.TrackedResource<AmlFilesystemProperties> {
  ...ResourceNameParameter<
    Resource = AmlFilesystem,
    KeyName = "amlFilesystemName",
    SegmentName = "amlFilesystems",
    NamePattern = "^[0-9a-zA-Z][-0-9a-zA-Z_]{0,78}[0-9a-zA-Z]$"
  >;

  /**
   * The managed identity used by the AML file system, if configured.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: AmlFilesystemIdentity;

  /**
   * SKU for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: SkuName;

  ...Azure.ResourceManager.AvailabilityZonesProperty;
}

@armResourceOperations
interface AmlFilesystems {
  /**
   * Returns an AML file system.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("amlFilesystems_Get")
  get is ArmResourceRead<AmlFilesystem>;

  /**
   * Create or update an AML file system.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("amlFilesystems_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AmlFilesystem>;

  /**
   * Update an AML file system instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("amlFilesystems_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AmlFilesystem,
    PatchModel = AmlFilesystemUpdate,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = AmlFilesystem> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Schedules an AML file system for deletion.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("amlFilesystems_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    AmlFilesystem,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Returns all AML file systems the user has access to under a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("amlFilesystems_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<AmlFilesystem>;

  /**
   * Returns all AML file systems the user has access to under a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("amlFilesystems_List")
  list is ArmListBySubscription<AmlFilesystem>;

  /**
   * Archive data from the AML file system.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("amlFilesystems_Archive")
  archive is ArmResourceActionSync<
    AmlFilesystem,
    AmlFilesystemArchiveInfo,
    OkResponse,
    OptionalRequestBody = true
  >;

  /**
   * Cancel archiving data from the AML file system.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("amlFilesystems_CancelArchive")
  cancelArchive is ArmResourceActionSync<AmlFilesystem, void, OkResponse>;
}

@@maxLength(AmlFilesystem.name, 80);
@@minLength(AmlFilesystem.name, 2);
@@doc(AmlFilesystem.name,
  "Name for the AML file system. Allows alphanumerics, underscores, and hyphens. Start and end with alphanumeric."
);
@@doc(AmlFilesystem.properties, "Properties of the AML file system.");
@@doc(AmlFilesystems.createOrUpdate::parameters.resource,
  "Object containing the user-selectable properties of the AML file system. If read-only properties are included, they must match the existing values of those properties."
);
@@doc(AmlFilesystems.update::parameters.properties,
  "Object containing the user-selectable properties of the AML file system. If read-only properties are included, they must match the existing values of those properties."
);
@@doc(AmlFilesystems.archive::parameters.body,
  "Information about the archive operation"
);
