using Http;
using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.DevCompute;

@tag("DataPlaneContentPackageAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/contentpackages")
@get
@summary("Lists content packages for the sandbox group.")
// FIXME: Open API operation 'GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/contentpackages' is missing an operationId. Generated: 'get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_contentpackages'
op get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_contentpackages(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,

  /** Page number to retrieve. */
  @query
  Page?: Int32OrString,

  /** Number of items to return per page. */
  @query
  PageSize?: Int32OrString,

  /** Label selector for filtering resources. Accepts comma-separated key=value pairs(e.g., "env=prod,team=backend"). Returns only resources that have all specified labels with matching values. */
  @query labels?: string,

  ...ApiVersionParameter,
):
  | {
      @header contentType: "text/plain";
      @body body: ContentPackageListResponseView;
    }
  | ContentPackageListResponseView
  | {
      @header contentType: "text/json";
      @body body: ContentPackageListResponseView;
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

@tag("DataPlaneContentPackageAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/contentpackages/{id}")
@delete
@summary("Deletes a content package by ID.")
// FIXME: Open API operation 'DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/contentpackages/{id}' is missing an operationId. Generated: 'delete_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_contentpackages_id'
op delete_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_contentpackages_id(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path id: string,
  ...ApiVersionParameter,
):
  | AcceptedResponse
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
      statusCode: 500;
    };

@tag("DataPlaneContentPackageAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/contentpackages/{id}")
@get
@summary("Gets a specific content package by ID.")
// FIXME: Open API operation 'GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/contentpackages/{id}' is missing an operationId. Generated: 'get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_contentpackages_id'
op get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_contentpackages_id(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path id: string,
  ...ApiVersionParameter,
):
  | {
      @header contentType: "text/plain";
      @body body: ContentPackageResponseView;
    }
  | ContentPackageResponseView
  | {
      @header contentType: "text/json";
      @body body: ContentPackageResponseView;
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

@tag("DataPlaneContentPackageAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/contentpackages/upload")
@post
@summary("""
  Creates a content package by uploading binary content.
  The request body should contain the binary content of the package, and optional labels can be provided
  as query parameters.
  The response will include details of the created content package.
  """)
// FIXME: Open API operation 'POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/contentpackages/upload' is missing an operationId. Generated: 'post_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_contentpackages_upload'
op post_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_contentpackages_upload(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,

  /** Label selector for filtering resources. Accepts comma-separated key=value pairs(e.g., "env=prod,team=backend"). Returns only resources that have all specified labels with matching values. */
  @query labels?: string,

  ...ApiVersionParameter,
):
  | {
      @statusCode statusCode: 201;
      @header contentType: "text/plain";
      @body body: ContentPackageResponseView;
    }
  | (CreatedResponse & ContentPackageResponseView)
  | {
      @statusCode statusCode: 201;
      @header contentType: "text/json";
      @body body: ContentPackageResponseView;
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

      @header contentType: "text/plain";
      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 500;

      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 500;

      @header contentType: "text/json";
      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 503;
    };
