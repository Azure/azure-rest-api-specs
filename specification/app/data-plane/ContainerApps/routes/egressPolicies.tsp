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

/** Error responses for the putEgressPolicy operation. */
alias PutEgressPolicyErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for creating or replacing named egress policies. */
alias EgressPolicyPutOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PutEgressPolicyErrors
>;

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
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "The established putEgressPolicy name is retained to keep generated client names deterministic; the operation itself uses the standard Azure.Core ResourceCreateOrReplace signature."
  @summary("Creates or updates a named egress policy.")
  putEgressPolicy is EgressPolicyPutOperations.ResourceCreateOrReplace<NamedEgressPolicy>;
}
