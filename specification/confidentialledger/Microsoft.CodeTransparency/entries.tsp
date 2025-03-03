using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.CodeTransparency;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Post an entry to be registered on the CodeTransparency instance.")
@post
@route("/entries")
op createEntry is Foundations.Operation<
  CoseEntry,
  CreateEntryResult,
  ServiceTraits
>;

// Operations moved under the Entries interface
// as otherwise the generator separates those into
// separate clients
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Get the status the entry operation")
@route("/operations/{operationId}")
op getEntryStatus is Foundations.Operation<
  OperationIdParameter,
  GetOperationResult,
  ServiceTraits
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Get the status of all entries operations")
@route("/operations")
op listEntryStatuses is Foundations.Operation<
  {},
  ListOperationResult,
  ServiceTraits
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Get Entry with or without receipt embedded in its unprotected header")
@route("/entries/{entryId}")
op getEntry is Foundations.Operation<
  EmbedReceiptParameter,
  CoseEntry,
  ServiceTraits
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Get the receipt of an entry given a specific entry id.")
@route("/entries/{entryId}/receipt")
op getEntryReceipt is Foundations.Operation<
  EntryIdParameter,
  RawEntry,
  ServiceTraits
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Historical query to get a list of entries of a given range")
@route("/entries/txIds")
op listEntryIds is Foundations.Operation<
  TransactionsRange,
  EntryIds,
  ServiceTraits,
  ServiceUnavailableError | Foundations.ErrorResponse
>;
