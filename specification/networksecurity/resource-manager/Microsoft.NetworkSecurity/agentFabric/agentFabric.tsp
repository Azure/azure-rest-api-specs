import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Rest;
using Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.NetworkSecurity;

/** AgentFabric resource */
model AgentFabric is TrackedResource<AgentFabricProperties> {
  ...ResourceNameParameter<AgentFabric>;
}

/** Provisioning state of the resource */
union ProvisioningState {
  string,

  /** Resource provisioning succeeded */
  Succeeded: "Succeeded",

  /** Resource provisioning failed */
  Failed: "Failed",

  /** Resource provisioning was canceled */
  Canceled: "Canceled",
}

/** AgentFabric properties */
model AgentFabricProperties {
  /** The default policy groups to apply to all members of this fabric. */
  defaultPolicyGroups?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkSecurity/policyGroups";
    }
  ]>[];

  /** The provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface AgentFabrics {
  get is ArmResourceRead<AgentFabric>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AgentFabric>;
  update is ArmTagsPatchSync<AgentFabric>;
  delete is ArmResourceDeleteSync<AgentFabric>;
  listByResourceGroup is ArmResourceListByParent<AgentFabric>;
  listBySubscription is ArmListBySubscription<AgentFabric>;
}

/** The workload type of a member. */
union WorkloadType {
  string,

  /** Foundry workload type */
  Foundry: "Foundry",
}

/** Base workload configuration for a member. */
@discriminator("type")
model WorkloadBase {
  /** The workload type. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  type: WorkloadType;

  /** The unique identifier assigned to the workload by the resource provider. */
  @visibility(Lifecycle.Read)
  workloadId?: string;
}

/** Foundry workload configuration. */
model FoundryWorkload extends WorkloadBase {
  /** The workload type. */
  type: "Foundry";

  /** The Azure resource ID of the Foundry resource. */
  resourceId?: Azure.Core.armResourceIdentifier;
}

/** Member resource */
@parentResource(AgentFabric)
model Member is ProxyResource<MemberProperties> {
  ...ResourceNameParameter<Member>;
}

/** Member properties */
model MemberProperties {
  /** The workload configuration of the member. */
  workload?: WorkloadBase;

  /** The policy groups to apply to this member. */
  policyGroups?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkSecurity/policyGroups";
    }
  ]>[];

  /** The provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Members {
  get is ArmResourceRead<Member>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Member>;
  delete is ArmResourceDeleteSync<Member>;
  listByParent is ArmResourceListByParent<Member>;
}

/** The direction of network traffic for a policy. */
union PolicyDirection {
  string,

  /** Outbound traffic only. */
  Outbound: "Outbound",

  /** Inbound traffic only. */
  Inbound: "Inbound",

  /** Both inbound and outbound traffic. */
  Both: "Both",
}

/** The type of network security policy. */
union NetworkSecurityPolicyType {
  string,

  /** FQDN filtering policy type. */
  FqdnFiltering: "FqdnFiltering",
}

/** Base network security policy configuration. */
@discriminator("type")
model NetworkSecurityPolicyBase {
  /** The network security policy type. */
  type: NetworkSecurityPolicyType;
}

/** Source details for a network security policy. */
model SourceDetails {
  /** The workload identifiers for the source. */
  workloadIds?: string[];
}

/** Destination details for a network security policy. */
model DestinationDetails {
  /** The fully qualified domain names for the destination. */
  fqdns?: string[];
}

/** FQDN filtering network security policy. */
model FqdnFilteringPolicy extends NetworkSecurityPolicyBase {
  /** The network security policy type. */
  type: "FqdnFiltering";

  /** The name of the policy. */
  name?: string;

  /** The priority of the policy. */
  priority?: int32;

  /** The direction of traffic for the policy. */
  direction?: PolicyDirection;

  /** The ports for the policy. */
  ports?: int32[];

  /** The source details for the policy. */
  source?: SourceDetails;

  /** The destination details for the policy. */
  destination?: DestinationDetails;
}

/** PolicyGroup resource. */
model PolicyGroup is TrackedResource<PolicyGroupProperties> {
  ...ResourceNameParameter<PolicyGroup>;
}

/** PolicyGroup properties. */
model PolicyGroupProperties {
  /** The display name of the policy group. */
  displayName?: string;

  /** The description of the policy group. */
  description?: string;

  /** The priority of the policy group. */
  priority?: int32;

  /** The list of network security policies. */
  @identifiers(#[])
  networkSecurityPolicies?: NetworkSecurityPolicyBase[];

  /** The provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface PolicyGroups {
  get is ArmResourceRead<PolicyGroup>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PolicyGroup>;
  update is ArmTagsPatchSync<PolicyGroup>;
  delete is ArmResourceDeleteSync<PolicyGroup>;
  listByResourceGroup is ArmResourceListByParent<PolicyGroup>;
  listBySubscription is ArmListBySubscription<PolicyGroup>;
}
