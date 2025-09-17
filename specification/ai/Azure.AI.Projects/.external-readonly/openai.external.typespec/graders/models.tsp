/*
 * This file was automatically generated from an OpenAPI .yaml file.
 * Edits made directly to this file will be lost.
 */

import "../evals";
import "./custom.tsp";

using TypeSpec.OpenAPI;

namespace OpenAI;

// Tool customization (apply_discriminator): Use discriminated type
/**
 * A LabelModelGrader object which uses a model to assign labels to each item
 * in the evaluation.
 */
model GraderLabelModel extends Grader {
  @doc("""
    The object type, which is always `label_model`.
    """)
  type: GraderType.label_model;

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

// Tool customization (apply_discriminator): Use discriminated type
/** A MultiGrader object combines the output of multiple graders to produce a single score. */
model GraderMulti extends Grader {
  @doc("""
    The object type, which is always `multi`.
    """)
  type: GraderType.multi;

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

// Tool customization (apply_discriminator): Use discriminated type
/** A PythonGrader object that runs a python script on the input. */
model GraderPython extends Grader {
  @doc("""
    The object type, which is always `python`.
    """)
  type: GraderType.python;

  /** The name of the grader. */
  name: string;

  /** The source code of the python script. */
  source: string;

  /** The image tag to use for the python script. */
  image_tag?: string;
}

// Tool customization (apply_discriminator): Use discriminated type
/** A ScoreModelGrader object that uses a model to assign a score to the input. */
model GraderScoreModel extends Grader {
  @doc("""
    The object type, which is always `score_model`.
    """)
  type: GraderType.score_model;

  /** The name of the grader. */
  name: string;

  /** The model to use for the evaluation. */
  `model`: string;

  /** The sampling parameters for the model. */
  sampling_params?: unknown;

  /** The input text. This may include template strings. */
  input: EvalItem[];

  @doc("""
    The range of the score. Defaults to `[0, 1]`.
    """)
  range?: float32[];
}

// Tool customization (apply_discriminator): Use discriminated type
/** A StringCheckGrader object that performs a string comparison between input and reference using a specified operation. */
model GraderStringCheck extends Grader {
  @doc("""
    The object type, which is always `string_check`.
    """)
  type: GraderType.string_check;

  /** The name of the grader. */
  name: string;

  /** The input text. This may include template strings. */
  input: string;

  /** The reference text. This may include template strings. */
  reference: string;

  @doc("""
    The string check operation to perform. One of `eq`, `ne`, `like`, or `ilike`.
    """)
  operation: "eq" | "ne" | "like" | "ilike";
}

// Tool customization (apply_discriminator): Use discriminated type
/** A TextSimilarityGrader object which grades text based on similarity metrics. */
model GraderTextSimilarity extends Grader {
  /** The type of grader. */
  type: GraderType.text_similarity;

  /** The name of the grader. */
  name: string;

  /** The text being graded. */
  input: string;

  /** The text being graded against. */
  reference: string;

  @doc("""
    The evaluation metric to use. One of `fuzzy_match`, `bleu`, `gleu`, `meteor`, `rouge_1`, `rouge_2`, `rouge_3`, `rouge_4`, `rouge_5`, or `rouge_l`.
    """)
  evaluation_metric:
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

model RunGraderRequest {
  /** The grader used for the fine-tuning job. */
  grader:
    | GraderStringCheck
    | GraderTextSimilarity
    | GraderPython
    | GraderScoreModel
    | GraderMulti;

  @doc("""
    The dataset item provided to the grader. This will be used to populate
    the `item` namespace. See [the guide](/docs/guides/graders) for more details.
    """)
  item?: unknown;

  @doc("""
    The model sample to be evaluated. This value will be used to populate
    the `sample` namespace. See [the guide](/docs/guides/graders) for more details.
    The `output_json` variable will be populated if the model sample is a
    valid JSON string.
    """)
  model_sample: string;
}

model RunGraderResponse {
  reward: float32;
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
    execution_time: float32;
    scores: unknown;
    token_usage: int32 | null;
    sampled_model_name: string | null;
  };
  sub_rewards: unknown;
  model_grader_token_usage_per_model: unknown;
}

model ValidateGraderRequest {
  /** The grader used for the fine-tuning job. */
  grader:
    | GraderStringCheck
    | GraderTextSimilarity
    | GraderPython
    | GraderScoreModel
    | GraderMulti;
}

model ValidateGraderResponse {
  /** The grader used for the fine-tuning job. */
  grader?:
    | GraderStringCheck
    | GraderTextSimilarity
    | GraderPython
    | GraderScoreModel
    | GraderMulti;
}
