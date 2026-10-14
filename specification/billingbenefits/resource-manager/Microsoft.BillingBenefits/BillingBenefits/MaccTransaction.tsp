import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Macc.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.BillingBenefits;

/**
 * Transaction resource definition for Maccs
 */
@parentResource(Macc)
model MaccTransaction
  is Azure.ResourceManager.ProxyResource<TransactionProperties> {
  ...ResourceNameParameter<
    Resource = MaccTransaction,
    KeyName = "transactionName",
    SegmentName = "transactions",
    NamePattern = "^[a-zA-Z0-9_\\-\\.]+$"
  >;
}

@armResourceOperations
interface MaccTransactions {
  /**
   * Get a specific transaction for a MACC.
   */
  get is ArmResourceRead<MaccTransaction>;

  /**
   * List all transactions for a MACC.
   */
  listByParent is ArmResourceListByParent<
    MaccTransaction,
    Response = ArmResponse<MaccTransactionsList>
  >;
}

@@doc(MaccTransaction.name, "Name of the transaction");
@@doc(MaccTransaction.properties, "Transaction properties");
