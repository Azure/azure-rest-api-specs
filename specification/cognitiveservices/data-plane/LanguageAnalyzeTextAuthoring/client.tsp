import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Language.Text.Authoring;

// Rename operation for Python SDK
@@clientName(textAnalysisAuthoringListTrainingConfigVersions,
  "listTrainingVersions",
  "python"
);

// Rename union types for Python SDK backward compatibility
@@clientName(CompositionSetting, "CompositionMode", "python");
@@clientName(JobStatus, "OperationStatus", "python");
