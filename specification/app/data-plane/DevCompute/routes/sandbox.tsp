using Http;
using Azure.Core;

namespace AzureDevCompute {
  /** Successful Sandbox list response. */
  model SandboxListResponse {
    /** HTTP response status code. */
    @statusCode statusCode: 200;

    /** Sandboxes returned by the request. */
    @body
    body: SandboxFields[];
  }

  /** Successful Sandbox create response. */
  model SandboxCreatedResponse {
    /** HTTP response status code. */
    @statusCode statusCode: 201;

    /** Created sandbox. */
    @body body: SandboxFields;
  }

  /** Successful Sandbox get response. */
  model SandboxResponse {
    /** HTTP response status code. */
    @statusCode statusCode: 200;

    /** Sandbox resource. */
    @body body: SandboxFields;
  }

  /** Successful Sandbox delete response with an empty 200 body. */
  model SandboxDeletedResponse {
    /** HTTP response status code. */
    @statusCode statusCode: 200;
  }

  /** Successful Sandbox delete response with no content. */
  model SandboxDeletedNoContentResponse {
    /** HTTP response status code. */
    @statusCode statusCode: 204;
  }

  /** Errors returned when listing sandboxes. */
  alias ListErrors =
    | ErrorResponse<400>
    | ErrorResponse<401>
    | InternalServerErrorNoBody;

  /** Errors returned when creating a sandbox. */
  alias CreateErrors =
    | ErrorResponse<400>
    | ErrorResponse<401>
    | ErrorResponse<429>
    | InternalServerErrorNoBody;

  /** Errors returned when getting a sandbox. */
  alias GetErrors =
    | ErrorResponse<401>
    | ErrorResponse<404>
    | InternalServerErrorNoBody;

  /** Errors returned when deleting a sandbox. */
  alias DeleteErrors =
    | ErrorResponse<401>
    | InternalServerErrorNoBody
    | ErrorResponse<503>;
}

namespace AzureDevCompute {
  /** Azure-scoped Sandbox CRUD operations. */
  @tag("Sandboxes")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes")
  @useAuth(AzureDataPlaneS2sAuth)
  interface AzureSandboxes {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceList cannot preserve the existing Page, PageSize, and labels query parameter names or the array response without changing the established wire contract."
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This list operation uses a custom response model to preserve the existing bare-array wire contract, which the rule misclassifies as a single-object response."
    @doc("Lists sandboxes in a scope.")
    @get
    list is Foundations.Operation<
      {
        ...AzureResourceScope;

        /** One-based page number. */
        @query page?: int32;

        /** Maximum number of sandboxes returned per page. */
        @query pageSize?: int32;

        /** Comma-separated label selector. */
        @query labels?: string;
      },
      SandboxListResponse,
      DataPlaneStandardTraits,
      ListErrors
    >;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceCreateOrReplace cannot preserve the existing SandboxRequest body, 201 response, and custom error status shapes without changing the established wire contract."
    @doc("Creates a sandbox in a scope.")
    @put
    create is Foundations.Operation<
      {
        ...AzureResourceScope;

        /** Includes server debug timing information in the response. */
        @query includeDebug?: boolean = false;

        /** Sandbox create request. */
        @body request: SandboxRequest;
      },
      SandboxCreatedResponse,
      DataPlaneStandardTraits,
      CreateErrors
    >;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceRead cannot preserve the existing scoped id parameters and custom success/error response shapes without changing the established wire contract."
    @doc("Gets a sandbox by identifier.")
    @route("/{id}")
    @get
    get is Foundations.Operation<
      {
        ...AzureResourceScope;

        /** Sandbox identifier. */
        @path id: string;
      },
      SandboxResponse,
      DataPlaneStandardTraits,
      GetErrors
    >;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceDelete cannot preserve the existing empty 200 and 204 success responses or custom error status shapes without changing the established wire contract."
    @doc("Deletes a sandbox by identifier.")
    @route("/{id}")
    @delete
    delete is Foundations.Operation<
      {
        ...AzureResourceScope;

        /** Sandbox identifier. */
        @path id: string;
      },
      SandboxDeletedResponse | SandboxDeletedNoContentResponse,
      DataPlaneStandardTraits,
      DeleteErrors
    >;
  }
}
