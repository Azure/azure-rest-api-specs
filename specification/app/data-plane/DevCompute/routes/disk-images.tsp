using Http;
using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.DevCompute;

/** Public images are admin-curated and shared across all sandbox groups. */
@tag("DataPlaneDiskImageAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/public")
@get
@summary("Lists all public disk images available to the caller.")
// FIXME: Open API operation 'GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/public' is missing an operationId. Generated: 'get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_diskimages_public'
op get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_diskimages_public(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,

  @minValue(1)
  @maxValue(2147483647)
  @query
  page?: Int32OrString = 1,

  @minValue(1)
  @maxValue(100)
  @query
  pageSize?: Int32OrString = 50,

  ...ApiVersionParameter,
):
  | {
      @header contentType: "text/plain";
      @body body: PublicDiskImageResponseView[];
    }
  | Body<PublicDiskImageResponseView[]>
  | {
      @header contentType: "text/json";
      @body body: PublicDiskImageResponseView[];
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

/** Public images are global and shared across all sandbox groups. */
@tag("DataPlaneDiskImageAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/public/{name}")
@get
@summary("Gets a specific public disk image by name.")
// FIXME: Open API operation 'GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/public/{name}' is missing an operationId. Generated: 'get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_diskimages_public_name'
op get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_diskimages_public_name(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path name: string,
  ...ApiVersionParameter,
):
  | {
      @header contentType: "text/plain";
      @body body: PublicDiskImageResponseView;
    }
  | PublicDiskImageResponseView
  | {
      @header contentType: "text/json";
      @body body: PublicDiskImageResponseView;
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

/** Returns disk images scoped to the specified sandbox group. */
@tag("DataPlaneDiskImageAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages")
@get
@summary("Lists disk images in a sandbox group, with pagination support.")
// FIXME: Open API operation 'GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages' is missing an operationId. Generated: 'get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_diskimages'
op get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_diskimages(
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
      @body body: DiskImageResponseView[];
    }
  | Body<DiskImageResponseView[]>
  | {
      @header contentType: "text/json";
      @body body: DiskImageResponseView[];
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

@tag("DataPlaneDiskImageAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages")
@put
@summary("Creates a new disk image from an OCI image reference.")
// FIXME: Open API operation 'PUT /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages' is missing an operationId. Generated: 'put_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_diskimages'
op put_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_diskimages(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  ...ApiVersionParameter,
  @header contentType: "application/json" | "text/json" | "application/*+json",

  @typeChangedFrom(Versions.v2026_09_01, DiskImageRequestView)
  @body
  body: CreateDiskImageRequestView,
): CreateDiskImageResponse;

@tag("DataPlaneDiskImageAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/{id}")
@delete
@summary("Deletes a disk image by ID.")
// FIXME: Open API operation 'DELETE /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/{id}' is missing an operationId. Generated: 'delete_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_diskimages_id'
op delete_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_diskimages_id(
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

@tag("DataPlaneDiskImageAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/{id}")
@get
@summary("Gets a specific disk image by ID.")
// FIXME: Open API operation 'GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/{id}' is missing an operationId. Generated: 'get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_diskimages_id'
op get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_diskimages_id(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path id: string,
  ...ApiVersionParameter,
):
  | {
      @header contentType: "text/plain";
      @body body: DiskImageResponseView;
    }
  | DiskImageResponseView
  | {
      @header contentType: "text/json";
      @body body: DiskImageResponseView;
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

@tag("DataPlaneDiskImageAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/async")
@put
@summary("Creates a disk image asynchronously from an OCI image reference.")
// FIXME: Open API operation 'PUT /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/async' is missing an operationId. Generated: 'put_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_diskimages_async'
op put_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_diskimages_async(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  ...ApiVersionParameter,
  @header contentType: "application/json" | "text/json" | "application/*+json",

  @typeChangedFrom(Versions.v2026_09_01, DiskImageRequestView)
  @body
  body: CreateDiskImageRequestView,
):
  | {
      @statusCode statusCode: 202;
      @header contentType: "text/plain";
      @body body: DiskImageOperationResponseView;
    }
  | (AcceptedResponse & DiskImageOperationResponseView)
  | {
      @statusCode statusCode: 202;
      @header contentType: "text/json";
      @body body: DiskImageOperationResponseView;
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
      statusCode: 429;

      @header contentType: "text/plain";
      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 429;

      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 429;

      @header contentType: "text/json";
      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 500;
    };

@tag("DataPlaneDiskImageAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/operations/{operationId}")
@get
@summary("Gets the status of an async disk image operation.")
// FIXME: Open API operation 'GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/operations/{operationId}' is missing an operationId. Generated: 'get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_diskimages_operations_operationId'
op get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_diskimages_operations_operationId(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path operationId: string,
  ...ApiVersionParameter,
):
  | {
      @header contentType: "text/plain";
      @body body: DiskImageOperationResponseView;
    }
  | DiskImageOperationResponseView
  | {
      @header contentType: "text/json";
      @body body: DiskImageOperationResponseView;
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

@tag("DataPlaneDiskImageAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/v2")
@put
@summary("Creates a new disk image using the V2 discriminated source model.")
// FIXME: Open API operation 'PUT /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/v2' is missing an operationId. Generated: 'put_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_diskimages_v2'
@removed(Versions.v2026_09_01)
op put_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_diskimages_v2(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @query("api-version") apiVersion?: Versions,
  @header contentType: "application/json" | "text/json" | "application/*+json",
  @body body: CreateDiskImageV2RequestView,
):
  | {
      @header contentType: "text/plain";
      @body body: DiskImageResponseView;
    }
  | DiskImageResponseView
  | {
      @header contentType: "text/json";
      @body body: DiskImageResponseView;
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
      statusCode: 429;

      @header contentType: "text/plain";
      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 429;

      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 429;

      @header contentType: "text/json";
      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 500;
    };

@tag("DataPlaneDiskImageAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/dockerfile")
@post
@summary("Builds a disk image from a Dockerfile (synchronous).")
// FIXME: Open API operation 'POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/dockerfile' is missing an operationId. Generated: 'post_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_diskimages_dockerfile'
@removed(Versions.v2026_09_01)
op post_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_diskimages_dockerfile(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @query("api-version") apiVersion?: Versions,
  @header contentType: "application/json" | "text/json" | "application/*+json",
  @body body: BuildDiskImageFromDockerfileRequestView,
):
  | {
      @header contentType: "text/plain";
      @body body: DiskImageResponseView;
    }
  | DiskImageResponseView
  | {
      @header contentType: "text/json";
      @body body: DiskImageResponseView;
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
      statusCode: 429;

      @header contentType: "text/plain";
      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 429;

      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 429;

      @header contentType: "text/json";
      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 500;
    };

@tag("DataPlaneDiskImageAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/dockerfile/async")
@post
@summary("Builds a disk image from a Dockerfile (asynchronous).")
// FIXME: Open API operation 'POST /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/dockerfile/async' is missing an operationId. Generated: 'post_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_diskimages_dockerfile_async'
@removed(Versions.v2026_09_01)
op post_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_diskimages_dockerfile_async(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @query("api-version") apiVersion?: Versions,
  @header contentType: "application/json" | "text/json" | "application/*+json",
  @body body: BuildDiskImageFromDockerfileRequestView,
):
  | {
      @statusCode statusCode: 202;
      @header contentType: "text/plain";
      @body body: DiskImageOperationResponseView;
    }
  | (AcceptedResponse & DiskImageOperationResponseView)
  | {
      @statusCode statusCode: 202;
      @header contentType: "text/json";
      @body body: DiskImageOperationResponseView;
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
      statusCode: 429;

      @header contentType: "text/plain";
      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 429;

      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 429;

      @header contentType: "text/json";
      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 500;
    };

@tag("DataPlaneDiskImageAzure")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/v2/async")
@put
@summary("Creates a disk image asynchronously from a discriminated V2 source model.")
// FIXME: Open API operation 'PUT /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/v2/async' is missing an operationId. Generated: 'put_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_diskimages_v2_async'
@removed(Versions.v2026_09_01)
op put_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_diskimages_v2_async(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @query("api-version") apiVersion?: Versions,
  @header contentType: "application/json" | "text/json" | "application/*+json",
  @body body: CreateDiskImageV2RequestView,
):
  | {
      @statusCode statusCode: 202;
      @header contentType: "text/plain";
      @body body: DiskImageOperationResponseView;
    }
  | (AcceptedResponse & DiskImageOperationResponseView)
  | {
      @statusCode statusCode: 202;
      @header contentType: "text/json";
      @body body: DiskImageOperationResponseView;
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
      statusCode: 429;

      @header contentType: "text/plain";
      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 429;

      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 429;

      @header contentType: "text/json";
      @body body: ProblemDetails;
    }
  | {
      @statusCode
      statusCode: 500;
    };
