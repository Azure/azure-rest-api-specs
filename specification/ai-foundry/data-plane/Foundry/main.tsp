import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./src/agents/routes.tsp";
import "./src/conversations/routes.tsp";
import "./src/finetuning/routes.tsp";
import "./src/responses/routes.tsp";
import "./src/memory_stores/routes.tsp";
import "./src/connections/routes.tsp";
import "./src/evaluations/routes.tsp";
import "./src/datasets/routes.tsp";
import "./src/indexes/routes.tsp";
import "./src/deployments/routes.tsp";
import "./src/red-teams/routes.tsp";
import "./src/openai-evaluations/routes.tsp";
import "./src/evaluationrules/routes.tsp";
import "./src/evaluation_taxonomies/routes.tsp";
import "./src/evaluators/routes.tsp";
import "./src/insights/routes.tsp";
import "./src/schedules/routes.tsp";

import "./src/common/service.tsp";

namespace OpenAI {
  scalar integer extends TypeSpec.int64;
  scalar numeric extends TypeSpec.float64;
}

namespace Azure.AI.Projects {
  scalar integer extends OpenAI.integer;
  scalar numeric extends OpenAI.numeric;
}

@@minValue(OpenAI.CreateChatCompletionRequest.seed, -9223372036854775808);
@@maxValue(OpenAI.CreateChatCompletionRequest.seed, 9223372036854775807);
