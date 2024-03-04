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

//---------------------------------------------- Ec2VPCEndpoints ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model Ec2VPCEndpoint is TrackedResource<Ec2VPCEndpointProperties> {
  @doc("Name of Ec2VPCEndpoint")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ec2VPCEndpoints")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of Ec2VPCEndpoint")
model Ec2VPCEndpointProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsEc2VPCEndpointProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of awsEc2VPCEndpoint")
model AwsEc2VPCEndpointProperties {
  @doc("Gets and sets the property creationTimestamp.")
  creationTimestamp?: string;

  @doc("Gets and sets the property dnsEntries.")
  @extension("x-ms-identifiers", [])
  dnsEntries?: string[];

  @doc("Gets and sets the property id.")
  id?: string;

  @doc("Gets and sets the property networkInterfaceIds.")
  @extension("x-ms-identifiers", [])
  networkInterfaceIds?: string[];

  @doc("Gets and sets the property policyDocument. A policy to attach to the endpoint that controls access to the service.")
  policyDocument?: string;

  @doc("Gets and sets the property privateDnsEnabled. Indicate whether to associate a private hosted zone with the specified VPC.")
  privateDnsEnabled?: boolean;

  @doc("Gets and sets the property routeTableIds. One or more route table IDs.")
  @extension("x-ms-identifiers", [])
  routeTableIds?: string[];

  @doc("Gets and sets the property securityGroupIds. The ID of one or more security groups to associate with the endpoint network interface.")
  @extension("x-ms-identifiers", [])
  securityGroupIds?: string[];

  @doc("Gets and sets the property serviceName. The service name.")
  serviceName?: string;

  @doc("Gets and sets the property subnetIds. The ID of one or more subnets in which to create an endpoint network interface.")
  @extension("x-ms-identifiers", [])
  subnetIds?: string[];

  @doc("Gets and sets the property vpcEndpointType.")
  vpcEndpointType?: VpcEndpointType;

  @doc("Gets and sets the property vpcId. The ID of the VPC in which the endpoint will be used.")
  vpcId?: string;
}

@doc("VpcEndpointType enum")
enum VpcEndpointType {
  @doc("VpcEndpointType enum Gateway")
  Gateway: "Gateway",

  @doc("VpcEndpointType enum GatewayLoadBalancer")
  GatewayLoadBalancer: "GatewayLoadBalancer",

  @doc("VpcEndpointType enum Interface")
  Interface: "Interface",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Ec2VPCEndpoints {
  get is ArmResourceRead<Ec2VPCEndpoint>;
  @doc("Create a Ec2VPCEndpoint. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Ec2VPCEndpoint>;
  update is ArmCustomPatchAsync<
    Ec2VPCEndpoint,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Ec2VPCEndpoint>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Ec2VPCEndpoint>;
  listByResourceGroup is ArmResourceListByParent<Ec2VPCEndpoint>;
  listBySubscription is ArmListBySubscription<Ec2VPCEndpoint>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::EC2::VPCEndpoint
//--------------------------------------------------------------------------------------------
