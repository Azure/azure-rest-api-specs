import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

// Operations to not be exposed in generated client
@@access(Azure.AI.Projects.Evaluations.checkAnnotation, Access.internal);
@@access(Azure.AI.Projects.Evaluations.submitAnnotation, Access.internal);
@@access(Azure.AI.Projects.Evaluations.UploadRun, Access.internal);
@@access(Azure.AI.Projects.Evaluations.UploadUpdateRun, Access.internal);

// Models to not be exposed in generated client
@@access(Azure.AI.Projects.TargetModelConfig, Access.internal);
@@access(Azure.AI.Projects.AOAIModelConfig, Access.internal);
@@access(Azure.AI.Projects.MAASModelConfig, Access.internal);
@@access(Azure.AI.Projects.EvaluationTarget, Access.internal);
@@access(Azure.AI.Projects.Content, Access.internal);
@@access(Azure.AI.Projects.AnnotationDTO, Access.internal);
@@access(Azure.AI.Projects.EvaluationUpload, Access.internal);
@@access(Azure.AI.Projects.EvaluationTarget.target, Access.internal);


