import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "./models.flowprofile.tsp";
import "./models.tsp";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Versioning;

@versioned(Versions)
namespace Microsoft.AzureDataTransfer;

/**
 * ARM resource ID of a storage or messaging transfer flow.
 */
alias TransferFlowResourceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.AzureDataTransfer/storageTransferFlows";
  },
  {
    type: "Microsoft.AzureDataTransfer/messagingTransferFlows";
  }
]>;

/**
 * Properties of a transfer flow
 */
@added(Versions.v2026_06_29_preview)
model CommonTransferFlowProperties {
  /**
   * Name of the pipeline the transfer flow uses. Pipelines are service-managed resources that customers cannot access directly; customers are given the name of the pipeline they are approved to use.
   */
  pipeline: string;

  /**
   * Dataflow GUID associated with this flow
   */
  @visibility(Lifecycle.Read)
  flowId?: string;

  /**
   * Transfer role indicating the direction of data movement
   */
  transferRole: TransferRole;

  /**
   * ARM resource ID of the paired transfer flow on the remote side of the pipeline.
   */
  remoteTransferFlowResourceId: TransferFlowResourceId;

  /**
   * Approval and lifecycle status of the transfer flow. Set by the service; use the approve/reject pipeline actions and the enableTransfer/disableTransfer actions to change it.
   */
  @visibility(Lifecycle.Read)
  status?: CommonTransferFlowStatus;

  /**
   * Force disablement status of the current flow
   */
  @visibility(Lifecycle.Read)
  forceDisabledStatus?: ForceDisabledStatus[];

  /**
   * Name of the FlowProfile to use for transfer via the flow. Resolved relative to the pipeline identified by the pipeline property.
   */
  flowProfileName: string;

  /**
   * Provisioning state of the flow
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Status of the storage transfer flow.
 */
@added(Versions.v2026_06_29_preview)
union CommonTransferFlowStatus {
  string,

  /**
   * This flow has been created but is under review by the admin approver.
   */
  AwaitingApproval: "AwaitingApproval",

  /**
   * This flow has been approved by the admin approver and is waiting for the remote side to link.
   */
  ApprovedWaitingToBeLinked: "ApprovedWaitingToBeLinked",

  /**
   * This flow has been enabled and is ready to send or receive data.
   */
  Enabled: "Enabled",

  /**
   * This flow has been disabled.
   */
  Disabled: "Disabled",

  /**
   * This flow has been rejected by the admin approver and cannot be used.
   */
  Rejected: "Rejected",
}

/**
 * The request resource body to reference.
 */
@added(Versions.v2026_06_29_preview)
model ListTransferFlowsByPipelineRequestBody {
  /**
   * Filters applied to the storage and messaging transfer flows returned.
   */
  flows?: ListTransferFlowsRequestBody;
}

/**
 * The request resource body to reference for Flow resources.
 */
@added(Versions.v2026_06_29_preview)
model ListTransferFlowsRequestBody {
  /** Status of the resource(s). If null, all statuses are considered. */
  status?: CommonTransferFlowStatus;

  /** Data class types of the resource(s). If null, all data class types are considered. */
  dataClassTypes?: DataClassType[];
}

/**
 * Compact summary of a transfer flow associated with a pipeline.
 */
@added(Versions.v2026_06_29_preview)
model TransferFlowSummary {
  /**
   * ARM resource ID of the transfer flow.
   */
  id: TransferFlowResourceId;

  /**
   * Status of the transfer flow.
   */
  status?: CommonTransferFlowStatus;

  /**
   * Transfer role of the transfer flow.
   */
  transferRole?: TransferRole;

  /**
   * Name of the FlowProfile used by the transfer flow.
   */
  flowProfileName?: string;

  /**
   * ARM resource ID of the paired transfer flow on the remote side of the pipeline.
   */
  remoteTransferFlowResourceId?: TransferFlowResourceId;

  /**
   * ARM resource ID of the data resource (storage container/table or messaging queue/event hub) used by the transfer flow.
   */
  dataResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts/blobServices/containers";
    },
    {
      type: "Microsoft.Storage/storageAccounts/tableServices/tables";
    },
    {
      type: "Microsoft.ServiceBus/namespaces/queues";
    },
    {
      type: "Microsoft.EventHub/namespaces/eventhubs";
    }
  ]>;

  /**
   * The identity that requested the transfer flow.
   */
  requestor?: string;

  /**
   * The pipeline associated with the transfer flow.
   */
  pipeline?: string;

  /**
   * Data class type of the transfer flow.
   */
  dataClassType?: DataClassType;

  /**
   * Tenant ID of the transfer flow.
   */
  tenantId?: string;
}

/**
 * A page of transfer flow summaries associated with a pipeline.
 */
@added(Versions.v2026_06_29_preview)
model ListTransferFlowsByPipelineResult {
  /**
   * Summaries of the storage and messaging transfer flows associated with the pipeline.
   */
  @pageItems
  @identifiers(#["id"])
  value: TransferFlowSummary[];

  /**
   * The link to the next page of results, if any.
   */
  @nextLink
  nextLink?: url;
}

/**
 * The request resource body to reference.
 */
@added(Versions.v2026_06_29_preview)
model TransferFlowRequestBody {
  /**
   * ARM resource IDs of the transfer flows to approve or reject.
   */
  id?: TransferFlowResourceId[];

  /**
   * Reason for resource operation.
   */
  statusReason?: string;
}

/**
 * The resource response body to reference.
 */
@added(Versions.v2026_06_29_preview)
model TransferFlowResponseBody {
  /**
   * The transfer flows that were approved or rejected, with their resulting status.
   */
  @identifiers(#["id"])
  id: TransferFlowIdBody[];
}

/**
 * The resource to reference.
 */
@added(Versions.v2026_06_29_preview)
model TransferFlowIdBody {
  /**
   * ARM resource ID of the transfer flow.
   */
  id: TransferFlowResourceId;

  /**
   * Flow resource's status.
   */
  status?: CommonTransferFlowStatus;
}

/**
 * Transfer role indicating the role of data movement
 */
@added(Versions.v2026_06_29_preview)
union TransferRole {
  string,

  /**
   * The role is on the source side for the paired flow.
   */
  Source: "Source",

  /**
   * The role is on the destination side for the paired flow.
   */
  Destination: "Destination",
}
