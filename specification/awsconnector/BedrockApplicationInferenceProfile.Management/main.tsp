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

//---------------------------------------------- BedrockApplicationInferenceProfiles ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Bedrock Application Inference Profile",
    plural: "Bedrock Application Inference Profiles",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "Bedrock",
    "Application",
    "Inference",
    "Profile"
  ],
})
@doc("A Microsoft.AwsConnector resource")
model BedrockApplicationInferenceProfile
  is TrackedResource<BedrockApplicationInferenceProfileProperties> {
  @doc("Name of BedrockApplicationInferenceProfile")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("bedrockApplicationInferenceProfiles")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BedrockApplicationInferenceProfile")
model BedrockApplicationInferenceProfileProperties {
  @doc("AWS Properties")
  awsProperties?: AwsBedrockApplicationInferenceProfileProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsBedrockApplicationInferenceProfile")
model AwsBedrockApplicationInferenceProfileProperties {
  @doc("Time Stamp")
  createdAt?: string;

  @doc("Description of the inference profile")
  description?: string;

  @doc("Property inferenceProfileArn")
  inferenceProfileArn?: string;

  @doc("Property inferenceProfileId")
  inferenceProfileId?: string;

  @doc("Inference profile identifier. Supports both system-defined inference profile ids, and inference profile ARNs.")
  inferenceProfileIdentifier?: string;

  @doc("Property inferenceProfileName")
  inferenceProfileName?: string;

  @doc("Various ways to encode a list of models in a CreateInferenceProfile request")
  modelSource?: InferenceProfileModelSource;

  @doc("List of model configuration")
  @Azure.ResourceManager.identifiers(#[])
  models?: InferenceProfileModel[];

  @doc("Status of the Inference Profile")
  status?: Status;

  @doc("List of Tags")
  @Azure.ResourceManager.identifiers(#[])
  tags?: Tag[];

  @doc("Type of the Inference Profile")
  type?: Type;

  @doc("Time Stamp")
  updatedAt?: string;
}

@doc("Status enum")
union Status {
  @doc("Status enum ACTIVE")
  ACTIVE: "ACTIVE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InferenceProfileModelSource")
model InferenceProfileModelSource {
  @doc("Source arns for a custom inference profile to copy its regional load balancing config from. Thiscan either be a foundation model or predefined inference profile ARN.")
  copyFrom?: string;
}

@doc("Type enum")
union Type {
  @doc("Type enum APPLICATION")
  APPLICATION: "APPLICATION",

  @doc("Type enum SYSTEM_DEFINED")
  SYSTEM_DEFINED: "SYSTEM_DEFINED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InferenceProfileModel")
model InferenceProfileModel {
  @doc("ARN for Foundation Models in Bedrock. These models can be used as base models for model customization jobs")
  modelArn?: string;
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface BedrockApplicationInferenceProfiles {
  get is ArmResourceRead<BedrockApplicationInferenceProfile>;
  @doc("Create a BedrockApplicationInferenceProfile. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<BedrockApplicationInferenceProfile>;
  update is ArmCustomPatchAsync<
    BedrockApplicationInferenceProfile,
    Azure.ResourceManager.Foundations.TagsUpdateModel<BedrockApplicationInferenceProfile>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<BedrockApplicationInferenceProfile>;
  listByResourceGroup is ArmResourceListByParent<BedrockApplicationInferenceProfile>;
  listBySubscription is ArmListBySubscription<BedrockApplicationInferenceProfile>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Bedrock::ApplicationInferenceProfile
//--------------------------------------------------------------------------------------------
