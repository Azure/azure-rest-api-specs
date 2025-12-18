import "@azure-tools/typespec-client-generator-core";

import "./common/service.tsp";

import "./connections/routes.tsp";
import "./datasets/routes.tsp";
import "./indexes/routes.tsp";
import "./deployments/routes.tsp";
import "./red-teams/routes.tsp";
import "./evaluationrules/routes.tsp";
// Don't import openai-evaluations, we'll use Stainless SDK like in AgentsV2
// import "./openai-evaluations/routes.tsp";
import "./evaluation_taxonomies/routes.tsp";
import "./evaluators/routes.tsp";
import "./insights/routes.tsp";
import "./schedules/routes.tsp";

using Azure.ClientGenerator.Core;
namespace Foundry;

// --------------------------------------------------------------------------------
// Root client
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Projects, "AIProjectClient");

// --------------------------------------------------------------------------------
// Renames
// --------------------------------------------------------------------------------
@@clientName(Connections.list, "listConnections");
@@clientName(Connections.get, "getConnection");
@@clientName(Connections.getWithCredentials, "getConnectionWithCredentials");

@@clientName(Datasets.getVersion, "getDatasetVersion");
@@clientName(Datasets.startPendingUploadVersion, "pendingUpload");

// Shorter method names for SDK Index operations
@@clientName(Indexes.createOrUpdateVersion, "createOrUpdate");

// // Less generic names
@@clientName(Sku, "ModelDeploymentSku");
@@clientName(SasCredential, "BlobReferenceSasCredential"); // Not to be confused with class "SASCredentials"

// // More accurate naming
@@clientName(AssetCredentialResponse, "DatasetCredential");

@@clientName(EntraIDCredentials, "EntraIdCredentials");

@@clientName(EvalCompareReport, "EvaluationCompareReport");
@@clientName(EvalResult, "EvaluationResult");
@@clientName(EvalRun, "EvaluationRun");
@@clientName(EvalRunDataSource, "EvaluationRunDataSource");
@@clientName(EvalRunOutputItem, "EvaluationRunOutputItem");
@@clientName(EvalRunOutputItemResult, "EvaluationRunOutputItemResult");
@@clientName(EvalRunResultCompareItem, "EvaluationRunResultCompareItem");
@@clientName(EvalRunResultComparison, "EvaluationRunResultComparison");
@@clientName(EvalRunResultSummary, "EvaluationRunResultSummary");

// --------------------------------------------------------------------------------
// Usage / Public accessibility overrides
// --------------------------------------------------------------------------------

// Default name produces a style violation
@@clientName(SASCredentials, "SasCredentials", "java");
@@clientName(SasCredential, "BlobReferenceSasCredential");

// Make these two internal, since all SDKs hand-write a single public method with boolean "includeCredentials"
// input parameter that calls either on these two.
@@access(Connections.get, Access.internal);
@@access(Connections.getWithCredentials, Access.internal);

// The fix for ambiguous import of OperationState
@@clientName(Azure.Core.Foundations.OperationState, "operationStatus", "java");
