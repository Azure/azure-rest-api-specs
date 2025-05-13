import "@typespec/rest";
import "@typespec/http";
import "../SharedModels.tsp";
import "../SharedEnums.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace SkillContext
{

	@doc("SkillContext object containing properties of the current session relevant to the invoked skill")
	model SkillContextResponse {
		@doc("Skill descriptor containing attributes that describe a skill (i.e. Inputs required to execute the skill)")
		descriptor: SkillDescriptor;

		@doc("SkillContext Id")
		id: string;

		@doc("Array of feature flags")
		featureFlags: Array<string>;

		@doc("Skill Variable Collection")
		inputs: Record<SkillVariable>;

		@doc("Additional skill specific settings")
		properties: Record<string>;

		@doc("TODO")
		startTime: offsetDateTime;

		@doc("Tenant id of tenant in which skill invocation occured")
		tenantId: string;

		@doc("User id of user that invoked the skill")
		userId: string;

		@doc("Current session ID")
		sessionId: string;

		@doc("Current prompt ID")
		promptId: string;

		@doc("Current evaluation ID")
		evaluationId: string;

		@doc("Compliance flags for logging.")
		complianceFlags: ComplianceFlags;

		@doc("Fidelis Workspace Id")
		workspaceId: string;

		@doc("Originating source tag for the evaluation (i.e. Immersive, Logic Apps, etc.)")
		source: string;

		@doc("Indicates whether the evaluation is user driven or automated")
		invocationType: EvaluationInvocationType;

		@doc("Indicates whether the evaluation is from a Prompt or a Promptbook")
		invocationCategory: EvaluationInvocationCategory;

		@doc("Username of the user that invoked the skill")
		userName: string;
	}

	@doc("Evaluation Invocation Type")
	enum EvaluationInvocationType {
		@doc("Manual generation")
		Manual,

		@doc("Automated generation")
		Automated,
	}

	@doc("Evaluation Invocation Category")
	enum EvaluationInvocationCategory {
		@doc("Generated from a Prompt")
		UserPrompt,

		@doc("Generated from a Promptbook")
		Promptbooks,
	}

	@doc("Skill Audience")
	enum SkillAudience {
		@doc("A user of the application")
		User,

		@doc("The orchestrator (planner)")
		Planner,
	}

	@doc("ComplianceFlags")
	model ComplianceFlags {
		@doc("Whether to record logs in Geneva and Kusto for this user")
		recordLog: boolean;

		@doc("Locked down tables not required and non-customer content table does not have to be redacted")
		customerOptedInToEyesOnProductImprovement: boolean;

		@doc("When this is true, the data may be used for model improvement. This flag does not affect redaction.")
		customerOptedInToModelImprovement: boolean;
	}

	@doc("Skill Variable")
	model SkillVariable {
		@doc("Skill variable type")
		type?: string;

		@doc("Skill variable value")
		value?: string;

		@doc("Skill variable value is stored as json document")
		valueStoredAsJson: boolean;
	}

	@doc("Invoke skill request including necessary inputs for invoking a skill")
	model InvokeSkillRequest {
		@doc("Name of skillset in which desired skill to invoke resides")
		skillsetName?: string;

		@doc("Name of skill to be invoked")
		skillName: string;

		@doc("Skill inputs")
		inputs: Record<SkillVariable> | null;
	}

	@doc("Skill variable parent entity adding additional attribute 'skillsource' to provide visibility to users as to what data/information was used in generating the output of a skill")
	model OutputSkillVariable extends SkillVariable {
		@doc("Array of cited sources that were fetched by a skill and that impacted the output of the skill evaluation")
		sources: Array<SkillSource> | null;

		@doc("Suggested prompts providing assistance to users in understanding what prompts work well with CFS")
		suggestedPrompts: Array<SuggestedPrompt> | null;

		@doc("Skill name")
		skillName: string | null;

		@doc("Skill inputs that were used in generating the output of the skill evaluation")
		skillInputs: Record<string> | null;

		@doc("Skill output language")
		outputLanguage: string | null;

		@doc("Enum indicating the output type of the skill. Supports StructuredOutput and Primitive")
		outputType: SkillOutputType;
	}

	@doc("A collection of skill variables")
	model SkillVariableCollection extends Record<SkillVariable>{
	}

	@doc("An invocation of a skill")
	model SkillInvocation {
		@doc("The name of the skill function")
		functionName: string;

		@doc("The description of the skill")
		skillDescription: string;

		@doc("The inputs to the skill")
		inputs: SkillVariableCollection;

		@doc("If the skill is successful")
		success: boolean;

		@doc("The output of the skill")
		output: OutputSkillVariable;

		@doc("If the output is truncated")
		outputIsTruncated: boolean;
		
		@doc("The exception that occurred during the skill invocation")	
		exception: Exception;
	}

	@doc("Exception")
	model Exception {
		@doc("The exception message")
		message: string;

		@doc("The inner exception")
		innerException: Exception;
	}

	model EvaluationResultOutput {
		skillOutputType: SkillOutputType;
		primitiveOutput?: OutputSkillVariable;
		structuredOutput?: SkillStructuredOutput;
		primitiveOutputValue?: string;
	}

	model SkillStructuredOutput {
		components: Array<SkillOutputComponent>;
	}

	model SkillOutputComponent extends OutputComponent{
		action: SkillOutputComponentAction;
		includeInEvalResultAsRawComponent: boolean;
	}

	model OutputComponent {
		name: string;
		content: string;
		description?: string;
		type: OutputComponentType;
	}

	model SkillImageSource {
		displayName: string;
		imageFileType: string;
		description: string;
		imageBase64: string;
		imageThumbnailBase64: string;
	}

	enum OutputComponentType {
		GptOutput,
		Text,
		Image,
	}

	enum SkillOutputComponentAction {
		None,
		Summarize,
		Substitute,
	}

	@doc("Auth Location")
	enum AuthLocationEnum {
		@doc("Using Header")
		Header,

		@doc("Using QueryParams")
		QueryParams,
	}

	@doc("Skill Output type enum. Supports StructuredOutput and Primitive")
	enum SkillOutputType {
		@doc("Primitive")
		Primitive,
		@doc("Structured Components")
		StructuredComponents,
	}

	@doc("Represents the execution context for the current session.")
	model MedeinaExecutionContext {
		@doc("The session id.")
		SessionId: string;

		@doc("The prompt id.")
		PromptId: string;

		@doc("The evaluation id.")
		EvaluationId: string;

		@doc("The tenant id.")
		TenantId: string;

		@doc("The account id.")
		AccountId: string;

		@doc("The workspace id.")
		WorkspaceId: string;

		@doc("The display name of the user.")
		UserName: string;

		@doc("The Application Id that created the Session.")
		ApplicationId?: string;

		@doc("The Source tag i.e. 'immersive'.")
		Source: string;

		@doc("The source application ID.")
		UnauthenticatedSourceApplicationId: string;

		@doc("The selected skills.")
		SelectedSkills: string;

		@doc("The skillsets identified for execution during the evaluation process post skill selection.")
		SelectedSkillsets: Array<string>;

		@doc("Indicates whether the context is for a user onboarded to Fidelis.")
		IsFidelisUser: boolean;

		@doc("Indicates whether the evaluation is manually generated or user driven.")
		InvocationType: EvaluationInvocationType;

		@doc("Indicates whether the evaluation is from a Prompt or a Promptbook")
		InvocationCategory: EvaluationInvocationCategory;

		@doc("Compliance flags for logging.")
		ComplianceFlags: ComplianceFlags;

		@doc("Contains the context for the Azure OpenAI requests such as the deployment id.")
		AzureOpenAIExecutionContext: AzureOpenAIExecutionContext;

		@doc("Preview state of the execution context.")
		PreviewState: SkillPreviewState;

		@doc("ID of the agent")
		AgentId: string;

		@doc("Actual Fidelis workspace ID. This workspace ID is a GUID generated and provided by Fidelis.")
		actualWorkspaceId: string;

		@doc("Agent scope")
		agentScope: AgentScope;

		@doc("The agent trigger name identified for each agent evaluation execution")
		selectedAgentTrigger: string;

		@doc("The agent definition name identified for each agent evaluation execution")
		agentDefinitionName: string;

		@doc("Indicates Fallback options when no skill is chosen.")
		fallbackOptions?: FallbackOptions;

		@doc("This contains the time at which the evaluation started")
		EvaluationStartTime: offsetDateTime;

		@doc("The time when the prompt for the evaluation was created, except for during retries")
		EvaluationPromptCreationStartedAt: offsetDateTime;

		@doc("The time when the evaluation starts running after waiting in the processing queue.")
		EvaluationRunStartedAt: offsetDateTime;

		@doc("A snapshot of requests for sleeping attached to the evaluation in this context.")
		SleepRequests?: Record<duration>;

		@doc("Represents the amount of time the current prompt would like to sleep.")
		PromptSleepDuration?: duration;

		@doc("Represents the number of prompt executions that have occurred.")
		EvaluationExecutionCount: uint32;

		@doc("Determines the node visibility in the end user node map.")
		HideEvaluationNode: boolean;

		@doc("Is agent trial condition met")
		IsAgentTrialConditionMet: boolean;
	}

	
	@doc("Suggested prompts providing assistance to users in understanding what prompts work well with CFS")
	model SuggestedPrompt {
		@doc("Prompt text")
		prompt: string;
	}

	@doc("Source that is fetched during the evaluation of a skill. Provides visibility to users as to what data/information was used in generating the output of a skill")
	model SkillSource {
		@doc("User friendly name for the information source")
		displayName: string;

		@doc("Information source content (i.e. URL to article)")
		sourceContent: string;

		@doc("The source type (i.e. URI)")
		sourceType: SkillSourceType;

		@doc("Source data serialized as string")
		sourceSerializedData?: string | null;
	}

	@doc("Used to configure the preview state of a skill.")
	enum SkillPreviewState {
		GA,
		Public,
		Private
	}

	@doc("The prompt history of the current session")
	model PromptHistoryResponse {
		@doc("List of prompts that have been evaluated in the current session")
		prompts: Array<SessionPrompt>;
	}

	@doc("A record for a prompt and response used in tracking session prompt history")
	model SessionPrompt {
		@doc("The content of the prompt")
		prompt: string;

		@doc("Prompt response returned by the prompt evaluation")
		response: string | null;

		@doc("Type of prompt")
		promptType: PromptType;
	}

	@doc("The progress message to log during a skill invocation")
	model LogProgressRequest {
		@doc("Log level")
		level?: ProgressLogLevel;

		@doc("Log message")
		message: string;
	}
	
	@doc("Auth Details")
	model AuthDetails {
		@doc("Auth Location")
		authLocation: AuthLocationEnum;

		@doc("Auth Info")
		authInfo: Record<string>;
	}

	@doc("TokenCredentialRequest")
	model GetTokenCredentialRequest {
		@doc("Scopes")
		scopes: Array<string>;

		@doc("TokenCredential Type")
		tokenCredentialType: TokenCredentialEnum = TokenCredentialEnum.None;

		@doc("TenantId")
		tenantId?: string | null;
	}

	@doc("AccessToken")
	model AccessToken {
		@doc("Token string")
		token: string;

		@doc("Expiry time")
		expiresOn: offsetDateTime;
	}

	@doc("GetInputRequest")
	model GetInputRequest {
		@doc("Input Name")
		inputName: string;

		@doc("Default value for the input")
		defaultValue?: SkillVariable | null;
	}

	@doc("SetInputRequest")
	model SetInputRequest {
		@doc("Input Name")
		inputName: string;

		@doc("Default value for the input")
		defaultValue?: SkillVariable | null;
	}

	@doc("AddSourcesRequest")
	model AddSourcesRequest {
		@doc("List of SkillSource")
		sources: Array<SkillSource>;
	}

	@doc("AddSourceRequest")
	model AddSourceRequest {
		@doc("SkillSource")
		SkillSource: SkillSource;
	}

	@doc("AddSuggestedPromptsRequest")
	model AddSuggestedPromptsRequest {
		@doc("List of SuggestedPrompt")
		suggestedPrompts: Array<SuggestedPrompt>;
	}

	@doc("SetFinalResponseSettingsRequest")
	model SetFinalResponseSettingsRequest {
		@doc("FinalResponseBehavior")
		finalResponseBehavior: string;

		@doc("FinalResponseFormat")
		finalResponseFormat?: string;

		@doc("FinalResponsePersona")
		finalResponsePersona?: string;

		@doc("FinalResponseFallback")
		finalResponseFallback?: string;
	}

	@doc("PromptBuilder")
	model PromptBuilder {
		@doc("SkillName")
		skillName: string;

		@doc("SkillsetName")
		skillsetName: string;

		@doc("SkillInputParts")
		skillInputParts: Record<IPromptPart>;

		@doc("TokenReductionStrategies")
		tokenReductionStrategies: Array<TokenReductionStrategy>;

		@doc("TokenSafetyMargin")
		tokenSafetyMargin: int32 = 256;

		@doc("Functions")
		functions: FunctionList;
	}

	@doc("TokenReductionStrategy")
	model TokenReductionStrategy {
		@doc("TokenTarget")
		tokenTarget: TokenTarget;

		@doc("Parts")
		parts: Array<IPromptPart>;
	}

	@doc("IPromptPart")
	interface IPromptPart {
		@doc("Renders the prompt part")
		render(): string;
	}

	@doc("TokenTarget")
	model TokenTarget {
	}

	@doc("FunctionList")
	model FunctionList {
		@doc("Functions")
		functions: Array<GPTFunction>;
	}

	@doc("Represents a chat completion request.")
	model ChatCompletionRequest extends BaseCompletionRequest {
	  @doc("The messages associated with the request.")
	  Messages: Array<Message>;

	  @doc("The functions associated with the request.")
	  Functions: Array<GPTFunction>;

	  @doc("Specifies the function to call.")
	  FunctionCall: string;

	  @doc("The tools available for this request.")
	  Tools?: Array<Tools>;

	  @doc("The selected tool for execution.")
	  ToolChoice?: string;

	  @doc("Indicates whether tools can be called in parallel.")
	  ParallelToolCalls?: boolean;
	}

	@doc("Represents the base completion request with common parameters.")
	model BaseCompletionRequest {
	  @doc("The maximum number of tokens to generate.")
	  MaxTokens?: int32;

	  @doc("The sampling temperature to use.")
	  Temperature?: float64;

	  @doc("The nucleus sampling parameter.")
	  TopP?: float64;

	  @doc("The number of completions to generate.")
	  N?: int32;

	  @doc("Specifies whether to stream the response.")
	  Stream?: boolean;

	  @doc("The number of log probabilities to include.")
	  Logprobs?: int32;

	  @doc("Whether to include the prompt in the output.")
	  Echo?: boolean;

	  @doc("Stop sequences to terminate generation.")
	  Stop: Array<string>;

	  @doc("The penalty for repeating words in the presence.")
	  PresencePenalty?: float64;

	  @doc("The penalty for repeating tokens.")
	  FrequencyPenalty?: float64;

	  @doc("The number of completions to choose the best from.")
	  BestOf?: int32;

	  @doc("Adjusts likelihood of specific tokens.")
	  LogitBias: Record<int32>;

	  @doc("The response format specification.")
	  ResponseFormat: unknown;
	}

	@doc("Represents a message in the chat.")
	model Message {
	  @doc("The content of the message.")
	  Content?: string;

	  @doc("The role of the message sender.")
	  Role: string;

	  @doc("The name of the message sender.")
	  Name?: string;

	  @doc("The function call information.")
	  FunctionCall?: FunctionCall;

	  @doc("The tool calls associated with the message.")
	  ToolCalls?: Array<ToolCall>;

	  @doc("The identifier for the tool call.")
	  ToolCallId?: string;
	}

	@doc("Represents a function call.")
	model FunctionCall {
	  @doc("The name of the function.")
	  Name: string;

	  @doc("The arguments passed to the function.")
	  Arguments?: Record<string>;
	}

	@doc("Represents a tool call.")
	model ToolCall {
	  @doc("The id of the tool call.")
	  Id: string;

	  @doc("The type of the tool call.")
	  Type: string;

	  @doc("The function for the tool call.")
	  Function: ToolFunctionCall;
	}

	@doc("Represents a tool function call.")
	model ToolFunctionCall {
	  @doc("The name of the tool function.")
	  Name: string;

	  @doc("The arguments for the tool function.")
	  Arguments: string;
	}

	@doc("Represents a GPT function definition.")
	model GPTFunction {
	  @doc("The name of the GPT function.")
	  Name: string;

	  @doc("The description of the GPT function.")
	  Description: string;

	  @doc("The parameters required by the GPT function.")
	  Parameters: FunctionParameter;

	  @doc("The result of the GPT function.")
	  Result: FunctionResult;
	}

	@doc("Represents parameters for a function.")
	model FunctionParameter {
	  @doc("The type of the parameter.")
	  Type: string;

	  @doc("The properties of the parameter.")
	  Properties: Record<FunctionParameterProperty>;

	  @doc("The list of required properties.")
	  Required: Array<string>;
	}

	@doc("Represents parameters properties for a function.")
	model FunctionParameterProperty {
	  @doc("The type of the parameter property.")
	  Type: string;

	  @doc("The description of property of the parameter.")
	  Description: string;

	  @doc("The list of enums.")
	  Enum: Array<string>;
	}

	@doc("Represents the result of a function.")
	model FunctionResult {
	  @doc("The type of the result.")
	  Type: string;
	}

	@doc("Represents a tool.")
	model Tools {
	  @doc("The type of the tool.")
	  Type: string;

	  @doc("The function definition for the tool.")
	  Function: FunctionDefinition;
	}

	@doc("Represents the definition of a function.")
	model FunctionDefinition {
	  @doc("The description of the function.")
	  Description: string;

	  @doc("The name of the function.")
	  Name: string;

	  @doc("The parameters for the function.")
	  Parameters: unknown;
	}

	@doc("Represents the Azure OpenAI execution context.")
	model AzureOpenAIExecutionContext {
	  @doc("The API version.")
	  ApiVersion: string = "2024-06-01";

	  @doc("The environment where the request is being made.")
	  Environment: string;

	  @doc("Determines if the GPU proxy is enabled.")
	  IsGPUProxyEnabled: boolean = false;

	  @doc("The geographic location where the GPU processing is being done.")
	  GpuProcessingGeo?: string;

	  @doc("Whether the customer allows cross-geo compute in their workspace capacity.")
	  CustomerAllowCrossGeoCompute: boolean = false;

	  @doc("ECS controlled flag to allow cross-geo compute.")
	  EcsAllowCrossGeoCompute: boolean = false;

	  @doc("Properties used to add content prompt and content filter details from the response.")
	  ContentFilterProperties?: Record<string>;

	  @doc("Properties used to report information about the skill invocation. Must not contain customer content.")
	  ReportingProperties?: Record<string>;
	}

	@doc("Represents a request to create a chat completion.")
	model CreateChatCompletionRequest {
	  @doc("The deployment ID.")
	  deploymentId?: string;

	  @doc("The chat completion request details.")
	  chatCompletionRequest: ChatCompletionRequest;

	  @doc("The Azure OpenAI execution context.")
	  openAiExecutionContext?: AzureOpenAIExecutionContext;
	}

	@doc("Represents the base completion response.")
	model BaseCompletionResponse {
	  @doc("The unique identifier for the response.")
	  Id: string;

	  @doc("The object type.")
	  Object: string;

	  @doc("The creation timestamp.")
	  Created: offsetDateTime; 

	  @doc("The model used for completion.")
	  Model: string;

	  @doc("The usage statistics for the response.")
	  Usage: unknown;

	  @doc("The results of prompt filtering.")
	  PromptFilterResults: Array<unknown>;
	}


	@doc("Defines the severity levels for content filtering.")
	enum FilterSeverity {
	  safe,
	  low,
	  medium,
	  high,
	}

	@doc("Represents details of a code citation.")
	model CodeCitation {
	  @doc("The URL of the cited source.")
	  Url: string;

	  @doc("The license of the cited content.")
	  License: string;
	}

	model BaseChoice {
	  Index: int32;
	  @doc("Log probabilities for this choice.")
	  LogProbs: unknown;

	  @doc("The reason why the operation finished.")
	  FinishReason: string;

	  @doc("This object contains the list of content filter annotations.")
	  ContentFilterResults?: unknown;

	  @doc("This indicates when the content filtering system does not run on the chat completion.")
	  ContentFilterError?: unknown;
	}

	model ChatChoice extends BaseChoice {
	  @doc("The message associated with the chat choice.")
	  Message: Message;
	}

	model ChatCompletionResponse extends BaseCompletionResponse {
	  @doc("List of choices in the chat completion response.")
	  Choices: Array<ChatChoice>;
	}

	@doc("Represents a request to create embedding.")
	model CreateEmbeddingRequest {
	  @doc("The deployment ID.")
	  deploymentId?: string;

	  @doc("The embedding request details.")
	  embeddingRequest: EmbeddingRequest;

	  @doc("The Azure OpenAI execution context.")
	  openAiExecutionContext?: AzureOpenAIExecutionContext;
	}

	model EmbeddingRequest {
	  @doc("The object to embed.")
	  Input: unknown;
	}

	model EmbeddingData {
		Embedding: Array<float32>;
		Index: int32;
		Object: string;
	}

	model EmbeddingResponse {
		Data: Array<EmbeddingData>;
		Model: string;
		Object: string;
		Usage: unknown;
	}

	@doc("Represents a request to create a chat completion.")
	model CreateCompletionRequest {
	  @doc("The deployment ID.")
	  deploymentId?: string;

	  @doc("The chat completion request details.")
	  completionRequest: CompletionRequest;

	  @doc("The Azure OpenAI execution context.")
	  openAiExecutionContext?: AzureOpenAIExecutionContext;
	}

	model CompletionRequest extends BaseCompletionRequest {
  
		Prompt: string;
	}

	model CompletionResponse extends BaseCompletionResponse {
		Choices: Array<Choice>;
	}

	model Choice extends BaseChoice {
		Text: string;
	}

	
	@doc("ECSFlightIdentity object containing properties for ECSFlight.")
	model ECSFlightIdentity {
        @doc("workspace of the ecs flight")
        workspace?: string;
        @doc("Geography of the ECSFlight.")
        geo?: string;
        @doc("GPU geograpthy of the ECSFlight")
        gpuGeo?: string;
        @doc("Region of the ECSFlight.")
        region?: string;
        @doc("Ring of the ECSFlight.")
        ring?: string;
		@doc("Name of the skillset")
		skillsetName?: string;
		@doc("Name of the skill")
		skillName?: string;
		@doc("Source of the skillset")
		source?:string;
    }

	model EcsConfigurationRequest{
		@doc("ECSFlightIdentity object containing properties for ECSFlight.")
		ecsFlightIdentity?: ECSFlightIdentity;
		@doc("Configuration root")
		configurationRoot?: string;
		defaultValue?: unknown;
	}

	model ECSFlightResponse<T>{
		eTag?: string;
		ids?: Array<string>;
		settings?: T;
	}

	model FlightEnabledRequest{
		@doc("ECSFlightIdentity object containing properties for ECSFlight.")
		ecsFlightIdentity?: ECSFlightIdentity;
		@doc("Configuration root")
		configurationRoot?: string;
		@doc("name of the flight")
		configurationParameter?: string;
	}

	// The following models are used for Dynamic Prompts controller
	model DynamicPromptsSearchRequest {
		@doc("The scenario name for the search.")
		ScenarioName: string;
		@doc("The index name for the search.")
		IndexName: string;
		@doc("The version of the index.")
		Version: string;
		@doc("The query string for the search.")
		Query: string;
		@doc("The search filter.")
		SearchFilter?: string;
		@doc("The number of top results to return.")
		TopK: int32;
		@doc("The score threshold for the search.")
		ScoreThreshold: float32;
		@doc("The number of nearest neighbors to consider.")
		KNearestNeighborsCount: int32;
	}

	
	model DynamicPromptsFilterRequest {
		@doc("The selected columns for filtering.")
		selectedColumns?: string[];
		@doc("The filter string.")
		filter?: string;
	  }
	
	model DynamicPromptsBaseRequest {
		@doc("The scenario name for the request.")
		scenarioName: string;
		@doc("The index name for the request.")
		indexName: string;
		@doc("The version of the index.")
		version: string;
	}

	model DynamicPromptsIndexFilterRequest {
		@doc("The scenario name for the index filter request.")
		scenarioName: string;
		@doc("The index name for the index filter request.")
		indexName: string;
		@doc("The version of the index.")
		version: string;
		@doc("The selected columns for filtering.")
		selectedColumns?: string[];
		@doc("The filter string.")
		filter?: string;
	}

	model DynamicPromptsSuggestedPromptsRequest {
		@doc("The skillset name for the suggested prompts request.")
		skillsetName: string;
		@doc("The skill name for the suggested prompts request.")
		skillName: string;
		@doc("The prompt string.")
		prompt: string;
		@doc("The response string.")
		response: string;
	}

	model DynamicPromptingSemanticIndexDocument {
		@doc("The document ID.")
		id: string;
		@doc("The document RowId.")
		rowId: int32;
		@doc("The document UpdatedAt.")
		updatedAt: offsetDateTime;
		@doc("The document IndexId.")
		indexId: string;
		@doc("The document Filter1.")
		filter1: string;
		@doc("The document Filter2.")
		filter2: string;
		@doc("The document Filter3.")
		filter3: string;
		@doc("The document Filter4.")
		filter4: string;
		@doc("The document Filter5.")
		filter5: string;
		@doc("The document Filter6.")
		filter6: string;
		@doc("The document Filter7.")
		filter7: string;
		@doc("The document Filter8.")
		filter8: string;
		@doc("The document Filter9.")
		filter9: string;
		@doc("The document Filter10.")
		filter10: string;
		@doc("The document Content.")
		content: string;
		@doc("The document Description.")
		description: string;
		@doc("The document Embedding array.")
		embedding: Array<float32>;
	}

	model DynamicPromptsSearchResponse {
		@doc("The search results.")
		results: ScoredDoc<DynamicPromptingSemanticIndexDocument>[];
	}

	model DynamicPromptsFilterResponse {
		@doc("The filter results.")
		results: ScoredDoc<DynamicPromptingSemanticIndexDocument>[];
	}

	model DocumentCountResponse {
		@doc("The document count.")
		count: int64;
	}

	model DynamicPromptsIndexFilterResponse {
		@doc("The index filter results.")
		results: ScoredDoc<DynamicPromptingSemanticIndexDocument>[];
	}

	model PhysicalIndexExistsResponse {
		@doc("Indicates whether the physical index exists.")
		exists: boolean;
	}

	model SuggestedPromptsResponse {
		@doc("The suggested prompts.")
		prompts: SuggestedPrompt[];
	}

	model ScoredDoc<T> {
		@doc("The score of the document.")
		score: float32;
		@doc("The document.")
		document: T;
	}

	@doc("Defines the scope of an agent instance.")
	enum AgentScope {
		None,
		User,
		Workspace
	}

	@doc("Indicates Fallback options when no skill is chosen. When it is set to null, it's configured to KnowledgeBase fallback as default option.")
	model FallbackOptions {
		Fallback?: string;
		Product?: string;
	}
}
