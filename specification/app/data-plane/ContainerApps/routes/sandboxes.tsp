using Http;
using Rest;
using Azure.Core;
using Azure.Core.Traits;

namespace ContainerAppsSandbox {
  /** Successful Sandbox create response. */
  model SandboxCreatedResult {
    /** The HTTP 201 status code. */
    @statusCode statusCode: 201;

    /** URL of the created sandbox. */
    @header("Location") location: ResourceLocation<Sandbox>;

    /** Created sandbox. */
    @body body: Sandbox;
  }

  /** Errors returned when listing sandboxes. */
  alias ListErrors =
    | BadRequestErrorResult
    | UnauthorizedErrorResult
    | InternalServerErrorResult;

  /** Errors returned when creating a sandbox. */
  alias CreateErrors =
    | BadRequestErrorResult
    | UnauthorizedErrorResult
    | TooManyRequestsErrorResult
    | InternalServerErrorResult;

  /** Errors returned when getting a sandbox. */
  alias GetErrors =
    | UnauthorizedErrorResult
    | NotFoundErrorResult
    | InternalServerErrorResult;

  /** Errors returned when deleting a sandbox. */
  alias DeleteErrors = UnauthorizedErrorResult | InternalServerErrorResult;

  /** Shared operation traits for creating sandboxes. */
  alias SandboxCreateOperations = ResourceOperations<
    DataPlaneStandardTraits,
    CreateErrors
  >;

  /** Shared operation traits for deleting sandboxes. */
  alias SandboxDeleteOperations = ResourceOperations<
    DataPlaneStandardTraits,
    DeleteErrors
  >;

  /** Shared operation traits for reading sandboxes. */
  alias SandboxGetOperations = ResourceOperations<
    DataPlaneStandardTraits,
    GetErrors
  >;

  /** Query parameters for listing sandboxes. */
  alias SandboxListTraits = QueryParametersTrait<
    {
      /** Continuation token for paginated results. */
      @query @continuationToken skipToken?: string;

      /** Comma-separated label selector. */
      @query labels?: string;
    },
    TraitContext.List
  >;

  /** Shared operation traits for listing sandboxes. */
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

    @doc("Creates a sandbox in a scope.")
    @action("sandboxes")
    @actionSeparator("/")
    create is SandboxCreateOperations.ResourceAction<
      SandboxGroupScope,
      {
        /** Sandbox create request. */
        @body content: CreateSandboxContent;
      },
      SandboxCreatedResult
    >;

    @doc("Gets a sandbox by identifier.")
    get is SandboxGetOperations.ResourceRead<Sandbox>;

    @doc("Deletes a sandbox by identifier.")
    delete is SandboxDeleteOperations.ResourceDelete<Sandbox>;
  }
}
