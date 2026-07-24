import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "./agentsession.models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.App;

/** A persistent Agent Session that manages a renewable isolated SRE Agent runtime. */
@added(Versions.v2026_08_01_preview)
model AgentSession is TrackedResource<AgentSessionProperties> {
  ...ResourceNameParameter<
    Resource = AgentSession,
    KeyName = "agentSessionName",
    SegmentName = "agentSessions",
    NamePattern = "^[a-z0-9]([-a-z0-9]{0,61}[a-z0-9])?$"
  >;
  ...EntityTagProperty;
}

/** Operations for managing Agent Sessions. */
@added(Versions.v2026_08_01_preview)
@armResourceOperations
interface AgentSessions {
  /** Gets an Agent Session. */
  get is ArmResourceRead<AgentSession>;

  /** Creates an Agent Session and provisions its initial sandbox. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AgentSession>;

  /** Updates the tags of an Agent Session. */
  update is ArmTagsPatchAsync<AgentSession>;

  /** Deletes an Agent Session and any active sandbox. */
  delete is ArmResourceDeleteWithoutOkAsync<
    Resource = AgentSession,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader,
    Parameters = AgentSessionIfMatchParameter
  >;

  /** Lists Agent Sessions in a resource group. */
  listByResourceGroup is ArmResourceListByParent<AgentSession>;

  /** Lists Agent Sessions in a subscription. */
  listBySubscription is ArmListBySubscription<AgentSession>;

  /**
   * Returns the active sandbox when one exists, or provisions a sandbox when
   * the Agent Session has no active sandbox. Repeated calls do not create
   * overlapping sandboxes.
   */
  provision is ArmResourceActionAsync<
    Resource = AgentSession,
    Request = void,
    Response = AgentSession,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = AgentSession> &
      Azure.Core.Foundations.RetryAfterHeader,
    Parameters = AgentSessionIfMatchParameter
  >;
}
