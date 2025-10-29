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
@route("/skillContext/skillDescriptor")
@doc("Get skill descriptor")
op getSkillDescriptor(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@query skillName: string,
): SkillDescriptor;

@get
@route("/skillContext/skillDescriptors")
@doc("Get skill descriptors")
op getSkillDescriptors(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
): SkillDescriptor[];

@get
@route("/skillContext/skillsetDescriptors")
@doc("Get skillset descriptors")
op getSkillsetDescriptors(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
): SkillsetDescriptor[];

@get
@route("/skillContext/skillDescriptorWithSkillsetName")
@doc("Get skill descriptor with skillset name and skill name")
op getSkillDescriptorWithSkillsetName(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@query skillName: string,
@query skillsetName: string,
): SkillDescriptor;

@get
@route("/skillContext/executionContext")
@doc("Get execution context")
op getExecutionContext(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
): MedeinaExecutionContext;

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
@route("/skillContext/logProgressTitle")
@doc("Log a progress title for a skill invocation")
op logProgressTitle(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@query title: string,
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

@post
@route("/skillContext/getTokenCredentialAsync")
@doc("Gets the token credentials")
op getTokenCredential(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body getTokenCredentialRequest : GetTokenCredentialRequest ,
): AccessToken;

@post
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
@route("/skillContext/AddSuggestedPrompts")
@doc(" Adds a list of suggested prompts to the skill context")
op addSuggestedPrompts(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body addSuggestedPromptsRequest  : AddSuggestedPromptsRequest,
): NoContentResponse;

@post
@route("/skillContext/SetFinalResponseSettings")
@doc("Sets the final response settings")
op setFinalResponseSettings(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body setFinalResponseSettingsRequest  : SetFinalResponseSettingsRequest,
): NoContentResponse;

@get
@route("/skillContext/getCachedEntityAsync")
@doc("Gets the cached entity")
op getCachedEntity(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@query cacheKeySuffix? : string,
@query({format: "multi"}) scopes? : Array<SkillUtilityCacheScope>,
@query dataType? : SkillUtilityCacheDataType,
): CachedEntity<unknown>;

@post
@route("/skillContext/setCachedEntityAsync")
@doc("Sets the cached entity")
op setCachedEntity(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body setCachedEntityRequest : SetCachedEntityRequest,
): SetCachedEntityDtoResponse;

@post
@route("/skillContext/createMemoryAsync")
@doc("Create a memory")
op createMemory(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body createMemoryRequest : CreateMemoryRequest,
): MemoryDtoResponse;

@put
@route("/skillContext/updateMemoryAsync")
@doc("Update memory")
op updateMemory(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body updateMemoryRequestWithId : UpdateMemoryRequestWithId,
): MemoryDtoResponse;

@get
@route("/skillContext/getMemoryAsync")
@doc("Get memory")
op getMemory(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@query memoryId : string,
@query subScopeId? : string,
@query scope? : MemoryScope,
): MemoryDtoResponse;

@get
@route("/skillContext/queryMemoriesAsync")
op queryMemories(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body request : QueryMemoriesRequest,
): MemoryDtoResponsePage;

@delete
@route("/skillcontext/removeMemoryAsync")
op removeMemory(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@query memoryId : string,
@query subScopeId? : string,
@query scope? : MemoryScope,
@query softDelete? : boolean = true,
): MemoryDtoResponse;

@post
@route("/skillContext/searchMemories")
op searchMemories(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body request : SearchMemoriesRequest
): MemoryDtoResponsePage;

@post
@route("/medeinaOpenAI/createChatCompletion")
@doc("Executes an Open AI Chat completion request")
op createChatCompletion(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body request  : CreateChatCompletionRequest,
): ChatCompletionResponse;

@post
@route("/medeinaOpenAI/createCompletion")
@doc("Executes an Open AI completion request")
op createCompletion(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body request  : CreateCompletionRequest,
): CompletionResponse;

@post
@route("/medeinaOpenAI/CreateEmbedding")
@doc("Creates Embedding for a prompt or message")
op CreateEmbedding(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body request  : CreateEmbeddingRequest,
): EmbeddingResponse;

@get
@route("/ecsFlight/getEcsConfiguration")
@doc("Gets the ECS configuration")
op getEcsConfiguration(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body getEcsConfigurationRequest : EcsConfigurationRequest,
): ECSFlightResponse<unknown>;

@get
@route("/ecsFlight/isEcsFlightEnabled")
@doc("returns if the flight is enabled")
op isEcsFlightEnabled(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body flightEnabledRequest : FlightEnabledRequest,
): boolean;

@post
@route("/skillContext/setEvaluateAsAgent")
@doc("")
op setEvaluateAsAgent(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
): NoContentResponse;

@post
@route("/skillContext/updateAgentConversation")
@doc("")
op updateAgentConversation(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body conversation: string,
): NoContentResponse;

@post
@route("/skillContext/updateAgentResponse")
@doc("")
op updateAgentResponse(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body response: string,
): NoContentResponse;

@post
@route("/skillContext/enqueueChildPrompt")
@doc("")
op enqueueChildPrompt(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
@body childEvaluationRequest: ChildEvaluationRequest,
): string;

@get
@route("/skillContext/yieldForChildren")
@doc("")
op yieldForChildren(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
): boolean;

@get
@route("/skillContext/skillFilters")
@doc("Returns skill filters")
op getSkillFilters(
@header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
): Record<string>;

//TODO: move this to a different file
// Dynamic Prompts API
@post
@route("/dynamicPrompts/search")
@doc("Performs a search operation using the provided search request.")
op search(
    @header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
    @body request: DynamicPromptsSearchRequest
): DynamicPromptsSearchResponse;

@post
@route("/dynamicPrompts/hybridsearch")
@doc("Performs a hybrid search operation using the provided search request.")
op hybridSearch(
    @header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
    @body request: DynamicPromptsSearchRequest
): DynamicPromptsSearchResponse;

@post
@route("/dynamicPrompts/filter")
@doc("Filters the dynamic prompts based on the provided filter request.")
op filter(
    @header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
    @body request?: DynamicPromptsFilterRequest
): DynamicPromptsFilterResponse;

@post
@route("/dynamicPrompts/count")
@doc("Gets the document count based on the provided base request.")
op getDocumentCount(
    @header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
    @body request: DynamicPromptsBaseRequest
): DocumentCountResponse;

@post
@route("/dynamicPrompts/indexfilter")
@doc("Filters the dynamic prompts by index based on the provided index filter request.")
op indexFilter(
    @header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
    @body request: DynamicPromptsIndexFilterRequest
): DynamicPromptsIndexFilterResponse;

@get
@route("/dynamicPrompts/exists")
@doc("Checks if the physical index exists.")
op physicalIndexExists(
    @header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string
): PhysicalIndexExistsResponse;

@post
@route("/dynamicPrompts/suggestedprompts")
@doc("Gets the suggested prompts based on the provided suggested prompts request.")
op getSuggestedPrompts(
    @header("X-MS-SecurityCopilot-EvaluationToken") evaluationToken: string,
    @body request: DynamicPromptsSuggestedPromptsRequest
): SuggestedPromptsResponse;