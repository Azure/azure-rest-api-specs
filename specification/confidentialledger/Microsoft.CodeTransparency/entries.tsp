#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@removed(Versions.`2025-01-31-preview`)
@doc("Post an entry to be registered on the CodeTransparency instance.")
@post
@sharedRoute
@route("/entries")
op createEntry is Foundations.Operation<
  SignedStatement,
  CreateEntryResult,
  ServiceTraits
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@added(Versions.`2025-01-31-preview`)
@doc("Post an entry to be registered on the CodeTransparency instance, see IETF SCITT SCRAPI draft")
@post
@sharedRoute
@route("/entries")
op createEntryChanged is Foundations.Operation<
  SignedStatement,
  CreateEntryCreated | CreateEntryPending,
  ServiceTraits
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@removed(Versions.`2025-01-31-preview`)
@doc("Get the status the entry operation")
@route("/operations/{operationId}")
op getEntryStatus is Foundations.Operation<
  OperationIdParameter,
  GetOperationResult,
  ServiceTraits
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@removed(Versions.`2025-01-31-preview`)
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
  SignedStatement | TransparentStatement,
  ServiceTraits
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Get the receipt of an entry given a specific entry id.")
@route("/entries/{entryId}/receipt")
op getEntryReceipt is Foundations.Operation<
  EntryIdParameter,
  ReceiptEntry,
  ServiceTraits
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@added(Versions.`2025-01-31-preview`)
@doc("Get the receipt of an entry given a specific entry id.")
@route("/entries/{entryId}/statement")
op getEntryStatement is Foundations.Operation<
  EntryIdParameter,
  TransparentStatement,
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
