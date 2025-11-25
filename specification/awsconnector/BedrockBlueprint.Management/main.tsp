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

//---------------------------------------------- BedrockBlueprints ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Bedrock Blueprint",
    plural: "Bedrock Blueprints",
  },
  keywords: ["Microsoft.AwsConnector", "Bedrock", "Blueprint"],
})
@doc("A Microsoft.AwsConnector resource")
model BedrockBlueprint is TrackedResource<BedrockBlueprintProperties> {
  @doc("Name of BedrockBlueprint")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("bedrockBlueprints")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BedrockBlueprint")
model BedrockBlueprintProperties {
  @doc("AWS Properties")
  awsProperties?: AwsBedrockBlueprintProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsBedrockBlueprint")
model AwsBedrockBlueprintProperties {
  @doc("ARN of a Blueprint")
  blueprintArn?: string;

  @doc("Name of the Blueprint")
  blueprintName?: string;

  @doc("Stage of the Blueprint")
  blueprintStage?: BlueprintStage;

  @doc("Creation timestamp")
  creationTime?: string;

  @doc("KMS encryption context")
  kmsEncryptionContext?: Record<string>;

  @doc("KMS key identifier")
  kmsKeyId?: string;

  @doc("Last modified timestamp")
  lastModifiedTime?: string;

  @doc("Schema of the blueprint")
  schema?: unknown;

  @doc("List of Tags")
  @Azure.ResourceManager.identifiers(#[])
  tags?: Tag[];

  @doc("Modality Type")
  type?: Type;
}

@doc("BlueprintStage enum")
union BlueprintStage {
  @doc("BlueprintStage enum DEVELOPMENT")
  DEVELOPMENT: "DEVELOPMENT",

  @doc("BlueprintStage enum LIVE")
  LIVE: "LIVE",

  string,
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

@doc("Type enum")
union Type {
  @doc("Type enum AUDIO")
  AUDIO: "AUDIO",

  @doc("Type enum DOCUMENT")
  DOCUMENT: "DOCUMENT",

  @doc("Type enum IMAGE")
  IMAGE: "IMAGE",

  @doc("Type enum VIDEO")
  VIDEO: "VIDEO",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface BedrockBlueprints {
  get is ArmResourceRead<BedrockBlueprint>;
  @doc("Create a BedrockBlueprint. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<BedrockBlueprint>;
  update is ArmCustomPatchAsync<
    BedrockBlueprint,
    Azure.ResourceManager.Foundations.TagsUpdateModel<BedrockBlueprint>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<BedrockBlueprint>;
  listByResourceGroup is ArmResourceListByParent<BedrockBlueprint>;
  listBySubscription is ArmListBySubscription<BedrockBlueprint>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Bedrock::Blueprint
//--------------------------------------------------------------------------------------------
