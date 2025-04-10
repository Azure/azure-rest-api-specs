import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

// Operations to not be exposed in generated client
@@access(Azure.AI.Projects.EvaluationResults.startPendingUpload, Access.internal);
@@access(Azure.AI.Projects.EvaluationResults.FetchAssetCredentials, Access.internal);

// Models to not be exposed in generated client

@@access(Azure.AI.Projects.EvaluationResult, Access.internal);
@@access(Azure.AI.Projects.ResultType, Access.internal);
