import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "./common.tsp";

@TypeSpec.Http.route("/gov/service")
namespace Microsoft.ManagedCcf.Transactions;

@doc("Possible states for a CCF transaction. See docs for details: https://microsoft.github.io/CCF/main/use_apps/verify_tx.html#checking-for-commit")
enum TransactionStatus {
  @doc("This is not a transaction the current node knows, but could exist in future. This may be returned when a transaction is created on one node then immediately queried on another, before it has been replicated.")
  Unknown,

  @doc("This transaction is known on the current node, but has not yet been committed. This is expected to be a temporary state.")
  Pending,
  
  @doc("This transaction is known on the current node, and known to be committed. This means it has been replicated to a quorum of nodes, so will persist through future elections. Committed is a terminal state of this state machine.")
  Committed,

  @doc("This transaction ID will never commit in the current service, because it contains a different term than a known transaction with the same sequence number. This can occur for a transaction ID returned from the service (ie - which was previously Unknown or Pending), if that transaction is lost during a consensus election. This should be rare. Invalid is a terminal state of this state machine.")
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
