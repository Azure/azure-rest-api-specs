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
 * Device Update linked account details.
 */
model LinkedAccount
  is Azure.ResourceManager.TrackedResource<LinkedAccountProperties> {
  ...ResourceNameParameter<
    Resource = LinkedAccount,
    KeyName = "linkedAccountName",
    SegmentName = "linkedAccounts",
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
@removed(Versions.v2026_07_02_preview)
@armResourceOperations
interface LinkedAccounts {
  /**
   * Returns linked account details for the given linked account name.
   */
  get is ArmResourceRead<LinkedAccount>;

  /**
   * Creates or updates a Linked Account.
   */
  create is ArmResourceCreateOrReplaceAsync<LinkedAccount>;

  /**
   * Updates linked account's patchable properties
   */
  @removed(Versions.v2026_06_01_preview)
  @renamedFrom(Versions.v2026_06_01_preview, "update")
  @sharedRoute
  @patch(#{ implicitOptionality: false })
  updateSync is ArmCustomPatchSync<LinkedAccount, LinkedAccountUpdate>;

  /**
   * Updates linked account's patchable properties
   */
  @added(Versions.v2026_06_01_preview)
  @sharedRoute
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    LinkedAccount,
    LinkedAccountUpdate,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = LinkedAccount> &
      ArmLroLocationHeader<FinalResult = LinkedAccount> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a linked account.
   */
  delete is ArmResourceDeleteWithoutOkAsync<LinkedAccount>;

  /**
   * Returns list of Linked Accounts.
   */
  listByResourceGroup is ArmResourceListByParent<LinkedAccount>;

  /**
   * Returns list of Linked Accounts.
   */
  listBySubscription is ArmListBySubscription<LinkedAccount>;

  /**
   * Check if the Linked Account name is available
   */
  @sharedRoute
  checkNameAvailability is checkGlobalNameAvailability;

  /**
   * Preflight check for account linking readiness. No state change.
   */
  @access(Access.internal)
  @action("linkPreflight")
  linkPreflight is ArmResourceActionSync<
    LinkedAccount,
    LinkPreflightRequest,
    LinkPreflightResponse
  >;

  /**
   * Initiate account linking. Validates and persists binding, sets linkingState=InProgress.
   */
  @access(Access.internal)
  @action("linkInitiate")
  linkInitiate is ArmResourceActionAsync<
    LinkedAccount,
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
    LinkedAccount,
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
  @removed(Versions.v2026_06_01_preview)
  @renamedFrom(Versions.v2026_06_01_preview, "linkUpdate")
  @sharedRoute
  @action("linkUpdate")
  linkUpdateSync is ArmResourceActionSync<
    LinkedAccount,
    LinkUpdateRequest,
    {
      @body
      body: LinkUpdateResponse;
    }
  >;

  /**
   * Update linking properties (e.g., identity rotation).
   */
  @access(Access.internal)
  @added(Versions.v2026_06_01_preview)
  @sharedRoute
  @action("linkUpdate")
  linkUpdate is ArmResourceActionAsync<
    LinkedAccount,
    LinkUpdateRequest,
    LinkUpdateResponse,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@maxLength(LinkedAccount.name, 36);
@@minLength(LinkedAccount.name, 3);
@@doc(
  LinkedAccount.name,
  "The user-chosen Linked Account name. Must be unique within the subscription and is used in the resource URL and ADU service routing. Allowed characters: alphanumeric and hyphens (not leading/trailing); length 3-36."
);
@@doc(LinkedAccounts.create::parameters.resource, "Linked Account details.");
@@doc(
  LinkedAccounts.updateSync::parameters.properties,
  "Updated Linked Account."
);
@@doc(LinkedAccounts.update::parameters.properties, "Updated Linked Account.");
