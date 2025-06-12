import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager.Foundations;

namespace Microsoft.StorageActions;

/**
 * Represents the condition block name that matched blob properties.
 */
union MatchedBlockName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  If: "If",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Else: "Else",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
}

/**
 * The operation to be performed on the object.
 */
union StorageTaskOperationName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SetBlobTier: "SetBlobTier",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SetBlobTags: "SetBlobTags",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SetBlobImmutabilityPolicy: "SetBlobImmutabilityPolicy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SetBlobLegalHold: "SetBlobLegalHold",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SetBlobExpiry: "SetBlobExpiry",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DeleteBlob: "DeleteBlob",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UndeleteBlob: "UndeleteBlob",
}

/**
 * Action to be taken when the operation is successful for a object.
 */
union OnSuccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  continue: "continue",
}

/**
 * Action to be taken when the operation fails for a object.
 */
union OnFailure {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  break: "break",
}

/**
 * Represents the provisioning state of the storage task.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ValidateSubscriptionQuotaBegin: "ValidateSubscriptionQuotaBegin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ValidateSubscriptionQuotaEnd: "ValidateSubscriptionQuotaEnd",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
}

/**
 * Represents the status of the execution.
 */
union RunStatusEnum {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Finished: "Finished",
}

/**
 * Represents the overall result of the execution for the run instance
 */
union RunResult {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
}

/**
 * Storage Task Preview Action.
 */
model StorageTaskPreviewAction {
  /**
   * Properties of the storage task preview.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties: StorageTaskPreviewActionProperties;
}

/**
 * Storage task preview action properties.
 */
model StorageTaskPreviewActionProperties {
  /**
   * Properties of a sample container to test for a match with the preview action.
   */
  container: StorageTaskPreviewContainerProperties;

  /**
   * Properties of some sample blobs in the container to test for matches with the preview action.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  blobs: StorageTaskPreviewBlobProperties[];

  /**
   * Preview action to test
   */
  action: StorageTaskPreviewActionCondition;
}

/**
 * Storage task preview container properties
 */
model StorageTaskPreviewContainerProperties {
  /**
   * Name of test container
   */
  name?: string;

  /**
   * metadata key value pairs to be tested for a match against the provided condition.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  metadata?: StorageTaskPreviewKeyValueProperties[];
}

/**
 * Storage task preview object key value pair properties.
 */
model StorageTaskPreviewKeyValueProperties {
  /**
   * Represents the key property of the pair.
   */
  key?: string;

  /**
   * Represents the value property of the pair.
   */
  value?: string;
}

/**
 * Storage task preview container properties
 */
model StorageTaskPreviewBlobProperties {
  /**
   * Name of test blob
   */
  name?: string;

  /**
   * properties key value pairs to be tested for a match against the provided condition.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  properties?: StorageTaskPreviewKeyValueProperties[];

  /**
   * metadata key value pairs to be tested for a match against the provided condition.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  metadata?: StorageTaskPreviewKeyValueProperties[];

  /**
   * tags key value pairs to be tested for a match against the provided condition.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  tags?: StorageTaskPreviewKeyValueProperties[];

  /**
   * Represents the condition block name that matched blob properties.
   */
  @visibility(Lifecycle.Read)
  matchedBlock?: MatchedBlockName;
}

/**
 * Represents the storage task conditions to be tested for a match with container and blob properties.
 */
model StorageTaskPreviewActionCondition {
  /**
   * The condition to be tested for a match with container and blob properties.
   */
  `if`: StorageTaskPreviewActionIfCondition;

  /**
   * Specify whether the else block is present in the condition.
   */
  elseBlockExists: boolean;
}

/**
 * Represents storage task preview action condition.
 */
model StorageTaskPreviewActionIfCondition {
  /**
   * Storage task condition to bes tested for a match.
   */
  condition?: string;
}

/**
 * Properties of the storage task.
 */
model StorageTaskProperties {
  /**
   * Storage task version.
   */
  @visibility(Lifecycle.Read)
  @maxValue(1)
  @minValue(1)
  taskVersion?: int64;

  /**
   * Storage Task is enabled when set to true and disabled when set to false
   */
  enabled: boolean;

  /**
   * Text that describes the purpose of the storage task
   */
  description: string;

  /**
   * The storage task action that is executed
   */
  action: StorageTaskAction;

  /**
   * Represents the provisioning state of the storage task.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The creation date and time of the storage task in UTC.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTimeInUtc?: utcDateTime;
}

/**
 * The storage task action represents conditional statements and operations to be performed on target objects.
 */
model StorageTaskAction {
  /**
   * The if block of storage task operation
   */
  `if`: IfCondition;

  /**
   * The else block of storage task operation
   */
  `else`?: ElseCondition;
}

/**
 * The if block of storage task operation
 */
model IfCondition {
  /**
   * Condition predicate to evaluate each object. See https://aka.ms/storagetaskconditions for valid properties and operators.
   */
  condition: string;

  /**
   * List of operations to execute when the condition predicate satisfies.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  operations: StorageTaskOperation[];
}

/**
 * Represents an operation to be performed on the object
 */
model StorageTaskOperation {
  /**
   * The operation to be performed on the object.
   */
  name: StorageTaskOperationName;

  /**
   * Key-value parameters for the operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: Record<string>;

  /**
   * Action to be taken when the operation is successful for a object.
   */
  onSuccess?: OnSuccess;

  /**
   * Action to be taken when the operation fails for a object.
   */
  onFailure?: OnFailure;
}

/**
 * The else block of storage task operation
 */
model ElseCondition {
  /**
   * List of operations to execute in the else block
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  operations: StorageTaskOperation[];
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Parameters of the storage task update request
 */
model StorageTaskUpdateParameters {
  /**
   * The identity of the resource.
   */
  identity?: Azure.ResourceManager.Foundations.ManagedServiceIdentity;

  /**
   * Gets or sets a list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups). A maximum of 15 tags can be provided for a resource. Each tag must have a key no greater in length than 128 characters and a value no greater in length than 256 characters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Properties of the storage task.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: StorageTaskUpdateProperties;
}

/**
 * Properties of the storage task.
 */
model StorageTaskUpdateProperties {
  /**
   * Storage task version.
   */
  @visibility(Lifecycle.Read)
  @maxValue(1)
  @minValue(1)
  taskVersion?: int64;

  /**
   * Storage Task is enabled when set to true and disabled when set to false
   */
  enabled?: boolean;

  /**
   * Text that describes the purpose of the storage task
   */
  description?: string;

  /**
   * The storage task action that is executed
   */
  action?: StorageTaskAction;

  /**
   * Represents the provisioning state of the storage task.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The creation date and time of the storage task in UTC.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTimeInUtc?: utcDateTime;
}

/**
 * Fetch Storage Tasks Run Summary.
 */
model StorageTaskReportSummary is Azure.Core.Page<StorageTaskReportInstance>;

/**
 * Storage Tasks run report instance
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StorageTaskReportInstance
  extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Storage task execution report for a run instance.
   */
  properties?: StorageTaskReportProperties;
}

/**
 * Storage task execution report for a run instance.
 */
model StorageTaskReportProperties {
  /**
   * Resource ID of the Storage Task Assignment associated with this reported run.
   */
  @visibility(Lifecycle.Read)
  taskAssignmentId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts/storageTaskAssignments";
    }
  ]>;

  /**
   * Resource ID of the Storage Account where this reported run executed.
   */
  @visibility(Lifecycle.Read)
  storageAccountId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  /**
   * Start time of the run instance. Filter options such as startTime gt '2023-06-26T20:51:24.4494016Z' and other comparison operators can be used as described for DateTime properties in https://learn.microsoft.com/en-us/rest/api/storageservices/querying-tables-and-entities#supported-comparison-operators
   */
  @visibility(Lifecycle.Read)
  startTime?: string;

  /**
   * End time of the run instance. Filter options such as startTime gt '2023-06-26T20:51:24.4494016Z' and other comparison operators can be used as described for DateTime properties in https://learn.microsoft.com/en-us/rest/api/storageservices/querying-tables-and-entities#supported-comparison-operators
   */
  @visibility(Lifecycle.Read)
  finishTime?: string;

  /**
   * Total number of objects that meet the condition as defined in the storage task assignment execution context. Filter options such as objectsTargetedCount gt 50 and other comparison operators can be used as described for Numerical properties in https://learn.microsoft.com/en-us/rest/api/storageservices/querying-tables-and-entities#supported-comparison-operators
   */
  @visibility(Lifecycle.Read)
  objectsTargetedCount?: string;

  /**
   * Total number of objects that meet the storage tasks condition and were operated upon. Filter options such as objectsOperatedOnCount ge 100 and other comparison operators can be used as described for Numerical properties in https://learn.microsoft.com/en-us/rest/api/storageservices/querying-tables-and-entities#supported-comparison-operators
   */
  @visibility(Lifecycle.Read)
  objectsOperatedOnCount?: string;

  /**
   * Total number of objects where task operation failed when was attempted. Filter options such as objectFailedCount eq 0 and other comparison operators can be used as described for Numerical properties in https://learn.microsoft.com/en-us/rest/api/storageservices/querying-tables-and-entities#supported-comparison-operators
   */
  @visibility(Lifecycle.Read)
  objectFailedCount?: string;

  /**
   * Total number of objects where task operation succeeded when was attempted.Filter options such as objectsSucceededCount gt 150 and other comparison operators can be used as described for Numerical properties in https://learn.microsoft.com/en-us/rest/api/storageservices/querying-tables-and-entities#supported-comparison-operators
   */
  @visibility(Lifecycle.Read)
  objectsSucceededCount?: string;

  /**
   * Well known Azure Storage error code that represents the error encountered during execution of the run instance.
   */
  @visibility(Lifecycle.Read)
  runStatusError?: string;

  /**
   * Represents the status of the execution.
   */
  @visibility(Lifecycle.Read)
  runStatusEnum?: RunStatusEnum;

  /**
   * Full path to the verbose report stored in the reporting container as specified in the assignment execution context for the storage account.
   */
  @visibility(Lifecycle.Read)
  summaryReportPath?: string;

  /**
   * Resource ID of the Storage Task applied during this run.
   */
  @visibility(Lifecycle.Read)
  taskId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.StorageActions/storageTasks";
    }
  ]>;

  /**
   * Storage Task Version
   */
  @visibility(Lifecycle.Read)
  taskVersion?: string;

  /**
   * Represents the overall result of the execution for the run instance
   */
  @visibility(Lifecycle.Read)
  runResult?: RunResult;
}

/**
 * The response from the List Storage Tasks operation.
 */
model StorageTaskAssignmentsListResult
  is Azure.Core.Page<StorageTaskAssignment>;

/**
 * Storage Task Assignment associated with this Storage Task.
 */
model StorageTaskAssignment {
  /**
   * Resource ID of the Storage Task Assignment.
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;
}

model StorageTasksListResult is Azure.Core.Page<StorageTask>;

@@doc(StorageTaskAssignmentsListResult.value,
  "List of Storage Task Assignment Resource IDs associated with this Storage Task."
);
@@doc(StorageTaskReportInstance.properties,
  "Storage task execution report for a run instance."
);
@@OpenAPI.extension(StorageTaskAssignmentsListResult.value,
  "x-ms-identifiers",
  #[]
);
@@doc(StorageTaskReportSummary.value, "Gets storage tasks run result summary.");
@@OpenAPI.extension(StorageTaskReportSummary.value, "x-ms-identifiers", #[]);
@@doc(StorageTasksListResult,
  "The response from the List Storage Task operation."
);
@@doc(StorageTasksListResult.value,
  "Gets the list of storage tasks and their properties."
);
@@OpenAPI.extension(StorageTasksListResult.value, "x-ms-identifiers", #[]);
@@visibility(Azure.Core.Page.value, Lifecycle.Read);
@@visibility(Azure.Core.Page.nextLink, Lifecycle.Read);
@@visibility(StorageTaskPreviewBlobProperties.matchedBlock, Lifecycle.Read);
@@visibility(StorageTaskReportProperties.runStatusEnum, Lifecycle.Read);
