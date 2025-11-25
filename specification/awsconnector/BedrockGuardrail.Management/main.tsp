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

//---------------------------------------------- BedrockGuardrails ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Bedrock Guardrail",
    plural: "Bedrock Guardrails",
  },
  keywords: ["Microsoft.AwsConnector", "Bedrock", "Guardrail"],
})
@doc("A Microsoft.AwsConnector resource")
model BedrockGuardrail is TrackedResource<BedrockGuardrailProperties> {
  @doc("Name of BedrockGuardrail")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("bedrockGuardrails")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BedrockGuardrail")
model BedrockGuardrailProperties {
  @doc("AWS Properties")
  awsProperties?: AwsBedrockGuardrailProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsBedrockGuardrail")
model AwsBedrockGuardrailProperties {
  @doc("Optional configuration for integrating Automated Reasoning policies with the guardrail.")
  automatedReasoningPolicyConfig?: AutomatedReasoningPolicyConfig;

  @doc("Messaging for when violations are detected in text")
  blockedInputMessaging?: string;

  @doc("Messaging for when violations are detected in text")
  blockedOutputsMessaging?: string;

  @doc("Content policy config for a guardrail.")
  contentPolicyConfig?: ContentPolicyConfig;

  @doc("Contextual grounding policy config for a guardrail.")
  contextualGroundingPolicyConfig?: ContextualGroundingPolicyConfig;

  @doc("Time Stamp")
  createdAt?: string;

  @doc("The system-defined guardrail profile that you’re using with your guardrail")
  crossRegionConfig?: GuardrailCrossRegionConfig;

  @doc("Description of the guardrail or its version")
  description?: string;

  @doc("List of failure recommendations")
  failureRecommendations?: string[];

  @doc("Arn representation for the guardrail")
  guardrailArn?: string;

  @doc("Unique id for the guardrail")
  guardrailId?: string;

  @doc("The KMS key with which the guardrail was encrypted at rest")
  kmsKeyArn?: string;

  @doc("Name of the guardrail")
  name?: string;

  @doc("Sensitive information policy config for a guardrail.")
  sensitiveInformationPolicyConfig?: SensitiveInformationPolicyConfig;

  @doc("Status of the guardrail")
  status?: Status;

  @doc("List of status reasons")
  statusReasons?: string[];

  @doc("List of Tags")
  @Azure.ResourceManager.identifiers(#[])
  tags?: Tag[];

  @doc("Topic policy config for a guardrail.")
  topicPolicyConfig?: TopicPolicyConfig;

  @doc("Time Stamp")
  updatedAt?: string;

  @doc("Guardrail version")
  version?: string;

  @doc("Word policy config for a guardrail.")
  wordPolicyConfig?: WordPolicyConfig;
}

@doc("Status enum")
union Status {
  @doc("Status enum CREATING")
  CREATING: "CREATING",

  @doc("Status enum DELETING")
  DELETING: "DELETING",

  @doc("Status enum FAILED")
  FAILED: "FAILED",

  @doc("Status enum READY")
  READY: "READY",

  @doc("Status enum UPDATING")
  UPDATING: "UPDATING",

  @doc("Status enum VERSIONING")
  VERSIONING: "VERSIONING",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AutomatedReasoningPolicyConfig")
model AutomatedReasoningPolicyConfig {
  @doc("The confidence threshold for triggering guardrail actions based on Automated Reasoning policy violations.")
  confidenceThreshold?: int32;

  @doc("The list of Automated Reasoning policy ARNs to include in the guardrail configuration")
  policies?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ContentPolicyConfig")
model ContentPolicyConfig {
  @doc("Guardrail tier config for content policy")
  contentFiltersTierConfig?: ContentFiltersTierNameModel;

  @doc("List of content filter configs in content policy.")
  @Azure.ResourceManager.identifiers(#[])
  filtersConfig?: ContentFilterConfig[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ContextualGroundingPolicyConfig")
model ContextualGroundingPolicyConfig {
  @doc("List of contextual grounding filter configs.")
  @Azure.ResourceManager.identifiers(#[])
  filtersConfig?: ContextualGroundingFilterConfig[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of GuardrailCrossRegionConfig")
model GuardrailCrossRegionConfig {
  @doc("The Amazon Resource Name (ARN) of the guardrail profile")
  guardrailProfileArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SensitiveInformationPolicyConfig")
model SensitiveInformationPolicyConfig {
  @doc("List of entities.")
  @Azure.ResourceManager.identifiers(#[])
  piiEntitiesConfig?: PiiEntityConfig[];

  @doc("List of regex.")
  @Azure.ResourceManager.identifiers(#[])
  regexesConfig?: RegexConfig[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Tag Key")
  key?: string;

  @doc("Tag Value")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TopicPolicyConfig")
model TopicPolicyConfig {
  @doc("List of topic configs in topic policy.")
  @Azure.ResourceManager.identifiers(#[])
  topicsConfig?: TopicConfig[];

  @doc("Guardrail tier config for topic policy")
  topicsTierConfig?: TopicsTierNameModel;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of WordPolicyConfig")
model WordPolicyConfig {
  @doc("A config for the list of managed words.")
  @Azure.ResourceManager.identifiers(#[])
  managedWordListsConfig?: ManagedWordsConfig[];

  @doc("List of custom word configs.")
  @Azure.ResourceManager.identifiers(#[])
  wordsConfig?: WordConfig[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ContentFiltersTierName")
model ContentFiltersTierNameModel {
  @doc("Tier name for tier configuration in content filters policy")
  @clientName("contentFiltersTierNamecsharp", "csharp")
  contentFiltersTierName?: ContentFiltersTierNameContentFiltersTierName;
}

@doc("ContentFiltersTierNameContentFiltersTierName enum")
union ContentFiltersTierNameContentFiltersTierName {
  @doc("ContentFiltersTierNameContentFiltersTierName enum CLASSIC")
  CLASSIC: "CLASSIC",

  @doc("ContentFiltersTierNameContentFiltersTierName enum STANDARD")
  STANDARD: "STANDARD",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ContentFilterConfig")
model ContentFilterConfig {
  @doc("Property inputAction")
  inputAction?: ContentFilterConfigInputAction;

  @doc("Property inputEnabled")
  inputEnabled?: boolean;

  @doc("List of modalities")
  inputModalities?: string[];

  @doc("Strength for filters")
  inputStrength?: ContentFilterConfigInputStrength;

  @doc("Property outputAction")
  outputAction?: ContentFilterConfigOutputAction;

  @doc("Property outputEnabled")
  outputEnabled?: boolean;

  @doc("List of modalities")
  outputModalities?: string[];

  @doc("Strength for filters")
  outputStrength?: ContentFilterConfigOutputStrength;

  @doc("Type of filter in content policy")
  type?: ContentFilterConfigType;
}

@doc("ContentFilterConfigInputAction enum")
union ContentFilterConfigInputAction {
  @doc("ContentFilterConfigInputAction enum BLOCK")
  BLOCK: "BLOCK",

  @doc("ContentFilterConfigInputAction enum NONE")
  NONE: "NONE",

  string,
}

@doc("ContentFilterConfigOutputAction enum")
union ContentFilterConfigOutputAction {
  @doc("ContentFilterConfigOutputAction enum BLOCK")
  BLOCK: "BLOCK",

  @doc("ContentFilterConfigOutputAction enum NONE")
  NONE: "NONE",

  string,
}

@doc("ContentFilterConfigType enum")
union ContentFilterConfigType {
  @doc("ContentFilterConfigType enum HATE")
  HATE: "HATE",

  @doc("ContentFilterConfigType enum INSULTS")
  INSULTS: "INSULTS",

  @doc("ContentFilterConfigType enum MISCONDUCT")
  MISCONDUCT: "MISCONDUCT",

  @doc("ContentFilterConfigType enum PROMPT_ATTACK")
  PROMPT_ATTACK: "PROMPT_ATTACK",

  @doc("ContentFilterConfigType enum SEXUAL")
  SEXUAL: "SEXUAL",

  @doc("ContentFilterConfigType enum VIOLENCE")
  VIOLENCE: "VIOLENCE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ContextualGroundingFilterConfig")
model ContextualGroundingFilterConfig {
  @doc("Property action")
  action?: ContextualGroundingFilterConfigAction;

  @doc("Property enabled")
  enabled?: boolean;

  @doc("The threshold for this filter.")
  threshold?: int32;

  @doc("Type of contextual grounding filter")
  type?: ContextualGroundingFilterConfigType;
}

@doc("ContentFilterConfigInputStrength enum")
union ContentFilterConfigInputStrength {
  @doc("ContentFilterConfigInputStrength enum HIGH")
  HIGH: "HIGH",

  @doc("ContentFilterConfigInputStrength enum LOW")
  LOW: "LOW",

  @doc("ContentFilterConfigInputStrength enum MEDIUM")
  MEDIUM: "MEDIUM",

  @doc("ContentFilterConfigInputStrength enum NONE")
  NONE: "NONE",

  string,
}

@doc("ContextualGroundingFilterConfigAction enum")
union ContextualGroundingFilterConfigAction {
  @doc("ContextualGroundingFilterConfigAction enum BLOCK")
  BLOCK: "BLOCK",

  @doc("ContextualGroundingFilterConfigAction enum NONE")
  NONE: "NONE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PiiEntityConfig")
model PiiEntityConfig {
  @doc("Options for sensitive information action.")
  action?: PiiEntityConfigAction;

  @doc("Options for sensitive information action.")
  inputAction?: PiiEntityConfigInputAction;

  @doc("Property inputEnabled")
  inputEnabled?: boolean;

  @doc("Options for sensitive information action.")
  outputAction?: PiiEntityConfigOutputAction;

  @doc("Property outputEnabled")
  outputEnabled?: boolean;

  @doc("The currently supported PII entities")
  type?: PiiEntityConfigType;
}

@doc("ContentFilterConfigOutputStrength enum")
union ContentFilterConfigOutputStrength {
  @doc("ContentFilterConfigOutputStrength enum HIGH")
  HIGH: "HIGH",

  @doc("ContentFilterConfigOutputStrength enum LOW")
  LOW: "LOW",

  @doc("ContentFilterConfigOutputStrength enum MEDIUM")
  MEDIUM: "MEDIUM",

  @doc("ContentFilterConfigOutputStrength enum NONE")
  NONE: "NONE",

  string,
}

@doc("PiiEntityConfigAction enum")
union PiiEntityConfigAction {
  @doc("PiiEntityConfigAction enum ANONYMIZE")
  ANONYMIZE: "ANONYMIZE",

  @doc("PiiEntityConfigAction enum BLOCK")
  BLOCK: "BLOCK",

  @doc("PiiEntityConfigAction enum NONE")
  NONE: "NONE",

  string,
}

@doc("PiiEntityConfigOutputAction enum")
union PiiEntityConfigOutputAction {
  @doc("PiiEntityConfigOutputAction enum ANONYMIZE")
  ANONYMIZE: "ANONYMIZE",

  @doc("PiiEntityConfigOutputAction enum BLOCK")
  BLOCK: "BLOCK",

  @doc("PiiEntityConfigOutputAction enum NONE")
  NONE: "NONE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RegexConfig")
model RegexConfig {
  @doc("Options for sensitive information action.")
  action?: RegexConfigAction;

  @doc("The regex description.")
  description?: string;

  @doc("Options for sensitive information action.")
  inputAction?: RegexConfigInputAction;

  @doc("Property inputEnabled")
  inputEnabled?: boolean;

  @doc("The regex name.")
  name?: string;

  @doc("Options for sensitive information action.")
  outputAction?: RegexConfigOutputAction;

  @doc("Property outputEnabled")
  outputEnabled?: boolean;

  @doc("The regex pattern.")
  pattern?: string;
}

@doc("ContextualGroundingFilterConfigType enum")
union ContextualGroundingFilterConfigType {
  @doc("ContextualGroundingFilterConfigType enum GROUNDING")
  GROUNDING: "GROUNDING",

  @doc("ContextualGroundingFilterConfigType enum RELEVANCE")
  RELEVANCE: "RELEVANCE",

  string,
}

@doc("PiiEntityConfigType enum")
union PiiEntityConfigType {
  @doc("PiiEntityConfigType enum ADDRESS")
  ADDRESS: "ADDRESS",

  @doc("PiiEntityConfigType enum AGE")
  AGE: "AGE",

  @doc("PiiEntityConfigType enum AWS_ACCESS_KEY")
  AWS_ACCESS_KEY: "AWS_ACCESS_KEY",

  @doc("PiiEntityConfigType enum AWS_SECRET_KEY")
  AWS_SECRET_KEY: "AWS_SECRET_KEY",

  @doc("PiiEntityConfigType enum CA_HEALTH_NUMBER")
  CA_HEALTH_NUMBER: "CA_HEALTH_NUMBER",

  @doc("PiiEntityConfigType enum CA_SOCIAL_INSURANCE_NUMBER")
  CA_SOCIAL_INSURANCE_NUMBER: "CA_SOCIAL_INSURANCE_NUMBER",

  @doc("PiiEntityConfigType enum CREDIT_DEBIT_CARD_CVV")
  CREDIT_DEBIT_CARD_CVV: "CREDIT_DEBIT_CARD_CVV",

  @doc("PiiEntityConfigType enum CREDIT_DEBIT_CARD_EXPIRY")
  CREDIT_DEBIT_CARD_EXPIRY: "CREDIT_DEBIT_CARD_EXPIRY",

  @doc("PiiEntityConfigType enum CREDIT_DEBIT_CARD_NUMBER")
  CREDIT_DEBIT_CARD_NUMBER: "CREDIT_DEBIT_CARD_NUMBER",

  @doc("PiiEntityConfigType enum DRIVER_ID")
  DRIVER_ID: "DRIVER_ID",

  @doc("PiiEntityConfigType enum EMAIL")
  EMAIL: "EMAIL",

  @doc("PiiEntityConfigType enum INTERNATIONAL_BANK_ACCOUNT_NUMBER")
  INTERNATIONAL_BANK_ACCOUNT_NUMBER: "INTERNATIONAL_BANK_ACCOUNT_NUMBER",

  @doc("PiiEntityConfigType enum IP_ADDRESS")
  IP_ADDRESS: "IP_ADDRESS",

  @doc("PiiEntityConfigType enum LICENSE_PLATE")
  LICENSE_PLATE: "LICENSE_PLATE",

  @doc("PiiEntityConfigType enum MAC_ADDRESS")
  MAC_ADDRESS: "MAC_ADDRESS",

  @doc("PiiEntityConfigType enum NAME")
  NAME: "NAME",

  @doc("PiiEntityConfigType enum PASSWORD")
  PASSWORD: "PASSWORD",

  @doc("PiiEntityConfigType enum PHONE")
  PHONE: "PHONE",

  @doc("PiiEntityConfigType enum PIN")
  PIN: "PIN",

  @doc("PiiEntityConfigType enum SWIFT_CODE")
  SWIFT_CODE: "SWIFT_CODE",

  @doc("PiiEntityConfigType enum UK_NATIONAL_HEALTH_SERVICE_NUMBER")
  UK_NATIONAL_HEALTH_SERVICE_NUMBER: "UK_NATIONAL_HEALTH_SERVICE_NUMBER",

  @doc("PiiEntityConfigType enum UK_NATIONAL_INSURANCE_NUMBER")
  UK_NATIONAL_INSURANCE_NUMBER: "UK_NATIONAL_INSURANCE_NUMBER",

  @doc("PiiEntityConfigType enum UK_UNIQUE_TAXPAYER_REFERENCE_NUMBER")
  UK_UNIQUE_TAXPAYER_REFERENCE_NUMBER: "UK_UNIQUE_TAXPAYER_REFERENCE_NUMBER",

  @doc("PiiEntityConfigType enum URL")
  URL: "URL",

  @doc("PiiEntityConfigType enum USERNAME")
  USERNAME: "USERNAME",

  @doc("PiiEntityConfigType enum US_BANK_ACCOUNT_NUMBER")
  US_BANK_ACCOUNT_NUMBER: "US_BANK_ACCOUNT_NUMBER",

  @doc("PiiEntityConfigType enum US_BANK_ROUTING_NUMBER")
  US_BANK_ROUTING_NUMBER: "US_BANK_ROUTING_NUMBER",

  @doc("PiiEntityConfigType enum US_INDIVIDUAL_TAX_IDENTIFICATION_NUMBER")
  US_INDIVIDUAL_TAX_IDENTIFICATION_NUMBER: "US_INDIVIDUAL_TAX_IDENTIFICATION_NUMBER",

  @doc("PiiEntityConfigType enum US_PASSPORT_NUMBER")
  US_PASSPORT_NUMBER: "US_PASSPORT_NUMBER",

  @doc("PiiEntityConfigType enum US_SOCIAL_SECURITY_NUMBER")
  US_SOCIAL_SECURITY_NUMBER: "US_SOCIAL_SECURITY_NUMBER",

  @doc("PiiEntityConfigType enum VEHICLE_IDENTIFICATION_NUMBER")
  VEHICLE_IDENTIFICATION_NUMBER: "VEHICLE_IDENTIFICATION_NUMBER",

  string,
}

@doc("RegexConfigInputAction enum")
union RegexConfigInputAction {
  @doc("RegexConfigInputAction enum ANONYMIZE")
  ANONYMIZE: "ANONYMIZE",

  @doc("RegexConfigInputAction enum BLOCK")
  BLOCK: "BLOCK",

  @doc("RegexConfigInputAction enum NONE")
  NONE: "NONE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TopicConfig")
model TopicConfig {
  @doc("Definition of topic in topic policy")
  definition?: string;

  @doc("List of text examples")
  examples?: string[];

  @doc("Property inputAction")
  inputAction?: TopicConfigInputAction;

  @doc("Property inputEnabled")
  inputEnabled?: boolean;

  @doc("Name of topic in topic policy")
  name?: string;

  @doc("Property outputAction")
  outputAction?: TopicConfigOutputAction;

  @doc("Property outputEnabled")
  outputEnabled?: boolean;

  @doc("Type of topic in a policy")
  type?: TopicConfigType;
}

@doc("PiiEntityConfigInputAction enum")
union PiiEntityConfigInputAction {
  @doc("PiiEntityConfigInputAction enum ANONYMIZE")
  ANONYMIZE: "ANONYMIZE",

  @doc("PiiEntityConfigInputAction enum BLOCK")
  BLOCK: "BLOCK",

  @doc("PiiEntityConfigInputAction enum NONE")
  NONE: "NONE",

  string,
}

@doc("RegexConfigOutputAction enum")
union RegexConfigOutputAction {
  @doc("RegexConfigOutputAction enum ANONYMIZE")
  ANONYMIZE: "ANONYMIZE",

  @doc("RegexConfigOutputAction enum BLOCK")
  BLOCK: "BLOCK",

  @doc("RegexConfigOutputAction enum NONE")
  NONE: "NONE",

  string,
}

@doc("TopicConfigOutputAction enum")
union TopicConfigOutputAction {
  @doc("TopicConfigOutputAction enum BLOCK")
  BLOCK: "BLOCK",

  @doc("TopicConfigOutputAction enum NONE")
  NONE: "NONE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TopicsTierName")
model TopicsTierNameModel {
  @doc("Tier name for tier configuration in topic policy")
  @clientName("topicsTierNamecsharp", "csharp")
  topicsTierName?: TopicsTierNameTopicsTierName;
}

@doc("RegexConfigAction enum")
union RegexConfigAction {
  @doc("RegexConfigAction enum ANONYMIZE")
  ANONYMIZE: "ANONYMIZE",

  @doc("RegexConfigAction enum BLOCK")
  BLOCK: "BLOCK",

  @doc("RegexConfigAction enum NONE")
  NONE: "NONE",

  string,
}

@doc("TopicConfigType enum")
union TopicConfigType {
  @doc("TopicConfigType enum DENY")
  DENY: "DENY",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ManagedWordsConfig")
model ManagedWordsConfig {
  @doc("Property inputAction")
  inputAction?: ManagedWordsConfigInputAction;

  @doc("Property inputEnabled")
  inputEnabled?: boolean;

  @doc("Property outputAction")
  outputAction?: ManagedWordsConfigOutputAction;

  @doc("Property outputEnabled")
  outputEnabled?: boolean;

  @doc("Options for managed words.")
  type?: ManagedWordsConfigType;
}

@doc("TopicConfigInputAction enum")
union TopicConfigInputAction {
  @doc("TopicConfigInputAction enum BLOCK")
  BLOCK: "BLOCK",

  @doc("TopicConfigInputAction enum NONE")
  NONE: "NONE",

  string,
}

@doc("ManagedWordsConfigInputAction enum")
union ManagedWordsConfigInputAction {
  @doc("ManagedWordsConfigInputAction enum BLOCK")
  BLOCK: "BLOCK",

  @doc("ManagedWordsConfigInputAction enum NONE")
  NONE: "NONE",

  string,
}

@doc("ManagedWordsConfigType enum")
union ManagedWordsConfigType {
  @doc("ManagedWordsConfigType enum PROFANITY")
  PROFANITY: "PROFANITY",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of WordConfig")
model WordConfig {
  @doc("Property inputAction")
  inputAction?: WordConfigInputAction;

  @doc("Property inputEnabled")
  inputEnabled?: boolean;

  @doc("Property outputAction")
  outputAction?: WordConfigOutputAction;

  @doc("Property outputEnabled")
  outputEnabled?: boolean;

  @doc("The custom word text.")
  text?: string;
}

@doc("TopicsTierNameTopicsTierName enum")
union TopicsTierNameTopicsTierName {
  @doc("TopicsTierNameTopicsTierName enum CLASSIC")
  CLASSIC: "CLASSIC",

  @doc("TopicsTierNameTopicsTierName enum STANDARD")
  STANDARD: "STANDARD",

  string,
}

@doc("WordConfigInputAction enum")
union WordConfigInputAction {
  @doc("WordConfigInputAction enum BLOCK")
  BLOCK: "BLOCK",

  @doc("WordConfigInputAction enum NONE")
  NONE: "NONE",

  string,
}

@doc("ManagedWordsConfigOutputAction enum")
union ManagedWordsConfigOutputAction {
  @doc("ManagedWordsConfigOutputAction enum BLOCK")
  BLOCK: "BLOCK",

  @doc("ManagedWordsConfigOutputAction enum NONE")
  NONE: "NONE",

  string,
}

@doc("WordConfigOutputAction enum")
union WordConfigOutputAction {
  @doc("WordConfigOutputAction enum BLOCK")
  BLOCK: "BLOCK",

  @doc("WordConfigOutputAction enum NONE")
  NONE: "NONE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface BedrockGuardrails {
  get is ArmResourceRead<BedrockGuardrail>;
  @doc("Create a BedrockGuardrail. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<BedrockGuardrail>;
  update is ArmCustomPatchAsync<
    BedrockGuardrail,
    Azure.ResourceManager.Foundations.TagsUpdateModel<BedrockGuardrail>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<BedrockGuardrail>;
  listByResourceGroup is ArmResourceListByParent<BedrockGuardrail>;
  listBySubscription is ArmListBySubscription<BedrockGuardrail>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Bedrock::Guardrail
//--------------------------------------------------------------------------------------------
