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

//---------------------------------------------- BedrockFlows ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Bedrock Flow",
    plural: "Bedrock Flows",
  },
  keywords: ["Microsoft.AwsConnector", "Bedrock", "Flow"],
})
@doc("A Microsoft.AwsConnector resource")
model BedrockFlow is TrackedResource<BedrockFlowProperties> {
  @doc("Name of BedrockFlow")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("bedrockFlows")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BedrockFlow")
model BedrockFlowProperties {
  @doc("AWS Properties")
  awsProperties?: AwsBedrockFlowProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsBedrockFlow")
model AwsBedrockFlowProperties {
  @doc("Arn representation of the Flow")
  arn?: string;

  @doc("Time Stamp.")
  createdAt?: string;

  @doc("A KMS key ARN")
  customerEncryptionKeyArn?: string;

  @doc("Flow definition")
  definition?: FlowDefinition;

  @doc("A bucket, key and optional version pointing to an S3 object containing a UTF-8 encoded JSON string Definition with the same schema as the Definition property of this resource")
  definitionS3Location?: S3Location;

  @doc("A JSON string containing a Definition with the same schema as the Definition property of this resource")
  definitionString?: string;

  @doc("When supplied with DefinitionString or DefinitionS3Location, substrings in the definition matching \${keyname} will be replaced with the associated value from this map")
  definitionSubstitutions?: unknown;

  @doc("Description of the flow")
  description?: string;

  @doc("ARN of a IAM role")
  executionRoleArn?: string;

  @doc("Identifier for a Flow")
  id?: string;

  @doc("Name for the flow")
  name?: string;

  @doc("Schema Type for Flow APIs")
  status?: Status;

  @doc("A map of tag keys and values")
  tags?: Record<string>;

  @doc("A map of tag keys and values")
  testAliasTags?: Record<string>;

  @doc("Time Stamp.")
  updatedAt?: string;

  @doc("List of flow validations")
  @Azure.ResourceManager.identifiers(#[])
  validations?: FlowValidation[];

  @doc("Draft Version.")
  version?: string;
}

@doc("Status enum")
union Status {
  @doc("Status enum Failed")
  Failed: "Failed",

  @doc("Status enum NotPrepared")
  NotPrepared: "NotPrepared",

  @doc("Status enum Prepared")
  Prepared: "Prepared",

  @doc("Status enum Preparing")
  Preparing: "Preparing",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FlowDefinition")
model FlowDefinition {
  @doc("List of connections")
  @Azure.ResourceManager.identifiers(#[])
  connections?: FlowConnection[];

  @doc("List of nodes in a flow")
  @Azure.ResourceManager.identifiers(#[])
  nodes?: FlowNode[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of S3Location")
model S3Location {
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
@doc("Definition of FlowValidation")
model FlowValidation {
  @doc("validation message")
  message?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FlowConnection")
model FlowConnection {
  @doc("Connection configuration")
  configuration?: FlowConnectionConfiguration;

  @doc("Name of a connection in a flow")
  name?: string;

  @doc("Name of a node in a flow")
  source?: string;

  @doc("Name of a node in a flow")
  target?: string;

  @doc("Connection type")
  type?: FlowConnectionType;
}

@doc("FlowConnectionType enum")
union FlowConnectionType {
  @doc("FlowConnectionType enum Conditional")
  Conditional: "Conditional",

  @doc("FlowConnectionType enum Data")
  Data: "Data",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FlowNode")
model FlowNode {
  @doc("Node configuration in a flow")
  configuration?: FlowNodeConfiguration;

  @doc("List of node inputs in a flow")
  @Azure.ResourceManager.identifiers(#[])
  inputs?: FlowNodeInput[];

  @doc("Name of a node in a flow")
  name?: string;

  @doc("List of node outputs in a flow")
  @Azure.ResourceManager.identifiers(#[])
  outputs?: FlowNodeOutput[];

  @doc("Flow node types")
  type?: FlowNodeType;
}

@doc("FlowNodeType enum")
union FlowNodeType {
  @doc("FlowNodeType enum Agent")
  Agent: "Agent",

  @doc("FlowNodeType enum Collector")
  Collector: "Collector",

  @doc("FlowNodeType enum Condition")
  Condition: "Condition",

  @doc("FlowNodeType enum InlineCode")
  InlineCode: "InlineCode",

  @doc("FlowNodeType enum Input")
  Input: "Input",

  @doc("FlowNodeType enum Iterator")
  Iterator: "Iterator",

  @doc("FlowNodeType enum KnowledgeBase")
  KnowledgeBase: "KnowledgeBase",

  @doc("FlowNodeType enum LambdaFunction")
  LambdaFunction: "LambdaFunction",

  @doc("FlowNodeType enum Lex")
  Lex: "Lex",

  @doc("FlowNodeType enum Loop")
  Loop: "Loop",

  @doc("FlowNodeType enum LoopController")
  LoopController: "LoopController",

  @doc("FlowNodeType enum LoopInput")
  LoopInput: "LoopInput",

  @doc("FlowNodeType enum Output")
  Output: "Output",

  @doc("FlowNodeType enum Prompt")
  Prompt: "Prompt",

  @doc("FlowNodeType enum Retrieval")
  Retrieval: "Retrieval",

  @doc("FlowNodeType enum Storage")
  Storage: "Storage",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FlowConnectionConfiguration")
model FlowConnectionConfiguration {
  @doc("Data connection configuration")
  data?: FlowDataConnectionConfiguration;

  @doc("Conditional connection configuration")
  conditional?: FlowConditionalConnectionConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FlowNodeConfiguration")
model FlowNodeConfiguration {
  @doc("Input flow node configuration")
  input?: unknown;

  @doc("Output flow node configuration")
  output?: unknown;

  @doc("Knowledge base flow node configuration")
  knowledgeBase?: KnowledgeBaseFlowNodeConfiguration;

  @doc("Condition flow node configuration")
  condition?: ConditionFlowNodeConfiguration;

  @doc("Lex flow node configuration")
  lex?: LexFlowNodeConfiguration;

  @doc("Prompt flow node configuration")
  prompt?: PromptFlowNodeConfiguration;

  @doc("Lambda function flow node configuration")
  lambdaFunction?: LambdaFunctionFlowNodeConfiguration;

  @doc("Agent flow node configuration")
  agent?: AgentFlowNodeConfiguration;

  @doc("Storage flow node configuration")
  storage?: StorageFlowNodeConfiguration;

  @doc("Iterator flow node configuration")
  iterator?: unknown;

  @doc("Collector flow node configuration")
  collector?: unknown;

  @doc("Retrieval flow node configuration")
  retrieval?: RetrievalFlowNodeConfiguration;

  @doc("Inline code config strucuture, contains code configs")
  inlineCode?: InlineCodeFlowNodeConfiguration;

  @doc("Loop node config, contains loop's internal definition")
  loop?: LoopFlowNodeConfiguration;

  @doc("Configuration for the LoopInput node")
  loopInput?: unknown;

  @doc("Configuration for the LoopController node, which manages loop execution")
  loopController?: LoopControllerFlowNodeConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FlowNodeInput")
model FlowNodeInput {
  @doc("Optional tag to classify input type, currently exclusive to LoopNode")
  category?: FlowNodeInputCategory;

  @doc("Expression for a node input in a flow")
  expression?: string;

  @doc("Name of a node input in a flow")
  name?: string;

  @doc("Type of input/output for a node in a flow")
  type?: FlowNodeInputType;
}

@doc("FlowNodeInputCategory enum")
union FlowNodeInputCategory {
  @doc("FlowNodeInputCategory enum ExitLoop")
  ExitLoop: "ExitLoop",

  @doc("FlowNodeInputCategory enum LoopCondition")
  LoopCondition: "LoopCondition",

  @doc("FlowNodeInputCategory enum ReturnValueToLoopStart")
  ReturnValueToLoopStart: "ReturnValueToLoopStart",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FlowNodeOutput")
model FlowNodeOutput {
  @doc("Name of a node output in a flow")
  name?: string;

  @doc("Type of input/output for a node in a flow")
  type?: FlowNodeOutputType;
}

@doc("FlowNodeInputType enum")
union FlowNodeInputType {
  @doc("FlowNodeInputType enum Array")
  Array: "Array",

  @doc("FlowNodeInputType enum Boolean")
  Boolean: "Boolean",

  @doc("FlowNodeInputType enum Number")
  Number: "Number",

  @doc("FlowNodeInputType enum Object")
  Object: "Object",

  @doc("FlowNodeInputType enum String")
  String: "String",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FlowDataConnectionConfiguration")
model FlowDataConnectionConfiguration {
  @doc("Name of a node output in a flow")
  sourceOutput?: string;

  @doc("Name of a node input in a flow")
  targetInput?: string;
}

@doc("FlowNodeOutputType enum")
union FlowNodeOutputType {
  @doc("FlowNodeOutputType enum Array")
  Array: "Array",

  @doc("FlowNodeOutputType enum Boolean")
  Boolean: "Boolean",

  @doc("FlowNodeOutputType enum Number")
  Number: "Number",

  @doc("FlowNodeOutputType enum Object")
  Object: "Object",

  @doc("FlowNodeOutputType enum String")
  String: "String",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FlowConditionalConnectionConfiguration")
model FlowConditionalConnectionConfiguration {
  @doc("Name of a condition in a flow")
  condition?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of KnowledgeBaseFlowNodeConfiguration")
model KnowledgeBaseFlowNodeConfiguration {
  @doc("Configuration for a guardrail")
  guardrailConfiguration?: GuardrailConfiguration;

  @doc("Model inference configuration")
  inferenceConfiguration?: PromptInferenceConfiguration;

  @doc("Identifier of the KnowledgeBase")
  knowledgeBaseId?: string;

  @doc("ARN or Id of a Bedrock Foundational Model or Inference Profile, or the ARN of a imported model, or a provisioned throughput ARN for custom models.")
  modelId?: string;

  @doc("Number Of Results to Retrieve")
  numberOfResults?: int32;

  @doc("Property orchestrationConfiguration")
  orchestrationConfiguration?: KnowledgeBaseOrchestrationConfiguration;

  @doc("Knowledge Base Prompt template")
  promptTemplate?: KnowledgeBasePromptTemplate;

  @doc("Property rerankingConfiguration")
  rerankingConfiguration?: VectorSearchRerankingConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ConditionFlowNodeConfiguration")
model ConditionFlowNodeConfiguration {
  @doc("List of conditions in a condition node")
  @Azure.ResourceManager.identifiers(#[])
  conditions?: FlowCondition[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LexFlowNodeConfiguration")
model LexFlowNodeConfiguration {
  @doc("ARN of a Lex bot alias")
  botAliasArn?: string;

  @doc("Lex bot locale id")
  localeId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PromptFlowNodeConfiguration")
model PromptFlowNodeConfiguration {
  @doc("Configuration for a guardrail")
  guardrailConfiguration?: GuardrailConfiguration;

  @doc("Prompt source configuration for prompt node")
  sourceConfiguration?: PromptFlowNodeSourceConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LambdaFunctionFlowNodeConfiguration")
model LambdaFunctionFlowNodeConfiguration {
  @doc("ARN of a Lambda.")
  lambdaArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AgentFlowNodeConfiguration")
model AgentFlowNodeConfiguration {
  @doc("Arn representation of the Agent Alias.")
  agentAliasArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StorageFlowNodeConfiguration")
model StorageFlowNodeConfiguration {
  @doc("storage service configuration for storage node")
  serviceConfiguration?: StorageFlowNodeServiceConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RetrievalFlowNodeConfiguration")
model RetrievalFlowNodeConfiguration {
  @doc("Retrieval service configuration for Retrieval node")
  serviceConfiguration?: RetrievalFlowNodeServiceConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InlineCodeFlowNodeConfiguration")
model InlineCodeFlowNodeConfiguration {
  @doc("The inline code entered by customers. max size is 5MB.")
  code?: string;

  @doc("Enum encodes the supported language type")
  language?: InlineCodeFlowNodeConfigurationLanguage;
}

@doc("InlineCodeFlowNodeConfigurationLanguage enum")
union InlineCodeFlowNodeConfigurationLanguage {
  @doc("InlineCodeFlowNodeConfigurationLanguage enum Python_3")
  Python_3: "Python_3",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LoopFlowNodeConfiguration")
model LoopFlowNodeConfiguration {
  @doc("Flow definition")
  definition?: FlowDefinition;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LoopControllerFlowNodeConfiguration")
model LoopControllerFlowNodeConfiguration {
  @doc("Condition branch for a condition node")
  continueCondition?: FlowCondition;

  @doc("Maximum number of iterations the loop can perform")
  maxIterations?: int32 = 10;
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
@doc("Definition of PromptInferenceConfiguration")
model PromptInferenceConfiguration {
  @doc("Prompt model inference configuration")
  text?: PromptModelInferenceConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of KnowledgeBaseOrchestrationConfiguration")
model KnowledgeBaseOrchestrationConfiguration {
  @doc("Property additionalModelRequestFields")
  additionalModelRequestFields?: unknown;

  @doc("Model inference configuration")
  inferenceConfig?: PromptInferenceConfiguration;

  @doc("Property performanceConfig")
  performanceConfig?: PerformanceConfiguration;

  @doc("Knowledge Base Prompt template")
  promptTemplate?: KnowledgeBasePromptTemplate;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of KnowledgeBasePromptTemplate")
model KnowledgeBasePromptTemplate {
  @doc("Property textPromptTemplate")
  textPromptTemplate?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VectorSearchRerankingConfiguration")
model VectorSearchRerankingConfiguration {
  @doc("Property bedrockRerankingConfiguration")
  bedrockRerankingConfiguration?: VectorSearchBedrockRerankingConfiguration;

  @doc("Enum of Rerank Configuration Types")
  type?: VectorSearchRerankingConfigurationType;
}

@doc("VectorSearchRerankingConfigurationType enum")
union VectorSearchRerankingConfigurationType {
  @doc("VectorSearchRerankingConfigurationType enum BEDROCK_RERANKING_MODEL")
  BEDROCK_RERANKING_MODEL: "BEDROCK_RERANKING_MODEL",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FlowCondition")
model FlowCondition {
  @doc("Expression for a condition in a flow")
  expression?: string;

  @doc("Name of a condition in a flow")
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PromptFlowNodeSourceConfiguration")
model PromptFlowNodeSourceConfiguration {
  @doc("Resource prompt configuration for prompt node")
  resource?: PromptFlowNodeResourceConfiguration;

  @doc("Inline prompt configuration for prompt node")
  inline?: PromptFlowNodeInlineConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StorageFlowNodeServiceConfiguration")
model StorageFlowNodeServiceConfiguration {
  @doc("s3 storage configuration for storage node")
  s3?: StorageFlowNodeS3Configuration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RetrievalFlowNodeServiceConfiguration")
model RetrievalFlowNodeServiceConfiguration {
  @doc("s3 Retrieval configuration for Retrieval node")
  s3?: RetrievalFlowNodeS3Configuration;
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
@doc("Definition of PerformanceConfiguration")
model PerformanceConfiguration {
  @doc("Performance Configuration Latency")
  latency?: PerformanceConfigurationLatency;
}

@doc("PerformanceConfigurationLatency enum")
union PerformanceConfigurationLatency {
  @doc("PerformanceConfigurationLatency enum optimized")
  optimized: "optimized",

  @doc("PerformanceConfigurationLatency enum standard")
  standard: "standard",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VectorSearchBedrockRerankingConfiguration")
model VectorSearchBedrockRerankingConfiguration {
  @doc("Property metadataConfiguration")
  metadataConfiguration?: MetadataConfigurationForReranking;

  @doc("Property modelConfiguration")
  modelConfiguration?: VectorSearchBedrockRerankingModelConfiguration;

  @doc("Number Of Results For Reranking")
  numberOfRerankedResults?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PromptFlowNodeResourceConfiguration")
model PromptFlowNodeResourceConfiguration {
  @doc("ARN of a prompt resource possibly with a version")
  promptArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PromptFlowNodeInlineConfiguration")
model PromptFlowNodeInlineConfiguration {
  @doc("Model inference configuration")
  inferenceConfiguration?: PromptInferenceConfiguration;

  @doc("ARN or Id of a Bedrock Foundational Model or Inference Profile, or the ARN of a imported model, or a provisioned throughput ARN for custom models.")
  modelId?: string;

  @doc("Prompt template configuration")
  templateConfiguration?: PromptTemplateConfiguration;

  @doc("Prompt template type")
  templateType?: PromptFlowNodeInlineConfigurationTemplateType;
}

@doc("PromptFlowNodeInlineConfigurationTemplateType enum")
union PromptFlowNodeInlineConfigurationTemplateType {
  @doc("PromptFlowNodeInlineConfigurationTemplateType enum TEXT")
  TEXT: "TEXT",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StorageFlowNodeS3Configuration")
model StorageFlowNodeS3Configuration {
  @doc("bucket name of an s3 that will be used for storage flow node configuration")
  bucketName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RetrievalFlowNodeS3Configuration")
model RetrievalFlowNodeS3Configuration {
  @doc("bucket name of an s3 that will be used for Retrieval flow node configuration")
  bucketName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MetadataConfigurationForReranking")
model MetadataConfigurationForReranking {
  @doc("Reranking Metadata Selection Mode")
  selectionMode?: MetadataConfigurationForRerankingSelectionMode;

  @doc("Reranking Metadata Selective Mode Configuration")
  selectiveModeConfiguration?: RerankingMetadataSelectiveModeConfiguration;
}

@doc("MetadataConfigurationForRerankingSelectionMode enum")
union MetadataConfigurationForRerankingSelectionMode {
  @doc("MetadataConfigurationForRerankingSelectionMode enum ALL")
  ALL: "ALL",

  @doc("MetadataConfigurationForRerankingSelectionMode enum SELECTIVE")
  SELECTIVE: "SELECTIVE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VectorSearchBedrockRerankingModelConfiguration")
model VectorSearchBedrockRerankingModelConfiguration {
  @doc("Property additionalModelRequestFields")
  additionalModelRequestFields?: unknown;

  @doc("Arn of a Bedrock Reranking model")
  modelArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PromptTemplateConfiguration")
model PromptTemplateConfiguration {
  @doc("Configuration for text prompt template")
  text?: TextPromptTemplateConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RerankingMetadataSelectiveModeConfiguration")
model RerankingMetadataSelectiveModeConfiguration {
  @doc("List of Fields For Reranking")
  @Azure.ResourceManager.identifiers(#[])
  fieldsToInclude?: FieldForReranking[];

  @doc("List of Fields For Reranking")
  @Azure.ResourceManager.identifiers(#[])
  fieldsToExclude?: FieldForReranking[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TextPromptTemplateConfiguration")
model TextPromptTemplateConfiguration {
  @doc("List of input variables")
  @Azure.ResourceManager.identifiers(#[])
  inputVariables?: PromptInputVariable[];

  @doc("Prompt content for String prompt template")
  text?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FieldForReranking")
model FieldForReranking {
  @doc("Field name for reranking")
  fieldName?: string;
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface BedrockFlows {
  get is ArmResourceRead<BedrockFlow>;
  @doc("Create a BedrockFlow. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<BedrockFlow>;
  update is ArmCustomPatchAsync<
    BedrockFlow,
    Azure.ResourceManager.Foundations.TagsUpdateModel<BedrockFlow>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<BedrockFlow>;
  listByResourceGroup is ArmResourceListByParent<BedrockFlow>;
  listBySubscription is ArmListBySubscription<BedrockFlow>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Bedrock::Flow
//--------------------------------------------------------------------------------------------
