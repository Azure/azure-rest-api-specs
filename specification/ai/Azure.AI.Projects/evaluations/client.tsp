import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

// Operations to not be exposed in generated client
@@access(Azure.AI.Projects.Evaluations.checkAnnotation, Access.internal);
@@access(Azure.AI.Projects.Evaluations.submitAnnotation, Access.internal);
@@access(Azure.AI.Projects.Evaluations.UploadRun, Access.internal);
@@access(Azure.AI.Projects.Evaluations.UploadUpdateRun, Access.internal);
