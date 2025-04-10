import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

// Operations to not be exposed in generated client
@@access(Azure.AI.Projects.checkAnnotation, Access.internal);
@@access(Azure.AI.Projects.submitAnnotation, Access.internal);
@@access(Azure.AI.Projects.UploadRun, Access.internal);
@@access(Azure.AI.Projects.UploadUpdateRun, Access.internal);

// Models to be exposed in generated client
@@access(Azure.AI.Projects.TargetModelConfig, Access.internal);
@@access(Azure.AI.Projects.AOAIModelConfig, Access.internal);
@@access(Azure.AI.Projects.MAASModelConfig, Access.internal);
@@access(Azure.AI.Projects.EvaluationTarget, Access.internal);
@@access(Azure.AI.Projects.AnnotationDTO, Access.internal);
@@access(Azure.AI.Projects.Content, Access.internal);
