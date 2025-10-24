import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "./common.tsp";

using TypeSpec.Http;

namespace ConfidentialLedger;

/**
 * The constitution is a script that assesses and applies proposals from
 * consortium members.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("Gets the constitution used for governance.")
@route("/app/governance/constitution")
@get
op getConstitution is ConfidentialLedgerCommon.LedgerOperation<
  {},
  Constitution
>;

/**
 * Consortium members can manage the Confidential Ledger.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
@summary("Lists the consortium members.")
@route("/app/governance/members")
@list
op listConsortiumMembers is ConfidentialLedgerCommon.LedgerOperation<
  {},
  Consortium
>;

/**
 * A quote is an SGX enclave measurement that can be used to verify the validity
 * of a node and its enclave.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("Gets quotes for all nodes of the Confidential Ledger.")
@route("/app/enclaveQuotes")
@get
op getEnclaveQuotes is ConfidentialLedgerCommon.LedgerOperation<
  {},
  ConfidentialLedgerEnclaves
>;

/**
 * Collection ids are user-created collections of ledger entries
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
@summary("Retrieves a list of collection ids present in the Confidential Ledger")
@route("/app/collections")
@list
op listCollections is ConfidentialLedgerCommon.LedgerOperation<
  {},
  PagedCollections
>;

/**
 * A collection id may optionally be specified. Only entries in the specified (or
 * default) collection will be returned.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
@summary("Gets ledger entries from a collection corresponding to a range.")
@route("/app/transactions")
@list
op listLedgerEntries is ConfidentialLedgerCommon.LedgerOperation<
  {
    /**
     * The collection id.
     */
    @query("collectionId")
    collectionId?: string;

    /**
     * Specify the first transaction ID in a range.
     */
    @query("fromTransactionId")
    fromTransactionId?: string;

    /**
     * Specify the last transaction ID in a range.
     */
    @query("toTransactionId")
    toTransactionId?: string;

    /**
     * Single tag.
     */
    @query("tag")
    tag?: string;
  },
  PagedLedgerEntries
>;

/**
 * A collection id may optionally be specified.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("Writes a ledger entry.")
@route("/app/transactions")
@post
op createLedgerEntry is ConfidentialLedgerCommon.LedgerOperation<
  {
    /**
     * The collection id.
     */
    @query("collectionId")
    collectionId?: string;

    /**
     * Comma separated tags.
     */
    @query("tags")
    tags?: string;

    /**
     * Ledger entry.
     */
    @bodyRoot
    entry: LedgerEntry;
  },
  LedgerWriteResult
>;

/**
 * To return older ledger entries, the relevant sections of the ledger must be
 * read from disk and validated. To prevent blocking within the enclave, the
 * response will indicate whether the entry is ready and part of the response, or
 * if the loading is still ongoing.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("""
  Gets the ledger entry at the specified transaction id. A collection id may
  optionally be specified to indicate the collection from which to fetch the
  value.
  """)
@route("/app/transactions/{transactionId}")
@get
op getLedgerEntry is ConfidentialLedgerCommon.LedgerOperation<
  {
    /**
     * The collection id.
     */
    @query("collectionId")
    collectionId?: string;

    /**
     * Identifies a write transaction.
     */
    @path
    transactionId: string;
  },
  LedgerQueryResult
>;

/**
 * Gets a receipt certifying ledger contents at a particular transaction id.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("Gets a receipt certifying ledger contents at a particular transaction id.")
@route("/app/transactions/{transactionId}/receipt")
@get
op getReceipt is ConfidentialLedgerCommon.LedgerOperation<
  {
    /**
     * Identifies a write transaction.
     */
    @path
    transactionId: string;
  },
  TransactionReceipt
>;

/**
 * Gets the status of an entry identified by a transaction id.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("Gets the status of an entry identified by a transaction id.")
@route("/app/transactions/{transactionId}/status")
@get
op getTransactionStatus is ConfidentialLedgerCommon.LedgerOperation<
  {
    /**
     * Identifies a write transaction.
     */
    @path
    transactionId: string;
  },
  TransactionStatus
>;

/**
 * A collection id may optionally be specified.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("Gets the current value available in the ledger.")
@route("/app/transactions/current")
@get
op getCurrentLedgerEntry is ConfidentialLedgerCommon.LedgerOperation<
  {
    /**
     * The collection id.
     */
    @query("collectionId")
    collectionId?: string;
  },
  LedgerEntry
>;

/**
 * All users' object IDs and single role per user will be returned.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
@summary("Gets details on a list of users.")
@route("/app/users")
@list
op listUsers is ConfidentialLedgerCommon.LedgerOperation<{}, PagedUsers>;

/**
 * All users' object IDs and multiple roles will be returned.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
@summary("Gets details on a list of users.")
@route("/app/ledgerUsers")
@list
op listLedgerUsers is ConfidentialLedgerCommon.LedgerOperation<
  {},
  PagedLedgerUsers
>;

/**
 * Deletes a user from the Confidential Ledger.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("Deletes a user from the Confidential Ledger.")
@route("/app/users/{userId}")
@delete
op deleteUser is ConfidentialLedgerCommon.LedgerOperation<
  {
    /**
     * The user id, either an AAD object ID or certificate fingerprint.
     */
    @path
    userId: string;
  },
  void
>;

/**
 * Gets a user.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("Gets a user.")
@route("/app/users/{userId}")
@get
op getUser is ConfidentialLedgerCommon.LedgerOperation<
  {
    /**
     * The user id, either an AAD object ID or certificate fingerprint.
     */
    @path
    userId: string;
  },
  LedgerUser
>;

/**
 * A JSON merge patch is applied for existing users
 */
#suppress "@typespec/http/patch-implicit-optional" "Irrelevant linter warning"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("Adds a user or updates a user's fields.")
@route("/app/users/{userId}")
@patch
op createOrUpdateUser is ConfidentialLedgerCommon.LedgerOperation<
  {
    /** application/merge-patch+json content-type */
    @header("Content-Type")
    contentType: "application/merge-patch+json";

    /**
     * The user id, either an AAD object ID or certificate fingerprint.
     */
    @path
    userId: string;

    /**
     * Details about a Confidential Ledger user.
     */
    @bodyRoot
    userDetails: LedgerUser;
  },
  LedgerUser
>;

/**
 * Deletes a user with multiple roles from the Confidential Ledger.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("Deletes a user with multiple roles from the Confidential Ledger.")
@route("/app/ledgerUsers/{userId}")
@delete
op deleteLedgerUser is ConfidentialLedgerCommon.LedgerOperation<
  {
    /**
     * The user id, either an AAD object ID or certificate fingerprint.
     */
    @path
    userId: string;
  },
  void
>;

/**
 * Gets a user with multiple roles.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("Gets a user with multiple roles.")
@route("/app/ledgerUsers/{userId}")
@get
op getLedgerUser is ConfidentialLedgerCommon.LedgerOperation<
  {
    /**
     * The user id, either an AAD object ID or certificate fingerprint.
     */
    @path
    userId: string;
  },
  LedgerUserMultipleRoles
>;

/**
 * A JSON merge patch is applied for existing users
 */
#suppress "@typespec/http/patch-implicit-optional" "Irrelevant linter warning"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("Adds a user or updates a user's fields.")
@route("/app/ledgerUsers/{userId}")
@patch
op createOrUpdateLedgerUser is ConfidentialLedgerCommon.LedgerOperation<
  {
    /** application/merge-patch+json content-type */
    @header("Content-Type")
    contentType: "application/merge-patch+json";

    /**
     * The user id, either an AAD object ID or certificate fingerprint.
     */
    @path
    userId: string;

    /**
     * Details about a Confidential Ledger user with multiple roles.
     */
    @bodyRoot
    userMultipleRoles: LedgerUserMultipleRoles;
  },
  LedgerUserMultipleRoles
>;

/**
 * Returns the user defined endpoint in the ACL instance
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("Gets a user defined endpoint.")
@route("/app/userDefinedEndpoints")
@get
op getUserDefinedEndpoint is ConfidentialLedgerCommon.LedgerOperation<
  {},
  Bundle
>;

/**
 * Creates the user defined endpoint in the ACL instance
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("Creates a user defined endpoint.")
@route("/app/userDefinedEndpoints")
@put
op createUserDefinedEndpoint is ConfidentialLedgerCommon.LedgerOperation<
  {
    /**
     * Specify a user defined endpoint.
     */
    @bodyRoot
    bundle: Bundle;
  },
  {
    @statusCode statusCode: 201;
  }
>;

/**
 * It returns the runtime options
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("Runtime options for user defined endpoints.")
@route("/app/userDefinedEndpoints/runtimeOptions")
@get
op getRuntimeOptions is ConfidentialLedgerCommon.LedgerOperation<
  {},
  JsRuntimeOptions
>;

/**
 * Updates the runtime options.
 */
#suppress "@typespec/http/patch-implicit-optional" "Irrelevant linter warning"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("Runtime options for user defined endpoints.")
@route("/app/userDefinedEndpoints/runtimeOptions")
@patch
op updateRuntimeOptions is ConfidentialLedgerCommon.LedgerOperation<
  {
    /** JS Runtime options */
    @bodyRoot
    jsRuntimeOptions: JsRuntimeOptions;
  },
  JsRuntimeOptions
>;

/**
 * It gets the module for the user defined endpoint.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("Module for user defined endpoints.")
@route("/app/userDefinedEndpoints/modules")
@get
op getUserDefinedEndpointsModule is ConfidentialLedgerCommon.LedgerOperation<
  {
    /**
     * module name of the user defined endpoint
     */
    @query("module_name")
    moduleName: string;
  },
  ModuleDef
>;

/**
 * User defined functions stored in the Confidential Ledger
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
@summary("Retrieves a list of user defined functions present in the Confidential Ledger")
@route("/app/userDefinedFunctions")
@list
op listUserDefinedFunctions is ConfidentialLedgerCommon.LedgerOperation<
  {},
  PagedUserDefinedFunctions
>;

/**
 * Deletes a user defined function from the Confidential Ledger.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("Deletes a user defined function from the Confidential Ledger.")
@route("/app/userDefinedFunctions/{functionId}")
@delete
op deleteUserDefinedFunction is ConfidentialLedgerCommon.LedgerOperation<
  {
    /**
     * Identifies a user defined function.
     */
    @path
    functionId: string;
  },
  void
>;

/**
 * Returns the user defined function in the Confidential Ledger
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("Gets a user defined function.")
@route("/app/userDefinedFunctions/{functionId}")
@get
op getUserDefinedFunction is ConfidentialLedgerCommon.LedgerOperation<
  {
    /**
     * Identifies a user defined function.
     */
    @path
    functionId: string;
  },
  UserDefinedFunction
>;

/**
 * Creates the user defined function in the Confidential Ledger
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("Creates a user defined function.")
@route("/app/userDefinedFunctions/{functionId}")
@put
op createUserDefinedFunction is ConfidentialLedgerCommon.LedgerOperation<
  {
    /**
     * Identifies a user defined function.
     */
    @path
    functionId: string;

    /**
     * Specify a user defined function of a Confidential Ledger.
     */
    @bodyRoot
    userDefinedFunction: UserDefinedFunction;
  },
  {
    #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Existing API contract"
    @statusCode statusCode: 200 | 201;
    ...CCFTransactionIdHeader;
  } & UserDefinedFunction
>;

/**
 * Executes the user defined function in the Confidential Ledger
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("Executes a user defined function.")
@route("/app/userDefinedFunctions/{functionId}:execute")
@post
op executeUserDefinedFunction is ConfidentialLedgerCommon.LedgerOperation<
  {
    /**
     * Identifies a user defined function.
     */
    @path
    functionId: string;

    /**
     * Specify user defined function execution properties.
     */
    @bodyRoot
    userDefinedFunctionExecutionProperties?: UserDefinedFunctionExecutionProperties;
  },
  UserDefinedFunctionExecutionResponse
>;

/**
 * user defined roles allow users to define and manage app specific AuthZ policy.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("Gets role actions for user defined roles")
@route("/app/roles")
@get
op getUserDefinedRole is ConfidentialLedgerCommon.LedgerOperation<
  {
    /**
     * user defined role name
     */
    @query("roleName")
    roleName: string;
  },
  UserDefinedRole
>;

/**
 * User defined roles allow users to define and manage app specific AuthZ policy.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("Creates new roles and their actions")
@route("/app/roles")
@put
op createUserDefinedRole is ConfidentialLedgerCommon.LedgerOperation<
  {
    /** Request body */
    #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Existing API contract"
    @bodyRoot
    body: UserDefinedRoles;
  },
  {}
>;

/**
 * User defined roles allow users to define and manage app specific AuthZ policy.
 */
#suppress "@typespec/http/patch-implicit-optional" "Irrelevant linter warning"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("""
  Patch replaces the allowed action on existing roles,if the desire is to remove
  an existing action, the role must be deleted and recreated.
  """)
@route("/app/roles")
@patch
op updateUserDefinedRole is ConfidentialLedgerCommon.LedgerOperation<
  {
    /** Request body */
    #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Existing API contract"
    @bodyRoot
    body: UserDefinedRoles;
  },
  {}
>;

/**
 * A user defined role allows the users to create and manage their own role
 * actions using the API.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@summary("Deletes user defined roles")
@route("/app/roles")
@delete
op deleteUserDefinedRole is ConfidentialLedgerCommon.LedgerOperation<
  {
    /**
     * user defined role name
     */
    @query("roleName")
    roleName: string;
  },
  {}
>;
