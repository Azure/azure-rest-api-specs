import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.StorageActions;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageTaskPreviewAction.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageTaskUpdateParameters.properties);

@@clientName(StorageTasks.create::parameters.resource, "parameters");
@@clientName(StorageTasks.update::parameters.properties, "parameters");
@@clientName(StorageTasksOperationGroup.previewActions::parameters.body,
  "parameters"
);
@@clientName(StorageTasksOperationGroup.previewActions, "PreviewActions");
@@clientName(StorageTaskOperation, "StorageTaskOperationInfo", "csharp");
@@clientName(OnSuccess, "OnSuccessAction", "csharp");
@@clientName(OnFailure, "OnFailureAction", "csharp");
@@clientName(StorageTaskPreviewActionProperties,
  "StorageTaskPreviewActionProperties",
  "csharp"
);
@@clientName(StorageTaskProperties, "StorageTaskProperties", "csharp");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageTask.properties);
