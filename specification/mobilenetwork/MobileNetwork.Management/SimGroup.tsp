import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
/**
 * SIM group resource.
 */
model SimGroup
  is Azure.ResourceManager.TrackedResource<SimGroupPropertiesFormat, false> {
  ...ResourceNameParameter<
    Resource = SimGroup,
    KeyName = "simGroupName",
    SegmentName = "simGroups",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]*$"
  >;

  /**
   * The identity used to retrieve the encryption key from Azure key vault.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ManagedServiceIdentity;
}

@armResourceOperations
interface SimGroups {
  /**
   * Gets information about the specified SIM group.
   */
  get is ArmResourceRead<SimGroup>;

  /**
   * Creates or updates a SIM group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SimGroup>;

  /**
   * Patch SIM group resource.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    SimGroup,
    PatchModel = IdentityAndTagsObject
  >;

  /**
   * Deletes the specified SIM group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    SimGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all the SIM groups in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<SimGroup>;

  /**
   * Gets all the SIM groups in a subscription.
   */
  listBySubscription is ArmListBySubscription<SimGroup>;

  /**
   * Bulk upload SIMs to a SIM group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Sims_BulkUpload")
  @action("uploadSims")
  bulkUpload is ArmResourceActionAsync<
    SimGroup,
    SimUploadList,
    ArmResponse<AsyncOperationStatus>
  >;

  /**
   * Bulk delete SIMs from a SIM group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Sims_BulkDelete")
  @action("deleteSims")
  bulkDelete is ArmResourceActionAsync<
    SimGroup,
    SimDeleteList,
    ArmResponse<AsyncOperationStatus> | NoContentResponse
  >;

  /**
   * Bulk upload SIMs in encrypted form to a SIM group. The SIM credentials must be encrypted.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Sims_BulkUploadEncrypted")
  @action("uploadEncryptedSims")
  bulkUploadEncrypted is ArmResourceActionAsync<
    SimGroup,
    EncryptedSimUploadList,
    ArmResponse<AsyncOperationStatus>
  >;

  /**
   * Move SIMs to another SIM Group
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Sims_Move")
  @action("moveSims")
  move is ArmResourceActionAsync<
    SimGroup,
    SimMove,
    ArmResponse<AsyncOperationStatus>
  >;

  /**
   * Clone SIMs to another SIM Group
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Sims_Clone")
  @action("cloneSims")
  clone is ArmResourceActionAsync<
    SimGroup,
    SimClone,
    ArmResponse<AsyncOperationStatus>
  >;
}

@@maxLength(SimGroup.name, 64);
@@doc(SimGroup.name, "The name of the SIM Group.");
@@doc(SimGroup.properties, "SIM group Properties.");
@@doc(SimGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update SIM group operation."
);
@@doc(SimGroups.updateTags::parameters.properties,
  "Parameters supplied to patch SIM group resource."
);
@@doc(SimGroups.bulkUpload::parameters.body,
  "Parameters supplied to the bulk SIM upload operation."
);
@@doc(SimGroups.bulkDelete::parameters.body,
  "Parameters supplied to the bulk SIM delete operation."
);
@@doc(SimGroups.bulkUploadEncrypted::parameters.body,
  "Parameters supplied to the encrypted SIMs upload operation."
);
@@doc(SimGroups.move::parameters.body, "Parameters supplied to move the SIMs.");
@@doc(SimGroups.clone::parameters.body,
  "Parameters supplied to clone the SIMs."
);
