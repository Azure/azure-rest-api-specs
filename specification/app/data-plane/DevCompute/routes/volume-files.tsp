using Http;
using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.DevCompute;

@tag("DataPlaneVolumeAzureFile")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}/files")
@delete
@summary("Delete a file or directory from a volume.")
// FIXME: Open API operation 'DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}/files' is missing an operationId. Generated: 'delete_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_volumes_volumeName_files'
op delete_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_volumes_volumeName_files(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path volumeName: string,
  @query path?: string,
  @query recursive?: boolean,
  ...ApiVersionParameter,
):
  | NoContentResponse
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
      statusCode: 500;
    };

@tag("DataPlaneVolumeAzureFile")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}/files")
@get
@summary("List directory contents within a volume.")
// FIXME: Open API operation 'GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}/files' is missing an operationId. Generated: 'get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_volumes_volumeName_files'
op get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_volumes_volumeName_files(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path volumeName: string,
  @query path?: string,
  ...ApiVersionParameter,
):
  | {
      @header contentType: "text/plain";
      @body body: VolumeListDirectoryResponseView;
    }
  | VolumeListDirectoryResponseView
  | {
      @header contentType: "text/json";
      @body body: VolumeListDirectoryResponseView;
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

@tag("DataPlaneVolumeAzureFile")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}/files/download")
@get
@summary("Download a file from a volume.")
// FIXME: Open API operation 'GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}/files/download' is missing an operationId. Generated: 'get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_volumes_volumeName_files_download'
op get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_volumes_volumeName_files_download(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path volumeName: string,
  @query path?: string,
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

@tag("DataPlaneVolumeAzureFile")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}/files/upload")
@put
@summary("Upload a file to a volume.")
// FIXME: Open API operation 'PUT /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}/files/upload' is missing an operationId. Generated: 'put_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_volumes_volumeName_files_upload'
op put_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_volumes_volumeName_files_upload(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path volumeName: string,
  @query path?: string,
  @query overwrite?: boolean,
  ...ApiVersionParameter,
):
  | {
      @header contentType: "text/plain";
      @body body: VolumePathItemView;
    }
  | VolumePathItemView
  | {
      @header contentType: "text/json";
      @body body: VolumePathItemView;
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
      statusCode: 412;

      @header contentType: "text/plain";
      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 412;

      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 412;

      @header contentType: "text/json";
      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 500;
    };

@tag("DataPlaneVolumeAzureFile")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}/files/mkdir")
@post
@summary("Create a directory within a volume.")
// FIXME: Open API operation 'POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}/files/mkdir' is missing an operationId. Generated: 'post_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_volumes_volumeName_files_mkdir'
op post_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_volumes_volumeName_files_mkdir(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path volumeName: string,
  @query path?: string,
  ...ApiVersionParameter,
):
  | {
      @statusCode statusCode: 201;
      @header contentType: "text/plain";
      @body body: VolumePathItemView;
    }
  | (CreatedResponse & VolumePathItemView)
  | {
      @statusCode statusCode: 201;
      @header contentType: "text/json";
      @body body: VolumePathItemView;
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
