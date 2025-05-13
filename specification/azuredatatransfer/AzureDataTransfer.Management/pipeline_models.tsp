import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./common_models.tsp";

using Azure.ResourceManager;
using Azure.ResourceManager.CommonTypes;

namespace Microsoft.AzureDataTransfer;

/**
 * Properties of pipeline
 */
model PipelineProperties {
  /**
   * Remote cloud of the data to be transferred or received
   */
  remoteCloud: string;

  /**
   * Display name of this pipeline
   */
  displayName?: string;

  /**
   * Connections associated with pipeline
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["id"])
  connections?: PipelineConnection[];

  /**
   * Subscribers of this resource
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  subscribers?: Subscriber[];

  /**
   * Provisioning state of the pipeline
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The policies for this pipeline
   */
  policies?: string[];

  /**
   * The flow types allowed for this pipeline
   */
  flowTypes?: FlowType[];

  /**
   * The flow types that are disabled for this pipeline
   */
  disabledFlowTypes?: FlowType[];

  /**
   * Quarantine Download Storage Account
   */
  quarantineDownloadStorageAccount?: string;

  /**
   * Quarantine Download Storage Container
   */
  quarantineDownloadStorageContainer?: string;

  /**
   * Status of the current pipeline
   */
  status?: PipelineStatus;
}

/**
 * Status of the current pipeline
 */
union PipelineStatus {
  string,

  /**
   * The pipeline is currently enabled and all child connection and flow resources below able to send or receive data.
   */
  Enabled: "Enabled",

  /**
   * The pipeline is currently disabled and all child connection and flow resources below are unable to send or receive data.
   */
  Disabled: "Disabled",
}

/**
 * An individual that would like to subscribe to events that occur on a pipeline.
 */
model Subscriber {
  /**
   * Email of the subscriber
   */
  email?: string;

  /**
   * Number specifying what notifications to receive
   */
  notifications?: int64;
}

/**
 * Connection body inside a pipeline
 */
model PipelineConnection {
  ...Record<unknown>;

  /**
   * Connection id inside pipeline
   */
  id: string;

  /**
   * Connection name inside pipeline
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Connection type inside pipeline
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Connection location inside pipeline
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * Connection etag inside pipeline
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  /**
   * Connection properties inside pipeline
   */
  properties?: PipelineConnectionProperties;
}

/**
 * Connection properties inside pipeline
 */
model PipelineConnectionProperties {
  ...Record<unknown>;

  /**
   * Internal metadata of the connection inside pipeline.
   */
  internalMetadata?: InternalMetadataProperties;
}

/**
 * Internal metadata of the connection inside pipeline.
 */
model InternalMetadataProperties {
  ...Record<unknown>;

  /**
   * Operation status associated with the last patch request
   */
  operationStatus?: OperationStatusProperties;

  /**
   * User that last set the approved status for this connection
   */
  @visibility(Lifecycle.Read)
  statusSetBy?: string;
}

/**
 * The pipelines resource patch definition.
 */
model PipelinesPatch {
  /**
   * Properties of pipelines patch body.
   */
  properties?: PipelinesPatchProperties;

  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
  ...ManagedServiceIdentityProperty;
}

/**
 * Properties of pipelines patch body.
 */
model PipelinesPatchProperties {
  /**
   * Connections associated with pipeline
   */
  @OpenAPI.extension("x-ms-identifiers", #["id"])
  connections?: PipelineConnection[];

  /**
   * The flow types allowed for this pipeline
   */
  flowTypes?: FlowType[];
}

/**
 * Operation status associated with the last patch request
 */
model OperationStatusProperties {
  /**
   * Operation status for the last patch request for this connection.
   */
  @visibility(Lifecycle.Read)
  status?: OperationStatusEnum;

  /**
   * Operation status ID of the last patch request for this connection.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Message for the operation for the last patch request for this connection.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Operation status for the last patch request for this connection.
 */
union OperationStatusEnum {
  string,

  /**
   * The last patch request for this connection completed with an error.
   */
  Failed: "Failed",

  /**
   * The last patch request for this connection completed.
   */
  Succeeded: "Succeeded",
}

/**
 * The action to be executed.
 */
model Action {
  /**
   * Type of action to be executed
   */
  actionType: ActionType;

  /**
   * Type of target to execute the action on
   */
  targetType: TargetType;

  /**
   * Targets for the action
   */
  targets: string[];

  /**
   * Business justification for the action
   */
  justification?: string;
}

/**
 * An array of connection id resources.
 */
model ConnectionIdList {
  /**
   * Connection ID to target
   */
  value?: string[];
}

/**
 * An array of flow resources.
 */
model ListFlowsByPipelineResult {
  /**
   * List flows by pipeline result by connection
   */
  @OpenAPI.extension("x-ms-identifiers", #["id"])
  value?: ListFlowsByPipelineConnection[];
}

/**
 * A connection resource id in addition to all child flow resources under this connection.
 */
model ListFlowsByPipelineConnection {
  /**
   * ID of the connection.
   */
  id?: string;

  /**
   * List of flows associated with the connection.
   */
  flows?: Flow[];
}

/**
 * Type of target to execute the action on
 */
union TargetType {
  string,

  /**
   * The action executing is targeting a pipeline.
   */
  Pipeline: "Pipeline",

  /**
   * The action executing is targeting a connection.
   */
  Connection: "Connection",

  /**
   * The action executing is targeting a flow type.
   */
  FlowType: "FlowType",
}
