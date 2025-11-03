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
		startTime: utcDateTime;

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

		@doc("ID of the agent")
		agentId: string;

		@doc("Agent scope")
		agentScope: AgentScope;

		@doc("The agent trigger name identified for each agent evaluation execution")
		selectedAgentTrigger: string;

		@doc("Indicates Fallback options when no skill is chosen.")
		fallbackOptions?: FallbackOptions;

		@doc("Represents the number of prompt executions that have occurred.")
		evaluationExecutionCount: uint32;

		@doc("Actual Fidelis workspace ID. This workspace ID is a GUID generated and provided by Fidelis.")
		actualWorkspaceId: string;
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

	alias SkillVariableCollection = Record<SkillVariable>;

	// @doc("A collection of skill variables")
	// model SkillVariableCollection extends Record<SkillVariable>{
	// }

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
		sessionId: string;

		@doc("The prompt id.")
		promptId: string;

		@doc("The evaluation id.")
		evaluationId: string;

		@doc("The tenant id.")
		tenantId: string;

		@doc("The account id.")
		accountId: string;

		@doc("The workspace id.")
		workspaceId: string;

		@doc("The display name of the user.")
		userName: string;

		@doc("The Application Id that created the Session.")
		applicationId?: string;

		@doc("The Source tag i.e. 'immersive'.")
		source: string;

		@doc("The source application ID.")
		unauthenticatedSourceApplicationId: string;

		@doc("The selected skills.")
		selectedSkills: string;

		@doc("The skillsets identified for execution during the evaluation process post skill selection.")
		selectedSkillsets: Array<string>;

		@doc("Indicates whether the context is for a user onboarded to Fidelis.")
		isFidelisUser: boolean;

		@doc("Indicates whether the evaluation is manually generated or user driven.")
		invocationType: EvaluationInvocationType;

		@doc("Indicates whether the evaluation is from a Prompt or a Promptbook")
		invocationCategory: EvaluationInvocationCategory;

		@doc("Compliance flags for logging.")
		complianceFlags: ComplianceFlags;

		@doc("Contains the context for the Azure OpenAI requests such as the deployment id.")
		azureOpenAIExecutionContext: AzureOpenAIExecutionContext;

		@doc("Preview state of the execution context.")
		previewState: SkillPreviewState;

		@doc("ID of the agent")
		agentId: string;

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
		evaluationStartTime: offsetDateTime;

		@doc("The time when the prompt for the evaluation was created, except for during retries")
		evaluationPromptCreationStartedAt: offsetDateTime;

		@doc("The time when the evaluation starts running after waiting in the processing queue.")
		evaluationRunStartedAt: offsetDateTime;

		@doc("A snapshot of requests for sleeping attached to the evaluation in this context.")
		sleepRequests?: Record<duration>;

		@doc("Represents the amount of time the current prompt would like to sleep.")
		promptSleepDuration?: duration;

		@doc("Represents the number of prompt executions that have occurred.")
		evaluationExecutionCount: uint32;

		@doc("Determines the node visibility in the end user node map.")
		hideEvaluationNode: boolean;

		@doc("Is agent trial condition met")
		isAgentTrialConditionMet: boolean;
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
		@doc("")
		structuredContent?: EvaluationStepLogStructuredContent;

		@doc("Log level")
		level?: ProgressLogLevel;

		@doc("Log message")
		message?: string;

		@doc("It holds the current state of the evaluation step for step logging")
		evaluationStepCurrentState?: EvaluationStepCurrentState;
	}

	@doc("Evaluation Step Current State")
	model EvaluationStepCurrentState {
	  @doc("The current evaluation log ID.")
	  currentEvaluationLogId?: string;

	  @doc("Indicates if the step is running.")
	  isStepRunning?: boolean;

	  @doc("Parallel evaluation steps keyed by step name.")
	  parallelEvaluationSteps: Record<EvaluationStepInfo>;

	  @doc("Progress logs keyed by log name.")
	  progressLogs: Record<string>;
	}

	@doc("Evaluation Step Info")
	model EvaluationStepInfo {
	  @doc("Indicates if the step is running.")
	  isRunning: boolean;

	  @doc("The evaluation step ID.")
	  evalutionStepid: string;

	  @doc("The evaluation log ID.")
	  evaluationLogid: string;
	}

	@doc("")
	model EvaluationStepLogStructuredContent {
		@doc("Title of the log step")
		title: string;
		@doc("")
		summaryContent: string;
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
		skillSource: SkillSource;
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

	@doc("Request model for creating new memory")
	model CreateMemoryRequest extends BaseMemoryRequest{
		@doc("Content")
		content: string;

		@doc("Name")
		name: string;

		@doc("Category")
		category: string;

		@doc("AssociatedFeedbackContent")
		associatedFeedbackContent?: string;

		@doc("AssociatedFeedbackProperties")
		associatedFeedbackProperties?: Record<string>;

		@doc("Properties")
		properties?: Record<string>;

		@doc("AssociatedFeedbackMetadata")
		associatedFeedbackMetadata?: FeedbackMetadata;

		@doc("Tags")
		tags?: string[];

		@doc("Metadata")
		metadata?: MemoryMetadataRequestOptions;

		@doc("SummarizationOptions")
		summarizationOptions?: MemorySummarizationRequestOptions;

		@doc("EmbeddingOptions")
		embeddingOptions?: MemoryEmbeddingRequestOptions;

		@doc("Type")
		type: MemoryType;

		@doc("EmbeddingTarget")
		embeddingTarget?: MemoryEmbeddingTarget;

		@doc("ActivationMode")
		activationMode?: MemoryActivationRequirementsMode;
	}

	@doc("")
	model UpdateMemoryRequestWithId extends UpdateMemoryRequest {
		@doc("MemoryId")
		memoryId: string;
	}

	@doc("UpdateMemoryRequest")
	model UpdateMemoryRequest extends BaseMemoryRequest {
		@doc("Content")
		content: string;

		@doc("SummarizedContent")
		summarizedContent: string;

		@doc("Category")
		category: string;

		@doc("Name")
		name: string;

		@doc("AssociatedFeedbackContent")
		associatedFeedbackContent?: string;

		@doc("Properties")
		properties?: Record<string>;

		@doc("AssociatedFeedbackProperties")
		associatedFeedbackProperties?: Record<string>;

		@doc("AssociatedFeedbackMetadata")
		associatedFeedbackMetadata?: FeedbackMetadata;

		@doc("Tags")
		tags?: string[];

		@doc("State")
		state?: MemoryState;
	}

	@doc("QueryMemoriesRequest")
	model QueryMemoriesRequest {
		@doc("")
		subScopeId?: string;
		@doc("")
		scope?: MemoryScope;
		@doc("")
		subScope?: MemorySubScope;
		@doc("")
		categoryFilter?: string;
		@doc("")
		createdByFilter?: string;
		@doc("")
		continuationToken?: string;
		@doc("")
		createdAtStartTime?: offsetDateTime;
		@doc("")
		createdAtEndTime?: offsetDateTime;
		@doc("")
		typeFilter?: MemoryType;
		@doc("")
		nameFilter?: string;
		@doc("")
		matchingTagsFilter?: Record<string>;
		@doc("Indicates whether to include only Active memories in the response")
		includeOnlyActive: boolean;
		limit: int32;
	}

	@doc("SearchMemoriesRequest")
	model SearchMemoriesRequest extends BaseMemoryRequest {
		query: string;
		type?: MemoryType;
		name: string;
		category: string;
		tags?: string[];
		includeOnlyActive: boolean;
	}

	@doc("MemoryState")
	enum MemoryState {
		@doc("Unknown")
		Unknown: "Unknown",

		@doc("Active")
		Active: "Active",

		@doc("Created")
		Created: "Created",

		@doc("Processing")
		Processing: "Processing",

		@doc("Disabled")
		Disabled: "Disabled",

		@doc("Deleted")
		Deleted: "Deleted",

		@doc("FailedSubProcessing")
		FailedSubProcessing: "FailedSubProcessing",
	}

	@doc("BaseMemoryRequest")
	model BaseMemoryRequest {
		@doc("SubScopeId")
		subScopeId: string;

		@doc("Scope")
		scope: MemoryScope;

		@doc("SubScope")
		subScope?: MemorySubScope;
	}

	@doc("MemoryScope")
	enum MemoryScope {
		@doc("Unknown")
		Unknown: "Unknown",

		@doc("Session")
		Session: "Session",

		@doc("User")
		User: "User",

		@doc("Workspace")
		Workspace: "Workspace",
	}

	@doc("MemorySubScope")
	enum MemorySubScope {
		@doc("Unknown")
		Unknown: "Unknown",

		@doc("Skillset")
		Skillset: "Skillset",

		@doc("Skill")
		Skill: "Skill",

		@doc("Agent")
		Agent: "Agent",
	}

	@doc("FeedbackMetadata")
	model FeedbackMetadata {
		@doc("FeedbackSessionId")
		feedbackSessionId: string;

		@doc("FeedbackPromptId")
		feedbackPromptId: string;

		@doc("FeedbackEvaluationId")
		feedbackEvaluationId: string;

		@doc("FeedbackTargetSessionId")
		feedbackTargetSessionId: string;

		@doc("FeedbackTargetPromptId")
		feedbackTargetPromptId: string;

		@doc("FeedbackTargetEvaluationId")
		feedbackTargetEvaluationId: string;
	}

	@doc("MemoryMetadataRequestOptions")
	model MemoryMetadataRequestOptions {
		@doc("AdditionalInformation")
		additionalInformation?: Record<string>;

		@doc("InternalInformation")
		internalInformation?: Record<string>;
	}

	@doc("MemorySummarizationRequestOptions")
	model MemorySummarizationRequestOptions {
		@doc("SummarizationEnabled")
		summarizationEnabled: boolean;
	}

	@doc("MemoryEmbeddingRequestOptions")
	model MemoryEmbeddingRequestOptions {
		@doc("EmbeddingEnabled")
		embeddingEnabled: boolean;
	}


	@doc("MemoryEmbeddingTarget")
	enum MemoryEmbeddingTarget {
		@doc("Unknown")
		Unknown: "Unknown",

		@doc("Value")
		Value: "Value",

		@doc("SummarizedValue")
		SummarizedValue: "SummarizedValue",
	}

	@doc("MemoryActivationRequirementsMode")
	enum MemoryActivationRequirementsMode {
		@doc("Unknown")
		Unknown: "Unknown",

		@doc("None")
		None: "None",

		@doc("AllOperations")
		AllOperations: "AllOperations",

		@doc("AnyOperation")
		AnyOperation: "AnyOperation",

		@doc("EmbeddingsRequired")
		EmbeddingsRequired: "EmbeddingsRequired",

		@doc("SummarizationRequired")
		SummarizationRequired: "SummarizationRequired",
	}

	@doc("MemoryDtoResponse")
	model MemoryDtoResponse {
		id: string;
		metadata: MemoryMetadataDto;
		scope: MemoryScope;
		scopeId: string;
		subScope?: MemorySubScope;
		subScopeId: string;
		createdAt: utcDateTime;
		updatedAt: utcDateTime;
		lastUpdatedBy: string;
		state: MemoryState;
		content: string;
		name: string;
		category: string;
		associatedFeedbackContent: string;
		associatedFeedbackProperties: Record<string>;
		properties: Record<string>;
		associatedFeedbackMetadata: FeedbackMetadata;
		activationMode: MemoryActivationRequirementsMode;
		tags: string[];
		additionalContent: AdditionalMemoryContent;
		summarizationOptions: MemorySummarizationOptionsDto;
		embeddingOptions: MemoryEmbeddingOptionsDto;
		type: MemoryType;
	}

	@doc("Page of MemoryDtoResponse items with optional continuation token for pagination.")
	model MemoryDtoResponsePage {
		@doc("List of MemoryDtoResponse.")
		values: Array<MemoryDtoResponse>;

		@doc("Continuation token for pagination.")
		continuationToken?: string;
	}

	model MemoryMetadataDto {
		userId: string;
		tenantId: string;
		accountId: string;
		workspaceId: string;
		additionalInformation: Record<string>;
	}

	model AdditionalMemoryContent {
		summarizedValue: string;
		originalFeedbackValue: string;
		originalFeedbackProperties: Record<string>;
	}

	model MemorySummarizationOptionsDto {
		summarizationEnabled: boolean;
		summarizationState: MemorySummarizationState;
	}

	model MemoryEmbeddingOptionsDto {
		embeddingEnabled: boolean;
		embeddingState: MemoryEmbeddingState;
	}

	enum MemorySummarizationState {
		Unknown: "Unknown",
		NotSummarized: "NotSummarized",
		Processing: "Processing",
		Summarized: "Summarized",
		FailedToSummarize: "FailedToSummarize",
	}

	enum MemoryEmbeddingState {
		Unknown: "Unknown",
		NotEmbedded: "NotEmbedded",
		Processing: "Processing",
		Embedded: "Embedded",
		FailedToEmbed: "FailedToEmbed",
	}

	enum MemoryType {
		Unknown: "Unknown",
		Semantic: "Semantic",
		Episodic: "Episodic",
	}

	@doc("")
	model ChildEvaluationRequest {
		promptId: string;
		promptType: PromptType;
		evaluationType: EvaluationType;
		skillsetName: string;
		skillName: string;
		hideNode: boolean;
		content: string;
		inputs: SkillVariableCollection;
		parallelExecutionIndex: int32;
		afterPromptId: string;
	}

	@doc("")
	enum EvaluationType {
		`unknown`,
		normal,
		waitForInput,
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
	  messages: Array<Message>;

	  @doc("The functions associated with the request.")
	  functions: Array<GPTFunction>;

	  @doc("Specifies the function to call.")
	  functionCall: string;

	  @doc("The tools available for this request.")
	  tools?: Array<Tools>;

	  @doc("The selected tool for execution.")
	  toolChoice?: string;

	  @doc("Indicates whether tools can be called in parallel.")
	  parallelToolCalls?: boolean;
	}

	@doc("Represents the base completion request with common parameters.")
	model BaseCompletionRequest {
	  @doc("The maximum number of tokens to generate.")
	  maxTokens?: int32;

	  @doc("The sampling temperature to use.")
	  temperature?: float64;

	  @doc("The nucleus sampling parameter.")
	  topP?: float64;

	  @doc("The number of completions to generate.")
	  n?: int32;

	  @doc("Specifies whether to stream the response.")
	  stream?: boolean;

	  @doc("The number of log probabilities to include.")
	  logprobs?: int32;

	  @doc("Whether to include the prompt in the output.")
	  echo?: boolean;

	  @doc("Stop sequences to terminate generation.")
	  stop: Array<string>;

	  @doc("The penalty for repeating words in the presence.")
	  presencePenalty?: float64;

	  @doc("The penalty for repeating tokens.")
	  frequencyPenalty?: float64;

	  @doc("The number of completions to choose the best from.")
	  bestOf?: int32;

	  @doc("Adjusts likelihood of specific tokens.")
	  logitBias: Record<int32>;

	  @doc("The response format specification.")
	  responseFormat: unknown;
	}

	@doc("Represents a message in the chat.")
	model Message {
	  @doc("The content of the message.")
	  content?: string;

	  @doc("The role of the message sender.")
	  role: string;

	  @doc("The name of the message sender.")
	  name?: string;

	  @doc("The function call information.")
	  functionCall?: FunctionCall;

	  @doc("The tool calls associated with the message.")
	  toolCalls?: Array<ToolCall>;

	  @doc("The identifier for the tool call.")
	  toolCallId?: string;
	}

	@doc("Represents a function call.")
	model FunctionCall {
	  @doc("The name of the function.")
	  name: string;

	  @doc("The arguments passed to the function.")
	  arguments?: Record<string>;
	}

	@doc("Represents a tool call.")
	model ToolCall {
	  @doc("The id of the tool call.")
	  id: string;

	  @doc("The type of the tool call.")
	  type: string;

	  @doc("The function for the tool call.")
	  function: ToolFunctionCall;
	}

	@doc("Represents a tool function call.")
	model ToolFunctionCall {
	  @doc("The name of the tool function.")
	  name: string;

	  @doc("The arguments for the tool function.")
	  arguments: string;
	}

	@doc("Represents a GPT function definition.")
	model GPTFunction {
	  @doc("The name of the GPT function.")
	  name: string;

	  @doc("The description of the GPT function.")
	  description: string;

	  @doc("The parameters required by the GPT function.")
	  parameters: FunctionParameter;

	  @doc("The result of the GPT function.")
	  result: FunctionResult;
	}

	@doc("Represents parameters for a function.")
	model FunctionParameter {
	  @doc("The type of the parameter.")
	  type: string;

	  @doc("The properties of the parameter.")
	  properties: Record<FunctionParameterProperty>;

	  @doc("The list of required properties.")
	  required: Array<string>;
	}

	@doc("Represents parameters properties for a function.")
	model FunctionParameterProperty {
	  @doc("The type of the parameter property.")
	  type: string;

	  @doc("The description of property of the parameter.")
	  description: string;

	  @doc("The list of enums.")
	  `enum`: Array<string>;
	}

	@doc("Represents the result of a function.")
	model FunctionResult {
	  @doc("The type of the result.")
	  type: string;
	}

	@doc("Represents a tool.")
	model Tools {
	  @doc("The type of the tool.")
	  type: string;

	  @doc("The function definition for the tool.")
	  function: FunctionDefinition;
	}

	@doc("Represents the definition of a function.")
	model FunctionDefinition {
	  @doc("The description of the function.")
	  description: string;

	  @doc("The name of the function.")
	  name: string;

	  @doc("The parameters for the function.")
	  parameters: unknown;
	}

	@doc("Represents the Azure OpenAI execution context.")
	model AzureOpenAIExecutionContext {
	  @doc("The API version.")
	  apiVersion: string = "2024-06-01";

	  @doc("The environment where the request is being made.")
	  environment: string;

	  @doc("Determines if the GPU proxy is enabled.")
	  isGPUProxyEnabled: boolean = false;

	  @doc("The geographic location where the GPU processing is being done.")
	  gpuProcessingGeo?: string;

	  @doc("Whether the customer allows cross-geo compute in their workspace capacity.")
	  customerAllowCrossGeoCompute: boolean = false;

	  @doc("ECS controlled flag to allow cross-geo compute.")
	  ecsAllowCrossGeoCompute: boolean = false;

	  @doc("Properties used to add content prompt and content filter details from the response.")
	  contentFilterProperties?: Record<string>;

	  @doc("Properties used to report information about the skill invocation. Must not contain customer content.")
	  reportingProperties?: Record<string>;
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
	  id: string;

	  @doc("The object type.")
	  object: string;

	  @doc("The creation timestamp.")
	  created: utcDateTime;

	  @doc("The model used for completion.")
	  `model`: string;

	  @doc("The usage statistics for the response.")
	  usage: unknown;

	  @doc("The results of prompt filtering.")
	  promptFilterResults: Array<unknown>;
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
	  url: string;

	  @doc("The license of the cited content.")
	  license: string;
	}

	model BaseChoice {
	  index: int32;
	  @doc("Log probabilities for this choice.")
	  logProbs: unknown;

	  @doc("The reason why the operation finished.")
	  finishReason: string;

	  @doc("This object contains the list of content filter annotations.")
	  contentFilterResults?: unknown;

	  @doc("This indicates when the content filtering system does not run on the chat completion.")
	  contentFilterError?: unknown;
	}

	model ChatChoice extends BaseChoice {
	  @doc("The message associated with the chat choice.")
	  message: Message;
	}

	model ChatCompletionResponse extends BaseCompletionResponse {
	  @doc("List of choices in the chat completion response.")
	  choices: Array<ChatChoice>;
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
	  input: unknown;
	}

	model EmbeddingData {
		Embedding: Array<float32>;
		Index: int32;
		Object: string;
	}

	model EmbeddingResponse {
		data: Array<EmbeddingData>;
		`model`: string;
		object: string;
		usage: unknown;
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
  
		prompt: string;
	}

	model CompletionResponse extends BaseCompletionResponse {
		choices: Array<Choice>;
	}

	model Choice extends BaseChoice {
		text: string;
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
		scenarioName: string;
		@doc("The index name for the search.")
		indexName: string;
		@doc("The version of the index.")
		version: string;
		@doc("The query string for the search.")
		query: string;
		@doc("The search filter.")
		searchFilter?: string;
		@doc("The number of top results to return.")
		topK: int32;
		@doc("The score threshold for the search.")
		scoreThreshold: float32;
		@doc("The number of nearest neighbors to consider.")
		kNearestNeighborsCount: int32;
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
		fallback?: string;
		product?: string;
	}

	@doc("Define Error Response Types From Pluginhost")
	enum PluginhostErrorType {
		DataAccessNotAuthorizedException,
		SkillException,
		UserException,
		PlatformException,
		Exception
	}

	@doc("Class of type ErrorResponse. This is used to return error messages from pluginhost.")
	model PluginhostErrorResponse {
		@doc("The error message.")
		message: string;
		@doc("The error type.")
		type: PluginhostErrorType;
		@doc("The error code.")
		errorCode: string;
		@doc("The error details.")
		errorDetails: string;
	}

	@doc("Scoping options for skill cache. All cached entries are default scope to User ID. Tenant Id is not supported as User ID is already tenant-scoped")
	enum SkillUtilityCacheScope {
		@doc("Skillset scope: accessible across skills within a skillset.")
		Skillset,
		@doc("Skill scope: accessible only within a given skill.")
		Skill,
		@doc("Session scope: accessible only within a given session.")
		Session,
		@doc("Workspace scope: accessible within a given workspace.")
		Workspace
	}

	@doc("Data type for what's being stored in skill utility cache.")
	enum SkillUtilityCacheDataType {
		@doc("Default unknown to catch places where this enum isn't set.")
		Unknown: 0,
		@doc("Normal data type: anything can be stored, including customer content.")
		Normal: 1,
		@doc("Internal metadata type: only internal metadata that doesn't contain customer content.")
		InternalMetadata: 2
	}

	model CachedEntity<T> {
		@doc("The cached entity.")
		cachedEntity: T;
	}

	@doc("Request model for setting cached entity")
	model SetCachedEntityRequest {
		@doc("Entity to cache")
		entity: CachedEntity<unknown>;

		@doc("Optional suffix to make cache key unique; if not specified, entity type is used as the suffix")
		cacheKeySuffix?: string;

		@doc("Scopes to limit the cache entry to (scoped to user already by default)")
		scopes?: Record<SkillUtilityCacheScope>;

		@doc("Time to live for the cache entry")
		ttl?: duration;

		@doc("Type of data to be stored in the cache")
		dataType: SkillUtilityCacheDataType;
	}

	@doc("Response model for setting cached entity")
	model SetCachedEntityDtoResponse {
		@doc("Indicates whether the cache entry was successfully set.")
		Success: boolean;
	}

	@doc("Defines the state of debugging through local PluginHost")
	enum LocalPluginHostDebugState {
		None,
		Running,
		Completed,
		Error,
	}

	@doc("Represents an arbitrary JSON object (maps to Dictionary<string, object> in C#).")
	model JsonObject {
	  @indexer
	  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Intentionally allowing any object value"
	  [key: string]: unknown;
	}

	@doc("Request model TeamsNotificationInputs")
	model TeamsNotificationInputs {
		@doc("The ID of the recipient for the Teams notification, which is an Entra ID.")
		recipientId: string;

		@doc("The ID of the agent sending the notification, which is an Entra ID.")
		tenantId: string;

		@doc("The ID of the agent sending the notification.")
		agentId: string;

		@doc("The Bot ID of the Azure Bot registered by INS as part of onboarding your Teams agent with INS. Defaults to test bot ID if not specified. For production, use your registered bot ID.")
		botId?: string;

		@doc("The template ID for the Teams notification, which can be used to specify a predefined message format. Defaults to test template ID if not specified. For production, use your registered template ID.")
		templateId?: string;

		@doc("The subject of the Teams notification.")
		subject?: string;

		@doc("The locale for the Teams notification, defaulting to 'en-US'.")
		locale?: string;

		@doc("A dictionary of options for the Teams notification, such as custom properties or additional settings.")
		options?: Record<string>;

		@doc("Description of the notification, which can be used to provide additional context or information for querying or logging purposes.")
		description?: string;

		@doc("Other parameters in selected template.")
		parameters?: JsonObject | null;
	}

	@doc("Represents a notification including destinations, locale and template mapping settings.")
	model NotificationRequest {
		@doc("The destinations for this notification.")
		destinations: Array<Destination>;
		
		@doc("The deduplication identifier.")
		deduplicationId: string;

		@doc("Identifier of the template used for this notification.")
		templateId: string;

		@doc("Indicates whether tenant parameter-mapping rules apply.")
		mapParametersToTemplateUsingTenantSettings: boolean;

		@doc("Locale string.")
		locale: string;

		@doc("Dictionary holding all parameters (subject, mailbox, etc.).")
		parameters: Record<unknown>;

		@doc("Identifier of the agent sending this notification.")
		agentId: string;

		@doc("Bot ID of the Azure Bot registered by INS for the Teams agent.")
		botId: string;
	}

	@doc("Represents a destination for a notification (e.g., Email, EntraId).")
	model Destination {
		@doc("Unique identifier for this destination.")
		id: string;

		@doc("Type string for this destination (e.g., 'Email').")
		type: string;
	}
}