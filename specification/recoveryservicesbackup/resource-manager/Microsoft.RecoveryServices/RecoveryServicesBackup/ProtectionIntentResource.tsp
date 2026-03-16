import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Legacy;

namespace Microsoft.RecoveryServices;
/**
 * Base class for backup ProtectionIntent.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy TrackedResourceWithOptionalLocation for back compatibility"
@parentResource(BackupFabricResource)
model ProtectionIntentResource
  is TrackedResourceWithOptionalLocation<ProtectionIntent> {
  ...ResourceNameParameter<
    Resource = ProtectionIntentResource,
    KeyName = "intentObjectName",
    SegmentName = "backupProtectionIntent",
    NamePattern = ""
  >;

  /**
   * Optional ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  eTag?: string;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ProtectionIntentResource,
    Response = ArmResourceUpdatedResponse<ProtectionIntentResource>
  >;

  /**
   * Used to remove intent from an item
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
