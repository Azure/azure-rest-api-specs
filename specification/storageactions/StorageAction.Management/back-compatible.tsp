import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.StorageActions;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(StorageTaskPreviewAction.properties,
  "!csharp,!java,!python,!javascript"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(StorageTaskUpdateParameters.properties,
  "!csharp,!java,!python,!javascript"
);

@@clientName(StorageTasks.create::parameters.resource, "parameters");
@@clientName(StorageTasks.update::parameters.properties, "parameters");
@@clientName(StorageTasksOperationGroup.previewActions::parameters.body,
  "parameters"
);
@@clientName(StorageTasks.storageTaskAssignmentList, "List");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(StorageTask.properties,
  "!csharp,!java,!python,!javascript"
);

// @@clientLocation decorators for operations with custom @operationId
// These ensure consistent operationId generation in the output
@@clientLocation(StorageTasksOperationGroup.previewActions, StorageTasks);
@@clientLocation(StorageTasks.list, "StorageTasksReport");
@@clientLocation(StorageTasks.storageTaskAssignmentList,
  "StorageTaskAssignment"
);
