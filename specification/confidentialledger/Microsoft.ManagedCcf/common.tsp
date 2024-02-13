import "@typespec/http";
import "@azure-tools/typespec-azure-core";

namespace Microsoft.ManagedCcf;

alias transactionIdHeaderField = "x-ms-ccf-transaction-id";

@doc("Uniquely identifies an atomic transaction within a CCF service. Composed of a term number and sequence number. Sequence numbers increase monotonically, apart from during elections where the service may reuse an existing sequence number. Each election will result in a new, higher term number being used for the conflicting and future sequence numbers.")
@pattern("^[0-9]+\\.[0-9]+$")
scalar transactionId extends string;

alias TxIdWriteHdr = {
  @doc("Identifier for transaction where this request produced a write on the service. This uniquely identifies the submitted request, and can be used to confirm that the request becomes committed.")
  @TypeSpec.Http.header(transactionIdHeaderField)
  transactionId: transactionId;
};

alias TxIdWriteHeader = Azure.Core.Traits.ResponseHeadersTrait<TxIdWriteHdr>;

alias TxIdReadHdr = {
  @doc("Identifier for transaction this response was read from. The service state may be altered by other write requests. Reads at the same transactionId describe a consistent single point in the service history.")
  @TypeSpec.Http.header(transactionIdHeaderField)
  transactionId: transactionId;
};

alias TxIdReadHeader = Azure.Core.Traits.ResponseHeadersTrait<TxIdReadHdr>;

alias JavaScriptSource = {
  @doc("This contains raw JavaScript source code, not escaped into a JSON object.")
  @TypeSpec.Http.header("content-type")
  contentType: "text/javascript";
};

@doc("Hex encoding of SHA-256 of a node's public key.")
@pattern("^[a-f0-9]{64}$")
scalar nodeId extends string;

@doc("Hex encoding of SHA-256 of a member certificate's fingerprint.")
@pattern("^[a-f0-9]{64}$")
scalar memberId extends string;

@doc("Hex encoding of SHA-256 of user certificate's fingerprint.")
@pattern("^[a-f0-9]{64}$")
scalar userId extends string;

@doc("Hex encoding of SHA-256 of proposed actions and merkle root of store at proposal creation. Unlike other IDs, this is generated on the service and will not be known in advance.")
@pattern("^[a-f0-9]{64}$")
scalar proposalId extends string;

@doc("A non-negative JSON-safe integer (ie max is 2^53 - 1)")
@minValue(0)
scalar safeuint extends safeint;
