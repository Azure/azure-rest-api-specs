using Http;
using Rest;
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
    /** HTTP response status code. */
    @statusCode statusCode: 201;

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
  alias DeleteErrors = ErrorResult<401> | ErrorResult<500>;

  /** Standard resource operations for reading sandboxes. */
  alias SandboxGetOperations = ResourceOperations<
    DataPlaneStandardTraits,
    GetErrors
  >;
}

namespace ContainerAppsSandbox {
  /** Azure-scoped Sandbox CRUD operations. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceList cannot preserve the existing Page, PageSize, and labels query parameter names or the array response without changing the established wire contract."
  @doc("Lists sandboxes in a scope.")
  @tag("Sandboxes")
  interface AzureSandboxes {
    @doc("Lists sandboxes in a scope.")
    @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes")
    @listsResource(Sandbox)
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

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core ResourceOperations.ResourceCreateWithServiceProvidedName requires a standard resource hierarchy, Sandbox request body, and 201 Location response, which cannot preserve the established scoped route, CreateSandboxContent request, and Sandbox response body."
    @doc("Creates a sandbox in a scope.")
    @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes")
    @post
    create is Foundations.Operation<
      {
        ...AzureResourceScope;

        /** Sandbox create request. */
        @body content: CreateSandboxContent;
      },
      SandboxCreatedResult,
      DataPlaneStandardTraits,
      CreateErrors
    >;

    @doc("Gets a sandbox by identifier.")
    get is SandboxGetOperations.ResourceRead<Sandbox>;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceDelete cannot preserve the existing empty 200 and 204 success responses or custom error status shapes without changing the established wire contract."
    @doc("Deletes a sandbox by identifier.")
    @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}")
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
