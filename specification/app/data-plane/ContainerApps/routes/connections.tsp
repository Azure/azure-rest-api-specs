using Http;
using Rest;
using Azure.Core;
using Azure.Core.Traits;

namespace ContainerAppsSandbox;

/** Errors returned by deleteConnection. */
alias DeleteConnectionErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<500>;

/** Query parameters for deleting a connection. */
alias DeleteConnectionTraits = QueryParametersTrait<
  {
    /** Whether to force deletion of the connection. */
    @query force?: boolean;
  },
  TraitContext.Delete
>;

/** Standard resource operations for deleting connections. */
alias ConnectionDeleteOperations = ResourceOperations<
  DataPlaneStandardTraits,
  DeleteConnectionErrors
>;

/** Errors returned by listConnections. */
alias ListConnectionErrors = ErrorResult<401> | ErrorResult<500>;

/** Query parameters for listing connections. */
alias ListConnectionTraits = QueryParametersTrait<
  {
    /** Whether to include sandbox identifiers using each connection. */
    @query includeSandboxIds?: boolean;

    /** Label selector for filtering resources. Accepts comma-separated key=value pairs(e.g., "env=prod,team=backend"). Returns only resources that have all specified labels with matching values. */
    @query labels?: string;

    /** Continuation token for paginated results. */
    @query @continuationToken continuationToken?: string;
  },
  TraitContext.List
>;

/** Standard resource operations for listing connections. */
alias ConnectionListOperations = ResourceOperations<
  DataPlaneStandardTraits,
  ListConnectionErrors
>;

/** Errors returned by getConnection. */
alias GetConnectionErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

/** Query parameters for reading a connection. */
alias GetConnectionTraits = QueryParametersTrait<
  {
    /** Whether to include sandbox identifiers using the connection. */
    @query includeSandboxIds?: boolean;
  },
  TraitContext.Read
>;

/** Standard resource operations for reading connections. */
alias ConnectionGetOperations = ResourceOperations<
  DataPlaneStandardTraits,
  GetConnectionErrors
>;

/** OK. */
model PostConnectionResult200 {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: Connection;
}

/** Created. */
model PostConnectionResult201 {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response body. */
  @body body: Connection;
}

/** Successful responses returned by postConnection. */
alias PostConnectionResult = PostConnectionResult200 | PostConnectionResult201;

/** Errors returned by postConnection. */
alias PostConnectionErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<500>;

/** OK. */
model PostConnectionAuthorizeResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: Connection;
}

/** Errors returned by postConnectionAuthorize. */
alias PostConnectionAuthorizeErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

/** Standard resource operations for authorizing connections. */
alias ConnectionAuthorizeOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostConnectionAuthorizeErrors
>;

/** OK. */
model PostConnectionConsentLinkResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: GenerateConsentLinkResponse;
}

/** Errors returned by postConnectionConsentLink. */
alias PostConnectionConsentLinkErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

/** Standard resource operations for generating connection consent links. */
alias ConnectionConsentLinkOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostConnectionConsentLinkErrors
>;

/** OK. */
model PostConnectionRefreshResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: Connection;
}

/** Errors returned by postConnectionRefresh. */
alias PostConnectionRefreshErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

/** Standard resource operations for refreshing connections. */
alias ConnectionRefreshOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostConnectionRefreshErrors
>;

/** OK. */
model PutConnectionPolicyRulesResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: Connection;
}

/** Errors returned by putConnectionPolicyRules. */
alias PutConnectionPolicyRulesErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

@tag("connections")
interface ConnectionsOperations {
  /** Deletes a connection by ID. */
  @summary("Deletes a connection by ID.")
  deleteConnection is ConnectionDeleteOperations.ResourceDelete<
    Connection,
    DeleteConnectionTraits
  >;

  /** Lists connections in a sandbox group. */
  @summary("Lists connections in a sandbox group.")
  listConnections is ConnectionListOperations.ResourceList<
    Connection,
    ListConnectionTraits
  >;

  /** Gets a specific connection by ID. */
  @summary("Gets a specific connection by ID.")
  getConnection is ConnectionGetOperations.ResourceRead<
    Connection,
    GetConnectionTraits
  >;

  /** Creates a new connection. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core standard operations cannot preserve the existing POST route, request body, 200 and 201 responses, and custom error status shapes without changing the established wire contract."
  @summary("Creates a new connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/connections")
  @post
  postConnection is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** Request body. */
      @body body: CreateConnectionContent;
    },
    PostConnectionResult,
    DataPlaneStandardTraits,
    PostConnectionErrors
  >;

  /** Authorizes a connection with parameter values. */
  @summary("Authorizes a connection with parameter values.")
  @action("authorize")
  @actionSeparator("/")
  postConnectionAuthorize is ConnectionAuthorizeOperations.ResourceAction<
    Connection,
    {
      /** Request body. */
      @body body: AuthorizeConnectionContent;
    },
    PostConnectionAuthorizeResult
  >;

  /** Generates a consent link for a connection. */
  @summary("Generates a consent link for a connection.")
  @action("consentLink")
  @actionSeparator("/")
  postConnectionConsentLink is ConnectionConsentLinkOperations.ResourceAction<
    Connection,
    {
      /** Request body. */
      @body body?: GenerateConsentLinkContent;
    },
    PostConnectionConsentLinkResult
  >;

  /** Refreshes a connection's state from the upstream provider. */
  @summary("Refreshes a connection's state from the upstream provider.")
  @action("refresh")
  @actionSeparator("/")
  postConnectionRefresh is ConnectionRefreshOperations.ResourceAction<
    Connection,
    {
      /** includeSandboxIds parameter. */
      @query includeSandboxIds?: boolean;
    },
    PostConnectionRefreshResult
  >;

  /** Updates the policy rules and tool settings on a connection. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This connection subresource operation uses the approved putConnectionPolicyRules name instead of the standard replace prefix."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core standard operations cannot preserve this existing policy-rules route, request body, and custom success/error response shapes without changing the established wire contract."
  @summary("Updates the policy rules and tool settings on a connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/connections/{id}/policyRules")
  @put
  putConnectionPolicyRules is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: UpdatePolicyRulesContent;
    },
    PutConnectionPolicyRulesResult,
    DataPlaneStandardTraits,
    PutConnectionPolicyRulesErrors
  >;
}
