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

//---------------------------------------------- BedrockFlowAliases ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Bedrock Flow Alias",
    plural: "Bedrock Flow Aliases",
  },
  keywords: ["Microsoft.AwsConnector", "Bedrock", "Flow", "Alias"],
})
@doc("A Microsoft.AwsConnector resource")
model BedrockFlowAlias is TrackedResource<BedrockFlowAliasProperties> {
  @doc("Name of BedrockFlowAlias")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("bedrockFlowAliases")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BedrockFlowAlias")
model BedrockFlowAliasProperties {
  @doc("AWS Properties")
  awsProperties?: AwsBedrockFlowAliasProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsBedrockFlowAlias")
model AwsBedrockFlowAliasProperties {
  @doc("Arn of the Flow Alias")
  arn?: string;

  @doc("Property concurrencyConfiguration")
  concurrencyConfiguration?: FlowAliasConcurrencyConfiguration;

  @doc("Time Stamp.")
  createdAt?: string;

  @doc("Description of the Resource.")
  description?: string;

  @doc("Arn representation of the Flow")
  flowArn?: string;

  @doc("Identifier for a flow resource.")
  flowId?: string;

  @doc("Id for a Flow Alias generated at the server side.")
  id?: string;

  @doc("Name for a resource.")
  name?: string;

  @doc("Routing configuration for a Flow alias.")
  @Azure.ResourceManager.identifiers(#[])
  routingConfiguration?: FlowAliasRoutingConfigurationListItem[];

  @doc("A map of tag keys and values")
  tags?: Record<string>;

  @doc("Time Stamp.")
  updatedAt?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FlowAliasConcurrencyConfiguration")
model FlowAliasConcurrencyConfiguration {
  @doc("Number of nodes executed concurrently at a time")
  maxConcurrency?: int32;

  @doc("Property type")
  type?: FlowAliasConcurrencyConfigurationType;
}

@doc("FlowAliasConcurrencyConfigurationType enum")
union FlowAliasConcurrencyConfigurationType {
  @doc("FlowAliasConcurrencyConfigurationType enum Automatic")
  Automatic: "Automatic",

  @doc("FlowAliasConcurrencyConfigurationType enum Manual")
  Manual: "Manual",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FlowAliasRoutingConfigurationListItem")
model FlowAliasRoutingConfigurationListItem {
  @doc("Version.")
  flowVersion?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface BedrockFlowAliases {
  get is ArmResourceRead<BedrockFlowAlias>;
  @doc("Create a BedrockFlowAlias. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<BedrockFlowAlias>;
  update is ArmCustomPatchAsync<
    BedrockFlowAlias,
    Azure.ResourceManager.Foundations.TagsUpdateModel<BedrockFlowAlias>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<BedrockFlowAlias>;
  listByResourceGroup is ArmResourceListByParent<BedrockFlowAlias>;
  listBySubscription is ArmListBySubscription<BedrockFlowAlias>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Bedrock::FlowAlias
//--------------------------------------------------------------------------------------------
