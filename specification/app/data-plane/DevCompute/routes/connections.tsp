using Http;
using Azure.Core;

namespace AzureDevCompute;

/** No Content. */
model DeleteConnectionsResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

/** Errors returned by deleteConnections. */
alias DeleteConnectionsErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | InternalServerErrorNoBody;

/** OK. */
model ListConnectionResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: ConnectionResponse[];
}

/** Errors returned by listConnections. */
alias ListConnectionErrors = ErrorResponse<401> | InternalServerErrorNoBody;

/** OK. */
model GetConnectionResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: ConnectionResponse;
}

/** Errors returned by getConnections. */
alias GetConnectionErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

/** OK. */
model PostConnectionsResponse200 {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: ConnectionResponse;
}

/** Created. */
model PostConnectionsResponse201 {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response body. */
  @body body: ConnectionResponse;
}

/** Successful responses returned by postConnections. */
alias PostConnectionsResponse =
  | PostConnectionsResponse200
  | PostConnectionsResponse201;

/** Errors returned by postConnections. */
alias PostConnectionsErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | InternalServerErrorNoBody;

/** OK. */
model PostConnectionsAuthorizeResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: ConnectionResponse;
}

/** Errors returned by postConnectionsAuthorize. */
alias PostConnectionsAuthorizeErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

/** OK. */
model PostConnectionsConsentLinkResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: GenerateConsentLinkResponse;
}

/** Errors returned by postConnectionsConsentLink. */
alias PostConnectionsConsentLinkErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

/** OK. */
model PostConnectionsRefreshResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: ConnectionResponse;
}

/** Errors returned by postConnectionsRefresh. */
alias PostConnectionsRefreshErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

/** OK. */
model PutConnectionsPolicyRulesResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: ConnectionResponse;
}

/** Errors returned by putConnectionsPolicyRules. */
alias PutConnectionsPolicyRulesErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

@tag("connections")
interface ConnectionsOperations {
  /** Deletes a connection by ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceDelete cannot preserve the existing force query parameter, 204 response, and custom error status shapes without changing the established wire contract."
  @summary("Deletes a connection by ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/connections/{id}")
  @delete
  deleteConnections is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** force parameter. */
      @query force?: boolean;
    },
    DeleteConnectionsResponse,
    DataPlaneStandardTraits,
    DeleteConnectionsErrors
  >;

  /** Lists connections in a sandbox group. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceList cannot preserve the existing includeSandboxIds, Page, PageSize, and labels query parameter names or the bare-array response without changing the established wire contract."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This list operation uses a custom response model to preserve the existing bare-array wire contract, which the rule misclassifies as a single-object response."
  @summary("Lists connections in a sandbox group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/connections")
  @get
  listConnections is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** includeSandboxIds parameter. */
      @query includeSandboxIds?: boolean;

      /** Page number to retrieve. */
      @query("Page") page?: int32;

      /** Number of items to return per page. */
      @query("PageSize") pageSize?: int32;

      /** Label selector for filtering resources. Accepts comma-separated key=value pairs(e.g., "env=prod,team=backend"). Returns only resources that have all specified labels with matching values. */
      @query labels?: string;
    },
    ListConnectionResponse,
    DataPlaneStandardTraits,
    ListConnectionErrors
  >;

  /** Gets a specific connection by ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceRead cannot preserve the existing includeSandboxIds query parameter and custom success/error response shapes without changing the established wire contract."
  @summary("Gets a specific connection by ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/connections/{id}")
  @get
  getConnections is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** includeSandboxIds parameter. */
      @query includeSandboxIds?: boolean;
    },
    GetConnectionResponse,
    DataPlaneStandardTraits,
    GetConnectionErrors
  >;

  /** Creates a new connection. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core standard operations cannot preserve the existing POST route, request body, 200 and 201 responses, and custom error status shapes without changing the established wire contract."
  @summary("Creates a new connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/connections")
  @post
  postConnections is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** Request body. */
      @body body: ConnectionCreateRequest;
    },
    PostConnectionsResponse,
    DataPlaneStandardTraits,
    PostConnectionsErrors
  >;

  /** Authorizes a connection with parameter values. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core standard operations cannot preserve this existing connection authorization action and its custom success/error response shapes without changing the established wire contract."
  @summary("Authorizes a connection with parameter values.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/connections/{id}/authorize")
  @post
  postConnectionsAuthorize is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: AuthorizeConnectionRequest;
    },
    PostConnectionsAuthorizeResponse,
    DataPlaneStandardTraits,
    PostConnectionsAuthorizeErrors
  >;

  /** Generates a consent link for a connection. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core standard operations cannot preserve this existing consent-link action and its custom success/error response shapes without changing the established wire contract."
  @summary("Generates a consent link for a connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/connections/{id}/consentLink")
  @post
  postConnectionsConsentLink is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body?: GenerateConsentLinkRequest;
    },
    PostConnectionsConsentLinkResponse,
    DataPlaneStandardTraits,
    PostConnectionsConsentLinkErrors
  >;

  /** Refreshes a connection's state from the upstream provider. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core standard operations cannot preserve this existing connection refresh action and its custom success/error response shapes without changing the established wire contract."
  @summary("Refreshes a connection's state from the upstream provider.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/connections/{id}/refresh")
  @post
  postConnectionsRefresh is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** includeSandboxIds parameter. */
      @query includeSandboxIds?: boolean;
    },
    PostConnectionsRefreshResponse,
    DataPlaneStandardTraits,
    PostConnectionsRefreshErrors
  >;

  /** Updates the policy rules and tool settings on a connection. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "The existing policy-rules PUT operation name is preserved to avoid changing its generated operation ID."
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core standard operations cannot preserve this existing policy-rules route, request body, and custom success/error response shapes without changing the established wire contract."
  @summary("Updates the policy rules and tool settings on a connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/connections/{id}/policyRules")
  @put
  putConnectionsPolicyRules is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: UpdatePolicyRulesRequest;
    },
    PutConnectionsPolicyRulesResponse,
    DataPlaneStandardTraits,
    PutConnectionsPolicyRulesErrors
  >;
}
