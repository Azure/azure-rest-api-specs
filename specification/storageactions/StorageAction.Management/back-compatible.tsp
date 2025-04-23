import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.StorageActions;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageTaskUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageTaskPreviewAction.properties);

@@clientName(StorageTaskOperation, "StorageTaskOperationInfo");
@@clientName(StorageTasks.create::parameters.resource, "parameters");
@@clientName(StorageTasks.update::parameters.properties, "parameters");
@@clientName(StorageTasksOperationGroup.previewActions::parameters.body,
  "parameters"
);
@@clientName(StorageTasksOperationGroup.previewActions, "PreviewActions");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageTask.properties);
