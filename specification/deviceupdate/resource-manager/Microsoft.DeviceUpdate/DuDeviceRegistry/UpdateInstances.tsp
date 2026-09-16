import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.DeviceUpdate;

/**
 * Device Update instance details.
 */
model UpdateInstance
  is Azure.ResourceManager.TrackedResource<UpdateInstanceProperties> {
  ...ResourceNameParameter<
    Resource = UpdateInstance,
    KeyName = "updateInstanceName",
    SegmentName = "updateInstances",
    NamePattern = "^[A-Za-z0-9]+(-[A-Za-z0-9]+)*$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

/**
 * Internal link* actions (linkPreflight, linkInitiate, linkNotify, linkUpdate).
 *
 * Intended caller: Microsoft.DeviceRegistry RP via its namespace Managed Identity (MI).
 *
 * Authorization model:
 *   1. Bilateral RBAC — caller must hold write on the ADR namespace AND either a
 *      granular link action or general write on the target resource.
 *   2. Linking flow only runs through ADR — these endpoints are not exposed for
 *      direct customer use. Only ADR's namespace MI can invoke them; the resource
 *      verifies this on every call.
 *   3. MI attribution — the resource validates the calling MI matches the namespace's
 *      outbound MI declared in the request body.
 *
 * These actions are publicly documented per ARM modeling guidance: external requests
 * are blocked via RP business logic rather than hiding behind an RPaaS-internal endpoint.
 */
@added(Versions.v2026_07_02_preview)
@armResourceOperations
interface UpdateInstances {
  /**
   * Returns update instance details for the given update instance name.
   */
  get is ArmResourceRead<UpdateInstance>;

  /**
   * Creates or updates an Update Instance.
   */
  create is ArmResourceCreateOrReplaceAsync<UpdateInstance>;

  /**
   * Updates update instance's patchable properties.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    UpdateInstance,
    UpdateInstanceUpdate,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = UpdateInstance> &
      ArmLroLocationHeader<FinalResult = UpdateInstance> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes an update instance.
   */
  delete is ArmResourceDeleteWithoutOkAsync<UpdateInstance>;

  /**
   * Returns list of Update Instances.
   */
  listByResourceGroup is ArmResourceListByParent<UpdateInstance>;

  /**
   * Returns list of Update Instances.
   */
  listBySubscription is ArmListBySubscription<UpdateInstance>;

  /**
   * Check if the Update Instance name is available.
   */
  @sharedRoute
  checkNameAvailability is checkGlobalNameAvailability;

  /**
   * Preflight check for account linking readiness. No state change.
   */
  @access(Access.internal)
  @action("linkPreflight")
  linkPreflight is ArmResourceActionSync<
    UpdateInstance,
    LinkPreflightRequest,
    LinkPreflightResponse
  >;

  /**
   * Initiate account linking. Validates and persists binding, sets linkingState=InProgress.
   */
  @access(Access.internal)
  @action("linkInitiate")
  linkInitiate is ArmResourceActionAsync<
    UpdateInstance,
    LinkInitiateRequest,
    AccountLinking,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Notify linking state change (commit, fail, or namespaceDeleted).
   */
  @access(Access.internal)
  @action("linkNotify")
  linkNotify is ArmResourceActionAsync<
    UpdateInstance,
    LinkNotifyRequest,
    AccountLinking,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update linking properties (e.g., identity rotation).
   */
  @access(Access.internal)
  @action("linkUpdate")
  linkUpdate is ArmResourceActionAsync<
    UpdateInstance,
    LinkUpdateRequest,
    UpdateInstanceLinkUpdateResponse,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@maxLength(UpdateInstance.name, 36);
@@minLength(UpdateInstance.name, 3);
@@doc(
  UpdateInstance.name,
  "The user-chosen Update Instance name. Must be unique within the subscription and is used in the resource URL and ADU service routing. Allowed characters: alphanumeric and hyphens (not leading/trailing); length 3-36."
);
@@doc(UpdateInstances.create::parameters.resource, "Update Instance details.");
@@doc(
  UpdateInstances.update::parameters.properties,
  "Updated Update Instance."
);
