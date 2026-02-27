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

//---------------------------------------------- BedrockAgentAliases ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Bedrock Agent Alias",
    plural: "Bedrock Agent Aliases",
  },
  keywords: ["Microsoft.AwsConnector", "Bedrock", "Agent", "Alias"],
})
@doc("A Microsoft.AwsConnector resource")
model BedrockAgentAlias is TrackedResource<BedrockAgentAliasProperties> {
  @doc("Name of BedrockAgentAlias")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("bedrockAgentAliases")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BedrockAgentAlias")
model BedrockAgentAliasProperties {
  @doc("AWS Properties")
  awsProperties?: AwsBedrockAgentAliasProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsBedrockAgentAlias")
model AwsBedrockAgentAliasProperties {
  @doc("Arn representation of the Agent Alias.")
  agentAliasArn?: string;

  @doc("The list of history events for an alias for an Agent.")
  @Azure.ResourceManager.identifiers(#[])
  agentAliasHistoryEvents?: AgentAliasHistoryEvent[];

  @doc("Id for an Agent Alias generated at the server side.")
  agentAliasId?: string;

  @doc("Name for a resource.")
  agentAliasName?: string;

  @doc("The statuses an Agent Alias can be in.")
  agentAliasStatus?: AgentAliasStatus;

  @doc("Identifier for a resource.")
  agentId?: string;

  @doc("Time Stamp.")
  createdAt?: string;

  @doc("Description of the Resource.")
  description?: string;

  @doc("Routing configuration for an Agent alias.")
  @Azure.ResourceManager.identifiers(#[])
  routingConfiguration?: AgentAliasRoutingConfigurationListItem[];

  @doc("A map of tag keys and values")
  tags?: Record<string>;

  @doc("Time Stamp.")
  updatedAt?: string;
}

@doc("AgentAliasStatus enum")
union AgentAliasStatus {
  @doc("AgentAliasStatus enum CREATING")
  CREATING: "CREATING",

  @doc("AgentAliasStatus enum DELETING")
  DELETING: "DELETING",

  @doc("AgentAliasStatus enum FAILED")
  FAILED: "FAILED",

  @doc("AgentAliasStatus enum PREPARED")
  PREPARED: "PREPARED",

  @doc("AgentAliasStatus enum UPDATING")
  UPDATING: "UPDATING",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AgentAliasHistoryEvent")
model AgentAliasHistoryEvent {
  @doc("Time Stamp.")
  endDate?: string;

  @doc("Routing configuration for an Agent alias.")
  @Azure.ResourceManager.identifiers(#[])
  routingConfiguration?: AgentAliasRoutingConfigurationListItem[];

  @doc("Time Stamp.")
  startDate?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AgentAliasRoutingConfigurationListItem")
model AgentAliasRoutingConfigurationListItem {
  @doc("Agent Version.")
  agentVersion?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface BedrockAgentAliases {
  get is ArmResourceRead<BedrockAgentAlias>;
  @doc("Create a BedrockAgentAlias. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<BedrockAgentAlias>;
  update is ArmCustomPatchAsync<
    BedrockAgentAlias,
    Azure.ResourceManager.Foundations.TagsUpdateModel<BedrockAgentAlias>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<BedrockAgentAlias>;
  listByResourceGroup is ArmResourceListByParent<BedrockAgentAlias>;
  listBySubscription is ArmListBySubscription<BedrockAgentAlias>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Bedrock::AgentAlias
//--------------------------------------------------------------------------------------------
