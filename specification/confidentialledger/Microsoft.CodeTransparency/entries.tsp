using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.CodeTransparency;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Entries endpoints")
interface ServiceEntries {
  @doc("Post an entry to be registered on the CodeTransparency instance.")
  @post
  @route("/entries")
  createEntry is Foundations.Operation<CoseEntry, CreateEntryResult, ServiceTraits>;

  // Operations moved under the Entries interface
  // as otherwise the generator separates those into
  // separate clients
  @doc("Get the status the entry operation")
  @route("/operations/{operationId}")
  getEntryStatus  is Foundations.Operation<OperationIdParameter, GetOperationResult, ServiceTraits>;

  @doc("Get the status of all entries operations")
  @route("/operations")
  listEntryStatuses is Foundations.Operation<{}, ListOperationResult, ServiceTraits>;

  @doc("Get Entry with or without receipt embedded in its unprotected header")
  @route("/entries/{entryId}")
  getEntry is Foundations.Operation<EmbedReceiptParameter, CoseEntry, ServiceTraits>;

  @doc("Get the receipt of an entry given a specific entry id.")
  @route("/entries/{entryId}/receipt")
  getEntryReceipt is Foundations.Operation<EntryIdParameter, RawEntry, ServiceTraits>;

  @doc("Historical query to get a list of entries of a given range")
  @route("/entries/txIds")
  listEntryIds is Foundations.Operation<
    TransactionsRange,
    EntryIds,
    ServiceTraits,
    ServiceUnavailableError
  >;
}