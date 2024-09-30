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
    @header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
  ): SkillContextResponse;

  @post
  @route("invokeSkill")
  @doc("Invokes a skill. Allows current skill to invoke dependency skills.")
  op invokeSkill(
    @header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
    @body invokeSkill: InvokeSkillRequest,
  ): OutputSkillVariable;

  @get
  @route("promptHistory")
  @doc("Get prompt history")
  op getPromptHistory(
    @header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
  ): PromptHistoryResponse;

  @post
  @route("logProgress")
  @doc("Log a progress message for a skill invocation")
  op logProgress(
    @header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
    @body logProgressRequest: LogProgressRequest,
  ): NoContentResponse;

  @post
  @route("setOutputAsync")
  @doc("Sets the skill output")
  op setSkillOutput(
    @header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
    @body outputSkillVariable: OutputSkillVariable,
  ): NoContentResponse;

  @get
  @route("skillsetSettings")
  @doc("Gets the skillset settings")
  op getSkillsetSettings(
    @header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
  ): Record<string>;

  @post
  @route("setSkillInvocationStarted")
  @doc("Notifies security copilot backend service that the skill has been invoked")
  op setSkillInvocationStarted(
    @header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
  ): NoContentResponse;

  @post
  @route("setSkillInvocationCompleted")
  @doc("Notifies security copilot backend service that the skill invocation has completed")
  op setSkillInvocationCompleted(
    @header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
  ): NoContentResponse;

  @get
  @route("getSkillsetAuthInfoAsync")
  @doc("Gets the skillset auth related information")
  op getSkillsetAuthInfo(
    @header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
  ): AuthDetails;

  @get
  @route("getTokenCredentialAsync")
  @doc("Gets the token credentials")
  op getTokenCredential(
    @header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
    @body getTokenCredentialRequest : GetTokenCredentialRequest ,
  ): AccessToken;

  @get
  @route("getInputAsync")
  @doc("Gets the skill input")
  op getInput(
    @header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
    @body getInputRequest : GetInputRequest,
  ): SkillVariable | NoContentResponse ;

  @post
  @route("setInputAsync")
  @doc("Sets the input for the skill")
  op setInput(
    @header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
    @body setInputRequest : SetInputRequest,
  ): NoContentResponse;

  @post
  @route("AddSources")
  @doc("Adds a list of sources to the output")
  op addSources(
    @header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
    @body addSourcesRequest  : AddSourcesRequest,
  ): NoContentResponse;

  @post
  @route("AddSource")
  @doc("Adds a source to the output")
  op addSource(
    @header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
    @body addSourceRequest  : AddSourceRequest,
  ): NoContentResponse;
}
