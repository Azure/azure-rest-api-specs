import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";
import "@typespec/openapi";
import "../.external-readonly/openai.external.typespec/evals/model.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;


union GraderType {
  string_check: "string_check",
  text_similarity: "text_similarity",
  score_model: "score_model",
  label_model: "label_model",
  python: "python",
  multi: "multi",
   /** Foundry evaluator type */
  azure_ai_evaluator: "azure_ai_evaluator",
}

@discriminator("type")
model EvalGraderParams {
  type: GraderType;
}

@discriminator("type")
model EvalGraderResource {
  type: GraderType;
}

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

/*
model Eval extends OpenAI.Eval {

  // Tool customization: Use discriminated type
  testing_criteria: EvalGraderResource[] | null = null;
}
*/

/*
model CreateEvalRequest extends OpenAI.CreateEvalRequest {

  // Tool customization: Use discriminated type
  @doc("""
    A list of graders for all eval runs in this group. Graders can reference variables in the data source using double curly braces notation, like `{{item.variable_name}}`. To reference the model's output, use the `sample` namespace (ie, `{{sample.output_text}}`).
    Includes foundry evaluator type.
    """)
  testing_criteria: EvalGraderParams[];
} */