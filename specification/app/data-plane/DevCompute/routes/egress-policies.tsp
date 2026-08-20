using Http;
using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.DevCompute;

@tag("DataPlaneNamedEgressPolicyAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/egressPolicies")
@get
@summary("Lists all named egress policies in a sandbox group.")
// FIXME: Open API operation 'GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/egressPolicies' is missing an operationId. Generated: 'get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_egressPolicies'
op get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_egressPolicies(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  ...ApiVersionParameter,
):
  | {
      @header contentType: "text/plain";
      @body body: NamedEgressPolicyListResponse;
    }
  | NamedEgressPolicyListResponse
  | {
      @header contentType: "text/json";
      @body body: NamedEgressPolicyListResponse;
    }
  | {
      @statusCode
      statusCode: 401;

      @header contentType: "text/plain";
      @body body: ProblemDetails;
    }
  | (UnauthorizedResponse & ProblemDetails)
  | {
      @statusCode
      statusCode: 401;

      @header contentType: "text/json";
      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 500;
    };

@tag("DataPlaneNamedEgressPolicyAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/egressPolicies/{policyId}")
@delete
@summary("Deletes a named egress policy by ID.")
// FIXME: Open API operation 'DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/egressPolicies/{policyId}' is missing an operationId. Generated: 'delete_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_egressPolicies_policyId'
op delete_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_egressPolicies_policyId(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path policyId: string,
  ...ApiVersionParameter,
):
  | NoContentResponse
  | {
      @statusCode
      statusCode: 401;

      @header contentType: "text/plain";
      @body body: ProblemDetails;
    }
  | (UnauthorizedResponse & ProblemDetails)
  | {
      @statusCode
      statusCode: 401;

      @header contentType: "text/json";
      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 404;

      @header contentType: "text/plain";
      @body body: ProblemDetails;
    }
  | (NotFoundResponse & ProblemDetails)
  | {
      @statusCode
      statusCode: 404;

      @header contentType: "text/json";
      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 500;
    };

@tag("DataPlaneNamedEgressPolicyAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/egressPolicies/{policyId}")
@get
@summary("Gets a specific named egress policy by ID.")
// FIXME: Open API operation 'GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/egressPolicies/{policyId}' is missing an operationId. Generated: 'get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_egressPolicies_policyId'
op get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_egressPolicies_policyId(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path policyId: string,
  ...ApiVersionParameter,
):
  | {
      @header contentType: "text/plain";
      @body body: NamedEgressPolicyResponseView;
    }
  | NamedEgressPolicyResponseView
  | {
      @header contentType: "text/json";
      @body body: NamedEgressPolicyResponseView;
    }
  | {
      @statusCode
      statusCode: 401;

      @header contentType: "text/plain";
      @body body: ProblemDetails;
    }
  | (UnauthorizedResponse & ProblemDetails)
  | {
      @statusCode
      statusCode: 401;

      @header contentType: "text/json";
      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 404;

      @header contentType: "text/plain";
      @body body: ProblemDetails;
    }
  | (NotFoundResponse & ProblemDetails)
  | {
      @statusCode
      statusCode: 404;

      @header contentType: "text/json";
      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 500;
    };

@tag("DataPlaneNamedEgressPolicyAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/egressPolicies/{policyId}")
@put
@summary("Creates or updates a named egress policy.")
// FIXME: Open API operation 'PUT /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/egressPolicies/{policyId}' is missing an operationId. Generated: 'put_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_egressPolicies_policyId'
op put_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_egressPolicies_policyId(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path policyId: string,
  ...ApiVersionParameter,
  @header contentType: "application/json" | "text/json" | "application/*+json",
  @body body: NamedEgressPolicyUpsertView,
):
  | {
      @header contentType: "text/plain";
      @body body: NamedEgressPolicyResponseView;
    }
  | NamedEgressPolicyResponseView
  | {
      @header contentType: "text/json";
      @body body: NamedEgressPolicyResponseView;
    }
  | {
      @statusCode statusCode: 201;
      @header contentType: "text/plain";
      @body body: NamedEgressPolicyResponseView;
    }
  | (CreatedResponse & NamedEgressPolicyResponseView)
  | {
      @statusCode statusCode: 201;
      @header contentType: "text/json";
      @body body: NamedEgressPolicyResponseView;
    }
  | {
      @statusCode
      statusCode: 400;

      @header contentType: "text/plain";
      @body body: ProblemDetails;
    }
  | (BadRequestResponse & ProblemDetails)
  | {
      @statusCode
      statusCode: 400;

      @header contentType: "text/json";
      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 401;

      @header contentType: "text/plain";
      @body body: ProblemDetails;
    }
  | (UnauthorizedResponse & ProblemDetails)
  | {
      @statusCode
      statusCode: 401;

      @header contentType: "text/json";
      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 500;
    };
