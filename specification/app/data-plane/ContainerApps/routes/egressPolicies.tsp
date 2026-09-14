using Http;
using Rest;
using Azure.Core;

namespace ContainerAppsSandbox;

/** Errors returned by deleteEgressPolicy. */
alias DeleteEgressPolicyErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

/** Standard resource operations for deleting named egress policies. */
alias EgressPolicyDeleteOperations = ResourceOperations<
  DataPlaneStandardTraits,
  DeleteEgressPolicyErrors
>;

/** OK. */
model ListEgressPolicyResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: NamedEgressPolicyListResponse;
}

/** Errors returned by listEgressPolicies. */
alias ListEgressPolicyErrors = ErrorResult<401> | ErrorResult<500>;

/** Errors returned by getEgressPolicy. */
alias GetEgressPolicyErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

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
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<500>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
@tag("egressPolicies")
interface EgressPoliciesOperations {
  /** Deletes a named egress policy by ID. */
  @summary("Deletes a named egress policy by ID.")
  deleteEgressPolicy is EgressPolicyDeleteOperations.ResourceDelete<NamedEgressPolicy>;

  /** Lists all named egress policies in a sandbox group. */
  @summary("Lists all named egress policies in a sandbox group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/egressPolicies")
  @listsResource(NamedEgressPolicy)
  @get
  listEgressPolicies is Foundations.Operation<
    {
      ...AzureResourceScope;
    },
    ListEgressPolicyResult,
    DataPlaneStandardTraits,
    ListEgressPolicyErrors
  >;

  /** Gets a specific named egress policy by ID. */
  @summary("Gets a specific named egress policy by ID.")
  getEgressPolicy is EgressPolicyGetOperations.ResourceRead<NamedEgressPolicy>;

  /** Creates or updates a named egress policy. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
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
