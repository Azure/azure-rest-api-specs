using Http;
using Azure.Core;

namespace ContainerAppsSandbox {
  /** Successful Sandbox list response. */
  model SandboxListResult {
    /** HTTP response status code. */
    @statusCode statusCode: 200;

    /** Sandboxes returned by the request. */
    @body
    body: Sandbox[];
  }

  /** Successful Sandbox create response. */
  model SandboxCreatedResult {
    /**
     * HTTP response status code. The service returns 200 on a successful create, not the
     * conventional 201 for PUT. The generated clients build a status classifier from this and
     * surface anything not listed as a failure, so this must track the service exactly - the
     * earlier declaration of 201 made every successful create throw RequestFailedException.
     */
    @statusCode statusCode: 200;

    /** Created sandbox. */
    @body body: Sandbox;
  }

  /** Successful Sandbox get response. */
  model SandboxResult {
    /** HTTP response status code. */
    @statusCode statusCode: 200;

    /** Sandbox resource. */
    @body body: Sandbox;
  }

  /** Successful Sandbox delete response with an empty 200 body. */
  model SandboxDeletedResult {
    /** HTTP response status code. */
    @statusCode statusCode: 200;
  }

  /** Successful Sandbox delete response with no content. */
  model SandboxDeletedNoContentResult {
    /** HTTP response status code. */
    @statusCode statusCode: 204;
  }

  /** Errors returned when listing sandboxes. */
  alias ListErrors = ErrorResult<400> | ErrorResult<401> | ErrorResult<500>;

  /** Errors returned when creating a sandbox. */
  alias CreateErrors =
    | ErrorResult<400>
    | ErrorResult<401>
    | ErrorResult<429>
    | ErrorResult<500>;

  /** Errors returned when getting a sandbox. */
  alias GetErrors = ErrorResult<401> | ErrorResult<404> | ErrorResult<500>;

  /** Errors returned when deleting a sandbox. */
  alias DeleteErrors = ErrorResult<401> | ErrorResult<500> | ErrorResult<503>;
}

namespace ContainerAppsSandbox {
  /** Azure-scoped Sandbox CRUD operations. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceList cannot preserve the existing Page, PageSize, and labels query parameter names or the array response without changing the established wire contract."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This list operation uses a custom response model to preserve the existing bare-array wire contract, which the rule misclassifies as a single-object response."
  @doc("Lists sandboxes in a scope.")
  @tag("Sandboxes")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes")
  interface AzureSandboxes {
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
      SandboxListResult,
      DataPlaneStandardTraits,
      ListErrors
    >;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceCreateOrReplace cannot preserve the existing SandboxContent body, 201 response, and custom error status shapes without changing the established wire contract."
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
      SandboxCreatedResult,
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
      SandboxResult,
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
      SandboxDeletedResult | SandboxDeletedNoContentResult,
      DataPlaneStandardTraits,
      DeleteErrors
    >;
  }
}
