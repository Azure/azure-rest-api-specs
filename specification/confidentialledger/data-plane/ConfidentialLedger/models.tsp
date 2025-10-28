import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;

namespace ConfidentialLedger;

/** Roles */
model UserDefinedRoles {
  /** Roles */
  roles: Role[];
}

/** User defined role */
model UserDefinedRole {
  /** User defined role */
  role: Role[];
}

/**
 * State of a ledger query.
 */
union ConfidentialLedgerQueryState {
  string,

  /** The query is still loading */
  Loading: "Loading",

  /** The query is ready */
  Ready: "Ready",
}

/**
 * Represents the protocol to be used to compute the digest of a claim from the
 * given claim data.
 */
union ApplicationClaimProtocol {
  string,

  /** Ledger Entry V1 protocol */
  LedgerEntryV1: "LedgerEntryV1",
}

/**
 * Represents the kind of an application claim.
 */
union ApplicationClaimKind {
  string,

  /** Claim derived from a ledger entry */
  LedgerEntry: "LedgerEntry",

  /** Claim in digested form */
  ClaimDigest: "ClaimDigest",
}

/**
 * Represents the state of the transaction.
 */
union TransactionState {
  string,

  /** The transaction is committed */
  Committed: "Committed",

  /** The transaction is pending */
  Pending: "Pending",
}

/**
 * Represents an assignable role.
 */
union ConfidentialLedgerUserRoleName {
  string,

  /** Administrator role */
  Administrator: "Administrator",

  /** Contributor role */
  Contributor: "Contributor",

  /** Reader role */
  Reader: "Reader",
}

/**
 * Indicates whether request forwarding is required for this operation.
 */
union ForwardingRequired {
  string,

  /** Forwarding is required sometimes */
  sometimes: "sometimes",

  /** Forwarding is always required */
  always: "always",

  /** Forwarding is never required */
  `never`: "never",
}

/**
 * Represents the operation mode of the endpoint.
 */
union Mode {
  string,

  /** Read-write mode */
  readwrite: "readwrite",

  /** Read-only mode */
  readonly: "readonly",

  /** Historical mode */
  historical: "historical",
}

/**
 * Represents the redirection strategy for the endpoint.
 */
union RedirectionStrategy {
  string,

  /** No redirection strategy */
  none: "none",

  /** Redirect to primary */
  to_primary: "to_primary",

  /** Redirect to backup */
  to_backup: "to_backup",
}

/**
 * Represents the status of a user defined function execution.
 */
union UserDefinedFunctionExecutionStatus {
  string,

  /** The function execution completed successfully */
  Succeeded: "Succeeded",

  /** The function execution failed */
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
model Consortium {
  /**
   * Members in the consortium.
   */
  @pageItems
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
model PagedCollections {
  /**
   * Collection identifiers.
   */
  @pageItems
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
  /**
   * Identifier for the collection.
   */
  collectionId: string;
}

/**
 * Paginated ledger entries returned in response to a query.
 */
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
  @pageItems
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

  /**
   * The collection identifier for this ledger entry.
   */
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
  runtimeOptions?: JsRuntimeOptions;
}

/**
 * JS runtime options for user defined endpoints and functions
 */
model JsRuntimeOptions {
  /**
   * Whether to log exception details in the runtime.
   */
  @encodedName("application/json", "log_exception_details")
  logExceptionDetails?: boolean;

  /**
   * Maximum number of cached interpreters.
   */
  @encodedName("application/json", "max_cached_interpreters")
  @minValue(0)
  maxCachedInterpreters?: int64;

  /**
   * Maximum execution time in milliseconds.
   */
  @encodedName("application/json", "max_execution_time_ms")
  @minValue(0)
  maxExecutionTimeMs?: int64;

  /**
   * Maximum heap size in bytes.
   */
  @encodedName("application/json", "max_heap_bytes")
  @minValue(0)
  maxHeapBytes?: int64;

  /**
   * Maximum stack size in bytes.
   */
  @encodedName("application/json", "max_stack_bytes")
  @minValue(0)
  maxStackBytes?: int64;

  /**
   * Whether to return exception details in the response.
   */
  @encodedName("application/json", "return_exception_details")
  returnExceptionDetails?: boolean;
}

alias CCFTransactionIdHeader = {
  /**
   * The transaction id at which this write will become durable.
   */
  @header("x-ms-ccf-transaction-id")
  transactionId: string;
};

/**
 * Returned as a result of a write to the Confidential Ledger, the transaction id
 * in the response indicates when the write will become durable.
 */
model LedgerWriteResult {
  ...CCFTransactionIdHeader;

  /**
   * The collection identifier of the ledger entry.
   */
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

  /**
   * The receipt contents for the transaction.
   */
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

/**
 * The contents of a receipt
 */
model ReceiptContents {
  /**
   * Certificate
   */
  cert?: string;

  /**
   * Leaf
   */
  leaf?: string;

  /**
   * Leaf components of the receipt
   */
  leafComponents?: ReceiptLeafComponents;

  /**
   * Node identifier
   */
  nodeId: string;

  /**
   * Proof
   */
  proof: ReceiptElement[];

  /**
   * Root
   */
  root?: string;

  /**
   * Service endorsements
   */
  serviceEndorsements?: string[];

  /**
   * The signature of the receipt
   */
  signature: string;
}

/**
 * Components that make up a receipt leaf node.
 */
model ReceiptLeafComponents {
  /**
   * Claims digest
   */
  claimsDigest?: string;

  /**
   * Commit evidence
   */
  commitEvidence?: string;

  /**
   * TWrite set digest
   */
  writeSetDigest?: string;
}

/**
 * Receipt element
 */
model ReceiptElement {
  /**
   * Left
   */
  left?: string;

  /**
   * Right
   */
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
model PagedUsers {
  /**
   * Ledger users.
   */
  @pageItems
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
model PagedLedgerUsers {
  /**
   * Ledger users with details.
   */
  @pageItems
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
  /**
   * Metadata information for the bundle.
   */
  metadata: Metadata;

  /**
   * Any object
   */
  modules: ModuleDef[];
}

/**
 * Metadata for endpoints.
 */
model Metadata {
  /**
   * A map of path to method endpoints for the path
   */
  endpoints: Record<MethodToEndpointProperties>;
}

/**
 * Maps methods to their corresponding endpoint properties.
 */
model MethodToEndpointProperties {
  /**
   * Properties for GET method endpoint.
   */
  get?: EndpointProperties;

  /**
   * Properties for PUT method endpoint.
   */
  put?: EndpointProperties;

  /**
   * Properties for PATCH method endpoint.
   */
  patch?: EndpointProperties;

  /**
   * Properties for DELETE method endpoint.
   */
  delete?: EndpointProperties;
}

/**
 * Endpoint properties.
 */
model EndpointProperties {
  /**
   * Authentication policies for the endpoint.
   */
  @encodedName("application/json", "authn_policies")
  authnPolicies: Record<unknown>[];

  /**
   * Indicates whether request forwarding is required for this endpoint.
   */
  @encodedName("application/json", "forwarding_required")
  forwardingRequired: ForwardingRequired;

  /**
   * Policy for interpreter reuse.
   */
  @encodedName("application/json", "interpreter_reuse")
  interpreterReuse?: InterpreterReusePolicy;

  /**
   * The JavaScript function.
   */
  @encodedName("application/json", "js_function")
  jsFunction?: string;

  /**
   * The JavaScript module.
   */
  @encodedName("application/json", "js_module")
  jsModule?: string;

  /**
   * The operation mode for this endpoint.
   */
  mode?: Mode;

  /**
   * Anything
   */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Service did not define a type for openapi"
  openapi?: Record<unknown>;

  /**
   * Openapi hidden
   */
  @encodedName("application/json", "openapi_hidden")
  openapiHidden?: boolean;

  /**
   * Redirection strategy
   */
  @encodedName("application/json", "redirection_strategy")
  redirectionStrategy?: RedirectionStrategy;
}

/**
 * Policy for interpreter reuse.
 */
model InterpreterReusePolicy {
  /**
   * Key for the interpreter reuse policy.
   */
  key: string;
}

/**
 * Module definition
 */
model ModuleDef {
  /**
   * Module
   */
  module: string;

  /**
   * Name
   */
  name: string;
}

/**
 * Paginated user defined functions returned in response to a query.
 */
model PagedUserDefinedFunctions {
  /**
   * User-defined functions.
   */
  @pageItems
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

  /**
   * role actions
   */
  roleActions?: string[];
}

/**
 * An item in the Merkle proof.
 */
model MerkleProofElement {
  /**
   * The left hash value in the Merkle proof element.
   */
  left?: string;

  /**
   * The right hash value in the Merkle proof element.
   */
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
