import "../common/models.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("The kind of question presented in a human-evaluation template.")
@removed(Versions.v1)
union QuestionKind {
  string,

  @doc("Two-option answer (yes/no).")
  yes_no: "yesNo",
}

@doc("The source of a human evaluation template.")
@removed(Versions.v1)
union TemplateSource {
  string,

  @doc("Built-in template from the azureml registry.")
  builtin: "builtin",

  @doc("Custom template created in the workspace.")
  custom: "custom",
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Discriminator is the question kind."
@doc("A single question presented to the human evaluator. Each question captures one evaluation dimension and produces one annotation entry when submitted.")
@removed(Versions.v1)
@discriminator("kind")
model Question {
  @doc("The kind of question.")
  kind: QuestionKind;

  @doc("The question text shown to the human evaluator (for example, 'Was this response helpful?').")
  text: string;

  @doc("The evaluation dimension this question captures (for example, 'helpfulness'). Maps to gen_ai.evaluation.name in the OpenTelemetry GenAI Semantic Conventions.")
  dimension: string;
}

@doc("A two-option (yes/no) question. The evaluator picks one of two choices; the answer is a boolean.")
@removed(Versions.v1)
model YesNoQuestion extends Question {
  kind: QuestionKind.yes_no;
}

@doc("A human-evaluation template: the rubric a builder or end user applies when evaluating a trace. Identified by name + version.")
@removed(Versions.v1)
@resource("humanevaluations/templates")
model HumanEvaluationTemplate {
  ...AssetBase;

  @doc("The source of the template (builtin or custom).")
  source: TemplateSource;

  @doc("The questions presented to the human evaluator.")
  @minItems(1)
  @visibility(Lifecycle.Read)
  questions: Question[];
}
