import "./VirtualMachineScaleSetsExamples.tsp";

/** Describes the schema of the Virtual Machine Scale Set events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents;

/** Schema of the Data property of an EventGridEvent for a Microsoft.Compute.VirtualMachineScaleSets.LifecycleHookEvents preview event. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
@example(LifecycleHookEventsExample)
model LifecycleHookEventsEventData {
  /** The name of the Lifecycle Hook event. This is a unique identifier for the Lifecycle Hook event. */
  name?: string;

  /** The ARM resource ID of the Lifecycle Hook event entity created by the platform for this event. Customers can use this ARM resource ID to query more details about the event through Azure Resource Manager APIs. */
  id?: string;

  /** The properties of the Virtual Machine Scale Set Lifecycle Hook event. */
  properties?: VMScaleSetLifecycleHookEventProperties;

  /** Operational information related to the Lifecycle Hook event. */
  operationalInfo?: OperationalInfo;
}

/** Defines the Virtual Machine Scale Set Lifecycle Hook event properties. */
model VMScaleSetLifecycleHookEventProperties {
  /** Defines the type or scenario for sending a Virtual Machine Scale Set Lifecycle Hook event to the customer. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "backcompat"
  type?: VMScaleSetLifecycleHookEventType;

  /** Specifies the exact UTC timestamp in ISO 8601 format till which the event would remain in the current lifecycle state waiting for an action from the customer. Beyond this timestamp, the platform will apply the defaultAction for the event. */
  waitUntil?: string;

  /** Specifies the exact UTC timestamp in ISO 8601 format till when the customer can delay the Lifecycle Hook event. The customer will not be allowed to delay the event to a timestamp beyond this. */
  maxWaitUntil?: string;

  /** The UTC timestamp in ISO 8601 format at which the platform creates the Virtual Machine Scale Set Lifecycle Hook event entity. */
  timeCreated?: string;

  /** Specify the action that will be applied on the a target resource in the Virtual Machine Scale Set Lifecycle Hook event if the platform does not get a response from the customer for the target resource before waitUntil. */
  defaultAction?: LifecycleHookAction;

  /** List of target resources which are getting processed in the Virtual Machine Scale Set Lifecycle Hook event. */
  @visibility(Lifecycle.Read)
  targetResources?: VMScaleSetLifecycleHookEventTargetResource[];

  /**
   * Additional key-value pairs set on the Lifecycle Hook event that gives customer some useful context/data.
   * The keys in this dictionary are specific to the Lifecycle Hook type. Different Lifecycle Hook events can have different sets of keys in the additional context depending on the Lifecycle Hook type.
   * For example, for a Lifecycle Hook event with UpgradeAutoOSScheduling type,
   * the additional context can contain the key "priority" that helps customer identify the priority of the Auto OS Upgrade operation triggered on the Virtual Machine Scale Set.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  additionalContext?: VMScaleSetLifecycleHookEventAdditionalContext;

  /** Specifies the state of the Virtual Machine Scale Set Lifecycle Hook event. */
  state?: VMScaleSetLifecycleHookEventState;
}

/** Define a single target ARM resource in a Virtual Machine Scale Set Lifecycle Hook event. Currently, this can be a Virtual Machine Scale Set resource or an individual virtual machine resource within a VMScaleSet. */
model VMScaleSetLifecycleHookEventTargetResource {
  /** Specifies the target ARM resource. Currently, this can be a Virtual Machine Scale Set resource or an individual virtual machine resource within a VMScaleSet. */
  resource?: ApiEntityReference;

  /** State of the Lifecycle Hook for the target resource. The customer can patch this property to move the Lifecycle Hook to a terminal state. */
  actionState?: LifecycleHookActionState;
}

/** The API entity reference. */
model ApiEntityReference {
  /** The ARM resource id in the form of /subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/... */
  id?: string;
}

/**
 * Additional key-value pairs set on the Lifecycle Hook event that gives customer some useful context/data.
 * The keys in this dictionary are specific to the Lifecycle Hook type. Different Lifecycle Hook events can have different sets of keys in the additional context depending on the Lifecycle Hook type.
 * For example, for a Lifecycle Hook event with UpgradeAutoOSScheduling type,
 * the additional context can contain the key "priority" that helps customer identify the priority of the Auto OS Upgrade operation triggered on the Virtual Machine Scale Set.
 */
model VMScaleSetLifecycleHookEventAdditionalContext {
  /** Can only be present for a Lifecycle Hook event of type "UpgradeAutoOSScheduling". Denotes the priority of the Virtual Machine Scale Set Lifecycle Hook event for the Auto OS Upgrade scheduled on the Virtual Machine Scale Set. */
  priority?: string;
}

/** Operational information for a Virtual Machine Scale Set Lifecycle Hook event. */
model OperationalInfo {
  /** The activity ID associated with the operation generating the Lifecycle Hook event. */
  activityId?: string;
}

/** Specifies the scenario for which the customer is interested in receiving Virtual Machine Scale Set Lifecycle Hook events. */
union VMScaleSetLifecycleHookEventType {
  string,

  /** Lifecycle Hook event sent to the customer before an Auto OS Upgrade operation starts on the Virtual Machine Scale Set. */
  UpgradeAutoOSScheduling: "UpgradeAutoOSScheduling",

  /** Lifecycle Hook event sent to the customer before upgrade starts on a batch of virtual machines belonging to a Virtual Machine Scale Set during an Auto OS Upgrade operation. */
  UpgradeAutoOSRollingBatchStarting: "UpgradeAutoOSRollingBatchStarting",
}

/** The action that will be applied to a target resource in the Virtual Machine Scale Set Lifecycle Hook event if the platform does not receive a response from the customer for the target resource before waitUntil. */
union LifecycleHookAction {
  string,

  /** The Lifecycle Hook of a target resource in a Lifecycle Hook event will be approved. */
  Approve: "Approve",

  /** The Lifecycle Hook of a target resource in a Lifecycle Hook event will be rejected. */
  Reject: "Reject",
}

/** Approval status of a target resource in a Virtual Machine Scale Set Lifecycle Hook event. */
union LifecycleHookActionState {
  string,

  /** The Lifecycle Hook for the target resource is waiting for approval. */
  Waiting: "Waiting",

  /** The Lifecycle Hook for the target resource is approved. */
  Approved: "Approved",

  /** The Lifecycle Hook for the target resource is rejected. */
  Rejected: "Rejected",
}

/** The states that a Virtual Machine Scale Set Lifecycle Hook event can be in. This is not settable by the customer. It is set only by the platform. */
union VMScaleSetLifecycleHookEventState {
  string,

  /** The Lifecycle Hook event is active. E.g., waiting on a response from the customer. */
  Active: "Active",

  /** The Lifecycle Hook event is completed. i.e., all the target resources in the event have moved to a terminal state. */
  Completed: "Completed",
}
