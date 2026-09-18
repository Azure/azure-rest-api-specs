using Http;
using Rest;
using Azure.Core;
using Azure.Core.Traits;

namespace ContainerAppsSandbox;

/** Error responses for the deleteConnection operation. */
alias DeleteConnectionErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

/** Query parameters for deleting a connection. */
alias DeleteConnectionTraits = QueryParametersTrait<
  {
    /** Whether to force deletion of the connection. */
    @query force?: boolean;
  },
  TraitContext.Delete
>;

/** Shared operation traits for deleting connections. */
alias ConnectionDeleteOperations = ResourceOperations<
  DataPlaneStandardTraits,
  DeleteConnectionErrors
>;

/** Error responses for the listConnection operation. */
alias ListConnectionErrors =
  | UnauthorizedErrorResult
  | InternalServerErrorResult;

/** Query parameters for listing connections. */
alias ListConnectionTraits = QueryParametersTrait<
  {
    /** Whether to include sandbox identifiers using each connection. */
    @query includeSandboxIds?: boolean;

    /** Comma-separated key=value labels that all resources must match. */
    @query labels?: string;

    /** Continuation token for paginated results. */
    @query @continuationToken skipToken?: string;
  },
  TraitContext.List
>;

/** Shared operation traits for listing connections. */
alias ConnectionListOperations = ResourceOperations<
  DataPlaneStandardTraits,
  ListConnectionErrors
>;

/** Error responses for the getConnection operation. */
alias GetConnectionErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** Query parameters for reading a connection. */
alias GetConnectionTraits = QueryParametersTrait<
  {
    /** Whether to include sandbox identifiers using the connection. */
    @query includeSandboxIds?: boolean;
  },
  TraitContext.Read
>;

/** Shared operation traits for reading connections. */
alias ConnectionGetOperations = ResourceOperations<
  DataPlaneStandardTraits,
  GetConnectionErrors
>;

/** The HTTP 200 response for the postConnection operation. */
model PostConnectionResult200 {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned connection. */
  @body body: Connection;
}

/** The HTTP 201 response for the postConnection operation. */
model PostConnectionResult201 {
  /** The HTTP 201 status code. */
  @statusCode statusCode: 201;

  /** The returned connection. */
  @body body: Connection;
}

/** Successful responses for the postConnection operation. */
alias PostConnectionResult = PostConnectionResult200 | PostConnectionResult201;

/** Error responses for the postConnection operation. */
alias PostConnectionErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | InternalServerErrorResult;

/** The HTTP 200 response for the postConnectionAuthorize operation. */
model PostConnectionAuthorizeResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned connection. */
  @body body: Connection;
}

/** Error responses for the postConnectionAuthorize operation. */
alias PostConnectionAuthorizeErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for authorizing connections. */
alias ConnectionAuthorizeOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostConnectionAuthorizeErrors
>;

/** The HTTP 200 response for the postConnectionConsentLink operation. */
model PostConnectionConsentLinkResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned consent link. */
  @body body: GenerateConsentLinkResponse;
}

/** Error responses for the postConnectionConsentLink operation. */
alias PostConnectionConsentLinkErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for generating connection consent links. */
alias ConnectionConsentLinkOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostConnectionConsentLinkErrors
>;

/** The HTTP 200 response for the postConnectionRefresh operation. */
model PostConnectionRefreshResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned connection. */
  @body body: Connection;
}

/** Error responses for the postConnectionRefresh operation. */
alias PostConnectionRefreshErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for refreshing connections. */
alias ConnectionRefreshOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostConnectionRefreshErrors
>;

/** The HTTP 200 response for the putConnectionPolicyRules operation. */
model PutConnectionPolicyRulesResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned connection. */
  @body body: Connection;
}

/** Error responses for the putConnectionPolicyRules operation. */
alias PutConnectionPolicyRulesErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "CreateConnectionAsync is a custom POST operation with a DataPlaneConnectionCreateRequest body and implementation-specific 200-or-201 behavior based on whether a connection was newly created."
  @summary("Creates a new connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/connections")
  @post
  postConnection is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** The connection configuration to create. */
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
      /** Provider-specific authorization parameters. */
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
      /** Options for the generated consent link. */
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
      /** Whether to include identifiers of sandboxes using the connection. */
      @query includeSandboxIds?: boolean;
    },
    PostConnectionRefreshResult
  >;

  /** Updates the policy rules and tool settings on a connection. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "PUT {id}/policyRules is a custom policyRules subresource update endpoint, so the operation name intentionally mirrors the HTTP method and route."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "UpdatePolicyRulesAsync is a custom PUT subresource operation that accepts UpdatePolicyRulesRequest, returns the updated connection with 200, maps policy and tool validation failures to 400, and returns 404 when the connection is not found."
  @summary("Updates the policy rules and tool settings on a connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/connections/{id}/policyRules")
  @put
  putConnectionPolicyRules is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** The connection identifier. */
      @path id: string;

      /** The policy rules and enabled tool groups to apply. */
      @body body: UpdatePolicyRulesContent;
    },
    PutConnectionPolicyRulesResult,
    DataPlaneStandardTraits,
    PutConnectionPolicyRulesErrors
  >;
}
