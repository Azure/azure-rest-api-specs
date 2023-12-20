import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ConfidentialLedger;
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
  @doc("Retrieves the properties of a Confidential Ledger.")
  get is ArmResourceRead<ConfidentialLedger>;
  @doc("Creates a  Confidential Ledger with the specified ledger parameters.")
  create is ArmResourceCreateOrUpdateAsync<ConfidentialLedger>;
  @doc("Updates properties of Confidential Ledger")
  update is ArmResourcePatchAsync<ConfidentialLedger, LedgerProperties>;
  @doc("Deletes an existing Confidential Ledger.")
  delete is ArmResourceDeleteAsync<ConfidentialLedger>;
  @doc("Retrieves the properties of all Confidential Ledgers.")
  listByResourceGroup is ArmResourceListByParent<
    ConfidentialLedger,
    {
      ...BaseParameters<ConfidentialLedger>;

      @doc("The filter to apply on the list operation. eg. $filter=ledgerType eq 'Public'")
      @query("$filter")
      $filter?: string;
    }
  >;
  @doc("Retrieves the properties of all Confidential Ledgers.")
  listBySubscription is ArmListBySubscription<ConfidentialLedger>;
}
