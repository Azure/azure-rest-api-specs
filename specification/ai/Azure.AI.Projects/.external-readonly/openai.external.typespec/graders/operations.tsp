import "@typespec/http";
import "@typespec/openapi";

import "../common";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace OpenAI;

@route("fine_tuning/alpha/graders")
@tag("Fine-tuning")
interface Graders {
  @post
  @route("run")
  @operationId("runGrader")
  @summary("Run a grader.")
  runGrader(@body request: RunGraderRequest): RunGraderResponse;

  @post
  @route("validate")
  @operationId("validateGrader")
  @summary("Validate a grader.")
  validateGrader(@body request: ValidateGraderRequest): ValidateGraderResponse;
}
