import "@typespec/rest";
import "@typespec/http";
import "../SharedModels.tsp";
import "../SharedEnums.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace SkillContext;

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

  @doc("Enum indicating the output type of the skill. Supports StructuredOutput and Primitive")
  outputType: SkillOutputType;
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
  source: SkillSource;
}