import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Base class for backup ProtectionIntent.
 */
@parentResource(BackupFabricResource)
model ProtectionIntentResource
  is Azure.ResourceManager.TrackedResource<ProtectionIntent> {
  ...ResourceNameParameter<
    Resource = ProtectionIntentResource,
    KeyName = "intentObjectName",
    SegmentName = "backupProtectionIntent",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ProtectionIntentResources {
  /**
   * Provides the details of the protection intent up item. This is an asynchronous operation. To know the status of the operation,
   * call the GetItemOperationResult API.
   */
  get is ArmResourceRead<ProtectionIntentResource>;

  /**
   * Create Intent for Enabling backup of an item. This is a synchronous operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ProtectionIntentResource,
    Response = ArmResourceUpdatedResponse<ProtectionIntentResource>
  >;

  /**
   * Used to remove intent from an item
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteSync<
    ProtectionIntentResource,
    Response = ArmDeletedNoContentResponse
  >;
}

@@doc(ProtectionIntentResource.name,
  "Backed up item name whose details are to be fetched."
);
@@doc(ProtectionIntentResource.properties,
  "ProtectionIntentResource properties"
);
@@doc(ProtectionIntentResources.createOrUpdate::parameters.resource,
  "resource backed up item"
);
