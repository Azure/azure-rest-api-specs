import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.StorageActions;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The operation to be performed on the object.")
enum StorageTaskOperationName {
  SetBlobTier,
  SetBlobTags,
  SetBlobImmutabilityPolicy,
  SetBlobLegalHold,
  SetBlobExpiry,
  DeleteBlob,
  UndeleteBlob,
}

@doc("Represents the status of the execution.")
enum RunStatusEnum {
  InProgress,
  Finished,
}

@doc("Represents the overall result of the execution for the run instance")
enum RunResult {
  Succeeded,
  Failed,
}

@doc("Represents the condition block name that matched blob properties.")
enum MatchedBlockName {
  If,
  Else,
  None,
}

@doc("Represents the provisioning state of the storage task.")
@fixed
enum ProvisioningState {
  ValidateSubscriptionQuotaBegin,
  ValidateSubscriptionQuotaEnd,
  Creating,
  Succeeded,
  Deleting,
  Canceled,
  Failed,
}

@doc("Properties of the storage task.")
model StorageTaskProperties {
  @doc("Storage task version.")
  @visibility("read")
  @maxValue(1)
  @minValue(1)
  taskVersion?: int32;

  @doc("Storage Task is enabled when set to true and disabled when set to false")
  enabled: boolean;

  @doc("Text that describes the purpose of the storage task")
  description: string;

  @doc("The storage task action that is executed")
  action: StorageTaskAction;

  @doc("Represents the provisioning state of the storage task.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The creation date and time of the storage task in UTC.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTimeInUtc?: utcDateTime;
}

@doc("The storage task action represents conditional statements and operations to be performed on target objects.")
model StorageTaskAction {
  @doc("The if block of storage task operation")
  `if`: IfCondition;

  @doc("The else block of storage task operation")
  `else`?: ElseCondition;
}

@doc("The if block of storage task operation")
model IfCondition {
  @doc("The condition predicate which is composed of object properties, eg: blob and container properties.")
  condition: string;

  @doc("List of operations to execute when the condition predicate satisfies.")
  operations: StorageTaskOperation[];
}

@doc("Represents an operation to be performed on the object")
model StorageTaskOperation {
  @doc("The operation to be performed on the object.")
  name: StorageTaskOperationName;

  @doc("Key-value parameters for the operation.")
  parameters?: Record<string>;

  @doc("Action to be taken when the operation is successful for a object.")
  onSuccess?: "continue";

  @doc("Action to be taken when the operation fails for a object.")
  onFailure?: "break";
}

@doc("The else block of storage task operation")
model ElseCondition {
  @doc("List of operations to execute in the else block")
  operations: StorageTaskOperation[];
}

@doc("Parameters of the storage task update request")
model StorageTaskUpdateParameters {
  @doc("The identity of the resource.")
  identity?: ManagedIdentityProperties;

  @doc("Gets or sets a list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups). A maximum of 15 tags can be provided for a resource. Each tag must have a key no greater in length than 128 characters and a value no greater in length than 256 characters.")
  tags?: Record<string>;

  @doc("Properties of the storage task.")
  properties?: StorageTaskProperties;
}

@doc("The response from the List Storage Tasks operation.")
model StorageTaskAssignmentsListResult
  is Azure.Core.Page<StorageTaskAssignment>;

@doc("Fetch the Storage task assignment ARM ids.")
model StorageTaskAssignment {
  @doc("ARM Id of the storage task assignments, associated with the storage tasks.")
  @visibility("read")
  id?: ResourceIdentifier;
}

@doc("Storage task execution report for a run instance.")
model StorageTaskReportProperties {
  @doc("Represents the Storage Task Assignment Id associated with the storage task that provided an execution context.")
  @visibility("read")
  taskAssignmentId?: ResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts/storageTaskAssignments";
    }
  ]>;

  @doc("Represents the Storage Account Id where the storage task definition was applied and executed.")
  @visibility("read")
  storageAccountId?: ResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  @doc("Start time of the run instance. Filter options such as startTime gt '2023-06-26T20:51:24.4494016Z' and other comparison operators can be used as described for DateTime properties in https://learn.microsoft.com/en-us/rest/api/storageservices/querying-tables-and-entities#supported-comparison-operators")
  @visibility("read")
  startTime?: string;

  @doc("End time of the run instance. Filter options such as startTime gt '2023-06-26T20:51:24.4494016Z' and other comparison operators can be used as described for DateTime properties in https://learn.microsoft.com/en-us/rest/api/storageservices/querying-tables-and-entities#supported-comparison-operators")
  @visibility("read")
  finishTime?: string;

  @doc("Total number of objects that meet the condition as defined in the storage task assignment execution context. Filter options such as objectsTargetedCount gt 50 and other comparison operators can be used as described for Numerical properties in https://learn.microsoft.com/en-us/rest/api/storageservices/querying-tables-and-entities#supported-comparison-operators")
  @visibility("read")
  objectsTargetedCount?: string;

  @doc("Total number of objects that meet the storage tasks condition and were operated upon. Filter options such as objectsOperatedOnCount ge 100 and other comparison operators can be used as described for Numerical properties in https://learn.microsoft.com/en-us/rest/api/storageservices/querying-tables-and-entities#supported-comparison-operators")
  @visibility("read")
  objectsOperatedOnCount?: string;

  @doc("Total number of objects where task operation failed when was attempted. Filter options such as objectFailedCount eq 0 and other comparison operators can be used as described for Numerical properties in https://learn.microsoft.com/en-us/rest/api/storageservices/querying-tables-and-entities#supported-comparison-operators")
  @visibility("read")
  objectFailedCount?: string;

  @doc("Total number of objects where task operation succeeded when was attempted.Filter options such as objectsSucceededCount gt 150 and other comparison operators can be used as described for Numerical properties in https://learn.microsoft.com/en-us/rest/api/storageservices/querying-tables-and-entities#supported-comparison-operators")
  @visibility("read")
  objectsSucceededCount?: string;

  @doc("Well known Azure Storage error code that represents the error encountered during execution of the run instance.")
  @visibility("read")
  runStatusError?: string;

  @doc("Represents the status of the execution.")
  @visibility("read")
  runStatusEnum?: RunStatusEnum;

  @doc("Full path to the verbose report stored in the reporting container as specified in the assignment execution context for the storage account. ")
  @visibility("read")
  summaryReportPath?: string;

  @doc("Storage Task Arm Id.")
  @visibility("read")
  taskId?: ResourceIdentifier<[
    {
      type: "Microsoft.StorageActions/storageTasks";
    }
  ]>;

  @doc("Storage Task Version")
  @visibility("read")
  taskVersion?: string;

  @doc("Represents the overall result of the execution for the run instance")
  @visibility("read")
  runResult?: RunResult;
}

@doc("Storage Task Preview Action.")
model StorageTaskPreviewAction {
  @doc("Properties of the storage task preview.")
  properties: StorageTaskPreviewActionProperties;
}

@doc("Storage task preview action properties.")
model StorageTaskPreviewActionProperties {
  @doc("Preview action container properties to be tested for a match with the provided condition.")
  container: StorageTaskPreviewContainerProperties;

  @doc("Preview action container properties to be tested for a match with the provided condition.")
  blobs: StorageTaskPreviewBlobProperties[];

  @doc("Preview action container properties to be tested for a match with the provided condition.")
  action: StorageTaskPreviewActionCondition;
}

@doc("Storage task preview container properties")
model StorageTaskPreviewContainerProperties {
  @doc("property for the container name.")
  name?: string;

  @doc("metadata key value pairs to be tested for a match against the provided condition.")
  metadata?: StorageTaskPreviewKeyValueProperties[];
}

@doc("Storage task preview object key value pair properties.")
model StorageTaskPreviewKeyValueProperties {
  @doc("Represents the key property of the pair.")
  key?: string;

  @doc("Represents the value property of the pair.")
  value?: string;
}

@doc("Storage task preview container properties")
model StorageTaskPreviewBlobProperties {
  @doc("property for the container name.")
  name?: string;

  @doc("properties key value pairs to be tested for a match against the provided condition.")
  properties?: StorageTaskPreviewKeyValueProperties[];

  @doc("metadata key value pairs to be tested for a match against the provided condition.")
  metadata?: StorageTaskPreviewKeyValueProperties[];

  @doc("tags key value pairs to be tested for a match against the provided condition.")
  tags?: StorageTaskPreviewKeyValueProperties[];

  @doc("Represents the condition block name that matched blob properties.")
  @visibility("read")
  matchedBlock?: MatchedBlockName;
}

@doc("Represents the storage task conditions to be tested for a match with container and blob properties.")
model StorageTaskPreviewActionCondition {
  @doc("The condition to be tested for a match with container and blob properties.")
  `if`: StorageTaskPreviewActionIfCondition;

  @doc("Specify whether the else block is present in the condition.")
  elseBlockExists: boolean;
}

@doc("Represents storage task preview action condition.")
model StorageTaskPreviewActionIfCondition {
  @doc("Storage task condition to bes tested for a match.")
  condition?: string;
}
