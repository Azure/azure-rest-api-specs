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
@doc("Definition of NetworkFirewallFirewall")
model NetworkFirewallFirewallProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsNetworkFirewallFirewallProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of awsNetworkFirewallFirewall")
model AwsNetworkFirewallFirewallProperties {
  @doc("Gets and sets the property deleteProtection.")
  deleteProtection?: boolean;

  @doc("Gets and sets the property description.")
  description?: string;

  @doc("Gets and sets the property endpointIds.")
  @extension("x-ms-identifiers", [])
  endpointIds?: string[];

  @doc("Gets and sets the property firewallArn. A resource ARN.")
  firewallArn?: string;

  @doc("Gets and sets the property firewallId.")
  firewallId?: string;

  @doc("Gets and sets the property firewallName.")
  firewallName?: string;

  @doc("Gets and sets the property firewallPolicyArn. A resource ARN.")
  firewallPolicyArn?: string;

  @doc("Gets and sets the property firewallPolicyChangeProtection.")
  firewallPolicyChangeProtection?: boolean;

  @doc("Gets and sets the property subnetChangeProtection.")
  subnetChangeProtection?: boolean;

  @doc("Gets and sets the property subnetMappings.")
  @extension("x-ms-identifiers", [])
  subnetMappings?: SubnetMapping[];

  @doc("Gets and sets the property tags.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Gets and sets the property vpcId.")
  vpcId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of SubnetMapping")
model SubnetMapping {
  @doc("Gets and sets the property iPAddressType. A IPAddressType")
  iPAddressType?: string;

  @doc("Gets and sets the property subnetId. A SubnetId.")
  subnetId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key.")
  key?: string;

  @doc("Gets and sets the property value.")
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
