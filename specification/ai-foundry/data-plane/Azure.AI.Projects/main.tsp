import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./agents/operations.tsp"; // TODO: Rename file agents/operations.tsp to agents/routes.tsp
import "./conversations/operations.tsp"; // TODO: Rename conversations/operations.tsp to conversations/routes.tsp
import "./finetuning/operations.tsp";
import "./responses/operations.tsp"; // TODO: Rename responses/operations.tsp to responses/routes.tsp
import "./memory_stores/operations.tsp"; // TODO: Rename memory_stores/operations.tsp to memory_stores/routes.tsp
import "./connections/routes.tsp";
import "./evaluations/routes.tsp";
import "./datasets/routes.tsp";
import "./indexes/routes.tsp";
import "./deployments/routes.tsp";
import "./red-teams/routes.tsp";
import "./openai-evaluations/routes.tsp";
import "./evaluationrules/routes.tsp";
import "./evaluation_taxonomies/routes.tsp";
import "./evaluators/routes.tsp";
import "./insights/routes.tsp";
import "./schedules/routes.tsp";

import "./service.tsp";

namespace OpenAI {
  scalar integer extends TypeSpec.int64;
  scalar numeric extends TypeSpec.float64;
}

namespace Azure.AI.Projects {
  scalar integer extends OpenAI.integer;
  scalar numeric extends OpenAI.numeric;
}
