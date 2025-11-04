import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../../../Azure.AI.Projects/service.tsp";

import "../../../Azure.AI.Projects/connections/routes.tsp";
import "../../../Azure.AI.Projects/datasets/routes.tsp";
import "../../../Azure.AI.Projects/indexes/routes.tsp";
import "../../../Azure.AI.Projects/deployments/routes.tsp";
import "../../../Azure.AI.Projects/red-teams/routes.tsp";
import "../../../Azure.AI.Projects/evaluationrules/routes.tsp";
// Don't import openai-evaluations, we'll use Stainless SDK like in AgentsV2
// import "../../../Azure.AI.Projects/openai-evaluations/routes.tsp";
// import "../../../Azure.AI.Projects/evaluation_taxonomies/routes.tsp";
import "../../../Azure.AI.Projects/evaluators/routes.tsp";
import "../../../Azure.AI.Projects/insights/routes.tsp";
import "../../../Azure.AI.Projects/schedules/routes.tsp";
