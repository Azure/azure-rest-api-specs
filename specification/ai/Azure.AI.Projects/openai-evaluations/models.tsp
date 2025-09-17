import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";
import "@typespec/openapi";
import "../.external-readonly/openai.external.typespec/evals/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;


@summary("AzureAIEvaluator")
model AzureAIEvaluator {
  /** The object type, which is always `label_model`. */
  @extension("x-stainless-const", true)
  type: "azure_ai_evaluator";

  /** The name of the evaluator. */
  evaluator_name: string;

  /** Optional version of the evaluator. */
  version?: string;
}

model Eval {

  ...Omit<OpenAI.Eval, "testing_criteria">;

  /** A list of testing criteria. */
  testing_criteria: (
    | OpenAI.EvalGraderLabelModel
    | OpenAI.EvalGraderStringCheck
    | OpenAI.EvalGraderTextSimilarity
    | OpenAI.EvalGraderPython
    | OpenAI.EvalGraderScoreModel
    | Azure.AI.Projects.AzureAIEvaluator
  )[];
}