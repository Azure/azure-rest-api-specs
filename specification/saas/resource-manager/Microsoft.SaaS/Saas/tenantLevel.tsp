import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.SaaS;

@tenantResource
model SaasTenantResource is TrackedResource<SaasResourceProperties> {
  ...ResourceNameParameter<
    Resource = SaasTenantResource,
    KeyName = "resourceId",
    SegmentName = "saasresources",
    NamePattern = "^[a-zA-Z0-9-]{3,50}$"
  >;
}

@armResourceOperations
interface SaasTenantLevel {
  createResource is ArmResourceCreateOrReplaceAsync<SaasTenantResource>;
  getResource is ArmResourceRead<SaasTenantResource>;
  updateResource is ArmCustomPatchAsync<
    SaasTenantResource,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      SaasTenantResource,
      SaasResourceProperties
    >
  >;
  deleteResource is ArmResourceDeleteWithoutOkAsync<SaasTenantResource>;
  list is ArmResourceListByParent<SaasTenantResource>;
  listAccessToken is ArmResourceActionSync<
    SaasTenantResource,
    void,
    AccessTokenResult
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom preflight route not tied to SaasTenantResource"
interface SaasTenantLevelPreflight {
  /** Pre-validates SaaS subscription operations. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Preflight accepts dynamic payload"
  @post
  @route("/providers/Microsoft.SaaS/deployments/{saasSubscriptionName}/preflight")
  preflight(
    ...ApiVersionParameter,

    /** The SaaS subscription name. */
    @path saasSubscriptionName: string,

    /** The preflight request body. */
    @body body: unknown,
  ): OkResponse | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom operation status route"
interface SaasOperationResults {
  /** Gets the status of a long-running SaaS operation. Returns the resource on completion. */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "operationResults uses Retry-After, not Location"
  @get
  @route("/providers/Microsoft.SaaS/operationResults/{operationId}")
  getOperationStatus(
    ...ApiVersionParameter,

    /** The operation ID. */
    @path operationId: string,
  ):
    | ArmResponse<SaasResource>
    | {
        @statusCode statusCode: 202;
        @header("Retry-After") retryAfter?: int32;
      }
    | {
        @statusCode statusCode: 204;
      }
    | ErrorResponse;
}
