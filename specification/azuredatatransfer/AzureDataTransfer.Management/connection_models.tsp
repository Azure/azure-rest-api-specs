import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./common_models.tsp";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AzureDataTransfer;

/**
 * Properties of connection
 */
model ConnectionProperties {
  /**
   * Pipeline to use to transfer data
   */
  pipeline: string;

  /**
   * Direction of data movement
   */
  direction?: Direction;

  /**
   * Justification for the connection request
   */
  justification?: string;

  /**
   * Status of the connection
   */
  @visibility(Lifecycle.Read)
  status?: Status;

  /**
   * Force disablement status of the current connection
   */
  @visibility(Lifecycle.Read)
  forceDisabledStatus?: ForceDisabledStatus[];

  /**
   * Reason for status
   */
  @visibility(Lifecycle.Read)
  statusReason?: string;

  /**
   * Link status of the current connection
   */
  @visibility(Lifecycle.Read)
  linkStatus?: LinkStatus;

  /**
   * Resource ID of the linked connection
   */
  @visibility(Lifecycle.Read)
  linkedConnectionId?: string;

  /**
   * The flow types being requested for this connection
   */
  flowTypes?: FlowType[];

  /**
   * Requirement ID of the connection
   */
  requirementId?: string;

  /**
   * Subscription ID to link cloud subscriptions together
   */
  remoteSubscriptionId?: string;

  /**
   * Approver of this connection request
   */
  @visibility(Lifecycle.Read)
  approver?: string;

  /**
   * PIN to link requests together
   */
  pin?: string;

  /**
   * The timestamp that this connection request was submitted at
   */
  @visibility(Lifecycle.Read)
  dateSubmitted?: utcDateTime;

  /**
   * The primary contact for this connection request
   */
  primaryContact?: string;

  /**
   * The secondary contacts for this connection request
   */
  secondaryContacts?: string[];

  /**
   * Provisioning state of the connection
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The policies for this connection
   */
  policies?: string[];

  /**
   * The schemas for this connection
   */
  schemas?: Schema[];

  /**
   * The schema URIs for this connection
   */
  schemaUris?: url[];
}

/**
 * The connections resource patch definition.
 */
model ConnectionsPatch {
  ...ManagedServiceIdentityProperty;
  ...ArmTagsProperty;
}

/**
 * Pending connection object
 */
model PendingConnection {
  ...ConnectionProperties;
  ...Azure.ResourceManager.TrackedResource<Connection>;

  /**
   * Subscription ID of the pending connection.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;
}

/**
 * Pending flow object
 */
model PendingFlow {
  ...FlowProperties;
  ...Azure.ResourceManager.TrackedResource<Flow>;

  /**
   * Subscription ID of the pending flow.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * Connection ID of the pending flow.
   */
  @visibility(Lifecycle.Read)
  connectionId?: string;
}

/**
 * Status of the connection
 */
union Status {
  string,
  InReview: "InReview",
  Approved: "Approved",
  Rejected: "Rejected",
  Accepted: "Accepted",
}
