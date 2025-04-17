import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "./common.tsp";

@TypeSpec.Http.route("/gov/service")
namespace Microsoft.ManagedCcf.Transactions;

@doc("Possible states for a CCF transaction. See docs for details: https://microsoft.github.io/CCF/main/use_apps/verify_tx.html#checking-for-commit")
union TransactionStatus {
  string,

  @doc("This is not a transaction the current node knows, but could exist in future. This may be returned when a transaction is created on one node then immediately queried on another, before it has been replicated.")
  "Unknown",

  @doc("This transaction is known on the current node, but has not yet been committed. This is expected to be a temporary state.")
  "Pending",

  @doc("This transaction is known on the current node, and known to be committed. This means it has been replicated to a quorum of nodes, so will persist through future elections. Committed is a terminal state of this state machine.")
  "Committed",

  @doc("This transaction ID will never commit in the current service, because it contains a different term than a known transaction with the same sequence number. This can occur for a transaction ID returned from the service (ie - which was previously Unknown or Pending), if that transaction is lost during a consensus election. This should be rare. Invalid is a terminal state of this state machine.")
  "Invalid",
}

@doc("Common transaction information.")
model Transaction {
  @doc("Status of this transaction.")
  status: TransactionStatus;
}

@doc("Description of a named transaction's current state.")
@TypeSpec.Rest.resource("transactions")
model NamedTransaction {
  @doc("Identifier of the requested transaction.")
  @visibility(Lifecycle.Query)
  @key
  transactionId: transactionId;

  ...Transaction;
}

@doc("Description of latest committed transaction.")
@TypeSpec.Rest.resource("transactions")
model CommittedTransaction {
  @doc("Singleton key for accessing commit.")
  @visibility(Lifecycle.Query)
  @key
  id: "commit";

  @doc("Identifier of committed transaction.")
  transactionId: transactionId;

  ...Transaction;
}

interface Transactions {
  @doc("Get status of transaction by transaction ID, to determine whether it has committed.")
  get is Azure.Core.StandardResourceOperations.ResourceRead<NamedTransaction>;

  @doc("Get latest committed transaction.")
  getCommit is Azure.Core.StandardResourceOperations.ResourceRead<CommittedTransaction>;

  // To add:
  // - /transactions/{transactionId}/receipt (Long-running)
}
