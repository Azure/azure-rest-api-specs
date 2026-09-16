using Http;
using Rest;
using Azure.Core;
using Azure.Core.Traits;

namespace ContainerAppsSandbox {
  /** Successful Sandbox create response. */
  model SandboxCreatedResult {
    /** HTTP response status code. */
    @statusCode statusCode: 201;

    /** Created sandbox. */
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

  /** Query parameters for listing sandboxes. */
  alias SandboxListTraits = QueryParametersTrait<
    {
      /** Continuation token for paginated results. */
      @query @continuationToken continuationToken?: string;

      /** Comma-separated label selector. */
      @query labels?: string;
    },
    TraitContext.List
  >;

  /** Standard resource operations for listing sandboxes. */
  alias SandboxListOperations = ResourceOperations<
    DataPlaneStandardTraits,
    ListErrors
  >;
}

namespace ContainerAppsSandbox {
  /** Azure-scoped Sandbox CRUD operations. */
  @doc("Lists sandboxes in a scope.")
  @tag("Sandboxes")
  interface AzureSandboxes {
    @doc("Lists sandboxes in a scope.")
    list is SandboxListOperations.ResourceList<Sandbox, SandboxListTraits>;

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "The established wire contract uses POST with CreateSandboxContent and returns the created Sandbox in a 201 response body."
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

    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "The established wire contract allows both empty 200 and 204 success responses."
    @doc("Deletes a sandbox by identifier.")
    @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}")
    @delete
    delete is Foundations.Operation<
      {
        ...AzureResourceScope;

        /** Sandbox identifier. */
        @path id: SandboxId;
      },
      SandboxDeletedResult | SandboxDeletedNoContentResult,
      DataPlaneStandardTraits,
      DeleteErrors
    >;
  }
}
