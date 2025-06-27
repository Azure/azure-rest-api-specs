import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace ConfidentialLedger.Ledger;

/**
 * State of a ledger query.
 */
union ConfidentialLedgerQueryState {
  string,
  Loading: "Loading",
  Ready: "Ready",
}

/**
 * Represents the protocol to be used to compute the digest of a claim from the
 * given claim data.
 */
union ApplicationClaimProtocol {
  string,
  LedgerEntryV1: "LedgerEntryV1",
}

/**
 * Represents the kind of an application claim.
 */
union ApplicationClaimKind {
  string,
  LedgerEntry: "LedgerEntry",
  ClaimDigest: "ClaimDigest",
}

/**
 * Represents the state of the transaction.
 */
union TransactionState {
  string,
  Committed: "Committed",
  Pending: "Pending",
}

/**
 * Represents an assignable role.
 */
union ConfidentialLedgerUserRoleName {
  string,
  Administrator: "Administrator",
  Contributor: "Contributor",
  Reader: "Reader",
}

union ForwardingRequired {
  string,
  sometimes: "sometimes",
  always: "always",
  `never`: "never",
}

union Mode {
  string,
  readwrite: "readwrite",
  readonly: "readonly",
  historical: "historical",
}

union RedirectionStrategy {
  string,
  none: "none",
  to_primary: "to_primary",
  to_backup: "to_backup",
}

/**
 * Represents the status of a user defined function execution.
 */
union UserDefinedFunctionExecutionStatus {
  string,
  Succeeded: "Succeeded",
  Failed: "Failed",
}

/**
 * The governance script for the application.
 */
model Constitution {
  /**
   * SHA256 digest of the constitution script.
   */
  digest: string;

  /**
   * Contents of the constitution.
   */
  script: string;
}

/**
 * List of members in the consortium.
 */
@pagedResult
model Consortium {
  @items
  members: ConsortiumMember[];

  /**
   * Path from which to retrieve the next page of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Describes a member of the consortium.
 */
model ConsortiumMember {
  /**
   * PEM-encoded certificate associated with the member.
   */
  certificate: string;

  /**
   * Identifier assigned to the member.
   */
  id: string;
}

/**
 * Information about the enclaves running the Confidential Ledger.
 */
model ConfidentialLedgerEnclaves {
  /**
   * Id of the Confidential Ledger node responding to the request.
   */
  currentNodeId: string;

  /**
   * Dictionary of enclave quotes, indexed by node id.
   */
  enclaveQuotes: Record<EnclaveQuote>;
}

/**
 * Contains the enclave quote.
 */
model EnclaveQuote {
  /**
   * ID assigned to this node.
   */
  nodeId: string;

  /**
   * MRENCLAVE value of the code running in the enclave.
   */
  mrenclave?: string;

  /**
   * Version of the quote presented.
   */
  quoteVersion: string;

  /**
   * Raw SGX quote, parsable by tools like Open Enclave's oeverify.
   */
  raw: string;
}

/**
 * Paginated collections returned in response to a query.
 */
@pagedResult
model PagedCollections {
  @items
  collections: Collection[];

  /**
   * Path from which to retrieve the next page of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Identifier for collections.
 */
model Collection {
  collectionId: string;
}

/**
 * Paginated ledger entries returned in response to a query.
 */
@pagedResult
model PagedLedgerEntries {
  /**
   * State of a ledger query.
   */
  state: ConfidentialLedgerQueryState;

  /**
   * Path from which to retrieve the next page of results.
   */
  @nextLink
  nextLink?: string;

  /**
   * Array of ledger entries.
   */
  @items
  entries: LedgerEntry[];
}

/**
 * An entry in the ledger.
 */
model LedgerEntry {
  /**
   * Contents of the ledger entry.
   */
  contents: string;

  @visibility(Lifecycle.Read)
  collectionId?: string;

  /**
   * A unique identifier for the state of the ledger. If returned as part of a
   * LedgerEntry, it indicates the state from which the entry was read.
   */
  @visibility(Lifecycle.Read)
  transactionId?: string;

  /**
   * List of user defined function hooks to be executed before the ledger entry is
   * written.
   */
  preHooks?: UserDefinedFunctionHook[];

  /**
   * List of user defined function hooks to be executed after the ledger entry is
   * written.
   */
  postHooks?: UserDefinedFunctionHook[];
}

/**
 * Hook for a user defined function execution.
 */
model UserDefinedFunctionHook {
  /**
   * ID of the user defined function to execute.
   */
  functionId: string;

  /**
   * The properties for executing a user defined function.
   */
  properties?: UserDefinedFunctionExecutionProperties;
}

/**
 * The properties for executing a user defined function.
 */
model UserDefinedFunctionExecutionProperties {
  /**
   * Runtime arguments of the user defined function. Defaults to an empty list.
   */
  arguments?: string[];

  /**
   * Name of the exported function to execute in the code of the user defined
   * function. Defaults to main.
   */
  exportedFunctionName?: string;

  /**
   * JS runtime options for user defined endpoints and functions
   */
  runtimeOptions?: JSRuntimeOptions;
}

/**
 * JS runtime options for user defined endpoints and functions
 */
model JSRuntimeOptions {
  log_exception_details?: boolean;
  max_cached_interpreters?: int64;
  max_execution_time_ms?: int64;
  max_heap_bytes?: int64;
  max_stack_bytes?: int64;
  return_exception_details?: boolean;
}

/**
 * Returned as a result of a write to the Confidential Ledger, the transaction id
 * in the response indicates when the write will become durable.
 */
model LedgerWriteResult {
  collectionId: string;
}

/**
 * The result of querying for a ledger entry from an older transaction id. The
 * ledger entry is available in the response only if the returned state is Ready.
 */
model LedgerQueryResult {
  /**
   * State of a ledger query.
   */
  state: ConfidentialLedgerQueryState;

  /**
   * The ledger entry found as a result of the query. This is only available if the
   * query is in Ready state.
   */
  entry?: LedgerEntry;
}

/**
 * A receipt certifying the transaction at the specified id.
 */
model TransactionReceipt {
  /**
   * List of application claims.
   */
  applicationClaims?: ApplicationClaim[];

  receipt?: ReceiptContents;

  /**
   * State of a ledger query.
   */
  state: ConfidentialLedgerQueryState;

  /**
   * A unique identifier for the state of the ledger. If returned as part of a
   * LedgerEntry, it indicates the state from which the entry was read.
   */
  transactionId: string;
}

/**
 * A claim of a ledger application.
 */
model ApplicationClaim {
  /**
   * An application claim in digested form.
   */
  digest?: ClaimDigest;

  /**
   * Represents the kind of an application claim.
   */
  kind: ApplicationClaimKind;

  /**
   * An application claim derived from ledger entry data.
   */
  ledgerEntry?: LedgerEntryClaim;
}

/**
 * An application claim in digested form.
 */
model ClaimDigest {
  /**
   * The digest of the application claim, in hexadecimal form.
   */
  value?: string;

  /**
   * Represents the protocol to be used to compute the digest of a claim from the
   * given claim data.
   */
  protocol: ApplicationClaimProtocol;
}

/**
 * An application claim derived from ledger entry data.
 */
model LedgerEntryClaim {
  /**
   * Identifier of a collection.
   */
  collectionId?: string;

  /**
   * Contents of a ledger entry.
   */
  contents?: string;

  /**
   * Base64-encoded secret key.
   */
  secretKey?: string;

  /**
   * Represents the protocol to be used to compute the digest of a claim from the
   * given claim data.
   */
  protocol: ApplicationClaimProtocol;
}

model ReceiptContents {
  cert?: string;
  leaf?: string;
  leafComponents?: ReceiptLeafComponents;
  nodeId: string;
  proof: ReceiptElement[];
  root?: string;
  serviceEndorsements?: string[];
  signature: string;
}

model ReceiptLeafComponents {
  claimsDigest?: string;
  commitEvidence?: string;
  writeSetDigest?: string;
}

model ReceiptElement {
  left?: string;
  right?: string;
}

/**
 * Response returned to a query for the transaction status
 */
model TransactionStatus {
  /**
   * Represents the state of the transaction.
   */
  state: TransactionState;

  /**
   * A unique identifier for the state of the ledger. If returned as part of a
   * LedgerEntry, it indicates the state from which the entry was read.
   */
  transactionId: string;
}

/**
 * Paginated users returned in response to a query.
 */
@pagedResult
model PagedUsers {
  @items
  ledgerUsers?: LedgerUser[];

  /**
   * Path from which to retrieve the next page of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Details about a Confidential Ledger user.
 */
model LedgerUser {
  /**
   * Represents an assignable role.
   */
  assignedRole: ConfidentialLedgerUserRoleName;

  /**
   * Identifier for the user. This must either be an AAD object id or a certificate
   * fingerprint.
   */
  @visibility(Lifecycle.Read)
  userId?: string;
}

/**
 * Paginated users returned in response to a query.
 */
@pagedResult
model PagedLedgerUsers {
  @items
  ledgerUsers?: LedgerUserMultipleRoles[];

  /**
   * Path from which to retrieve the next page of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Details about a Confidential Ledger user.
 */
model LedgerUserMultipleRoles {
  /**
   * Represents an assignable role.
   */
  assignedRoles: ConfidentialLedgerUserRoleName[];

  /**
   * Identifier for the user. This must either be an AAD object id or a certificate
   * fingerprint.
   */
  @visibility(Lifecycle.Read)
  userId?: string;
}

/**
 * bundle for the user defined endpoints
 */
model Bundle {
  metadata: Metadata;

  /**
   * Any object
   */
  modules: Record<unknown>;
}

model Metadata {
  /**
   * A map of path to method endpoints for the path
   */
  endpoints: Record<MethodToEndpointProperties>;
}

model MethodToEndpointProperties {
  get?: EndpointProperties;
  put?: EndpointProperties;
  patch?: EndpointProperties;
  delete?: EndpointProperties;
}

model EndpointProperties {
  authn_policies: unknown[];
  forwarding_required: ForwardingRequired;
  interpreter_reuse?: InterpreterReusePolicy;
  js_function?: string;
  js_module?: string;
  mode?: Mode;

  /**
   * Anything
   */
  openapi?: unknown;

  openapi_hidden?: boolean;
  redirection_strategy?: RedirectionStrategy;
}

model InterpreterReusePolicy {
  key: string;
}

model ModuleDef {
  module: string;
  name: string;
}

/**
 * Paginated user defined functions returned in response to a query.
 */
@pagedResult
model PagedUserDefinedFunctions {
  @items
  functions: UserDefinedFunction[];

  /**
   * Path from which to retrieve the next page of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * A user defined function in the ledger.
 */
model UserDefinedFunction {
  /**
   * Code of the user defined function in JavaScript.
   */
  code: string;

  /**
   * ID of the user defined function.
   */
  @visibility(Lifecycle.Read)
  id?: string;
}

/**
 * The result of a user defined function execution.
 */
model UserDefinedFunctionExecutionResponse {
  /**
   * The error object of a user defined function execution. This is returned only
   * when the user defined function execution throws an exception.
   */
  error?: UserDefinedFunctionExecutionError;

  /**
   * The result object of a user defined function execution. This is returned only
   * when the user defined function executes successfully.
   */
  result?: UserDefinedFunctionExecutionResult;

  /**
   * Represents the status of a user defined function execution.
   */
  status: UserDefinedFunctionExecutionStatus;
}

/**
 * The error object of a user defined function execution. This is returned only
 * when the user defined function execution throws an exception.
 */
model UserDefinedFunctionExecutionError {
  /**
   * Message indicating the error thrown when executing the function.
   */
  message?: string;
}

/**
 * The result object of a user defined function execution. This is returned only
 * when the user defined function executes successfully.
 */
model UserDefinedFunctionExecutionResult {
  /**
   * String-encoded value returned by the user defined function execution. If the
   * function does not return any value, this is set to an empty string.
   */
  returnValue?: string;
}

/**
 * Definition for roles
 */
model Role {
  /**
   * name of the user defined role
   */
  roleName?: string;

  roleActions?: string[];
}

/**
 * An item in the Merkle proof.
 */
model MerkleProofElement {
  left?: string;
  right?: string;
}

/**
 * Object for assigning a role to a user.
 */
model RoleAssignment {
  /**
   * Represents an assignable role.
   */
  roleName: ConfidentialLedgerUserRoleName;

  /**
   * Description of the role.
   */
  description?: string;
}
