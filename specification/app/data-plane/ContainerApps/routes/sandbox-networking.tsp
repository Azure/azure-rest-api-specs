using Http;
using Rest;
using Azure.Core;

namespace ContainerAppsSandbox;

/** The HTTP 200 response for the getSandboxEgressDecisions operation. */
model GetSandboxEgressDecisionsResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned egress decisions. */
  @body body: EgressDecisionsResponse;
}

/** Error responses for the getSandboxEgressDecisions operation. */
alias GetSandboxEgressDecisionsErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

/** The HTTP 200 response for the getSandboxPorts operation. */
model GetSandboxPortsResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned configured ports. */
  @body body: PortsListResponse;
}

/** Error responses for the getSandboxPorts operation. */
alias GetSandboxPortsErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** The HTTP 200 response for the patchSandboxPort operation. */
model PatchSandboxPortResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned configured ports. */
  @body body: PortsListResponse;
}

/** Error responses for the patchSandboxPort operation. */
alias PatchSandboxPortErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

/** The HTTP 200 response for the postSandboxConnectionAdd operation. */
model PostSandboxConnectionAddResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned attached connections. */
  @body body: ConnectionsListResponse;
}

/** Error responses for the postSandboxConnectionAdd operation. */
alias PostSandboxConnectionAddErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for adding sandbox connections. */
alias SandboxConnectionAddOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxConnectionAddErrors
>;

/** The HTTP 200 response for the postSandboxEgressPolicy operation. */
model PostSandboxEgressPolicyResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned egress policy. */
  @body body: SandboxEgressPolicy;
}

/** Error responses for the postSandboxEgressPolicy operation. */
alias PostSandboxEgressPolicyErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for setting sandbox egress policies. */
alias SandboxEgressPolicyOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxEgressPolicyErrors
>;

/** The HTTP 200 response for the postSandboxPortAdd operation. */
model PostSandboxPortAddResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned configured ports. */
  @body body: PortsListResponse;
}

/** Error responses for the postSandboxPortAdd operation. */
alias PostSandboxPortAddErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for adding sandbox ports. */
alias SandboxPortAddOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxPortAddErrors
>;

/** The HTTP 200 response for the postSandboxPortRemove operation. */
model PostSandboxPortRemoveResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned configured ports. */
  @body body: PortsListResponse;
}

/** Error responses for the postSandboxPortRemove operation. */
alias PostSandboxPortRemoveErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for removing sandbox ports. */
alias SandboxPortRemoveOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxPortRemoveErrors
>;

/** The HTTP 200 response for the putSandboxPorts operation. */
model PutSandboxPortsResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned configured ports. */
  @body body: PortsListResponse;
}

/** Error responses for the putSandboxPorts operation. */
alias PutSandboxPortsErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("sandboxes")
interface SandboxNetworkingOperations {
  /** Gets egress decisions for a sandbox. */
  @summary("Gets egress decisions for a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/egressDecisions")
  @get
  getSandboxEgressDecisions is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** The sandbox identifier. */
      @path id: SandboxId;
    },
    GetSandboxEgressDecisionsResult,
    DataPlaneStandardTraits,
    GetSandboxEgressDecisionsErrors
  >;

  /** Gets the list of ports for a sandbox. */
  @summary("Gets the list of ports for a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/ports")
  @get
  getSandboxPorts is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** The sandbox identifier. */
      @path id: SandboxId;
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

      /** The sandbox identifier. */
      @path id: SandboxId;

      /** The fields to update on the port. */
      @body body: UpdateSandboxPortContent;
    },
    PatchSandboxPortResult,
    DataPlaneStandardTraits,
    PatchSandboxPortErrors
  >;

  /** Adds a connection to a sandbox. */
  @summary("Adds a connection to a sandbox.")
  @action("connections/add")
  @actionSeparator("/")
  postSandboxConnectionAdd is SandboxConnectionAddOperations.ResourceAction<
    Sandbox,
    {
      /** The connection to attach to the sandbox. */
      @body body: AddConnectionContent;
    },
    PostSandboxConnectionAddResult
  >;

  /** Sets the egress policy for a sandbox. */
  @summary("Sets the egress policy for a sandbox.")
  @action("egresspolicy")
  @actionSeparator("/")
  postSandboxEgressPolicy is SandboxEgressPolicyOperations.ResourceAction<
    Sandbox,
    {
      /** The egress policy to apply to the sandbox. */
      @body body: SandboxEgressPolicy;
    },
    PostSandboxEgressPolicyResult
  >;

  /** Adds a port to a sandbox. */
  @summary("Adds a port to a sandbox.")
  @action("ports/add")
  @actionSeparator("/")
  postSandboxPortAdd is SandboxPortAddOperations.ResourceAction<
    Sandbox,
    {
      /** The port configuration to add. */
      @body body: CreateSandboxPortContent;
    },
    PostSandboxPortAddResult
  >;

  /** Removes a port from a sandbox. */
  @summary("Removes a port from a sandbox.")
  @action("ports/remove")
  @actionSeparator("/")
  postSandboxPortRemove is SandboxPortRemoveOperations.ResourceAction<
    Sandbox,
    {
      /** The name or number of the port to remove. */
      @body body: RemovePortContent;
    },
    PostSandboxPortRemoveResult
  >;

  /** Updates all ports for a sandbox. */
  @summary("Updates all ports for a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/ports")
  @put
  putSandboxPorts is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** The sandbox identifier. */
      @path id: SandboxId;

      /** The complete port configuration for the sandbox. */
      @body body: UpdatePortsContent;
    },
    PutSandboxPortsResult,
    DataPlaneStandardTraits,
    PutSandboxPortsErrors
  >;
}
