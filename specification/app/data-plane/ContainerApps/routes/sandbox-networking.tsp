using Http;
using Azure.Core;

namespace ContainerAppsSandbox;

/** OK. */
model GetSandboxEgressDecisions2Result {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: EgressDecisionsResponse;
}

/** Errors returned by getSandboxEgressDecisions2. */
alias GetSandboxEgressDecisions2Errors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<500>;

/** OK. */
model GetSandboxPortsResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: PortsListResponse;
}

/** Errors returned by getSandboxPorts. */
alias GetSandboxPortsErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

/** OK. */
model PatchSandboxPortResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: PortsListResponse;
}

/** Errors returned by patchSandboxPort. */
alias PatchSandboxPortErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<500>;

/** OK. */
model PostSandboxConnectionAddResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: ConnectionsListResponse;
}

/** Errors returned by postSandboxConnectionAdd. */
alias PostSandboxConnectionAddErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<500>;

/** OK. */
model PostSandboxEgressPolicyResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SandboxEgressPolicy;
}

/** Errors returned by postSandboxEgressPolicy. */
alias PostSandboxEgressPolicyErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<500>;

/** OK. */
model PostSandboxPortAddResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: PortsListResponse;
}

/** Errors returned by postSandboxPortAdd. */
alias PostSandboxPortAddErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<500>;

/** OK. */
model PostSandboxPortRemoveResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: PortsListResponse;
}

/** Errors returned by postSandboxPortRemove. */
alias PostSandboxPortRemoveErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<500>;

/** OK. */
model PutSandboxPortsResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: PortsListResponse;
}

/** Errors returned by putSandboxPorts. */
alias PutSandboxPortsErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<500>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("sandboxes")
interface SandboxNetworkingOperations {
  /** Gets egress decisions for a sandbox. */
  @summary("Gets egress decisions for a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/egressDecisions")
  @get
  getSandboxEgressDecisions2 is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    GetSandboxEgressDecisions2Result,
    DataPlaneStandardTraits,
    GetSandboxEgressDecisions2Errors
  >;

  /** Gets the list of ports for a sandbox. */
  @summary("Gets the list of ports for a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/ports")
  @get
  getSandboxPorts is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    GetSandboxPortsResult,
    DataPlaneStandardTraits,
    GetSandboxPortsErrors
  >;

  /** Updates a single port on a sandbox (partial update). */
  @summary("Updates a single port on a sandbox (partial update).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/ports")
  @patch
  patchSandboxPort is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: UpdateSandboxPortContent;
    },
    PatchSandboxPortResult,
    DataPlaneStandardTraits,
    PatchSandboxPortErrors
  >;

  /** Adds a connection to a sandbox. */
  @summary("Adds a connection to a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/connections/add")
  @post
  postSandboxConnectionAdd is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: AddConnectionContent;
    },
    PostSandboxConnectionAddResult,
    DataPlaneStandardTraits,
    PostSandboxConnectionAddErrors
  >;

  /** Sets the egress policy for a sandbox. */
  @summary("Sets the egress policy for a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/egresspolicy")
  @post
  postSandboxEgressPolicy is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: SandboxEgressPolicy;
    },
    PostSandboxEgressPolicyResult,
    DataPlaneStandardTraits,
    PostSandboxEgressPolicyErrors
  >;

  /** Adds a port to a sandbox. */
  @summary("Adds a port to a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/ports/add")
  @post
  postSandboxPortAdd is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: CreateSandboxPortContent;
    },
    PostSandboxPortAddResult,
    DataPlaneStandardTraits,
    PostSandboxPortAddErrors
  >;

  /** Removes a port from a sandbox. */
  @summary("Removes a port from a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/ports/remove")
  @post
  postSandboxPortRemove is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: RemovePortContent;
    },
    PostSandboxPortRemoveResult,
    DataPlaneStandardTraits,
    PostSandboxPortRemoveErrors
  >;

  /** Updates all ports for a sandbox. */
  @summary("Updates all ports for a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/ports")
  @put
  putSandboxPorts is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: UpdatePortsContent;
    },
    PutSandboxPortsResult,
    DataPlaneStandardTraits,
    PutSandboxPortsErrors
  >;
}
