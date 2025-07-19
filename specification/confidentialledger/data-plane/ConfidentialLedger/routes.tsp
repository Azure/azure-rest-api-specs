import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "./common.tsp";

using TypeSpec.Http;

namespace ConfidentialLedger.Ledger;

interface Operations {
  /**
   * The constitution is a script that assesses and applies proposals from
   * consortium members.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @summary("Gets the constitution used for governance.")
  @route("/app/governance/constitution")
  @get
  getConstitution is Common.LedgerOperation<{}, Constitution>;

  /**
   * Consortium members can manage the Confidential Ledger.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @summary("Lists the consortium members.")
  @route("/app/governance/members")
  @get
  listConsortiumMembers is Common.LedgerOperation<{}, Consortium>;

  /**
   * A quote is an SGX enclave measurement that can be used to verify the validity
   * of a node and its enclave.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @summary("Gets quotes for all nodes of the Confidential Ledger.")
  @route("/app/enclaveQuotes")
  @get
  getEnclaveQuotes is Common.LedgerOperation<{}, ConfidentialLedgerEnclaves>;

  /**
   * Collection ids are user-created collections of ledger entries
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @summary("Retrieves a list of collection ids present in the Confidential Ledger")
  @route("/app/collections")
  @get
  listCollections is Common.LedgerOperation<{}, PagedCollections>;

  /**
   * A collection id may optionally be specified. Only entries in the specified (or
   * default) collection will be returned.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @summary("Gets ledger entries from a collection corresponding to a range.")
  @route("/app/transactions")
  @get
  listLedgerEntries is Common.LedgerOperation<
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
  createLedgerEntry is Common.LedgerOperation<
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
  getLedgerEntry is Common.LedgerOperation<
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
  getReceipt is Common.LedgerOperation<
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
  getTransactionStatus is Common.LedgerOperation<
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
  getCurrentLedgerEntry is Common.LedgerOperation<
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
  @summary("Gets details on a list of users.")
  @route("/app/users")
  @get
  listUsers is Common.LedgerOperation<{}, PagedUsers>;

  /**
   * All users' object IDs and multiple roles will be returned.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @summary("Gets details on a list of users.")
  @route("/app/ledgerUsers")
  @get
  listLedgerUsers is Common.LedgerOperation<{}, PagedLedgerUsers>;

  /**
   * Deletes a user from the Confidential Ledger.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @summary("Deletes a user from the Confidential Ledger.")
  @route("/app/users/{userId}")
  @delete
  deleteUser is Common.LedgerOperation<
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
  getUser is Common.LedgerOperation<
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
  createOrUpdateUser is Common.LedgerOperation<
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
  deleteLedgerUser is Common.LedgerOperation<
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
  getLedgerUser is Common.LedgerOperation<
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
  createOrUpdateLedgerUser is Common.LedgerOperation<
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
  getUserDefinedEndpoint is Common.LedgerOperation<{}, Bundle>;

  /**
   * Creates the user defined endpoint in the ACL instance
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @summary("Creates a user defined endpoint.")
  @route("/app/userDefinedEndpoints")
  @put
  createUserDefinedEndpoint is Common.LedgerOperation<
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
  getRuntimeOptions is Common.LedgerOperation<{}, JsRuntimeOptions>;

  /**
   * Updates the runtime options.
   */
  #suppress "@typespec/http/patch-implicit-optional" "Irrelevant linter warning"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @summary("Runtime options for user defined endpoints.")
  @route("/app/userDefinedEndpoints/runtimeOptions")
  @patch
  updateRuntimeOptions is Common.LedgerOperation<
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
  getUserDefinedEndpointsModule is Common.LedgerOperation<
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
  @summary("Retrieves a list of user defined functions present in the Confidential Ledger")
  @route("/app/userDefinedFunctions")
  @get
  listUserDefinedFunctions is Common.LedgerOperation<
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
  deleteUserDefinedFunction is Common.LedgerOperation<
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
  getUserDefinedFunction is Common.LedgerOperation<
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
  createUserDefinedFunction is Common.LedgerOperation<
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
  executeUserDefinedFunction is Common.LedgerOperation<
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
  getUserDefinedRole is Common.LedgerOperation<
    {
      /**
       * user defined role name
       */
      @query("roleName")
      roleName: string;
    },
    Role[]
  >;

  /**
   * User defined roles allow users to define and manage app specific AuthZ policy.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @summary("Creates new roles and their actions")
  @route("/app/roles")
  @put
  createUserDefinedRole is Common.LedgerOperation<
    {
      /** Request body */
      #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Existing API contract"
      @bodyRoot
      roles: Role[];
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
  updateUserDefinedRole is Common.LedgerOperation<
    {
      /** Request body */
      #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Existing API contract"
      @bodyRoot
      roles: Role[];
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
  deleteUserDefinedRole is Common.LedgerOperation<
    {
      /**
       * user defined role name
       */
      @query("roleName")
      roleName: string;
    },
    {}
  >;
}
