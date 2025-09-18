import "@typespec/openapi";
import "../evals/models.tsp";
using TypeSpec.OpenAPI;
namespace OpenAI;
/** A StringCheckGrader object that performs a string comparison between input and reference using a specified operation. */
@summary("StringCheckGrader")
@extension(
  "x-oaiMeta",
  #{
    name: "String Check Grader",
    group: "graders",
    example: "{\n  \"type\": \"string_check\",\n  \"name\": \"Example string check grader\",\n  \"input\": \"{{sample.output_text}}\",\n  \"reference\": \"{{item.label}}\",\n  \"operation\": \"eq\"\n}\n",
  }
)
model GraderStringCheck {
  /** The object type, which is always `string_check`. */
  @extension("x-stainless-const", true)
  type: "string_check";

  /** The name of the grader. */
  name: string;

  /** The input text. This may include template strings. */
  input: string;

  /** The reference text. This may include template strings. */
  reference: string;

  /** The string check operation to perform. One of `eq`, `ne`, `like`, or `ilike`. */
  operation: "eq" | "ne" | "like" | "ilike";
}

/** A TextSimilarityGrader object which grades text based on similarity metrics. */
@summary("TextSimilarityGrader")
@extension(
  "x-oaiMeta",
  #{
    name: "Text Similarity Grader",
    group: "graders",
    example: "{\n  \"type\": \"text_similarity\",\n  \"name\": \"Example text similarity grader\",\n  \"input\": \"{{sample.output_text}}\",\n  \"reference\": \"{{item.label}}\",\n  \"evaluation_metric\": \"fuzzy_match\"\n}\n",
  }
)
model GraderTextSimilarity {
  /** The type of grader. */
  @extension("x-stainless-const", true)
  type: "text_similarity" = "text_similarity";

  /** The name of the grader. */
  name: string;

  /** The text being graded. */
  input: string;

  /** The text being graded against. */
  reference: string;

  /**The evaluation metric to use. One of `cosine`, `fuzzy_match`, `bleu`,
  `gleu`, `meteor`, `rouge_1`, `rouge_2`, `rouge_3`, `rouge_4`, `rouge_5`,
  or `rouge_l`.*/
  evaluation_metric:
    | "cosine"
    | "fuzzy_match"
    | "bleu"
    | "gleu"
    | "meteor"
    | "rouge_1"
    | "rouge_2"
    | "rouge_3"
    | "rouge_4"
    | "rouge_5"
    | "rouge_l";
}

/** A PythonGrader object that runs a python script on the input. */
@summary("PythonGrader")
@extension(
  "x-oaiMeta",
  #{
    name: "Python Grader",
    group: "graders",
    example: "{\n  \"type\": \"python\",\n  \"name\": \"Example python grader\",\n  \"image_tag\": \"2025-05-08\",\n  \"source\": \"\"\"\ndef grade(sample: dict, item: dict) -> float:\n    \\\"\"\"\n    Returns 1.0 if `output_text` equals `label`, otherwise 0.0.\n    \\\"\"\"\n    output = sample.get(\"output_text\")\n    label = item.get(\"label\")\n    return 1.0 if output == label else 0.0\n\"\"\",\n}\n",
  }
)
model GraderPython {
  /** The object type, which is always `python`. */
  @extension("x-stainless-const", true)
  type: "python";

  /** The name of the grader. */
  name: string;

  /** The source code of the python script. */
  source: string;

  /** The image tag to use for the python script. */
  image_tag?: string;
}

/** A ScoreModelGrader object that uses a model to assign a score to the input. */
@summary("ScoreModelGrader")
@extension(
  "x-oaiMeta",
  #{
    name: "Score Model Grader",
    group: "graders",
    example: "{\n    \"type\": \"score_model\",\n    \"name\": \"Example score model grader\",\n    \"input\": [\n        {\n            \"role\": \"user\",\n            \"content\": (\n                \"Score how close the reference answer is to the model answer. Score 1.0 if they are the same and 0.0 if they are different.\"\n                \" Return just a floating point score\\n\\n\"\n                \" Reference answer: {{item.label}}\\n\\n\"\n                \" Model answer: {{sample.output_text}}\"\n            ),\n        }\n    ],\n    \"model\": \"gpt-4o-2024-08-06\",\n    \"sampling_params\": {\n        \"temperature\": 1,\n        \"top_p\": 1,\n        \"seed\": 42,\n    },\n}\n",
  }
)
model GraderScoreModel {
  /** The object type, which is always `score_model`. */
  @extension("x-stainless-const", true)
  type: "score_model";

  /** The name of the grader. */
  name: string;

  /** The model to use for the evaluation. */
  `model`: string;

  /** The sampling parameters for the model. */
  sampling_params?: {};

  /** The input text. This may include template strings. */
  input: EvalItem[];

  /** The range of the score. Defaults to `[0, 1]`. */
  range?: numeric[];
}

/** A MultiGrader object combines the output of multiple graders to produce a single score. */
@summary("MultiGrader")
@extension(
  "x-oaiMeta",
  #{
    name: "Multi Grader",
    group: "graders",
    example: "{\n  \"type\": \"multi\",\n  \"name\": \"example multi grader\",\n  \"graders\": [\n    {\n      \"type\": \"text_similarity\",\n      \"name\": \"example text similarity grader\",\n      \"input\": \"The graded text\",\n      \"reference\": \"The reference text\",\n      \"evaluation_metric\": \"fuzzy_match\"\n    },\n    {\n      \"type\": \"string_check\",\n      \"name\": \"Example string check grader\",\n      \"input\": \"{{sample.output_text}}\",\n      \"reference\": \"{{item.label}}\",\n      \"operation\": \"eq\"\n    }\n  ],\n  \"calculate_output\": \"0.5 * text_similarity_score +  0.5 * string_check_score)\"\n}\n",
  }
)
model GraderMulti {
  /** The object type, which is always `multi`. */
  @extension("x-stainless-const", true)
  type: "multi" = "multi";

  /** The name of the grader. */
  name: string;

  graders:
    | GraderStringCheck
    | GraderTextSimilarity
    | GraderPython
    | GraderScoreModel
    | GraderLabelModel;

  /** A formula to calculate the output based on grader results. */
  calculate_output: string;
}

/**A LabelModelGrader object which uses a model to assign labels to each item
in the evaluation.*/
@summary("LabelModelGrader")
@extension(
  "x-oaiMeta",
  #{
    name: "Label Model Grader",
    group: "graders",
    example: "{\n  \"name\": \"First label grader\",\n  \"type\": \"label_model\",\n  \"model\": \"gpt-4o-2024-08-06\",\n  \"input\": [\n    {\n      \"type\": \"message\",\n      \"role\": \"system\",\n      \"content\": {\n        \"type\": \"input_text\",\n        \"text\": \"Classify the sentiment of the following statement as one of positive, neutral, or negative\"\n      }\n    },\n    {\n      \"type\": \"message\",\n      \"role\": \"user\",\n      \"content\": {\n        \"type\": \"input_text\",\n        \"text\": \"Statement: {{item.response}}\"\n      }\n    }\n  ],\n  \"passing_labels\": [\n    \"positive\"\n  ],\n  \"labels\": [\n    \"positive\",\n    \"neutral\",\n    \"negative\"\n  ]\n}\n",
  }
)
model GraderLabelModel {
  /** The object type, which is always `label_model`. */
  @extension("x-stainless-const", true)
  type: "label_model";

  /** The name of the grader. */
  name: string;

  /** The model to use for the evaluation. Must support structured outputs. */
  `model`: string;

  input: EvalItem[];

  /** The labels to assign to each item in the evaluation. */
  labels: string[];

  /** The labels that indicate a passing result. Must be a subset of labels. */
  passing_labels: string[];
}

@summary("RunGraderRequest")
model RunGraderRequest {
  /** The grader used for the fine-tuning job. */
  grader:
    | GraderStringCheck
    | GraderTextSimilarity
    | GraderPython
    | GraderScoreModel
    | GraderMulti;

  /**The dataset item provided to the grader. This will be used to populate
  the `item` namespace. See [the guide](https://platform.openai.com/docs/guides/graders) for more details.*/
  item?: {};

  /**The model sample to be evaluated. This value will be used to populate
  the `sample` namespace. See [the guide](https://platform.openai.com/docs/guides/graders) for more details.
  The `output_json` variable will be populated if the model sample is a
  valid JSON string.*/
  model_sample: string;
}

model RunGraderResponse {
  reward: numeric;
  metadata: {
    name: string;
    type: string;
    errors: {
      formula_parse_error: boolean;
      sample_parse_error: boolean;
      truncated_observation_error: boolean;
      unresponsive_reward_error: boolean;
      invalid_variable_error: boolean;
      other_error: boolean;
      python_grader_server_error: boolean;
      python_grader_server_error_type: string | null;
      python_grader_runtime_error: boolean;
      python_grader_runtime_error_details: string | null;
      model_grader_server_error: boolean;
      model_grader_refusal_error: boolean;
      model_grader_parse_error: boolean;
      model_grader_server_error_details: string | null;
    };
    execution_time: numeric;
    scores: Record<unknown>;
    token_usage: integer | null;
    sampled_model_name: string | null;
  };
  sub_rewards: Record<unknown>;
  model_grader_token_usage_per_model: Record<unknown>;
}

@summary("ValidateGraderRequest")
model ValidateGraderRequest {
  /** The grader used for the fine-tuning job. */
  grader:
    | GraderStringCheck
    | GraderTextSimilarity
    | GraderPython
    | GraderScoreModel
    | GraderMulti;
}

@summary("ValidateGraderResponse")
model ValidateGraderResponse {
  /** The grader used for the fine-tuning job. */
  grader?:
    | GraderStringCheck
    | GraderTextSimilarity
    | GraderPython
    | GraderScoreModel
    | GraderMulti;
}
