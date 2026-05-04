using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.SaaS;

/** Tenant-level SaaS resource operations (GA 2026-04-01). */
@route("/providers/Microsoft.SaaS/saasresources")
interface SaasTenantLevel {
  /** Creates a SaaS resource. */
  @put
  createResource(
    ...Azure.ResourceManager.ApiVersionParameter,
    @body parameters: SaasResourceCreation,
  ): {
    @statusCode statusCode: 200;
    @body body: SaasResource;
  } | {
    @statusCode statusCode: 202;
    @header location: string;
    @header("Retry-After") retryAfter?: int32;
  } | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /** Get all tenant-level SaaS resources. */
  @get
  list(
    ...Azure.ResourceManager.ApiVersionParameter,
  ): {
    @statusCode statusCode: 200;
    @body body: SaasResourceResponseWithContinuation;
  } | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /** Gets a specific tenant-level SaaS resource. */
  @get
  @route("{resourceId}")
  getResource(
    ...Azure.ResourceManager.ApiVersionParameter,
    @path resourceId: string,
  ): {
    @statusCode statusCode: 200;
    @body body: SaasResource;
  } | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /** Updates a SaaS resource. */
  @patch
  @route("{resourceId}")
  updateResource(
    ...Azure.ResourceManager.ApiVersionParameter,
    @path resourceId: string,
    @body parameters: SaasResourceCreation,
  ): {
    @statusCode statusCode: 200;
    @body body: SaasResource;
  } | {
    @statusCode statusCode: 202;
    @header location: string;
    @header("Retry-After") retryAfter?: int32;
  } | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /** Deletes the specified SaaS. */
  @delete
  @route("{resourceId}")
  deleteResource(
    ...Azure.ResourceManager.ApiVersionParameter,
    @path resourceId: string,
    @body parameters: DeleteOptions,
  ): {
    @statusCode statusCode: 200;
  } | {
    @statusCode statusCode: 204;
  } | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /** Gets the ISV access token for a SaaS resource. */
  @post
  @route("{resourceId}/listAccessToken")
  listAccessToken(
    ...Azure.ResourceManager.ApiVersionParameter,
    @path resourceId: string,
  ): {
    @statusCode statusCode: 200;
    @body body: AccessTokenResult;
  } | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /** Pre-validates SaaS subscription operations. */
  @post
  @route("preflight")
  preflight(
    ...Azure.ResourceManager.ApiVersionParameter,
    @body body: unknown,
  ): {
    @statusCode statusCode: 200;
  } | Azure.ResourceManager.CommonTypes.ErrorResponse;
}

/** Operation result status polling. */
@route("/providers/Microsoft.SaaS/operationResults")
interface SaasOperationResults {
  /** Gets the status of an operation. */
  @get
  @route("{operationId}")
  getOperationStatus(
    ...Azure.ResourceManager.ApiVersionParameter,
    @path operationId: string,
  ): {
    @statusCode statusCode: 200;
    @body body: SaasResource;
  } | {
    @statusCode statusCode: 202;
    @header location: string;
    @header("Retry-After") retryAfter?: int32;
  } | Azure.ResourceManager.CommonTypes.ErrorResponse;
}

