@doc("Describes the schema of the Azure VMware Solution events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent.")
namespace Microsoft.EventGrid.SystemEvents;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.AVS.PrivateCloudUpdating event.")
model AvsPrivateCloudUpdatingEventData extends AvsPrivateCloudEventData {}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.AVS.PrivateCloudUpdated event.")
model AvsPrivateCloudUpdatedEventData extends AvsPrivateCloudEventData {}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.AVS.PrivateCloudFailed event.")
model AvsPrivateCloudFailedEventData extends AvsPrivateCloudEventData {
  @doc("Failure reason of an event.")
  failureMessage?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.AVS.ClusterCreated event.")
model AvsClusterCreatedEventData extends AvsClusterEventData {}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.AVS.ClusterDeleted event.")
model AvsClusterDeletedEventData extends AvsClusterEventData {}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.AVS.ClusterUpdating event.")
model AvsClusterUpdatingEventData extends AvsClusterEventData {}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.AVS.ClusterUpdated event.")
model AvsClusterUpdatedEventData extends AvsClusterEventData {}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.AVS.ClusterFailed event.")
model AvsClusterFailedEventData extends AvsClusterEventData {
  @doc("Failure reason of an event.")
  failureMessage?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.AVS.ScriptExecutionFinished event.")
model AvsScriptExecutionFinishedEventData extends AvsScriptExecutionEventData {
  @doc("Named outputs of completed execution, if any.")
  namedOutputs: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.AVS.ScriptExecutionCancelled event.")
model AvsScriptExecutionCancelledEventData
  extends AvsScriptExecutionEventData {}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.AVS.ScriptExecutionFailed event.")
model AvsScriptExecutionFailedEventData extends AvsScriptExecutionEventData {
  @doc("Failure reason of an event.")
  failureMessage?: string;
}

@doc("Schema of the Data property of an EventGridEvent for Microsoft.AVS/privateClouds events.")
model AvsPrivateCloudEventData {
  @doc("Id of the operation that caused this event.")
  operationId?: string;
}

@doc("Schema of the Data property of an EventGridEvent for Microsoft.AVS/clusters events.")
model AvsClusterEventData {
  @doc("Id of the operation that caused this event.")
  operationId?: string;

  @doc("Hosts added to the cluster in this event, if any.")
  addedHostNames: string[];

  @doc("Hosts removed from the cluster in this event, if any.")
  removedHostNames: string[];

  @doc("Hosts in Maintenance mode in the cluster, if any.")
  inMaintenanceHostNames: string[];
}

@doc("Schema of the Data property of an EventGridEvent for Microsoft.AVS/scriptExecutions events.")
model AvsScriptExecutionEventData {
  @doc("Id of the operation that caused this event.")
  operationId?: string;

  @doc("Cmdlet referenced in the execution that caused this event.")
  cmdletId?: string;

  @doc("Stdout outputs from the execution, if any.")
  output?: string[];
}
