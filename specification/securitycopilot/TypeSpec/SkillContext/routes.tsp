import "@typespec/rest";
import "@typespec/http";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

@route("/skillContext")
@summary("Operations for skills to interact with security copilot ")
namespace SkillContext {
  @get
  @doc("Get the SkillContext for the current skill invocation")
  op getSkillContext(
    @header `X-MS-SecurityCopilot-EvaluationToken`: string,
  ): SkillContextResponse | UnauthorizedResponse;

  @post
  @route("invokeSkill")
  @doc("Invokes a skill. Allows current skill to invoke dependency skills.")
  op invokeSkill(
    @header `X-MS-SecurityCopilot-EvaluationToken`: string,
    @body invokeSkill: InvokeSkillRequest,
  ): OutputSkillVariable | BadRequestResponse;

  @get
  @route("promptHistory")
  @doc("Get prompt history")
  op getPromptHistory(
    @header `X-MS-SecurityCopilot-EvaluationToken`: string,
  ): PromptHistoryResponse | UnauthorizedResponse;

  @post
  @route("logProgress")
  @doc("Log a progress message for a skill invocation")
  op logProgress(
    @header `X-MS-SecurityCopilot-EvaluationToken`: string,
    @body logProgressRequest: LogProgressRequest,
  ): NoContentResponse | UnauthorizedResponse | BadRequestResponse;

  @post
  @route("setOutput")
  @doc("Sets the skill output")
  op setSkillOutput(
    @header `X-MS-SecurityCopilot-EvaluationToken`: string,
    @body outputSkillVariable: OutputSkillVariable,
  ): NoContentResponse | UnauthorizedResponse | BadRequestResponse;

  @get
  @route("skillsetSettings")
  @doc("Sets the skillset settings")
  op skillsetSettings(
    @header `X-MS-SecurityCopilot-EvaluationToken`: string,
  ): SkillsetConfiguration | UnauthorizedResponse;

  @post
  @route("setSkillInvocationStarted")
  @doc("Notifies security copilot backend service that the skill has been invoked")
  op setSkillInvocationStarted(
    @header `X-MS-SecurityCopilot-EvaluationToken`: string,
  ): NoContentResponse;

  @post
  @route("setSkillInvocationCompleted")
  @doc("Notifies security copilot backend service that the skill invocation has completed")
  op setSkillInvocationCompleted(
    @header `X-MS-SecurityCopilot-EvaluationToken`: string,
  ): NoContentResponse;
}
