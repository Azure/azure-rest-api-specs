import "@typespec/rest";
import "@typespec/http";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace SkillContext;

@get
@route("/skillContext")
@doc("Get the SkillContext for the current skill invocation")
op getSkillContext(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
): SkillContextResponse;

@post
@route("/skillContext/invokeSkill")
@doc("Invokes a skill. Allows current skill to invoke dependency skills.")
op invokeSkill(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body invokeSkill: InvokeSkillRequest,
): OutputSkillVariable;

@get
@route("/skillContext/promptHistory")
@doc("Get prompt history")
op getPromptHistory(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
): PromptHistoryResponse;

@post
@route("/skillContext/logProgress")
@doc("Log a progress message for a skill invocation")
op logProgress(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body logProgressRequest: LogProgressRequest,
): NoContentResponse;

@post
@route("/skillContext/setOutputAsync")
@doc("Sets the skill output")
op setSkillOutput(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body evaluationResultOutput: EvaluationResultOutput,
): NoContentResponse;

@get
@route("/skillContext/skillsetSettings")
@doc("Gets the skillset settings")
op getSkillsetSettings(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
): Record<string>;

@post
@route("/skillContext/setSkillInvocationStarted")
@doc("Notifies security copilot backend service that the skill has been invoked")
op setSkillInvocationStarted(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
): NoContentResponse;

@post
@route("/skillContext/setSkillInvocationCompleted")
@doc("Notifies security copilot backend service that the skill invocation has completed")
op setSkillInvocationCompleted(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
): NoContentResponse;

@get
@route("/skillContext/getSkillsetAuthInfoAsync")
@doc("Gets the skillset auth related information")
op getSkillsetAuthInfo(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
): AuthDetails;

@get
@route("/skillContext/getTokenCredentialAsync")
@doc("Gets the token credentials")
op getTokenCredential(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body getTokenCredentialRequest : GetTokenCredentialRequest ,
): AccessToken;

@get
@route("/skillContext/getInputAsync")
@doc("Gets the skill input")
op getInput(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body getInputRequest : GetInputRequest,
): SkillVariable | NoContentResponse ;

@post
@route("/skillContext/setInputAsync")
@doc("Sets the input for the skill")
op setInput(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body setInputRequest : SetInputRequest,
): NoContentResponse;

@post
@route("/skillContext/AddSources")
@doc("Adds a list of sources to the output")
op addSources(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body addSourcesRequest  : AddSourcesRequest,
): NoContentResponse;

@post
@route("/skillContext/AddSource")
@doc("Adds a source to the output")
op addSource(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body addSourceRequest  : AddSourceRequest,
): NoContentResponse;


@post
@route("/medeinaOpenAI/createChatCompletion")
@doc("Executes an Open AI Chat completion request")
op createChatCompletion(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body request  : CreateChatCompletionRequest,
): ChatCompletionResponse;

@post
@route("/medeinaOpenAI/createCompletion")
@doc("Executes an OpenAI completion request")
op createCompletion(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body request  : CreateCompletionRequest,
): CompletionResponse;

@post
@route("/medeinaOpenAI/CreateEmbedding")
@doc("Creates embeddings for the prompt messages based on the model chosen.")
op CreateEmbedding(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body request  : CreateEmbeddingRequest,
): EmbeddingResponse;
  
