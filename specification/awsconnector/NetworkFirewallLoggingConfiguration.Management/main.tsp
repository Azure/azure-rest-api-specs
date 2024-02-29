import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Supress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service({
  title: "Microsoft.AwsConnector",
  version: "2024-08-01-preview",
})
@doc("Microsoft.AwsConnector Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AwsConnector;

//---------------------------------------------- NetworkFirewallLoggingConfigurations ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model NetworkFirewallLoggingConfiguration
  is TrackedResource<NetworkFirewallLoggingConfigurationProperties> {
  @doc("Name of NetworkFirewallLoggingConfiguration")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("networkFirewallLoggingConfigurations")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of NetworkFirewallLoggingConfiguration")
model NetworkFirewallLoggingConfigurationProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsNetworkFirewallLoggingConfigurationProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of awsNetworkFirewallLoggingConfiguration")
model AwsNetworkFirewallLoggingConfigurationProperties {
  @doc("Gets and sets the property firewallArn. A resource ARN.")
  firewallArn?: string;

  @doc("Gets and sets the property firewallName.")
  firewallName?: string;

  @doc("Gets and sets the property loggingConfiguration.")
  loggingConfiguration?: LoggingConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of LoggingConfiguration")
model LoggingConfiguration {
  @doc("Gets and sets the property logDestinationConfigs.")
  @extension("x-ms-identifiers", [])
  logDestinationConfigs?: LogDestinationConfig[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of LogDestinationConfig")
model LogDestinationConfig {
  @doc("Gets and sets the property logDestination. A key-value pair to configure the logDestinations.")
  logDestination?: unknown;

  @doc("Gets and sets the property logDestinationType.")
  logDestinationType?: LogDestinationConfigLogDestinationType;

  @doc("Gets and sets the property logType.")
  logType?: LogDestinationConfigLogType;
}

@doc("LogDestinationConfigLogDestinationType enum")
enum LogDestinationConfigLogDestinationType {
  @doc("LogDestinationConfigLogDestinationType enum CloudWatchLogs")
  CloudWatchLogs: "CloudWatchLogs",

  @doc("LogDestinationConfigLogDestinationType enum KinesisDataFirehose")
  KinesisDataFirehose: "KinesisDataFirehose",

  @doc("LogDestinationConfigLogDestinationType enum S3")
  S3: "S3",
}

@doc("LogDestinationConfigLogType enum")
enum LogDestinationConfigLogType {
  @doc("LogDestinationConfigLogType enum ALERT")
  ALERT: "ALERT",

  @doc("LogDestinationConfigLogType enum FLOW")
  FLOW: "FLOW",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface NetworkFirewallLoggingConfigurations {
  get is ArmResourceRead<NetworkFirewallLoggingConfiguration>;
  @doc("Create a NetworkFirewallLoggingConfiguration. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<NetworkFirewallLoggingConfiguration>;
  update is ArmCustomPatchAsync<
    NetworkFirewallLoggingConfiguration,
    Azure.ResourceManager.Foundations.TagsUpdateModel<NetworkFirewallLoggingConfiguration>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<NetworkFirewallLoggingConfiguration>;
  listByResourceGroup is ArmResourceListByParent<NetworkFirewallLoggingConfiguration>;
  listBySubscription is ArmListBySubscription<NetworkFirewallLoggingConfiguration>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::NetworkFirewall::LoggingConfiguration
//--------------------------------------------------------------------------------------------
