using Http;
using Rest;
using Azure.Core;
using Azure.Core.Traits;

namespace ContainerAppsSandbox;

/** Error responses for the deleteEgressPolicy operation. */
alias DeleteEgressPolicyErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for deleting named egress policies. */
alias EgressPolicyDeleteOperations = ResourceOperations<
  DataPlaneStandardTraits,
  DeleteEgressPolicyErrors
>;

/** Error responses for the listEgressPolicy operation. */
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

/** Shared operation traits for listing egress policies. */
alias EgressPolicyListOperations = ResourceOperations<
  DataPlaneStandardTraits,
  ListEgressPolicyErrors
>;

/** Error responses for the getEgressPolicy operation. */
alias GetEgressPolicyErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for reading named egress policies. */
alias EgressPolicyGetOperations = ResourceOperations<
  DataPlaneStandardTraits,
  GetEgressPolicyErrors
>;

/** The HTTP 200 response for the putEgressPolicy operation. */
model PutEgressPolicyResult200 {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned egress policy. */
  @body body: NamedEgressPolicy;
}

/** The HTTP 201 response for the putEgressPolicy operation. */
model PutEgressPolicyResult201 {
  /** The HTTP 201 status code. */
  @statusCode statusCode: 201;

  /** The returned egress policy. */
  @body body: NamedEgressPolicy;
}

/** Successful responses for the putEgressPolicy operation. */
alias PutEgressPolicyResult =
  | PutEgressPolicyResult200
  | PutEgressPolicyResult201;

/** Error responses for the putEgressPolicy operation. */
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

      /** The egress policy identifier. */
      @path policyId: string;

      /** The named egress policy to create or replace. */
      @body body: NamedEgressPolicy;
    },
    PutEgressPolicyResult,
    DataPlaneStandardTraits,
    PutEgressPolicyErrors
  >;
}
