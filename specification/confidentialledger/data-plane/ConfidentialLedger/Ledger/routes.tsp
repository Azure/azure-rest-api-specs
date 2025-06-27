import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ConfidentialLedger.Ledger;

interface Operations {
  /**
   * The constitution is a script that assesses and applies proposals from
   * consortium members.
   */
  @summary("Gets the constitution used for governance.")
  @route("/app/governance/constitution")
  @get
  getConstitution is Azure.Core.Foundations.Operation<{}, Constitution>;

  /**
   * Consortium members can manage the Confidential Ledger.
   */
  @summary("Lists the consortium members.")
  @route("/app/governance/members")
  @get
  listConsortiumMembers is Azure.Core.Foundations.Operation<{}, Consortium>;

  /**
   * A quote is an SGX enclave measurement that can be used to verify the validity
   * of a node and its enclave.
   */
  @summary("Gets quotes for all nodes of the Confidential Ledger.")
  @route("/app/enclaveQuotes")
  @get
  getEnclaveQuotes is Azure.Core.Foundations.Operation<
    {},
    ConfidentialLedgerEnclaves
  >;

  /**
   * Collection ids are user-created collections of ledger entries
   */
  @summary("Retrieves a list of collection ids present in the Confidential Ledger")
  @route("/app/collections")
  @get
  listCollections is Azure.Core.Foundations.Operation<{}, PagedCollections>;

  /**
   * A collection id may optionally be specified. Only entries in the specified (or
   * default) collection will be returned.
   */
  @summary("Gets ledger entries from a collection corresponding to a range.")
  @route("/app/transactions")
  @get
  listLedgerEntries is Azure.Core.Foundations.Operation<
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
  @summary("Writes a ledger entry.")
  @route("/app/transactions")
  @post
  createLedgerEntry is Azure.Core.Foundations.Operation<
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
  @summary("""
    Gets the ledger entry at the specified transaction id. A collection id may
    optionally be specified to indicate the collection from which to fetch the
    value.
    """)
  @route("/app/transactions/{transactionId}")
  @get
  getLedgerEntry is Azure.Core.Foundations.Operation<
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
  @summary("Gets a receipt certifying ledger contents at a particular transaction id.")
  @route("/app/transactions/{transactionId}/receipt")
  @get
  getReceipt is Azure.Core.Foundations.Operation<
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
  @summary("Gets the status of an entry identified by a transaction id.")
  @route("/app/transactions/{transactionId}/status")
  @get
  getTransactionStatus is Azure.Core.Foundations.Operation<
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
  @summary("Gets the current value available in the ledger.")
  @route("/app/transactions/current")
  @get
  getCurrentLedgerEntry is Azure.Core.Foundations.Operation<
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
  @summary("Gets details on a list of users.")
  @route("/app/users")
  @get
  listUsers is Azure.Core.Foundations.Operation<{}, PagedUsers>;

  /**
   * All users' object IDs and multiple roles will be returned.
   */
  @summary("Gets details on a list of users.")
  @route("/app/ledgerUsers")
  @get
  listLedgerUsers is Azure.Core.Foundations.Operation<{}, PagedLedgerUsers>;

  /**
   * Deletes a user from the Confidential Ledger.
   */
  @summary("Deletes a user from the Confidential Ledger.")
  @route("/app/users/{userId}")
  @delete
  deleteUser is Azure.Core.Foundations.Operation<
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
  @summary("Gets a user.")
  @route("/app/users/{userId}")
  @get
  getUser is Azure.Core.Foundations.Operation<
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
  @summary("Adds a user or updates a user's fields.")
  @route("/app/users/{userId}")
  @patch
  createOrUpdateUser is Azure.Core.Foundations.Operation<
    {
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
  @summary("Deletes a user with multiple roles from the Confidential Ledger.")
  @route("/app/ledgerUsers/{userId}")
  @delete
  deleteLedgerUser is Azure.Core.Foundations.Operation<
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
  @summary("Gets a user with multiple roles.")
  @route("/app/ledgerUsers/{userId}")
  @get
  getLedgerUser is Azure.Core.Foundations.Operation<
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
  @summary("Adds a user or updates a user's fields.")
  @route("/app/ledgerUsers/{userId}")
  @patch
  createOrUpdateLedgerUser is Azure.Core.Foundations.Operation<
    {
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
  @summary("Gets a user defined endpoint.")
  @route("/app/userDefinedEndpoints")
  @get
  getUserDefinedEndpoint is Azure.Core.Foundations.Operation<{}, Bundle>;

  /**
   * Creates the user defined endpoint in the ACL instance
   */
  @summary("Creates a user defined endpoint.")
  @route("/app/userDefinedEndpoints")
  @put
  createUserDefinedEndpoint is Azure.Core.Foundations.Operation<Bundle, void>;

  /**
   * It returns the runtime options
   */
  @summary("Runtime options for user defined endpoints.")
  @route("/app/userDefinedEndpoints/runtimeOptions")
  @get
  getRuntimeOptions is Azure.Core.Foundations.Operation<{}, JSRuntimeOptions>;

  /**
   * Updates the runtime options.
   */
  // FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
  // Problematic names: [JSRuntimeOptions]
  @summary("Runtime options for user defined endpoints.")
  @route("/app/userDefinedEndpoints/runtimeOptions")
  @patch
  updateRuntimeOptions is Azure.Core.Foundations.Operation<
    JSRuntimeOptions,
    JSRuntimeOptions
  >;

  /**
   * It gets the module for the user defined endpoint.
   */
  @summary("Module for user defined endpoints.")
  @route("/app/userDefinedEndpoints/modules")
  @get
  getUserDefinedEndpointsModule is Azure.Core.Foundations.Operation<
    {
      /**
       * module name of the user defined endpoint
       */
      @query("module_name")
      module_name: string;
    },
    ModuleDef
  >;

  /**
   * User defined functions stored in the Confidential Ledger
   */
  @summary("Retrieves a list of user defined functions present in the Confidential Ledger")
  @route("/app/userDefinedFunctions")
  @get
  listUserDefinedFunctions is Azure.Core.Foundations.Operation<
    {},
    PagedUserDefinedFunctions
  >;

  /**
   * Deletes a user defined function from the Confidential Ledger.
   */
  @summary("Deletes a user defined function from the Confidential Ledger.")
  @route("/app/userDefinedFunctions/{functionId}")
  @delete
  deleteUserDefinedFunction is Azure.Core.Foundations.Operation<
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
  @summary("Gets a user defined function.")
  @route("/app/userDefinedFunctions/{functionId}")
  @get
  getUserDefinedFunction is Azure.Core.Foundations.Operation<
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
  @summary("Creates a user defined function.")
  @route("/app/userDefinedFunctions/{functionId}")
  @put
  createUserDefinedFunction is Azure.Core.Foundations.Operation<
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
    UserDefinedFunction
  >;

  /**
   * Executes the user defined function in the Confidential Ledger
   */
  @summary("Executes a user defined function.")
  @route("/app/userDefinedFunctions/{functionId}:execute")
  @post
  executeUserDefinedFunction is Azure.Core.Foundations.Operation<
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
  @summary("Gets role actions for user defined roles")
  @route("/app/roles")
  @get
  getUserDefinedRole is Azure.Core.Foundations.Operation<
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
  @summary("Creates new roles and their actions")
  @route("/app/roles")
  @put
  createUserDefinedRole is Azure.Core.Foundations.Operation<
    {
      @bodyRoot body: Role[];
    },
    void
  >;

  /**
   * User defined roles allow users to define and manage app specific AuthZ policy.
   */
  @summary("""
    Patch replaces the allowed action on existing roles,if the desire is to remove
    an existing action, the role must be deleted and recreated.
    """)
  @route("/app/roles")
  @patch
  updateUserDefinedRole is Azure.Core.Foundations.Operation<
    {
      @bodyRoot body: Role[];
    },
    void
  >;

  /**
   * A user defined role allows the users to create and manage their own role
   * actions using the API.
   */
  @summary("Deletes user defined roles")
  @route("/app/roles")
  @delete
  deleteUserDefinedRole is Azure.Core.Foundations.Operation<
    {
      /**
       * user defined role name
       */
      @query("roleName")
      roleName: string;
    },
    void
  >;
}
