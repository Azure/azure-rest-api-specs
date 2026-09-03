using Http;
using Azure.Core;

namespace ContainerAppsSandbox;

/** No Content. */
model DeleteEgressPolicyResult {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

/** Errors returned by deleteEgressPolicy. */
alias DeleteEgressPolicyErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

/** OK. */
model ListEgressPolicyResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: NamedEgressPolicyListResult;
}

/** Errors returned by listEgressPolicies. */
alias ListEgressPolicyErrors = ErrorResult<401> | ErrorResult<500>;

/** OK. */
model GetEgressPolicyResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: NamedEgressPolicy;
}

/** Errors returned by getEgressPolicy. */
alias GetEgressPolicyErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

/** OK. */
model PutEgressPolicyResponse200 {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: NamedEgressPolicy;
}

/** Created. */
model PutEgressPolicyResponse201 {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response body. */
  @body body: NamedEgressPolicy;
}

/** Successful responses returned by putEgressPolicy. */
alias PutEgressPolicyResponse =
  | PutEgressPolicyResponse200
  | PutEgressPolicyResponse201;

/** Errors returned by putEgressPolicy. */
alias PutEgressPolicyErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<500>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("egressPolicies")
interface EgressPoliciesOperations {
  /** Deletes a named egress policy by ID. */
  @summary("Deletes a named egress policy by ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/egressPolicies/{policyId}")
  @delete
  deleteEgressPolicy is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** policyId parameter. */
      @path policyId: string;
    },
    DeleteEgressPolicyResult,
    DataPlaneStandardTraits,
    DeleteEgressPolicyErrors
  >;

  /** Lists all named egress policies in a sandbox group. */
  @summary("Lists all named egress policies in a sandbox group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/egressPolicies")
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
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/egressPolicies/{policyId}")
  @get
  getEgressPolicy is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** policyId parameter. */
      @path policyId: string;
    },
    GetEgressPolicyResult,
    DataPlaneStandardTraits,
    GetEgressPolicyErrors
  >;

  /** Creates or updates a named egress policy. */
  @summary("Creates or updates a named egress policy.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/egressPolicies/{policyId}")
  @put
  putEgressPolicy is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** policyId parameter. */
      @path policyId: string;

      /** Request body. */
      @body body: NamedEgressPolicyUpsert;
    },
    PutEgressPolicyResponse,
    DataPlaneStandardTraits,
    PutEgressPolicyErrors
  >;
}
