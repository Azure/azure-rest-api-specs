import "./AVSExample.tsp";

/** Describes the schema of the Azure VMware Solution events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents;

/** Schema of the Data property of an EventGridEvent for a Microsoft.AVS.PrivateCloudUpdating event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftAVSPrivateCloudUpdatingExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model AvsPrivateCloudUpdatingEventData extends AvsPrivateCloudEventData {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.AVS.PrivateCloudUpdated event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model AvsPrivateCloudUpdatedEventData extends AvsPrivateCloudEventData {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.AVS.PrivateCloudFailed event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model AvsPrivateCloudFailedEventData extends AvsPrivateCloudEventData {
  /** Failure reason of an event. */
  failureMessage?: string;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.AVS.ClusterCreated event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model AvsClusterCreatedEventData extends AvsClusterEventData {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.AVS.ClusterDeleted event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model AvsClusterDeletedEventData extends AvsClusterEventData {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.AVS.ClusterUpdating event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model AvsClusterUpdatingEventData extends AvsClusterEventData {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.AVS.ClusterUpdated event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftAVSClusterUpdatedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model AvsClusterUpdatedEventData extends AvsClusterEventData {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.AVS.ClusterFailed event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model AvsClusterFailedEventData extends AvsClusterEventData {
  /** Failure reason of an event. */
  failureMessage?: string;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.AVS.ScriptExecutionStarted event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model AvsScriptExecutionStartedEventData extends AvsScriptExecutionEventData {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.AVS.ScriptExecutionFinished event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model AvsScriptExecutionFinishedEventData extends AvsScriptExecutionEventData {
  /** Named outputs of completed execution, if any. */
  @visibility(Lifecycle.Read)
  namedOutputs: Record<string>;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.AVS.ScriptExecutionCancelled event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model AvsScriptExecutionCancelledEventData
  extends AvsScriptExecutionEventData {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.AVS.ScriptExecutionFailed event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftAVSScriptExecutionFailedExample)
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model AvsScriptExecutionFailedEventData extends AvsScriptExecutionEventData {
  /** Failure reason of an event. */
  failureMessage?: string;
}

/** Schema of the Data property of an EventGridEvent for Microsoft.AVS/privateClouds events. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model AvsPrivateCloudEventData {
  /** Id of the operation that caused this event. */
  operationId: string;
}

/** Schema of the Data property of an EventGridEvent for Microsoft.AVS/clusters events. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model AvsClusterEventData {
  /** Id of the operation that caused this event. */
  operationId: string;

  /** Hosts added to the cluster in this event, if any. */
  @visibility(Lifecycle.Read)
  addedHostNames?: string[];

  /** Hosts removed from the cluster in this event, if any. */
  @visibility(Lifecycle.Read)
  removedHostNames?: string[];

  /** Hosts in Maintenance mode in the cluster, if any. */
  @visibility(Lifecycle.Read)
  inMaintenanceHostNames?: string[];
}

/** Schema of the Data property of an EventGridEvent for Microsoft.AVS/scriptExecutions events. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model AvsScriptExecutionEventData {
  /** Id of the operation that caused this event. */
  operationId: string;

  /** Cmdlet referenced in the execution that caused this event. */
  cmdletId: string;

  /** Stdout outputs from the execution, if any. */
  @visibility(Lifecycle.Read)
  output?: string[];
}
