import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ConfidentialLedger;
/**
 * Managed CCF. Contains the properties of Managed CCF Resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagedCCF
  is Azure.ResourceManager.TrackedResource<ManagedCCFProperties> {
  ...ResourceNameParameter<
    Resource = ManagedCCF,
    KeyName = "appName",
    SegmentName = "managedCCFs",
    NamePattern = "^[a-zA-Z0-9]"
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface ManagedCCFs {
  /**
   * Retrieves the properties of a Managed CCF app.
   */
  get is ArmResourceRead<ManagedCCF>;

  /**
   * Creates a Managed CCF with the specified Managed CCF parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is ArmResourceCreateOrReplaceAsync<
    ManagedCCF,
    Response = ArmResourceUpdatedResponse<ManagedCCF> | (CreatedResponse &
      ArmAsyncOperationHeader<FinalResult = ManagedCCF>)
  >;

  /**
   * Updates properties of Managed CCF
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<ManagedCCF, PatchModel = ManagedCCF>;

  /**
   * Deletes an existing Managed CCF.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedCCF,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Retrieves the properties of all Managed CCF apps.
   */
  listByResourceGroup is ArmResourceListByParent<
    ManagedCCF,
    Parameters = {
      /**
       * The filter to apply on the list operation. eg. $filter=ledgerType eq 'Public'
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<ManagedCCFList>
  >;

  /**
   * Retrieves the properties of all Managed CCF.
   */
  listBySubscription is ArmListBySubscription<
    ManagedCCF,
    Parameters = {
      /**
       * The filter to apply on the list operation. eg. $filter=ledgerType eq 'Public'
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<ManagedCCFList>
  >;

  /**
   * Backs up a Managed CCF Resource.
   */
  backup is ArmResourceActionAsync<
    ManagedCCF,
    ManagedCCFBackup,
    ManagedCCFBackupResponse
  >;

  /**
   * Restores a Managed CCF Resource.
   */
  restore is ArmResourceActionAsync<
    ManagedCCF,
    ManagedCCFRestore,
    ManagedCCFRestoreResponse
  >;
}

@@doc(ManagedCCF.name, "Name of the Managed CCF");
@@doc(ManagedCCF.properties, "Properties of Managed CCF Resource.");
@@doc(ManagedCCFs.create::parameters.resource,
  "Managed CCF Create Request Body"
);
@@doc(ManagedCCFs.update::parameters.properties,
  "Request body for Updating Managed CCF App"
);
@@doc(ManagedCCFs.backup::parameters.body, "Managed CCF Backup Request Body");
@@doc(ManagedCCFs.restore::parameters.body, "Managed CCF Restore Request Body");
