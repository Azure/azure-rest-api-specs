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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: AmlFilesystemIdentity;

  /**
   * SKU for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: SkuName;

  ...Azure.ResourceManager.AvailabilityZonesProperty;
}
@@visibility(AmlFilesystem.zones, Lifecycle.Read, Lifecycle.Create);

@armResourceOperations(#{ omitTags: true })
interface AmlFilesystems {
  /**
   * Returns an AML file system.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("amlFilesystems_Get")
  @tag("amlFilesystems")
  get is ArmResourceRead<AmlFilesystem, Error = CloudError>;

  /**
   * Create or update an AML file system.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("amlFilesystems_CreateOrUpdate")
  @tag("amlFilesystems")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AmlFilesystem,
    Error = CloudError
  >;

  /**
   * Update an AML file system instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @operationId("amlFilesystems_Update")
  @tag("amlFilesystems")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AmlFilesystem,
    PatchModel = AmlFilesystemUpdate,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = AmlFilesystem> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Schedules an AML file system for deletion.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("amlFilesystems_Delete")
  @tag("amlFilesystems")
  delete is ArmResourceDeleteWithoutOkAsync<
    AmlFilesystem,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = AmlFilesystem> &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Returns all AML file systems the user has access to under a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("amlFilesystems_ListByResourceGroup")
  @tag("amlFilesystems")
  listByResourceGroup is ArmResourceListByParent<
    AmlFilesystem,
    Response = ArmResponse<AmlFilesystemsListResult>,
    Error = CloudError
  >;

  /**
   * Returns all AML file systems the user has access to under a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("amlFilesystems_List")
  @tag("amlFilesystems")
  list is ArmListBySubscription<
    AmlFilesystem,
    Response = ArmResponse<AmlFilesystemsListResult>,
    Error = CloudError
  >;

  /**
   * Archive data from the AML file system.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("amlFilesystems_Archive")
  @tag("amlFilesystems")
  archive is ArmResourceActionSync<
    AmlFilesystem,
    AmlFilesystemArchiveInfo,
    OkResponse,
    OptionalRequestBody = true,
    Error = CloudError
  >;

  /**
   * Cancel archiving data from the AML file system.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("amlFilesystems_CancelArchive")
  @tag("amlFilesystems")
  cancelArchive is ArmResourceActionSync<
    AmlFilesystem,
    void,
    OkResponse,
    Error = CloudError
  >;
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
