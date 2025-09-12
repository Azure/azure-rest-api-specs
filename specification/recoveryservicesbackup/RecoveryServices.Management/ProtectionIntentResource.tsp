import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.RecoveryServices;
/**
 * Base class for backup ProtectionIntent.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(BackupFabricResource)
@Azure.ResourceManager.Private.armResourceInternal(ProtectionIntent)
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model ProtectionIntentResource extends Resource {
  ...ResourceNameParameter<
    Resource = ProtectionIntentResource,
    KeyName = "intentObjectName",
    SegmentName = "backupProtectionIntent",
    NamePattern = ""
  >;

  /**
   * ProtectionIntentResource properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: ProtectionIntent;
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
@@doc(ProtectionIntentResources.createOrUpdate::parameters.resource,
  "resource backed up item"
);
