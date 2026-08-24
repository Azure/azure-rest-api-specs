using Http;
using TypeSpec.Versioning;
using Azure.Core;

namespace AzureDevCompute;

/** OK. */
@removed(ApiVersions.v2026_09_01)
model GetSandboxesEgressDecisionsResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: EgressDecisionsResponse;
}

/** Errors returned by getSandboxesEgressDecisions. */
alias GetSandboxesEgressDecisionsErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | InternalServerErrorNoBody;

/** OK. */
@added(ApiVersions.v2026_09_01)
model GetSandboxesEgressDecisions2Response {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: EgressDecisionsResponse;
}

/** Errors returned by getSandboxesEgressDecisions2. */
alias GetSandboxesEgressDecisions2Errors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | InternalServerErrorNoBody;

/** OK. */
model GetSandboxesPortsResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: PortsListResponse;
}

/** Errors returned by getSandboxesPorts. */
alias GetSandboxesPortsErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

/** OK. */
model PatchSandboxesPortsResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: PortsListResponse;
}

/** Errors returned by patchSandboxesPorts. */
alias PatchSandboxesPortsErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | InternalServerErrorNoBody;

/** OK. */
model PostSandboxesConnectionsAddResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: ConnectionsListResponse;
}

/** Errors returned by postSandboxesConnectionsAdd. */
alias PostSandboxesConnectionsAddErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | InternalServerErrorNoBody;

/** OK. */
model PostSandboxesEgresspolicyResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SandboxEgressPolicy;
}

/** Errors returned by postSandboxesEgresspolicy. */
alias PostSandboxesEgresspolicyErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | InternalServerErrorNoBody;

/** OK. */
model PostSandboxesPortsAddResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: PortsListResponse;
}

/** Errors returned by postSandboxesPortsAdd. */
alias PostSandboxesPortsAddErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | InternalServerErrorNoBody;

/** OK. */
model PostSandboxesPortsRemoveResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: PortsListResponse;
}

/** Errors returned by postSandboxesPortsRemove. */
alias PostSandboxesPortsRemoveErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | InternalServerErrorNoBody;

/** OK. */
model PutSandboxesPortsResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: PortsListResponse;
}

/** Errors returned by putSandboxesPorts. */
alias PutSandboxesPortsErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | InternalServerErrorNoBody;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("sandboxes")
interface SandboxNetworkingOperations {
  /** Gets egress decisions for a sandbox. */
  @removed(ApiVersions.v2026_09_01)
  @summary("Gets egress decisions for a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/egress-decisions")
  @get
  getSandboxesEgressDecisions is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    GetSandboxesEgressDecisionsResponse,
    DataPlaneStandardTraits,
    GetSandboxesEgressDecisionsErrors
  >;

  /** Gets egress decisions for a sandbox. */
  @added(ApiVersions.v2026_09_01)
  @summary("Gets egress decisions for a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/egressDecisions")
  @get
  getSandboxesEgressDecisions2 is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    GetSandboxesEgressDecisions2Response,
    DataPlaneStandardTraits,
    GetSandboxesEgressDecisions2Errors
  >;

  /** Gets the list of ports for a sandbox. */
  @summary("Gets the list of ports for a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/ports")
  @get
  getSandboxesPorts is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    GetSandboxesPortsResponse,
    DataPlaneStandardTraits,
    GetSandboxesPortsErrors
  >;

  /** Updates a single port on a sandbox (partial update). */
  @summary("Updates a single port on a sandbox (partial update).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/ports")
  @patch
  patchSandboxesPorts is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: PatchPortRequest;
    },
    PatchSandboxesPortsResponse,
    DataPlaneStandardTraits,
    PatchSandboxesPortsErrors
  >;

  /** Adds a connection to a sandbox. */
  @summary("Adds a connection to a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/connections/add")
  @post
  postSandboxesConnectionsAdd is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: AddConnectionRequest;
    },
    PostSandboxesConnectionsAddResponse,
    DataPlaneStandardTraits,
    PostSandboxesConnectionsAddErrors
  >;

  /** Sets the egress policy for a sandbox. */
  @summary("Sets the egress policy for a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/egresspolicy")
  @post
  postSandboxesEgresspolicy is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: SandboxEgressPolicy;
    },
    PostSandboxesEgresspolicyResponse,
    DataPlaneStandardTraits,
    PostSandboxesEgresspolicyErrors
  >;

  /** Adds a port to a sandbox. */
  @summary("Adds a port to a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/ports/add")
  @post
  postSandboxesPortsAdd is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: AddPortRequest;
    },
    PostSandboxesPortsAddResponse,
    DataPlaneStandardTraits,
    PostSandboxesPortsAddErrors
  >;

  /** Removes a port from a sandbox. */
  @summary("Removes a port from a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/ports/remove")
  @post
  postSandboxesPortsRemove is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: RemovePortRequest;
    },
    PostSandboxesPortsRemoveResponse,
    DataPlaneStandardTraits,
    PostSandboxesPortsRemoveErrors
  >;

  /** Updates all ports for a sandbox. */
  @summary("Updates all ports for a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/ports")
  @put
  putSandboxesPorts is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: UpdatePortsRequest;
    },
    PutSandboxesPortsResponse,
    DataPlaneStandardTraits,
    PutSandboxesPortsErrors
  >;
}
