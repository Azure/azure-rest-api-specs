namespace OpenAI;

union GraderType {
  string_check: "string_check",
  text_similarity: "text_similarity",
  score_model: "score_model",
  label_model: "label_model",
  python: "python",
  multi: "multi",
}

@discriminator("type")
model Grader {
  type: GraderType;
}
