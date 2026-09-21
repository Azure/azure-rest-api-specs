import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./workspace.models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.Chaos;

/**
 * The host type of a subscriber - the kind of machine the agent runs on.
 */
union HostType {
  string,

  /**
   * An Azure virtual machine.
   */
  VirtualMachine: "VirtualMachine",

  /**
   * An instance of an Azure virtual machine scale set.
   */
  VmssInstance: "VmssInstance",

  /**
   * A machine that is not an Azure (ARM) resource - for example an on-premises or
   * non-Azure VM running the Chaos agent. Having no Azure resource id, it is
   * represented by a synthetic virtual surrogate resource under the workspace so it
   * can be targeted like any other discovered resource.
   */
  VirtualSurrogateResource: "VirtualSurrogateResource",
}

/**
 * The liveness status of a subscriber, derived from the agent heartbeat.
 */
union SubscriberStatus {
  string,

  /**
   * The agent is registered and actively heartbeating.
   */
  Connected: "Connected",

  /**
   * The agent's heartbeat has gone stale; heartbeats are no longer being received.
   */
  Disconnected: "Disconnected",

  /**
   * The agent has been disconnected long enough to be considered gone.
   */
  Expired: "Expired",
}

/**
 * The recognizable machine an agent runs on. Exactly one of `armResourceId` or
 * `externalId` is set.
 */
model SubscriberHost {
  /**
   * The ARM resource identifier of the host, for an ARM machine.
   */
  @visibility(Lifecycle.Read)
  armResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * The ARM-shaped external identifier (`.../virtualSurrogateResources/{hostHint}`)
   * of the host, for a non-ARM machine.
   */
  @visibility(Lifecycle.Read)
  externalId?: string;
}

/**
 * Model that represents the properties of a subscriber - a live agent
 * registration on a host.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This is a read-only resource"
model SubscriberProperties {
  /**
   * The ARM identifier of the parent workspace this subscriber is registered to.
   */
  @visibility(Lifecycle.Read)
  workspaceId: Azure.Core.armResourceIdentifier;

  /**
   * The `.../connections/{name}` connection that authorizes this subscriber.
   * Present only for below-ARM subscribers; omitted for above-ARM subscribers,
   * which are authorized by the workspace's system-managed allowance.
   */
  @visibility(Lifecycle.Read)
  connectionResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * The connection's per-create grant stamp this registration is bound to.
   * Present only for below-ARM subscribers; omitted for above-ARM subscribers.
   */
  @visibility(Lifecycle.Read)
  grantIncarnation?: string;

  /**
   * The parent workspace's per-creation stamp. A workspace recreate mints a new
   * incarnation and purges all prior subscribers.
   */
  @visibility(Lifecycle.Read)
  workspaceIncarnation: string;

  /**
   * The host type of the machine the agent runs on.
   */
  @visibility(Lifecycle.Read)
  kind: HostType;

  /**
   * The liveness status of the subscriber, from the agent heartbeat.
   */
  @visibility(Lifecycle.Read)
  status: SubscriberStatus;

  /**
   * The date and time when the agent first registered.
   */
  @visibility(Lifecycle.Read)
  registeredAt: utcDateTime;

  /**
   * The date and time of the agent's last heartbeat.
   */
  @visibility(Lifecycle.Read)
  lastSeenAt: utcDateTime;

  /**
   * The recognizable machine the agent runs on.
   */
  @visibility(Lifecycle.Read)
  host: SubscriberHost;

  /**
   * Where this agent surfaces - an ARM scope, or the workspace ARM path for a
   * workspace-scoped agent.
   */
  @visibility(Lifecycle.Read)
  scope: Azure.Core.armResourceIdentifier;

  /**
   * The `discoveredResources/{id}` this agent maps to.
   */
  @visibility(Lifecycle.Read)
  discoveredResourceId: Azure.Core.armResourceIdentifier;

  /**
   * The fault vocabulary this specific agent instance supports, used to recommend
   * scenarios for it. This is the per-agent capability set reported at registration,
   * distinct from the target-type `capabilityTypes` (actions) API, which describes what
   * a resource type supports rather than what this live agent supports.
   */
  @visibility(Lifecycle.Read)
  capabilities: string[];

  /**
   * An optional grouping identifier that matches a custom scope.
   */
  @visibility(Lifecycle.Read)
  customGroup?: string;
}

/**
 * Model that represents a subscriber - a live agent registration in a workspace.
 */
@parentResource(Workspace)
model Subscriber is Azure.ResourceManager.ProxyResource<SubscriberProperties> {
  ...ResourceNameParameter<
    Resource = Subscriber,
    KeyName = "subscriberName",
    SegmentName = "subscribers",
    NamePattern = "^[a-zA-Z0-9-]+$"
  >;
}

/**
 * Model that represents a list of subscribers and a link for pagination.
 */
model SubscriberListResult is Azure.Core.Page<Subscriber>;
