import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace AzureDevCompute.SandboxOperations;

/** Successful Sandbox list response. */
model SandboxListResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Sandboxes in the requested page. */
  @body body: SandboxFields[];
}

/** Successful Sandbox create response. */
model SandboxCreatedResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Created sandbox. */
  @body body: SandboxFields;
}

/** Successful Sandbox get or update response. */
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

alias ListErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | InternalServerErrorNoBody;

alias CreateErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | ErrorResponse<429>
  | InternalServerErrorNoBody
  | ErrorResponse<503>;

alias GetErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

alias UpdateErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

alias AzureDeleteErrors =
  | ErrorResponse<401>
  | InternalServerErrorNoBody
  | ErrorResponse<503>;

alias UserDeleteErrors =
  | ErrorResponse<401>
  | InternalServerErrorNoBody
  | ErrorResponse<503>;

model ListParameters<Scope extends TypeSpec.Reflection.Model> {
  ...Scope;

  /** One-based page number. */
  @query Page?: int32 | string | null;

  /** Maximum number of sandboxes returned per page. */
  @query PageSize?: int32 | string | null;

  /** Comma-separated label selector. */
  @query labels?: string;
}

model CreateParameters<Scope extends TypeSpec.Reflection.Model> {
  ...Scope;

  /** Includes server debug timing information in the response. */
  @query includeDebug?: boolean = false;

  /** Sandbox create request. */
  @body request: SandboxRequest;
}

model GetParameters<Scope extends TypeSpec.Reflection.Model> {
  ...Scope;

  /** Sandbox identifier. */
  @path id: SandboxId;
}

model UpdateParameters<Scope extends TypeSpec.Reflection.Model> {
  ...Scope;

  /** Sandbox identifier. */
  @path id: SandboxId;

  /** Sandbox merge-patch request. */
  @body request: PatchSandboxRequest;
}

model DeleteParameters<Scope extends TypeSpec.Reflection.Model> {
  ...Scope;

  /** Sandbox identifier. */
  @path id: SandboxId;
}

/** Lists sandboxes in a scope. */
op List<Scope extends TypeSpec.Reflection.Model> is Foundations.Operation<
  ListParameters<Scope>,
  SandboxListResponse,
  DataPlaneStandardTraits,
  ListErrors
>;

/** Creates a sandbox in a scope. */
op Create<Scope extends TypeSpec.Reflection.Model> is Foundations.Operation<
  CreateParameters<Scope>,
  SandboxCreatedResponse,
  DataPlaneStandardTraits,
  CreateErrors
>;

/** Gets a sandbox by identifier. */
op Get<Scope extends TypeSpec.Reflection.Model> is Foundations.Operation<
  GetParameters<Scope>,
  SandboxResponse,
  DataPlaneStandardTraits,
  GetErrors
>;

/** Updates mutable sandbox properties. */
op Update<Scope extends TypeSpec.Reflection.Model> is Foundations.Operation<
  UpdateParameters<Scope>,
  SandboxResponse,
  DataPlaneStandardTraits,
  UpdateErrors
>;

/** Deletes a sandbox by identifier. */
op Delete<
  Scope extends TypeSpec.Reflection.Model,
  Errors
> is Foundations.Operation<
  DeleteParameters<Scope>,
  SandboxDeletedResponse | SandboxDeletedNoContentResponse,
  DataPlaneStandardTraits,
  Errors
>;
