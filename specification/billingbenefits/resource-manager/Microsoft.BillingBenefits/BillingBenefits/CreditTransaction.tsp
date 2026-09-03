import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Credit.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.BillingBenefits;

/**
 * Transaction resource definition for Credits
 */
@parentResource(Credit)
model CreditTransaction
  is Azure.ResourceManager.ProxyResource<TransactionProperties> {
  ...ResourceNameParameter<
    Resource = CreditTransaction,
    KeyName = "transactionName",
    SegmentName = "transactions",
    NamePattern = "^[a-zA-Z0-9_\\-\\.]+$"
  >;
}

@armResourceOperations
interface CreditTransactions {
  /**
   * Get a specific transaction for a credit.
   */
  get is ArmResourceRead<CreditTransaction>;

  /**
   * List all transactions for a credit.
   */
  listByParent is ArmResourceListByParent<
    CreditTransaction,
    Response = ArmResponse<TransactionsList>
  >;
}

@@doc(CreditTransaction.name, "Name of the transaction");
@@doc(CreditTransaction.properties, "Transaction properties");
