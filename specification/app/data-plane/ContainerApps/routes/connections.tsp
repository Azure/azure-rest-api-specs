using Http;
using Azure.Core;

namespace ContainerAppsSandbox;

/** No Content. */
model DeleteConnectionResult {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

/** Errors returned by deleteConnection. */
alias DeleteConnectionErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<500>;

/** OK. */
model ListConnectionResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: Connection[];
}

/** Errors returned by listConnections. */
alias ListConnectionErrors = ErrorResult<401> | ErrorResult<500>;

/** OK. */
model GetConnectionResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: Connection;
}

/** Errors returned by getConnection. */
alias GetConnectionErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceDelete cannot preserve the existing force query parameter, 204 response, and custom error status shapes without changing the established wire contract."
  @summary("Deletes a connection by ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/connections/{id}")
  @delete
  deleteConnection is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** force parameter. */
      @query force?: boolean;
    },
    DeleteConnectionResult,
    DataPlaneStandardTraits,
    DeleteConnectionErrors
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
    ListConnectionResult,
    DataPlaneStandardTraits,
    ListConnectionErrors
  >;

  /** Gets a specific connection by ID. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceRead cannot preserve the existing includeSandboxIds query parameter and custom success/error response shapes without changing the established wire contract."
  @summary("Gets a specific connection by ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/connections/{id}")
  @get
  getConnection is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** includeSandboxIds parameter. */
      @query includeSandboxIds?: boolean;
    },
    GetConnectionResult,
    DataPlaneStandardTraits,
    GetConnectionErrors
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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core standard operations cannot preserve this existing connection authorization action and its custom success/error response shapes without changing the established wire contract."
  @summary("Authorizes a connection with parameter values.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/connections/{id}/authorize")
  @post
  postConnectionAuthorize is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: AuthorizeConnectionContent;
    },
    PostConnectionAuthorizeResult,
    DataPlaneStandardTraits,
    PostConnectionAuthorizeErrors
  >;

  /** Generates a consent link for a connection. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core standard operations cannot preserve this existing consent-link action and its custom success/error response shapes without changing the established wire contract."
  @summary("Generates a consent link for a connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/connections/{id}/consentLink")
  @post
  postConnectionConsentLink is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body?: GenerateConsentLinkContent;
    },
    PostConnectionConsentLinkResult,
    DataPlaneStandardTraits,
    PostConnectionConsentLinkErrors
  >;

  /** Refreshes a connection's state from the upstream provider. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core standard operations cannot preserve this existing connection refresh action and its custom success/error response shapes without changing the established wire contract."
  @summary("Refreshes a connection's state from the upstream provider.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/connections/{id}/refresh")
  @post
  postConnectionRefresh is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** includeSandboxIds parameter. */
      @query includeSandboxIds?: boolean;
    },
    PostConnectionRefreshResult,
    DataPlaneStandardTraits,
    PostConnectionRefreshErrors
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
