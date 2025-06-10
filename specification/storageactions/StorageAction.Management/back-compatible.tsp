import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.StorageActions;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StorageTaskPreviewAction.properties, "!csharp");

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StorageTaskUpdateParameters.properties, "!csharp");

@@clientName(StorageTasks.create::parameters.resource, "parameters");
@@clientName(StorageTasks.update::parameters.properties, "parameters");
@@clientName(StorageTasksOperationGroup.previewActions::parameters.body,
  "parameters"
);
@@clientName(StorageTasksOperationGroup.previewActions, "PreviewActions");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StorageTask.properties, "!csharp");
