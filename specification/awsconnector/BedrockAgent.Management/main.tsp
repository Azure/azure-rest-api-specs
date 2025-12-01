import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-portal-core";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Azure.Portal;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Supress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service(#{ title: "Microsoft.AwsConnector" })
@doc("Microsoft.AwsConnector Resource Provider management API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AwsConnector;

/** Api versions */
enum Versions {
  /** 2025-12-01-preview api version */
  `2025-12-01-preview`,
}

//---------------------------------------------- BedrockAgents ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Bedrock Agent",
    plural: "Bedrock Agents",
  },
  keywords: ["Microsoft.AwsConnector", "Bedrock", "Agent"],
})
@doc("A Microsoft.AwsConnector resource")
model BedrockAgent is TrackedResource<BedrockAgentProperties> {
  @doc("Name of BedrockAgent")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("bedrockAgents")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BedrockAgent")
model BedrockAgentProperties {
  @doc("AWS Properties")
  awsProperties?: AwsBedrockAgentProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsBedrockAgent")
model AwsBedrockAgentProperties {
  @doc("List of ActionGroups")
  @Azure.ResourceManager.identifiers(#[])
  actionGroups?: AgentActionGroup[];

  @doc("Arn representation of the Agent.")
  agentArn?: string;

  @doc("Agent collaboration state")
  agentCollaboration?: AgentCollaboration;

  @doc("List of Agent Collaborators")
  @Azure.ResourceManager.identifiers(#[])
  agentCollaborators?: AgentCollaborator[];

  @doc("Identifier for a resource.")
  agentId?: string;

  @doc("Name for a resource.")
  agentName?: string;

  @doc("ARN of a IAM role.")
  agentResourceRoleArn?: string;

  @doc("Schema Type for Action APIs.")
  agentStatus?: AgentStatus;

  @doc("Draft Agent Version.")
  agentVersion?: string;

  @doc("Specifies whether to automatically prepare after creating or updating the agent.")
  autoPrepare?: boolean;

  @doc("Time Stamp.")
  createdAt?: string;

  @doc("Structure for custom orchestration")
  customOrchestration?: CustomOrchestration;

  @doc("A KMS key ARN")
  customerEncryptionKeyArn?: string;

  @doc("Description of the Resource.")
  description?: string;

  @doc("Failure Reasons for Error.")
  failureReasons?: string[];

  @doc("ARN or name of a Bedrock model.")
  foundationModel?: string;

  @doc("Configuration for a guardrail.")
  guardrailConfiguration?: GuardrailConfiguration;

  @doc("Max Session Time.")
  idleSessionTTLInSeconds?: int32;

  @doc("Instruction for the agent.")
  instruction?: string;

  @doc("List of Agent Knowledge Bases")
  @Azure.ResourceManager.identifiers(#[])
  knowledgeBases?: AgentKnowledgeBase[];

  @doc("Configuration for memory storage")
  memoryConfiguration?: MemoryConfiguration;

  @doc("Types of orchestration strategy for agents")
  orchestrationType?: OrchestrationType;

  @doc("Time Stamp.")
  preparedAt?: string;

  @doc("Configuration for prompt override.")
  promptOverrideConfiguration?: PromptOverrideConfiguration;

  @doc("The recommended actions users can take to resolve an error in failureReasons.")
  recommendedActions?: string[];

  @doc("Specifies whether to allow deleting agent while it is in use.")
  skipResourceInUseCheckOnDelete?: boolean;

  @doc("A map of tag keys and values")
  tags?: Record<string>;

  @doc("A map of tag keys and values")
  testAliasTags?: Record<string>;

  @doc("Time Stamp.")
  updatedAt?: string;
}

@doc("AgentCollaboration enum")
union AgentCollaboration {
  @doc("AgentCollaboration enum DISABLED")
  DISABLED: "DISABLED",

  @doc("AgentCollaboration enum SUPERVISOR")
  SUPERVISOR: "SUPERVISOR",

  @doc("AgentCollaboration enum SUPERVISOR_ROUTER")
  SUPERVISOR_ROUTER: "SUPERVISOR_ROUTER",

  string,
}

@doc("OrchestrationType enum")
union OrchestrationType {
  @doc("OrchestrationType enum CUSTOM_ORCHESTRATION")
  CUSTOM_ORCHESTRATION: "CUSTOM_ORCHESTRATION",

  @doc("OrchestrationType enum DEFAULT")
  DEFAULT: "DEFAULT",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AgentActionGroup")
model AgentActionGroup {
  @doc("Type of Executors for an Action Group")
  actionGroupExecutor?: ActionGroupExecutor;

  @doc("Name of the action group")
  actionGroupName?: string;

  @doc("State of the action group")
  actionGroupState?: ActionGroupState;

  @doc("Contains information about the API Schema for the Action Group")
  apiSchema?: APISchema;

  @doc("Description of action group")
  description?: string;

  @doc("Schema of Functions")
  functionSchema?: FunctionSchema;

  @doc("Action Group Signature for a BuiltIn Action")
  parentActionGroupSignature?: ActionGroupSignature;

  @doc("Specifies whether to allow deleting action group while it is in use.")
  skipResourceInUseCheckOnDelete?: boolean;
}

@doc("AgentStatus enum")
union AgentStatus {
  @doc("AgentStatus enum CREATING")
  CREATING: "CREATING",

  @doc("AgentStatus enum DELETING")
  DELETING: "DELETING",

  @doc("AgentStatus enum FAILED")
  FAILED: "FAILED",

  @doc("AgentStatus enum NOT_PREPARED")
  NOT_PREPARED: "NOT_PREPARED",

  @doc("AgentStatus enum PREPARED")
  PREPARED: "PREPARED",

  @doc("AgentStatus enum PREPARING")
  PREPARING: "PREPARING",

  @doc("AgentStatus enum UPDATING")
  UPDATING: "UPDATING",

  @doc("AgentStatus enum VERSIONING")
  VERSIONING: "VERSIONING",

  string,
}

@doc("ActionGroupSignature enum")
union ActionGroupSignature {
  @doc("ActionGroupSignature enum AMAZON.CodeInterpreter")
  AMAZONCodeInterpreter: "AMAZON.CodeInterpreter",

  @doc("ActionGroupSignature enum AMAZON.UserInput")
  AMAZONUserInput: "AMAZON.UserInput",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AgentCollaborator")
model AgentCollaborator {
  @doc("Agent descriptor for agent collaborator")
  agentDescriptor?: AgentDescriptorModelProperties;

  @doc("Agent collaborator instruction")
  collaborationInstruction?: string;

  @doc("Agent collaborator name")
  collaboratorName?: string;

  @doc("Relay conversation history state")
  relayConversationHistory?: RelayConversationHistory;
}

@doc("ActionGroupState enum")
union ActionGroupState {
  @doc("ActionGroupState enum DISABLED")
  DISABLED: "DISABLED",

  @doc("ActionGroupState enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CustomOrchestration")
model CustomOrchestration {
  @doc("Types of executors for custom orchestration strategy")
  executor?: OrchestrationExecutor;
}

@doc("RelayConversationHistory enum")
union RelayConversationHistory {
  @doc("RelayConversationHistory enum DISABLED")
  DISABLED: "DISABLED",

  @doc("RelayConversationHistory enum TO_COLLABORATOR")
  TO_COLLABORATOR: "TO_COLLABORATOR",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of GuardrailConfiguration")
model GuardrailConfiguration {
  @doc("Identifier for the guardrail, could be the id or the arn")
  guardrailIdentifier?: string;

  @doc("Version of the guardrail")
  guardrailVersion?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AgentKnowledgeBase")
model AgentKnowledgeBase {
  @doc("Description of the Resource.")
  description?: string;

  @doc("Identifier for a resource.")
  knowledgeBaseId?: string;

  @doc("State of the knowledge base; whether it is enabled or disabled")
  knowledgeBaseState?: KnowledgeBaseState;
}

@doc("KnowledgeBaseState enum")
union KnowledgeBaseState {
  @doc("KnowledgeBaseState enum DISABLED")
  DISABLED: "DISABLED",

  @doc("KnowledgeBaseState enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MemoryConfiguration")
model MemoryConfiguration {
  @doc("Types of session storage persisted in memory")
  enabledMemoryTypes?: string[];

  @doc("Configuration for Session Summarization")
  sessionSummaryConfiguration?: SessionSummaryConfiguration;

  @doc("Maximum number of days to store session details")
  storageDays?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PromptOverrideConfiguration")
model PromptOverrideConfiguration {
  @doc("ARN of a Lambda.")
  overrideLambda?: string;

  @doc("List of BasePromptConfiguration")
  @Azure.ResourceManager.identifiers(#[])
  promptConfigurations?: PromptConfiguration[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ActionGroupExecutor")
model ActionGroupExecutor {
  @doc("ARN of a Lambda.")
  lambda?: string;

  @doc("Custom control of action execution")
  customControl?: CustomControlMethod;
}

@doc("CustomControlMethod enum")
union CustomControlMethod {
  @doc("CustomControlMethod enum RETURN_CONTROL")
  RETURN_CONTROL: "RETURN_CONTROL",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of APISchema")
model APISchema {
  @doc("The identifier for the S3 resource.")
  s3?: S3Identifier;

  @doc("String OpenAPI Payload")
  payload?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FunctionSchema")
model FunctionSchema {
  @doc("List of Function definitions")
  @Azure.ResourceManager.identifiers(#[])
  functions?: Function[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AgentDescriptorModelProperties")
model AgentDescriptorModelProperties {
  @doc("Alias ARN for agent descriptor")
  aliasArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OrchestrationExecutor")
model OrchestrationExecutor {
  @doc("ARN of a Lambda.")
  lambda?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SessionSummaryConfiguration")
model SessionSummaryConfiguration {
  @doc("Maximum number of Sessions to Summarize")
  maxRecentSessions?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PromptConfiguration")
model PromptConfiguration {
  @doc("Additional Model Request Fields for Prompt Configuration")
  additionalModelRequestFields?: unknown;

  @doc("Base Prompt Template.")
  basePromptTemplate?: string;

  @doc("ARN or name of a Bedrock model.")
  foundationModel?: string;

  @doc("Configuration for inference in prompt configuration")
  inferenceConfiguration?: InferenceConfiguration;

  @doc("Creation Mode for Prompt Configuration.")
  parserMode?: CreationMode;

  @doc("Creation Mode for Prompt Configuration.")
  promptCreationMode?: CreationMode;

  @doc("Prompt State.")
  promptState?: PromptState;

  @doc("Prompt Type.")
  promptType?: PromptType;
}

@doc("CreationMode enum")
union CreationMode {
  @doc("CreationMode enum DEFAULT")
  DEFAULT: "DEFAULT",

  @doc("CreationMode enum OVERRIDDEN")
  OVERRIDDEN: "OVERRIDDEN",

  string,
}

@doc("PromptState enum")
union PromptState {
  @doc("PromptState enum DISABLED")
  DISABLED: "DISABLED",

  @doc("PromptState enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of S3Identifier")
model S3Identifier {
  @doc("A bucket in S3.")
  s3BucketName?: string;

  @doc("A object key in S3.")
  @secret
  s3ObjectKey?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Function")
model Function {
  @doc("Description of function")
  description?: string;

  @doc("Name for a resource.")
  name?: string;

  @doc("A map of parameter name and detail")
  parameters?: Record<ParameterDetail>;

  @doc("ENUM to check if action requires user confirmation")
  requireConfirmation?: RequireConfirmation;
}

@doc("PromptType enum")
union PromptType {
  @doc("PromptType enum KNOWLEDGE_BASE_RESPONSE_GENERATION")
  KNOWLEDGE_BASE_RESPONSE_GENERATION: "KNOWLEDGE_BASE_RESPONSE_GENERATION",

  @doc("PromptType enum MEMORY_SUMMARIZATION")
  MEMORY_SUMMARIZATION: "MEMORY_SUMMARIZATION",

  @doc("PromptType enum ORCHESTRATION")
  ORCHESTRATION: "ORCHESTRATION",

  @doc("PromptType enum POST_PROCESSING")
  POST_PROCESSING: "POST_PROCESSING",

  @doc("PromptType enum PRE_PROCESSING")
  PRE_PROCESSING: "PRE_PROCESSING",

  @doc("PromptType enum ROUTING_CLASSIFIER")
  ROUTING_CLASSIFIER: "ROUTING_CLASSIFIER",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InferenceConfiguration")
model InferenceConfiguration {
  @doc("Maximum length of output")
  maximumLength?: int32;

  @doc("List of stop sequences")
  stopSequences?: string[];

  @doc("Controls randomness, higher values increase diversity")
  temperature?: int32;

  @doc("Sample from the k most likely next tokens")
  topK?: int32;

  @doc("Cumulative probability cutoff for token selection")
  topP?: int32;
}

@doc("RequireConfirmation enum")
union RequireConfirmation {
  @doc("RequireConfirmation enum DISABLED")
  DISABLED: "DISABLED",

  @doc("RequireConfirmation enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ParameterDetail")
model ParameterDetail {
  @doc("Description of function parameter.")
  description?: string;

  @doc("Information about if a parameter is required for function call. Default to false.")
  required?: boolean;

  @doc("Parameter Type")
  type?: Type;
}

@doc("Type enum")
union Type {
  @doc("Type enum array")
  array: "array",

  @doc("Type enum boolean")
  boolean: "boolean",

  @doc("Type enum integer")
  integer: "integer",

  @doc("Type enum number")
  number: "number",

  @doc("Type enum string")
  string: "string",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface BedrockAgents {
  get is ArmResourceRead<BedrockAgent>;
  @doc("Create a BedrockAgent. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<BedrockAgent>;
  update is ArmCustomPatchAsync<
    BedrockAgent,
    Azure.ResourceManager.Foundations.TagsUpdateModel<BedrockAgent>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<BedrockAgent>;
  listByResourceGroup is ArmResourceListByParent<BedrockAgent>;
  listBySubscription is ArmListBySubscription<BedrockAgent>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Bedrock::Agent
//--------------------------------------------------------------------------------------------
