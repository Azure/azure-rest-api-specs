import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Supress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service({
  title: "Microsoft.AwsConnector",
})
@doc("Microsoft.AwsConnector Resource Provider management API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AwsConnector;

/** Api versions */
enum Versions {
  /** 2024-08-01-preview api version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-08-01-preview`,
}

//---------------------------------------------- NetworkFirewallFirewalls ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model NetworkFirewallFirewall
  is TrackedResource<NetworkFirewallFirewallProperties> {
  @doc("Name of NetworkFirewallFirewall")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("networkFirewallFirewalls")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NetworkFirewallFirewall")
model NetworkFirewallFirewallProperties {
  @doc("Awsproperties")
  awsProperties?: AwsNetworkFirewallFirewallProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsNetworkFirewallFirewall")
model AwsNetworkFirewallFirewallProperties {
  @doc("Deleteprotection")
  deleteProtection?: boolean;

  @doc("Description")
  description?: string;

  @doc("Endpointids")
  @extension("x-ms-identifiers", [])
  endpointIds?: string[];

  @doc(" A resource ARN.")
  firewallArn?: string;

  @doc("Firewallid")
  firewallId?: string;

  @doc("Firewallname")
  firewallName?: string;

  @doc(" A resource ARN.")
  firewallPolicyArn?: string;

  @doc("Firewallpolicychangeprotection")
  firewallPolicyChangeProtection?: boolean;

  @doc("Subnetchangeprotection")
  subnetChangeProtection?: boolean;

  @doc("Subnetmappings")
  @extension("x-ms-identifiers", [])
  subnetMappings?: SubnetMapping[];

  @doc("Tags")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Vpcid")
  vpcId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SubnetMapping")
model SubnetMapping {
  @doc(" A IPAddressType")
  ipAddressType?: string;

  @doc(" A SubnetId.")
  subnetId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Key")
  key?: string;

  @doc("Value")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface NetworkFirewallFirewalls {
  get is ArmResourceRead<NetworkFirewallFirewall>;
  @doc("Create a NetworkFirewallFirewall. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<NetworkFirewallFirewall>;
  update is ArmCustomPatchAsync<
    NetworkFirewallFirewall,
    Azure.ResourceManager.Foundations.TagsUpdateModel<NetworkFirewallFirewall>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<NetworkFirewallFirewall>;
  listByResourceGroup is ArmResourceListByParent<NetworkFirewallFirewall>;
  listBySubscription is ArmListBySubscription<NetworkFirewallFirewall>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::NetworkFirewall::Firewall
//--------------------------------------------------------------------------------------------
