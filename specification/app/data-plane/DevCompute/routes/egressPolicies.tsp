using Http;
using Azure.Core;

namespace AzureDevCompute;

/** No Content. */
model DeleteEgressPoliciesResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

/** Errors returned by deleteEgressPolicies. */
alias DeleteEgressPoliciesErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

/** OK. */
model ListEgressPolicyResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: NamedEgressPolicyListResponse;
}

/** Errors returned by listEgressPolicies. */
alias ListEgressPolicyErrors = ErrorResponse<401> | InternalServerErrorNoBody;

/** OK. */
model GetEgressPolicyResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: NamedEgressPolicyResponse;
}

/** Errors returned by getEgressPolicies. */
alias GetEgressPolicyErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

/** OK. */
model PutEgressPoliciesResponse200 {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: NamedEgressPolicyResponse;
}

/** Created. */
model PutEgressPoliciesResponse201 {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response body. */
  @body body: NamedEgressPolicyResponse;
}

/** Successful responses returned by putEgressPolicies. */
alias PutEgressPoliciesResponse =
  | PutEgressPoliciesResponse200
  | PutEgressPoliciesResponse201;

/** Errors returned by putEgressPolicies. */
alias PutEgressPoliciesErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | InternalServerErrorNoBody;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("egressPolicies")
interface EgressPoliciesOperations {
  /** Deletes a named egress policy by ID. */
  @summary("Deletes a named egress policy by ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/egressPolicies/{policyId}")
  @delete
  deleteEgressPolicies is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** policyId parameter. */
      @path policyId: string;
    },
    DeleteEgressPoliciesResponse,
    DataPlaneStandardTraits,
    DeleteEgressPoliciesErrors
  >;

  /** Lists all named egress policies in a sandbox group. */
  @summary("Lists all named egress policies in a sandbox group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/egressPolicies")
  @get
  listEgressPolicies is Foundations.Operation<
    {
      ...AzureResourceScope;
    },
    ListEgressPolicyResponse,
    DataPlaneStandardTraits,
    ListEgressPolicyErrors
  >;

  /** Gets a specific named egress policy by ID. */
  @summary("Gets a specific named egress policy by ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/egressPolicies/{policyId}")
  @get
  getEgressPolicies is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** policyId parameter. */
      @path policyId: string;
    },
    GetEgressPolicyResponse,
    DataPlaneStandardTraits,
    GetEgressPolicyErrors
  >;

  /** Creates or updates a named egress policy. */
  @summary("Creates or updates a named egress policy.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/egressPolicies/{policyId}")
  @put
  putEgressPolicies is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** policyId parameter. */
      @path policyId: string;

      /** Request body. */
      @body body: NamedEgressPolicyUpsert;
    },
    PutEgressPoliciesResponse,
    DataPlaneStandardTraits,
    PutEgressPoliciesErrors
  >;
}
