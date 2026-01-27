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

//---------------------------------------------- BedrockPrompts ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Bedrock Prompt",
    plural: "Bedrock Prompts",
  },
  keywords: ["Microsoft.AwsConnector", "Bedrock", "Prompt"],
})
@doc("A Microsoft.AwsConnector resource")
model BedrockPrompt is TrackedResource<BedrockPromptProperties> {
  @doc("Name of BedrockPrompt")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("bedrockPrompts")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BedrockPrompt")
model BedrockPromptProperties {
  @doc("AWS Properties")
  awsProperties?: AwsBedrockPromptProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsBedrockPrompt")
model AwsBedrockPromptProperties {
  @doc("ARN of a prompt resource possibly with a version")
  arn?: string;

  @doc("Time Stamp.")
  createdAt?: string;

  @doc("A KMS key ARN")
  customerEncryptionKeyArn?: string;

  @doc("Name for a variant.")
  defaultVariant?: string;

  @doc("Name for a prompt resource.")
  description?: string;

  @doc("Identifier for a Prompt")
  id?: string;

  @doc("Name for a prompt resource.")
  name?: string;

  @doc("A map of tag keys and values")
  tags?: Record<string>;

  @doc("Time Stamp.")
  updatedAt?: string;

  @doc("List of prompt variants")
  @Azure.ResourceManager.identifiers(#[])
  variants?: PromptVariant[];

  @doc("Draft Version.")
  version?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PromptVariant")
model PromptVariant {
  @doc("Contains model-specific configurations")
  additionalModelRequestFields?: unknown;

  @doc("Target resource to invoke with Prompt")
  genAiResource?: PromptGenAiResource;

  @doc("Model inference configuration")
  inferenceConfiguration?: PromptInferenceConfiguration;

  @doc("List of metadata to associate with the prompt variant.")
  @Azure.ResourceManager.identifiers(#[])
  metadata?: PromptMetadataEntry[];

  @doc("ARN or Id of a Bedrock Foundational Model or Inference Profile, or the ARN of a imported model, or a provisioned throughput ARN for custom models.")
  modelId?: string;

  @doc("Name for a variant.")
  name?: string;

  @doc("Prompt template configuration")
  templateConfiguration?: PromptTemplateConfiguration;

  @doc("Prompt template type")
  templateType?: PromptVariantTemplateType;
}

@doc("PromptVariantTemplateType enum")
union PromptVariantTemplateType {
  @doc("PromptVariantTemplateType enum CHAT")
  CHAT: "CHAT",

  @doc("PromptVariantTemplateType enum TEXT")
  TEXT: "TEXT",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PromptGenAiResource")
model PromptGenAiResource {
  @doc("Target Agent to invoke with Prompt")
  agent?: PromptAgentResource;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PromptInferenceConfiguration")
model PromptInferenceConfiguration {
  @doc("Prompt model inference configuration")
  text?: PromptModelInferenceConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PromptMetadataEntry")
model PromptMetadataEntry {
  @doc("The key of a metadata tag for a prompt variant.")
  @secret
  key?: string;

  @doc("The value of a metadata tag for a prompt variant.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PromptTemplateConfiguration")
model PromptTemplateConfiguration {
  @doc("Configuration for text prompt template")
  text?: TextPromptTemplateConfiguration;

  @doc("Configuration for chat prompt template")
  chat?: ChatPromptTemplateConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PromptAgentResource")
model PromptAgentResource {
  @doc("Arn representation of the Agent Alias.")
  agentIdentifier?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PromptModelInferenceConfiguration")
model PromptModelInferenceConfiguration {
  @doc("Maximum length of output")
  maxTokens?: int32;

  @doc("List of stop sequences")
  stopSequences?: string[];

  @doc("Controls randomness, higher values increase diversity")
  temperature?: int32;

  @doc("Cumulative probability cutoff for token selection")
  topP?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TextPromptTemplateConfiguration")
model TextPromptTemplateConfiguration {
  @doc("CachePointBlock")
  cachePoint?: CachePointBlock;

  @doc("List of input variables")
  @Azure.ResourceManager.identifiers(#[])
  inputVariables?: PromptInputVariable[];

  @doc("Prompt content for String prompt template")
  text?: string;

  @doc("The identifier for the S3 resource.")
  textS3Location?: TextS3Location;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ChatPromptTemplateConfiguration")
model ChatPromptTemplateConfiguration {
  @doc("List of input variables")
  @Azure.ResourceManager.identifiers(#[])
  inputVariables?: PromptInputVariable[];

  @doc("List of messages for chat prompt template")
  @Azure.ResourceManager.identifiers(#[])
  messages?: Message[];

  @doc("Configuration for chat prompt template")
  @Azure.ResourceManager.identifiers(#[])
  system?: SystemContentBlock[];

  @doc("Tool configuration")
  toolConfiguration?: ToolConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CachePointBlock")
model CachePointBlock {
  @doc("CachePoint types for CachePointBlock")
  type?: CachePointBlockType;
}

@doc("CachePointBlockType enum")
union CachePointBlockType {
  @doc("CachePointBlockType enum default")
  default: "default",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PromptInputVariable")
model PromptInputVariable {
  @doc("Name for an input variable")
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TextS3Location")
model TextS3Location {
  @doc("A bucket in S3")
  bucket?: string;

  @doc("A object key in S3")
  @secret
  key?: string;

  @doc("The version of the the S3 object to use")
  version?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Message")
model Message {
  @doc("List of Content Blocks")
  @Azure.ResourceManager.identifiers(#[])
  content?: ContentBlock[];

  @doc("Conversation roles for the chat prompt")
  role?: MessageRole;
}

@doc("MessageRole enum")
union MessageRole {
  @doc("MessageRole enum assistant")
  assistant: "assistant",

  @doc("MessageRole enum user")
  user: "user",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SystemContentBlock")
model SystemContentBlock {
  @doc("Configuration for chat prompt template")
  text?: string;

  @doc("CachePointBlock")
  cachePoint?: CachePointBlock;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ToolConfiguration")
model ToolConfiguration {
  @doc("Tool choice")
  toolChoice?: ToolChoice;

  @doc("List of Tools")
  @Azure.ResourceManager.identifiers(#[])
  tools?: Tool[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ContentBlock")
model ContentBlock {
  @doc("Configuration for chat prompt template")
  text?: string;

  @doc("CachePointBlock")
  cachePoint?: CachePointBlock;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ToolChoice")
model ToolChoice {
  @doc("Auto Tool choice")
  auto?: unknown;

  @doc("Any Tool choice")
  any?: unknown;

  @doc("Specific Tool choice")
  tool?: SpecificToolChoice;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tool")
model Tool {
  @doc("Tool specification")
  toolSpec?: ToolSpecification;

  @doc("CachePointBlock")
  cachePoint?: CachePointBlock;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SpecificToolChoice")
model SpecificToolChoice {
  @doc("Tool name")
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ToolSpecification")
model ToolSpecification {
  @doc("Property description")
  description?: string;

  @doc("Tool input schema")
  inputSchema?: ToolInputSchema;

  @doc("Tool name")
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ToolInputSchema")
model ToolInputSchema {
  @doc("Property json")
  json?: unknown;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface BedrockPrompts {
  get is ArmResourceRead<BedrockPrompt>;
  @doc("Create a BedrockPrompt. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<BedrockPrompt>;
  update is ArmCustomPatchAsync<
    BedrockPrompt,
    Azure.ResourceManager.Foundations.TagsUpdateModel<BedrockPrompt>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<BedrockPrompt>;
  listByResourceGroup is ArmResourceListByParent<BedrockPrompt>;
  listBySubscription is ArmListBySubscription<BedrockPrompt>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Bedrock::Prompt
//--------------------------------------------------------------------------------------------
