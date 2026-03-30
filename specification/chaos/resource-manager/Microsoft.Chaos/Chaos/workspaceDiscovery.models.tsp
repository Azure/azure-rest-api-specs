import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./workspace.models.tsp";
import "./common.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.Chaos;

/**
 * Model that represents the latest workspace discovery result.
 */
@parentResource(Workspace)
@singleton("latest")
model WorkspaceDiscovery
  is Azure.ResourceManager.ProxyResource<WorkspaceDiscoveryProperties> {
  ...ResourceNameParameter<
    Resource = WorkspaceDiscovery,
    KeyName = "discoveryName",
    SegmentName = "discoveries",
    NamePattern = ""
  >;
}

/**
 * Model that represents the properties of the workspace discovery.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only singleton resource representing latest discovery status"
model WorkspaceDiscoveryProperties {
  /**
   * The discovery status.
   */
  @visibility(Lifecycle.Read)
  status: WorkspaceDiscoveryStatus;

  /**
   * The discovery UTC start time.
   */
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  /**
   * The discovery UTC end time.
   */
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  /**
   * System or infrastructure errors encountered during discovery.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  errors?: OperationError[];

  /**
   * The workspace ID this discovery belongs to.
   */
  @visibility(Lifecycle.Read)
  workspaceId: string;
}

/**
 * Enum of the workspace discovery status.
 */
union WorkspaceDiscoveryStatus {
  string,

  /**
   * The discovery is pending and has not started.
   */
  Pending: "Pending",

  /**
   * The discovery is in progress.
   */
  InProgress: "InProgress",

  /**
   * The discovery completed successfully.
   */
  Succeeded: "Succeeded",

  /**
   * The discovery failed.
   */
  Failed: "Failed",

  /**
   * The discovery was canceled.
   */
  Canceled: "Canceled",
}
