using Http;
using Rest;
using Azure.Core;

namespace ContainerAppsSandbox {
  /** A page of sandboxes. */
  model SandboxList {
    /** Sandboxes returned by the request. */
    @pageItems
    value: Sandbox[];

    /** Link to the next page of sandboxes, if one is available. */
    @nextLink
    nextLink?: string;
  }

  /** Successful Sandbox list response. */
  model SandboxListResult {
    /** HTTP response status code. */
    @statusCode statusCode: 200;

    /** A page of sandboxes. */
    @body body: SandboxList;
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
}

namespace ContainerAppsSandbox {
  /** Azure-scoped Sandbox CRUD operations. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core StandardResourceOperations.ResourceList cannot preserve the continuationToken query parameter alongside this custom scoped route and response contract."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This list operation uses a custom next-link response model, which the rule misclassifies as a single-object response."
  @doc("Lists sandboxes in a scope.")
  @tag("Sandboxes")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes")
  interface AzureSandboxes {
    @doc("Lists sandboxes in a scope.")
    @list
    @get
    list is Foundations.Operation<
      {
        ...AzureResourceScope;

        /** Continuation token for paginated results. */
        @query
        continuationToken?: string;

        /** Comma-separated label selector. */
        @query labels?: string;
      },
      SandboxListResult,
      DataPlaneStandardTraits,
      ListErrors
    >;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure.Core ResourceOperations.ResourceCreateWithServiceProvidedName requires a standard resource hierarchy, Sandbox request body, and 201 Location response, which cannot preserve the established scoped route, CreateSandboxContent request, and Sandbox response body."
    @doc("Creates a sandbox in a scope.")
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
