import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ConditionalCredit.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.BillingBenefits;

/**
 * Transaction resource definition for ConditionalCredits
 */
@parentResource(ConditionalCredit)
model ConditionalCreditTransaction
  is Azure.ResourceManager.ProxyResource<TransactionProperties> {
  ...ResourceNameParameter<
    Resource = ConditionalCreditTransaction,
    KeyName = "transactionName",
    SegmentName = "transactions",
    NamePattern = "^[a-zA-Z0-9_\\-\\.]+$"
  >;
}

@armResourceOperations
interface ConditionalCreditTransactions {
  /**
   * Get a specific transaction for a conditional credit.
   */
  get is ArmResourceRead<ConditionalCreditTransaction>;

  /**
   * List all transactions for a conditional credit.
   */
  listByParent is ArmResourceListByParent<
    ConditionalCreditTransaction,
    Response = ArmResponse<ConditionalCreditTransactionsList>
  >;
}

@@doc(ConditionalCreditTransaction.name, "Name of the transaction");
@@doc(ConditionalCreditTransaction.properties, "Transaction properties");
