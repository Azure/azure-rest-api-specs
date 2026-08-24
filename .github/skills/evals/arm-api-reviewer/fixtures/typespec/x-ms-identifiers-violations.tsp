// TypeSpec fixture: x-ms-identifiers violations (TSP-ARRAY-IDENTIFIERS)
// Seeded violations:
//   - @extension("x-ms-identifiers", []) on array property (FORBIDDEN -- use @identifiers(#[]))
//   - @extension("x-ms-identifiers", ["id"]) on array property (FORBIDDEN -- use @identifiers or @key)
//   - #suppress missing-x-ms-identifiers with "FIXME" placeholder reason (TSP-4.1: no placeholder text)
//   - #suppress missing-x-ms-identifiers with vague "matching another resource" reason
// Compliant patterns (positive controls -- should NOT be flagged):
//   - @key on item type's identity property
//   - @identifiers(#["propertyName"]) on array property
//   - @identifiers(#[]) on result-record array with no identifier

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Identifier Demo Service",
})
@versioned(Versions)
namespace Microsoft.IdentifierDemo;

/** API versions */
enum Versions {
  /** 2025-01-01 version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2025_01_01: "2025-01-01",
}

@segment("clusters")
model Cluster is TrackedResource<ClusterProperties> {
  @key("clusterName")
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  name: string;
}

/** Properties of a cluster resource. */
model ClusterProperties {
  /** The provisioning state. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  // Violation #1: @extension("x-ms-identifiers", []) is FORBIDDEN.
  // Correct fix: use @identifiers(#[]) instead.
  /** Ordered list of preflight check results for this cluster. */
  @extension("x-ms-identifiers", [])
  preflightResults?: PreflightResult[];

  // Violation #2: @extension("x-ms-identifiers", ["nodeId"]) is FORBIDDEN.
  // Correct fix: use @identifiers(#["nodeId"]) or @key on the item type.
  /** List of cluster nodes. */
  @extension("x-ms-identifiers", ["nodeId"])
  nodes?: ClusterNode[];

  // Violation #3: #suppress reason contains FIXME placeholder text.
  // TSP-4.1: suppression reasons MUST NOT contain FIXME/TODO/TBD.
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: revisit identifiers later"
  /** List of attached storage volumes. */
  volumes?: StorageVolume[];

  // Violation #4: #suppress reason is vague ("matching another resource").
  // TSP-4.1: each suppression must stand on its own with a real technical justification.
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Matching AiGateway pattern"
  /** List of cluster firewall rules. */
  firewallRules?: FirewallRule[];

  // Positive control #1: @identifiers(#["moveId"]) correctly applied -- should NOT be flagged.
  /** List of pending move requests. */
  @identifiers(#["moveId"])
  pendingMoves?: MoveRequest[];

  // Positive control #2: @identifiers(#[]) for result-record array -- should NOT be flagged.
  /** Historical diagnostic snapshots, ordered by timestamp. No stable identifier. */
  @identifiers(#[])
  diagnosticSnapshots?: DiagnosticSnapshot[];

  // Positive control #3: item type uses @key, so emitter derives x-ms-identifiers automatically -- should NOT be flagged.
  /** List of cluster tags. */
  customLabels?: ClusterLabel[];
}

/** A preflight check result. */
model PreflightResult {
  /** Name of the check that ran. */
  checkName: string;

  /** Whether the check passed. */
  passed: boolean;

  /** Detail message if the check failed. */
  message?: string;
}

/** A node in the cluster. */
model ClusterNode {
  /** Unique identifier of the node. */
  nodeId: string;

  /** Display name of the node. */
  displayName?: string;

  /** Current node status. */
  status?: string;
}

/** A storage volume attached to the cluster. */
model StorageVolume {
  /** Volume identifier. */
  volumeId: string;

  /** Size of the volume in GB. */
  sizeGB: int32;
}

/** A firewall rule on the cluster. */
model FirewallRule {
  /** Rule name. */
  ruleName: string;

  /** Whether the rule allows or denies traffic. */
  action: string;
}

/** A move request. */
model MoveRequest {
  /** Unique identifier for the move operation. */
  moveId: string;

  /** Source resource id. */
  source: string;

  /** Destination resource id. */
  destination: string;
}

/** A diagnostic snapshot record. */
model DiagnosticSnapshot {
  /** When the snapshot was taken. */
  timestamp: utcDateTime;

  /** Captured CPU percentage. */
  cpuPercent: float32;
}

/** A user-defined label on the cluster (positive control: item type uses @key). */
model ClusterLabel {
  /** The label key -- marked as the identity property via @key. */
  @key
  labelKey: string;

  /** The label value. */
  labelValue: string;
}

@armResourceOperations
interface Clusters {
  get is ArmResourceRead<Cluster>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Cluster>;
  update is ArmResourcePatchAsync<Cluster, ClusterProperties>;
  delete is ArmResourceDeleteAsync<Cluster>;
  listByResourceGroup is ArmResourceListByParent<Cluster>;
  listBySubscription is ArmListBySubscription<Cluster>;
}

interface Operations extends Azure.ResourceManager.Operations {}
