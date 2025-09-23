import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.StorageActions;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StorageTaskPreviewAction.properties, "!csharp,!java,!python");

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StorageTaskUpdateParameters.properties,
  "!csharp,!java,!python"
);

@@clientName(StorageTasks.create::parameters.resource, "parameters");
@@clientName(StorageTasks.update::parameters.properties, "parameters");
@@clientName(StorageTasksOperationGroup.previewActions::parameters.body,
  "parameters"
);
@@clientName(StorageTasks.storageTaskAssignmentList, "List");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StorageTask.properties, "!csharp,!java,!python");

// @@clientLocation decorators for operations with custom @operationId
// These ensure consistent operationId generation in the output
@@clientLocation(StorageTasksOperationGroup.previewActions, StorageTasks);
@@clientLocation(StorageTasks.list, "StorageTasksReport");
@@clientLocation(StorageTasks.storageTaskAssignmentList,
  "StorageTaskAssignment"
);
