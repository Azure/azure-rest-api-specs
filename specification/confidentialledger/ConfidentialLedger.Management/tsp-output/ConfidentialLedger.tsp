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
@doc("Confidential Ledger. Contains the properties of Confidential Ledger Resource.")
model ConfidentialLedger is TrackedResource<LedgerProperties> {
  @doc("Name of the Confidential Ledger")
  @pattern("^[a-zA-Z0-9]")
  @path
  @key("ledgerName")
  @segment("ledgers")
  name: string;
}

@armResourceOperations
interface ConfidentialLedgers {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieves the properties of a Confidential Ledger.")
  @operationId("Ledger_Get")
  get is ArmResourceRead<ConfidentialLedger>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a  Confidential Ledger with the specified ledger parameters.")
  @operationId("Ledger_Create")
  create is ArmResourceCreateOrUpdateAsync<
    ConfidentialLedger,
    BaseParameters<ConfidentialLedger>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates properties of Confidential Ledger")
  @operationId("Ledger_Update")
  update is ArmCustomPatchAsync<ConfidentialLedger, ConfidentialLedger>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes an existing Confidential Ledger.")
  @operationId("Ledger_Delete")
  delete is ArmResourceDeleteAsync<ConfidentialLedger>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieves the properties of all Confidential Ledgers.")
  @operationId("Ledger_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    ConfidentialLedger,
    {
      ...BaseParameters<ConfidentialLedger>;

      @doc("The filter to apply on the list operation. eg. $filter=ledgerType eq 'Public'")
      @query("$filter")
      $filter?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieves the properties of all Confidential Ledgers.")
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
