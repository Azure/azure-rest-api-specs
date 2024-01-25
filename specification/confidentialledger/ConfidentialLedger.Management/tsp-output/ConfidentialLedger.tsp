import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ConfidentialLedger;
/**
 * Confidential Ledger. Contains the properties of Confidential Ledger Resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(LedgerProperties)
model ConfidentialLedger extends TrackedResourceBase {
  /**
   * Name of the Confidential Ledger
   */
  @pattern("^[a-zA-Z0-9]")
  @path
  @key("ledgerName")
  @segment("ledgers")
  @visibility("read")
  name: string;

  /**
   * Properties of Confidential Ledger Resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: LedgerProperties;
}

@armResourceOperations
interface ConfidentialLedgers {
  /**
   * Retrieves the properties of a Confidential Ledger.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Ledger_Get")
  get is ArmResourceRead<ConfidentialLedger>;

  /**
   * Creates a  Confidential Ledger with the specified ledger parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Ledger_Create")
  create is ArmResourceCreateOrReplaceAsync<
    ConfidentialLedger,
    BaseParameters<ConfidentialLedger>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates properties of Confidential Ledger
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Ledger_Update")
  update is ArmCustomPatchAsync<ConfidentialLedger, ConfidentialLedger>;

  /**
   * Deletes an existing Confidential Ledger.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Ledger_Delete")
  delete is ArmResourceDeleteAsync<ConfidentialLedger>;

  /**
   * Retrieves the properties of all Confidential Ledgers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Ledger_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    ConfidentialLedger,
    {
      ...BaseParameters<ConfidentialLedger>;

      /**
       * The filter to apply on the list operation. eg. $filter=ledgerType eq 'Public'
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Retrieves the properties of all Confidential Ledgers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Ledger_ListBySubscription")
  listBySubscription is ArmListBySubscription<ConfidentialLedger>;
}

@@projectedName(ConfidentialLedgers.create::parameters.resource,
  "json",
  "confidentialLedger"
);
@@extension(ConfidentialLedgers.create::parameters.resource,
  "x-ms-client-name",
  "confidentialLedger"
);
@@doc(ConfidentialLedgers.create::parameters.resource,
  "Confidential Ledger Create Request Body"
);
@@projectedName(ConfidentialLedgers.update::parameters.properties,
  "json",
  "confidentialLedger"
);
@@extension(ConfidentialLedgers.update::parameters.properties,
  "x-ms-client-name",
  "confidentialLedger"
);
@@doc(ConfidentialLedgers.update::parameters.properties,
  "Confidential Ledger request body for Updating Ledger"
);
