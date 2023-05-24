import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "./common.tsp";

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
namespace Transactions;

@doc("Possible states for a CCF transaction. See docs for details: https://microsoft.github.io/CCF/main/use_apps/verify_tx.html#checking-for-commit")
enum TransactionStatus {
  Unknown,
  Pending,
  Committed,
  Invalid,
}

@doc("Description of a transaction's current state.")
@TypeSpec.Rest.resource("transactions")
model Transaction {
  @doc("Status of this transaction.")
  status: TransactionStatus;

  @doc("Identifier of the requested transaction.")
  @visibility("read")
  @key
  transactionId: transactionId;
}

@doc("Description of the latest committed transaction on the service.")
model CommitInfo {
  @doc("Identifier of latest committed transaction.")
  @visibility("read")
  transactionId: transactionId;
}

interface Transactions {
  @doc("Get status of transaction by transaction ID, to determine whether it has committed.")
  @TypeSpec.Rest.action("status")
  @TypeSpec.Rest.actionSeparator("/")
  @TypeSpec.Http.get
  getTransactionStatus is Azure.Core.StandardResourceOperations.ResourceAction<
    Transaction,
    {},
    Transaction
  >;

  @doc("Get latest committed transaction.")
  @TypeSpec.Rest.action("commit")
  @TypeSpec.Rest.actionSeparator("/")
  @TypeSpec.Http.get
  getCommit is Azure.Core.StandardResourceOperations.ResourceCollectionAction<
    Transaction,
    {},
    Transaction
  >;

  // To add:
  // - /transactions/{transactionId}/receipt (Long-running)
}
