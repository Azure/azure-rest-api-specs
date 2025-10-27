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
 * Confidential Ledger. Contains the properties of Confidential Ledger Resource.
 */
model ConfidentialLedger
  is Azure.ResourceManager.TrackedResource<LedgerProperties> {
  ...ResourceNameParameter<
    Resource = ConfidentialLedger,
    KeyName = "ledgerName",
    SegmentName = "ledgers",
    NamePattern = "^[^-0-9][A-Za-z0-9-]{1,33}[A-Za-z0-9]$"
  >;
}

@armResourceOperations
interface ConfidentialLedgers {
  /**
   * Retrieves the properties of a Confidential Ledger.
   */
  get is ArmResourceRead<ConfidentialLedger>;

  /**
   * Creates a  Confidential Ledger with the specified ledger parameters.
   */
  create is ArmResourceCreateOrReplaceAsync<ConfidentialLedger>;

  /**
   * Updates properties of Confidential Ledger
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ConfidentialLedger,
    PatchModel = ConfidentialLedger,
    Response = ArmResponse<ConfidentialLedger> | (CreatedResponse &
      ArmLroLocationHeader<FinalResult = ConfidentialLedger>)
  >;

  /**
   * Deletes an existing Confidential Ledger.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ConfidentialLedger,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Retrieves the properties of all Confidential Ledgers.
   */
  listByResourceGroup is ArmResourceListByParent<
    ConfidentialLedger,
    Parameters = {
      /**
       * The filter to apply on the list operation. eg. $filter=ledgerType eq 'Public'
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<ConfidentialLedgerList>
  >;

  /**
   * Retrieves the properties of all Confidential Ledgers.
   */
  listBySubscription is ArmListBySubscription<
    ConfidentialLedger,
    Parameters = {
      /**
       * The filter to apply on the list operation. eg. $filter=ledgerType eq 'Public'
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<ConfidentialLedgerList>
  >;

  /**
   * Backs up a Confidential Ledger Resource.
   */
  backup is ArmResourceActionAsync<
    ConfidentialLedger,
    ConfidentialLedgerBackup,
    ConfidentialLedgerBackupResponse
  >;

  /**
   * Restores a Confidential Ledger Resource.
   */
  restore is ArmResourceActionAsync<
    ConfidentialLedger,
    ConfidentialLedgerRestore,
    ConfidentialLedgerRestoreResponse
  >;
}

@@doc(ConfidentialLedger.name, "Name of the Confidential Ledger");
@@doc(ConfidentialLedger.properties,
  "Properties of Confidential Ledger Resource."
);
@@doc(ConfidentialLedgers.create::parameters.resource,
  "Confidential Ledger Create Request Body"
);
@@doc(ConfidentialLedgers.update::parameters.properties,
  "Confidential Ledger request body for Updating Ledger"
);
@@doc(ConfidentialLedgers.backup::parameters.body,
  "Confidential Ledger Backup Request Body"
);
@@doc(ConfidentialLedgers.restore::parameters.body,
  "Confidential Ledger Restore Request Body"
);
