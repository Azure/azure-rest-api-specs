import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

// Operations to not be exposed in generated client
@@access(Azure.AI.Projects.EvaluationResults.FetchAssetCredentials, Access.internal);
@@access(Azure.AI.Projects.EvaluationResults.startPendingUpload, Access.internal);
@@access(Azure.AI.Projects.EvaluationResults.listVersions, Access.internal);
@@access(Azure.AI.Projects.EvaluationResults.listLatest, Access.internal);
@@access(Azure.AI.Projects.EvaluationResults.create, Access.internal);
@@access(Azure.AI.Projects.EvaluationResults.deleteVersion, Access.internal);
@@access(Azure.AI.Projects.EvaluationResults.getVersion, Access.internal);
@@access(Azure.AI.Projects.EvaluationResults.createVersion, Access.internal);

// Models to not be exposed in generated client

@@access(Azure.AI.Projects.EvaluationResult, Access.internal);
@@access(Azure.AI.Projects.ResultType, Access.internal);
