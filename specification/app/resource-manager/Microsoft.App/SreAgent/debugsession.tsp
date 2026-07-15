import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./debugsession.models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.App;

/**
 * Provider-level actions for SRE Agent debug sessions.
 *
 * `startDebugSession` is an ARM `ProviderLevelAction` rooted at
 * `/subscriptions/{subscriptionId}`; it is not tied to a single ARM resource
 * instance, so RBAC is evaluated at the subscription scope.
 */
@added(Versions.v2026_06_01_preview)
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This interface groups a subscription-level provider action (startDebugSession) that is not tied to a single ARM resource type."
interface DebugSessionOperations {
  /**
   * Start a debug session for a set of resources across the participating
   * subscriptions. The action is a subscription-level provider action rooted at
   * the URL subscription; every requested resource must belong to the URL
   * subscription or to one of the declared additional subscriptions.
   */
  @summary("Start a debug session")
  @tag("POST")
  @autoRoute
  startDebugSession is ArmProviderActionSync<
    Request = StartDebugSessionRequest,
    Response = StartDebugSessionResponse,
    Scope = SubscriptionActionScope,
    Error = ErrorResponse
  >;
}
