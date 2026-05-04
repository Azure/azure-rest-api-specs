using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.SaaS;

/** Subscription-level SaaS resource operations (GA 2026-04-01). */
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SaaS/resources")
interface SaasSubscriptionLevel {
  /** Gets all Subscription Level SaaS in a resource group. */
  @get
  listByResourceGroup(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<SaasResource>,
  ): {
    @statusCode statusCode: 200;
    @body body: SaasResourceResponseWithContinuation;
  } | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /** Gets a specific Subscription Level SaaS resource. */
  @get
  @route("{resourceName}")
  get(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<SaasResource>,
    @path resourceName: string,
  ): {
    @statusCode statusCode: 200;
    @body body: SaasResource;
  } | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /** Creates or updates a SaaS resource. */
  @put
  @route("{resourceName}")
  createOrUpdate(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<SaasResource>,
    @path resourceName: string,
    @body parameters: SaasResourceCreation,
  ): {
    @statusCode statusCode: 200;
    @body body: SaasResource;
  } | {
    @statusCode statusCode: 202;
    @header location: string;
    @header("Retry-After") retryAfter?: int32;
  } | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /** Updates a SaaS Subscription Level resource. */
  @patch
  @route("{resourceName}")
  update(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<SaasResource>,
    @path resourceName: string,
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
  @route("{resourceName}")
  delete(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<SaasResource>,
    @path resourceName: string,
  ): {
    @statusCode statusCode: 200;
  } | {
    @statusCode statusCode: 202;
    @header location: string;
    @header("Retry-After") retryAfter?: int32;
  } | {
    @statusCode statusCode: 204;
  } | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /** Unsubscribe from a Subscription Level SaaS. */
  @post
  @route("{resourceName}/unsubscribe")
  unsubscribe(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<SaasResource>,
    @path resourceName: string,
    @body parameters: DeleteOptions,
  ): {
    @statusCode statusCode: 200;
  } | {
    @statusCode statusCode: 202;
    @header location: string;
    @header("Retry-After") retryAfter?: int32;
  } | {
    @statusCode statusCode: 204;
  } | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /** Gets the ISV access token for a Subscription Level SaaS. */
  @post
  @route("{resourceName}/listAccessToken")
  listAccessToken(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<SaasResource>,
    @path resourceName: string,
  ): {
    @statusCode statusCode: 200;
    @body body: AccessTokenResult;
  } | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /** Checks eligibility for a subscription-level SaaS purchase (resource-scoped). */
  @post
  @route("{resourceName}/checkEligibility")
  checkEligibility(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<SaasResource>,
    @path resourceName: string,
    @body saasResource: SaasResource,
  ): {
    @statusCode statusCode: 200;
    @body body: EligibilityCheckResult;
  } | Azure.ResourceManager.CommonTypes.ErrorResponse;
}

/** List SaaS resources by Azure subscription. */
@route("/subscriptions/{subscriptionId}/providers/Microsoft.SaaS")
interface SaasSubscriptionLevelGlobal {
  /** Gets all Subscription Level SaaS in an Azure subscription. */
  @get
  @route("resources")
  listByAzureSubscription(
    ...Azure.ResourceManager.ApiVersionParameter,
    @path subscriptionId: string,
  ): {
    @statusCode statusCode: 200;
    @body body: SaasResourceResponseWithContinuation;
  } | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /** Checks name availability for a SaaS resource. */
  @post
  @route("checkNameAvailability")
  checkNameAvailability(
    ...Azure.ResourceManager.ApiVersionParameter,
    @path subscriptionId: string,
    @body nameAvailability: SaasNameAvailabilityRequest,
  ): {
    @statusCode statusCode: 200;
    @body body: SaasNameAvailabilityResponse;
  } | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /** Checks eligibility for a subscription-level SaaS purchase (subscription-scoped). */
  @post
  @route("checkEligibility")
  checkEligibilitySubscription(
    ...Azure.ResourceManager.ApiVersionParameter,
    @path subscriptionId: string,
    @body saasResource: SaasResource,
  ): {
    @statusCode statusCode: 200;
    @body body: EligibilityCheckResult;
  } | Azure.ResourceManager.CommonTypes.ErrorResponse;
}

/** Move resources operations. */
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}")
interface SaasSubscriptionLevelMove {
  /** Validate whether a Subscription Level SaaS can be moved. */
  @post
  @route("validateMoveResources")
  validateMoveResources(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<SaasResource>,
    @body moveResourceParameter: MoveResource,
  ): {
    @statusCode statusCode: 200;
  } | Azure.ResourceManager.CommonTypes.ErrorResponse;

  /** Move a Subscription Level SaaS. */
  @post
  @route("moveResources")
  moveResources(
    ...Azure.ResourceManager.Foundations.DefaultBaseParameters<SaasResource>,
    @body moveResourceParameter: MoveResource,
  ): {
    @statusCode statusCode: 200;
  } | {
    @statusCode statusCode: 202;
    @header location: string;
    @header("Retry-After") retryAfter?: int32;
  } | Azure.ResourceManager.CommonTypes.ErrorResponse;
}

