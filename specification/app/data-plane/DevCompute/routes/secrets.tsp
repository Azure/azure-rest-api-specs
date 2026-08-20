using Http;
using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.DevCompute;

@tag("DataPlaneSecretAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/secrets")
@get
@summary("Lists all secrets in the sandbox group.")
// FIXME: Open API operation 'GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/secrets' is missing an operationId. Generated: 'get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_secrets'
op get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_secrets(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  ...ApiVersionParameter,
):
  | {
      @header contentType: "text/plain";
      @body body: SecretListResponse;
    }
  | SecretListResponse
  | {
      @header contentType: "text/json";
      @body body: SecretListResponse;
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

@tag("DataPlaneSecretAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/secrets/{secretId}/peek")
@post
@summary("Peeks (retrieves) all secret values.")
// FIXME: Open API operation 'POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/secrets/{secretId}/peek' is missing an operationId. Generated: 'post_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_secrets_secretId_peek'
op post_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_secrets_secretId_peek(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path secretId: string,
  ...ApiVersionParameter,
):
  | {
      @header contentType: "text/plain";
      @body body: SecretPeekResponse;
    }
  | SecretPeekResponse
  | {
      @header contentType: "text/json";
      @body body: SecretPeekResponse;
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

@tag("DataPlaneSecretAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/secrets/{secretId}/keys")
@get
@summary("Lists key names of a secret (values are not returned).")
// FIXME: Open API operation 'GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/secrets/{secretId}/keys' is missing an operationId. Generated: 'get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_secrets_secretId_keys'
op get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_secrets_secretId_keys(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path secretId: string,
  ...ApiVersionParameter,
):
  | {
      @header contentType: "text/plain";
      @body body: SecretKeysResponse;
    }
  | SecretKeysResponse
  | {
      @header contentType: "text/json";
      @body body: SecretKeysResponse;
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

@tag("DataPlaneSecretAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/secrets/{secretId}")
@delete
@summary("Deletes an entire secret.")
// FIXME: Open API operation 'DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/secrets/{secretId}' is missing an operationId. Generated: 'delete_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_secrets_secretId'
op delete_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_secrets_secretId(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path secretId: string,
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

@tag("DataPlaneSecretAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/secrets/{secretId}")
@put
@summary("Upserts key-value pairs in a secret.")
// FIXME: Open API operation 'PUT /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/secrets/{secretId}' is missing an operationId. Generated: 'put_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_secrets_secretId'
op put_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_secrets_secretId(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path secretId: string,
  ...ApiVersionParameter,
  @header contentType: "application/json" | "text/json" | "application/*+json",
  @body body: SecretUpsertRequest,
):
  | {
      @header contentType: "text/plain";
      @body body: SecretResponseView;
    }
  | SecretResponseView
  | {
      @header contentType: "text/json";
      @body body: SecretResponseView;
    }
  | {
      @statusCode statusCode: 201;
      @header contentType: "text/plain";
      @body body: SecretResponseView;
    }
  | (CreatedResponse & SecretResponseView)
  | {
      @statusCode statusCode: 201;
      @header contentType: "text/json";
      @body body: SecretResponseView;
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
