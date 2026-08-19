using Http;
using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.DevCompute;

@tag("DataPlaneSandboxAzureFile")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files")
@delete
@summary("""
  Deletes a file or directory in a running sandbox. If the target is a directory, the `recursive` query
  parameter must be set to true to delete it and its contents.
  """)
// FIXME: Open API operation 'DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files' is missing an operationId. Generated: 'delete_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_sandboxes_id_files'
op delete_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_sandboxes_id_files(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path id: string,
  @query path?: string,
  @query recursive?: boolean,
  @query containerName?: string,
  ...ApiVersionParameter,
):
  | {
      @header contentType: "text/plain";
      @body body: FileOpStatusResponse;
    }
  | FileOpStatusResponse
  | {
      @header contentType: "text/json";
      @body body: FileOpStatusResponse;
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
      statusCode: 409;

      @header contentType: "text/plain";
      @body body: ProblemDetails;
    }
  | (ConflictResponse & ProblemDetails)
  | {
      @statusCode
      statusCode: 409;

      @header contentType: "text/json";
      @body body: ProblemDetails;
    };

@tag("DataPlaneSandboxAzureFile")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files")
@get
@summary("Reads a file from a running sandbox. The file is streamed directly to the response body.")
// FIXME: Open API operation 'GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files' is missing an operationId. Generated: 'get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_sandboxes_id_files'
op get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_sandboxes_id_files(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path id: string,
  @query path?: string,
  @query containerName?: string,
  ...ApiVersionParameter,
):
  | {
      @header contentType: "text/plain";
      @body body: FileStreamResult;
    }
  | FileStreamResult
  | {
      @header contentType: "text/json";
      @body body: FileStreamResult;
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
      statusCode: 409;

      @header contentType: "text/plain";
      @body body: ProblemDetails;
    }
  | (ConflictResponse & ProblemDetails)
  | {
      @statusCode
      statusCode: 409;

      @header contentType: "text/json";
      @body body: ProblemDetails;
    };

@tag("DataPlaneSandboxAzureFile")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files")
@put
@summary("Writes a file to a running sandbox. The file is streamed directly from the request body.")
// FIXME: Open API operation 'PUT /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files' is missing an operationId. Generated: 'put_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_sandboxes_id_files'
op put_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_sandboxes_id_files(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path id: string,
  @query path?: string,
  @query createDirs?: boolean,
  @query mode?: UInt32OrString = 0,
  @query containerName?: string,
  ...ApiVersionParameter,
):
  | {
      @header contentType: "text/plain";
      @body body: WriteFileResponse;
    }
  | WriteFileResponse
  | {
      @header contentType: "text/json";
      @body body: WriteFileResponse;
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
      statusCode: 409;

      @header contentType: "text/plain";
      @body body: ProblemDetails;
    }
  | (ConflictResponse & ProblemDetails)
  | {
      @statusCode
      statusCode: 409;

      @header contentType: "text/json";
      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 413;

      @header contentType: "text/plain";
      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 413;

      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 413;

      @header contentType: "text/json";
      @body body: ProblemDetails;
    };

@tag("DataPlaneSandboxAzureFile")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files/list")
@get
@summary("""
  Lists the contents of a directory in a running sandbox. The response includes file and directory names, sizes,
  and metadata.
  """)
// FIXME: Open API operation 'GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files/list' is missing an operationId. Generated: 'get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_sandboxes_id_files_list'
op get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_sandboxes_id_files_list(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path id: string,
  @query path?: string,
  @query containerName?: string,
  ...ApiVersionParameter,
):
  | {
      @header contentType: "text/plain";
      @body body: DirListingResponse;
    }
  | DirListingResponse
  | {
      @header contentType: "text/json";
      @body body: DirListingResponse;
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
      statusCode: 409;

      @header contentType: "text/plain";
      @body body: ProblemDetails;
    }
  | (ConflictResponse & ProblemDetails)
  | {
      @statusCode
      statusCode: 409;

      @header contentType: "text/json";
      @body body: ProblemDetails;
    };

@tag("DataPlaneSandboxAzureFile")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files/stat")
@get
@summary("Gets metadata for a file or directory in a running sandbox, including size, permissions, and timestamps.")
// FIXME: Open API operation 'GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files/stat' is missing an operationId. Generated: 'get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_sandboxes_id_files_stat'
op get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_sandboxes_id_files_stat(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path id: string,
  @query path?: string,
  @query containerName?: string,
  ...ApiVersionParameter,
):
  | {
      @header contentType: "text/plain";
      @body body: FileInfoResponse;
    }
  | FileInfoResponse
  | {
      @header contentType: "text/json";
      @body body: FileInfoResponse;
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
      statusCode: 409;

      @header contentType: "text/plain";
      @body body: ProblemDetails;
    }
  | (ConflictResponse & ProblemDetails)
  | {
      @statusCode
      statusCode: 409;

      @header contentType: "text/json";
      @body body: ProblemDetails;
    };

@tag("DataPlaneSandboxAzureFile")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files/mkdir")
@post
@summary("""
  Creates a directory in a running sandbox. If the `createParents` property is set to true,
  any missing parent directories will also be created.
  """)
// FIXME: Open API operation 'POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files/mkdir' is missing an operationId. Generated: 'post_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_sandboxes_id_files_mkdir'
op post_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_sandboxes_id_files_mkdir(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path id: string,
  @query containerName?: string,
  ...ApiVersionParameter,
  @header contentType: "application/json" | "text/json" | "application/*+json",
  @body body: MkDirRequest,
):
  | {
      @header contentType: "text/plain";
      @body body: FileOpStatusResponse;
    }
  | FileOpStatusResponse
  | {
      @header contentType: "text/json";
      @body body: FileOpStatusResponse;
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
      statusCode: 409;

      @header contentType: "text/plain";
      @body body: ProblemDetails;
    }
  | (ConflictResponse & ProblemDetails)
  | {
      @statusCode
      statusCode: 409;

      @header contentType: "text/json";
      @body body: ProblemDetails;
    };
