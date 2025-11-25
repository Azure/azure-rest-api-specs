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

//---------------------------------------------- BedrockDataAutomationProjects ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Bedrock Data Automation Project",
    plural: "Bedrock Data Automation Projects",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "Bedrock",
    "Data",
    "Automation",
    "Project"
  ],
})
@doc("A Microsoft.AwsConnector resource")
model BedrockDataAutomationProject
  is TrackedResource<BedrockDataAutomationProjectProperties> {
  @doc("Name of BedrockDataAutomationProject")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("bedrockDataAutomationProjects")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BedrockDataAutomationProject")
model BedrockDataAutomationProjectProperties {
  @doc("AWS Properties")
  awsProperties?: AwsBedrockDataAutomationProjectProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsBedrockDataAutomationProject")
model AwsBedrockDataAutomationProjectProperties {
  @doc("Time Stamp")
  creationTime?: string;

  @doc("Custom output configuration")
  customOutputConfiguration?: CustomOutputConfiguration;

  @doc("KMS encryption context")
  kmsEncryptionContext?: Record<string>;

  @doc("KMS key identifier")
  kmsKeyId?: string;

  @doc("Time Stamp")
  lastModifiedTime?: string;

  @doc("Override configuration")
  overrideConfiguration?: OverrideConfiguration;

  @doc("ARN of a DataAutomationProject")
  projectArn?: string;

  @doc("Description of the DataAutomationProject")
  projectDescription?: string;

  @doc("Name of the DataAutomationProject")
  projectName?: string;

  @doc("Stage of the Project")
  projectStage?: ProjectStage;

  @doc("Standard output configuration")
  standardOutputConfiguration?: StandardOutputConfiguration;

  @doc("Property status")
  status?: Status;

  @doc("List of Tags")
  @Azure.ResourceManager.identifiers(#[])
  tags?: Tag[];
}

@doc("ProjectStage enum")
union ProjectStage {
  @doc("ProjectStage enum DEVELOPMENT")
  DEVELOPMENT: "DEVELOPMENT",

  @doc("ProjectStage enum LIVE")
  LIVE: "LIVE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CustomOutputConfiguration")
model CustomOutputConfiguration {
  @doc("Property blueprints")
  @Azure.ResourceManager.identifiers(#[])
  blueprints?: BlueprintItem[];
}

@doc("Status enum")
union Status {
  @doc("Status enum COMPLETED")
  COMPLETED: "COMPLETED",

  @doc("Status enum FAILED")
  FAILED: "FAILED",

  @doc("Status enum IN_PROGRESS")
  IN_PROGRESS: "IN_PROGRESS",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OverrideConfiguration")
model OverrideConfiguration {
  @doc("Property audio")
  audio?: AudioOverrideConfiguration;

  @doc("Property document")
  document?: DocumentOverrideConfiguration;

  @doc("Property image")
  image?: ImageOverrideConfiguration;

  @doc("Modality routing configuration")
  modalityRouting?: ModalityRoutingConfiguration;

  @doc("Property video")
  video?: VideoOverrideConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StandardOutputConfiguration")
model StandardOutputConfiguration {
  @doc("Property audio")
  audio?: AudioStandardOutputConfiguration;

  @doc("Property document")
  document?: DocumentStandardOutputConfiguration;

  @doc("Property image")
  image?: ImageStandardOutputConfiguration;

  @doc("Property video")
  video?: VideoStandardOutputConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Key for the tag")
  key?: string;

  @doc("Value for the tag")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BlueprintItem")
model BlueprintItem {
  @doc("ARN of a Blueprint")
  blueprintArn?: string;

  @doc("Stage of the Blueprint")
  blueprintStage?: BlueprintItemBlueprintStage;

  @doc("Blueprint Version")
  blueprintVersion?: string;
}

@doc("BlueprintItemBlueprintStage enum")
union BlueprintItemBlueprintStage {
  @doc("BlueprintItemBlueprintStage enum DEVELOPMENT")
  DEVELOPMENT: "DEVELOPMENT",

  @doc("BlueprintItemBlueprintStage enum LIVE")
  LIVE: "LIVE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AudioOverrideConfiguration")
model AudioOverrideConfiguration {
  @doc("Property modalityProcessing")
  modalityProcessing?: ModalityProcessingConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DocumentOverrideConfiguration")
model DocumentOverrideConfiguration {
  @doc("Property modalityProcessing")
  modalityProcessing?: ModalityProcessingConfiguration;

  @doc("Property splitter")
  splitter?: SplitterConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ImageOverrideConfiguration")
model ImageOverrideConfiguration {
  @doc("Property modalityProcessing")
  modalityProcessing?: ModalityProcessingConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ModalityRoutingConfiguration")
model ModalityRoutingConfiguration {
  @doc("Property jpeg")
  jpeg?: ModalityRoutingConfigurationjpeg;

  @doc("Property mov")
  mov?: ModalityRoutingConfigurationmov;

  @doc("Property mp4")
  mp4?: ModalityRoutingConfigurationmp4;

  @doc("Property png")
  png?: ModalityRoutingConfigurationpng;
}

@doc("ModalityRoutingConfigurationjpeg enum")
union ModalityRoutingConfigurationjpeg {
  @doc("ModalityRoutingConfigurationjpeg enum AUDIO")
  AUDIO: "AUDIO",

  @doc("ModalityRoutingConfigurationjpeg enum DOCUMENT")
  DOCUMENT: "DOCUMENT",

  @doc("ModalityRoutingConfigurationjpeg enum IMAGE")
  IMAGE: "IMAGE",

  @doc("ModalityRoutingConfigurationjpeg enum VIDEO")
  VIDEO: "VIDEO",

  string,
}

@doc("ModalityRoutingConfigurationmp4 enum")
union ModalityRoutingConfigurationmp4 {
  @doc("ModalityRoutingConfigurationmp4 enum AUDIO")
  AUDIO: "AUDIO",

  @doc("ModalityRoutingConfigurationmp4 enum DOCUMENT")
  DOCUMENT: "DOCUMENT",

  @doc("ModalityRoutingConfigurationmp4 enum IMAGE")
  IMAGE: "IMAGE",

  @doc("ModalityRoutingConfigurationmp4 enum VIDEO")
  VIDEO: "VIDEO",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VideoOverrideConfiguration")
model VideoOverrideConfiguration {
  @doc("Property modalityProcessing")
  modalityProcessing?: ModalityProcessingConfiguration;
}

@doc("ModalityRoutingConfigurationmov enum")
union ModalityRoutingConfigurationmov {
  @doc("ModalityRoutingConfigurationmov enum AUDIO")
  AUDIO: "AUDIO",

  @doc("ModalityRoutingConfigurationmov enum DOCUMENT")
  DOCUMENT: "DOCUMENT",

  @doc("ModalityRoutingConfigurationmov enum IMAGE")
  IMAGE: "IMAGE",

  @doc("ModalityRoutingConfigurationmov enum VIDEO")
  VIDEO: "VIDEO",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AudioStandardOutputConfiguration")
model AudioStandardOutputConfiguration {
  @doc("Property extraction")
  extraction?: AudioStandardExtraction;

  @doc("Property generativeField")
  generativeField?: AudioStandardGenerativeField;
}

@doc("ModalityRoutingConfigurationpng enum")
union ModalityRoutingConfigurationpng {
  @doc("ModalityRoutingConfigurationpng enum AUDIO")
  AUDIO: "AUDIO",

  @doc("ModalityRoutingConfigurationpng enum DOCUMENT")
  DOCUMENT: "DOCUMENT",

  @doc("ModalityRoutingConfigurationpng enum IMAGE")
  IMAGE: "IMAGE",

  @doc("ModalityRoutingConfigurationpng enum VIDEO")
  VIDEO: "VIDEO",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DocumentStandardOutputConfiguration")
model DocumentStandardOutputConfiguration {
  @doc("Property extraction")
  extraction?: DocumentStandardExtraction;

  @doc("Property generativeField")
  generativeField?: DocumentStandardGenerativeField;

  @doc("Property outputFormat")
  outputFormat?: DocumentOutputFormat;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ImageStandardOutputConfiguration")
model ImageStandardOutputConfiguration {
  @doc("Property extraction")
  extraction?: ImageStandardExtraction;

  @doc("Property generativeField")
  generativeField?: ImageStandardGenerativeField;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VideoStandardOutputConfiguration")
model VideoStandardOutputConfiguration {
  @doc("Property extraction")
  extraction?: VideoStandardExtraction;

  @doc("Property generativeField")
  generativeField?: VideoStandardGenerativeField;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ModalityProcessingConfiguration")
model ModalityProcessingConfiguration {
  @doc("Property state")
  state?: ModalityProcessingConfigurationState;
}

@doc("ModalityProcessingConfigurationState enum")
union ModalityProcessingConfigurationState {
  @doc("ModalityProcessingConfigurationState enum DISABLED")
  DISABLED: "DISABLED",

  @doc("ModalityProcessingConfigurationState enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SplitterConfiguration")
model SplitterConfiguration {
  @doc("Property state")
  state?: SplitterConfigurationState;
}

@doc("SplitterConfigurationState enum")
union SplitterConfigurationState {
  @doc("SplitterConfigurationState enum DISABLED")
  DISABLED: "DISABLED",

  @doc("SplitterConfigurationState enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AudioStandardExtraction")
model AudioStandardExtraction {
  @doc("Property category")
  category?: AudioExtractionCategory;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AudioStandardGenerativeField")
model AudioStandardGenerativeField {
  @doc("Property state")
  state?: AudioStandardGenerativeFieldState;

  @doc("Property types")
  types?: string[];
}

@doc("AudioStandardGenerativeFieldState enum")
union AudioStandardGenerativeFieldState {
  @doc("AudioStandardGenerativeFieldState enum DISABLED")
  DISABLED: "DISABLED",

  @doc("AudioStandardGenerativeFieldState enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DocumentStandardExtraction")
model DocumentStandardExtraction {
  @doc("Property boundingBox")
  boundingBox?: DocumentBoundingBox;

  @doc("Property granularity")
  granularity?: DocumentExtractionGranularity;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DocumentStandardGenerativeField")
model DocumentStandardGenerativeField {
  @doc("Property state")
  state?: DocumentStandardGenerativeFieldState;
}

@doc("DocumentStandardGenerativeFieldState enum")
union DocumentStandardGenerativeFieldState {
  @doc("DocumentStandardGenerativeFieldState enum DISABLED")
  DISABLED: "DISABLED",

  @doc("DocumentStandardGenerativeFieldState enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DocumentOutputFormat")
model DocumentOutputFormat {
  @doc("Property additionalFileFormat")
  additionalFileFormat?: DocumentOutputAdditionalFileFormat;

  @doc("Property textFormat")
  textFormat?: DocumentOutputTextFormat;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ImageStandardExtraction")
model ImageStandardExtraction {
  @doc("Property boundingBox")
  boundingBox?: ImageBoundingBox;

  @doc("Property category")
  category?: ImageExtractionCategory;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ImageStandardGenerativeField")
model ImageStandardGenerativeField {
  @doc("Property state")
  state?: ImageStandardGenerativeFieldState;

  @doc("Property types")
  types?: string[];
}

@doc("ImageStandardGenerativeFieldState enum")
union ImageStandardGenerativeFieldState {
  @doc("ImageStandardGenerativeFieldState enum DISABLED")
  DISABLED: "DISABLED",

  @doc("ImageStandardGenerativeFieldState enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VideoStandardExtraction")
model VideoStandardExtraction {
  @doc("Property boundingBox")
  boundingBox?: VideoBoundingBox;

  @doc("Property category")
  category?: VideoExtractionCategory;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VideoStandardGenerativeField")
model VideoStandardGenerativeField {
  @doc("Property state")
  state?: VideoStandardGenerativeFieldState;

  @doc("Property types")
  types?: string[];
}

@doc("VideoStandardGenerativeFieldState enum")
union VideoStandardGenerativeFieldState {
  @doc("VideoStandardGenerativeFieldState enum DISABLED")
  DISABLED: "DISABLED",

  @doc("VideoStandardGenerativeFieldState enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AudioExtractionCategory")
model AudioExtractionCategory {
  @doc("Property state")
  state?: AudioExtractionCategoryState;

  @doc("Property typeConfiguration")
  typeConfiguration?: AudioExtractionCategoryTypeConfiguration;

  @doc("Property types")
  types?: string[];
}

@doc("AudioExtractionCategoryState enum")
union AudioExtractionCategoryState {
  @doc("AudioExtractionCategoryState enum DISABLED")
  DISABLED: "DISABLED",

  @doc("AudioExtractionCategoryState enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DocumentBoundingBox")
model DocumentBoundingBox {
  @doc("Property state")
  state?: DocumentBoundingBoxState;
}

@doc("DocumentBoundingBoxState enum")
union DocumentBoundingBoxState {
  @doc("DocumentBoundingBoxState enum DISABLED")
  DISABLED: "DISABLED",

  @doc("DocumentBoundingBoxState enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DocumentExtractionGranularity")
model DocumentExtractionGranularity {
  @doc("Property types")
  types?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DocumentOutputAdditionalFileFormat")
model DocumentOutputAdditionalFileFormat {
  @doc("Property state")
  state?: DocumentOutputAdditionalFileFormatState;
}

@doc("DocumentOutputAdditionalFileFormatState enum")
union DocumentOutputAdditionalFileFormatState {
  @doc("DocumentOutputAdditionalFileFormatState enum DISABLED")
  DISABLED: "DISABLED",

  @doc("DocumentOutputAdditionalFileFormatState enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DocumentOutputTextFormat")
model DocumentOutputTextFormat {
  @doc("Property types")
  types?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ImageBoundingBox")
model ImageBoundingBox {
  @doc("Property state")
  state?: ImageBoundingBoxState;
}

@doc("ImageBoundingBoxState enum")
union ImageBoundingBoxState {
  @doc("ImageBoundingBoxState enum DISABLED")
  DISABLED: "DISABLED",

  @doc("ImageBoundingBoxState enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ImageExtractionCategory")
model ImageExtractionCategory {
  @doc("Property state")
  state?: ImageExtractionCategoryState;

  @doc("Property types")
  types?: string[];
}

@doc("ImageExtractionCategoryState enum")
union ImageExtractionCategoryState {
  @doc("ImageExtractionCategoryState enum DISABLED")
  DISABLED: "DISABLED",

  @doc("ImageExtractionCategoryState enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VideoBoundingBox")
model VideoBoundingBox {
  @doc("Property state")
  state?: VideoBoundingBoxState;
}

@doc("VideoBoundingBoxState enum")
union VideoBoundingBoxState {
  @doc("VideoBoundingBoxState enum DISABLED")
  DISABLED: "DISABLED",

  @doc("VideoBoundingBoxState enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VideoExtractionCategory")
model VideoExtractionCategory {
  @doc("Property state")
  state?: VideoExtractionCategoryState;

  @doc("Property types")
  types?: string[];
}

@doc("VideoExtractionCategoryState enum")
union VideoExtractionCategoryState {
  @doc("VideoExtractionCategoryState enum DISABLED")
  DISABLED: "DISABLED",

  @doc("VideoExtractionCategoryState enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AudioExtractionCategoryTypeConfiguration")
model AudioExtractionCategoryTypeConfiguration {
  @doc("Property transcript")
  transcript?: TranscriptConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TranscriptConfiguration")
model TranscriptConfiguration {
  @doc("Property channelLabeling")
  channelLabeling?: ChannelLabelingConfiguration;

  @doc("Property speakerLabeling")
  speakerLabeling?: SpeakerLabelingConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ChannelLabelingConfiguration")
model ChannelLabelingConfiguration {
  @doc("Property state")
  state?: ChannelLabelingConfigurationState;
}

@doc("ChannelLabelingConfigurationState enum")
union ChannelLabelingConfigurationState {
  @doc("ChannelLabelingConfigurationState enum DISABLED")
  DISABLED: "DISABLED",

  @doc("ChannelLabelingConfigurationState enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SpeakerLabelingConfiguration")
model SpeakerLabelingConfiguration {
  @doc("Property state")
  state?: SpeakerLabelingConfigurationState;
}

@doc("SpeakerLabelingConfigurationState enum")
union SpeakerLabelingConfigurationState {
  @doc("SpeakerLabelingConfigurationState enum DISABLED")
  DISABLED: "DISABLED",

  @doc("SpeakerLabelingConfigurationState enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface BedrockDataAutomationProjects {
  get is ArmResourceRead<BedrockDataAutomationProject>;
  @doc("Create a BedrockDataAutomationProject. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<BedrockDataAutomationProject>;
  update is ArmCustomPatchAsync<
    BedrockDataAutomationProject,
    Azure.ResourceManager.Foundations.TagsUpdateModel<BedrockDataAutomationProject>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<BedrockDataAutomationProject>;
  listByResourceGroup is ArmResourceListByParent<BedrockDataAutomationProject>;
  listBySubscription is ArmListBySubscription<BedrockDataAutomationProject>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Bedrock::DataAutomationProject
//--------------------------------------------------------------------------------------------
