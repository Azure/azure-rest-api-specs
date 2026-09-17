using Http;
using Rest;
using Azure.Core;
using Azure.Core.Traits;

namespace ContainerAppsSandbox;

/** Errors returned by deleteEgressPolicy. */
alias DeleteEgressPolicyErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** Standard resource operations for deleting named egress policies. */
alias EgressPolicyDeleteOperations = ResourceOperations<
  DataPlaneStandardTraits,
  DeleteEgressPolicyErrors
>;

/** Errors returned by listEgressPolicies. */
alias ListEgressPolicyErrors =
  | UnauthorizedErrorResult
  | InternalServerErrorResult;

/** Query parameters for listing egress policies. */
alias ListEgressPolicyTraits = QueryParametersTrait<
  {
    /** Continuation token for paginated results. */
    @query @continuationToken skipToken?: string;
  },
  TraitContext.List
>;

/** Standard resource operations for listing egress policies. */
alias EgressPolicyListOperations = ResourceOperations<
  DataPlaneStandardTraits,
  ListEgressPolicyErrors
>;

/** Errors returned by getEgressPolicy. */
alias GetEgressPolicyErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** Standard resource operations for reading named egress policies. */
alias EgressPolicyGetOperations = ResourceOperations<
  DataPlaneStandardTraits,
  GetEgressPolicyErrors
>;

/** OK. */
model PutEgressPolicyResult200 {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: NamedEgressPolicy;
}

/** Created. */
model PutEgressPolicyResult201 {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response body. */
  @body body: NamedEgressPolicy;
}

/** Successful responses returned by putEgressPolicy. */
alias PutEgressPolicyResult =
  | PutEgressPolicyResult200
  | PutEgressPolicyResult201;

/** Errors returned by putEgressPolicy. */
alias PutEgressPolicyErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | InternalServerErrorResult;

@tag("egressPolicies")
interface EgressPoliciesOperations {
  /** Deletes a named egress policy by ID. */
  @summary("Deletes a named egress policy by ID.")
  deleteEgressPolicy is EgressPolicyDeleteOperations.ResourceDelete<NamedEgressPolicy>;

  /** Lists all named egress policies in a sandbox group. */
  @summary("Lists all named egress policies in a sandbox group.")
  listEgressPolicies is EgressPolicyListOperations.ResourceList<
    NamedEgressPolicy,
    ListEgressPolicyTraits
  >;

  /** Gets a specific named egress policy by ID. */
  @summary("Gets a specific named egress policy by ID.")
  getEgressPolicy is EgressPolicyGetOperations.ResourceRead<NamedEgressPolicy>;

  /** Creates or updates a named egress policy. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "The custom PUT operation preserves the established 200 response and error status shapes, which Azure.Core ResourceOperations.ResourceCreateOrReplace cannot represent without changing the wire contract."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "The established operation name is retained to keep generated client names deterministic."
  @summary("Creates or updates a named egress policy.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/egressPolicies/{policyId}")
  @put
  putEgressPolicy is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** policyId parameter. */
      @path policyId: string;

      /** Request body. */
      @body body: NamedEgressPolicy;
    },
    PutEgressPolicyResult,
    DataPlaneStandardTraits,
    PutEgressPolicyErrors
  >;
}
