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

//---------------------------------------------- ElasticLoadBalancingV2LoadBalancers ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model ElasticLoadBalancingV2LoadBalancer
  is TrackedResource<ElasticLoadBalancingV2LoadBalancerProperties> {
  @doc("Name of ElasticLoadBalancingV2LoadBalancer")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("elasticLoadBalancingV2LoadBalancers")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ElasticLoadBalancingV2LoadBalancer")
model ElasticLoadBalancingV2LoadBalancerProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsElasticLoadBalancingV2LoadBalancerProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsElasticLoadBalancingV2LoadBalancer")
model AwsElasticLoadBalancingV2LoadBalancerProperties {
  @doc("Gets and sets the property canonicalHostedZoneID. The ID of the Amazon Route 53 hosted zone associated with the load balancer.")
  canonicalHostedZoneID?: string;

  @doc("Gets and sets the property dnsName. The public DNS name of the load balancer.")
  dnsName?: string;

  @doc("Gets and sets the property enforceSecurityGroupInboundRulesOnPrivateLinkTraffic. Indicates whether to evaluate inbound security group rules for traffic sent to a Network Load Balancer through PrivateLink")
  enforceSecurityGroupInboundRulesOnPrivateLinkTraffic?: string;

  @doc("Gets and sets the property ipAddressType. The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 (for IPv4 addresses) and dualstack (for IPv4 and IPv6 addresses).")
  ipAddressType?: string;

  @doc("Gets and sets the property loadBalancerArn. The Amazon Resource Name (ARN) of the load balancer.")
  loadBalancerArn?: string;

  @doc("Gets and sets the property loadBalancerAttributes. The load balancer attributes.")
  @extension("x-ms-identifiers", [])
  loadBalancerAttributes?: LoadBalancerAttribute[];

  @doc("Gets and sets the property loadBalancerFullName. The full name of the load balancer.")
  loadBalancerFullName?: string;

  @doc("Gets and sets the property loadBalancerName. The name of the load balancer.")
  loadBalancerName?: string;

  @doc("Gets and sets the property name. The name of the load balancer.")
  name?: string;

  @doc("Gets and sets the property scheme. The nodes of an Internet-facing load balancer have public IP addresses. The DNS name of an Internet-facing load balancer is publicly resolvable to the public IP addresses of the nodes. Therefore, Internet-facing load balancers can route requests from clients over the internet. The nodes of an internal load balancer have only private IP addresses. The DNS name of an internal load balancer is publicly resolvable to the private IP addresses of the nodes. Therefore, internal load balancers can route requests only from clients with access to the VPC for the load balancer. The default is an Internet-facing load balancer.")
  scheme?: string;

  @doc("Gets and sets the property securityGroups. The IDs of the security groups for the load balancer.")
  @extension("x-ms-identifiers", [])
  securityGroups?: string[];

  @doc("Gets and sets the property subnetMappings. The IDs of the public subnets. You can specify only one subnet per Availability Zone. You must specify either subnets or subnet mappings, but not both.")
  @extension("x-ms-identifiers", [])
  subnetMappings?: SubnetMapping[];

  @doc("Gets and sets the property subnets. The IDs of the public subnets. You can specify only one subnet per Availability Zone. You must specify either subnets or subnet mappings, but not both. To specify an Elastic IP address, specify subnet mappings instead of subnets.")
  @extension("x-ms-identifiers", [])
  subnets?: string[];

  @doc("Gets and sets the property tags. The tags to assign to the load balancer.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Gets and sets the property type. The type of load balancer. The default is application.")
  type?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LoadBalancerAttribute")
model LoadBalancerAttribute {
  @doc("Gets and sets the property key.")
  key?: string;

  @doc("Gets and sets the property value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SubnetMapping")
model SubnetMapping {
  @doc("Gets and sets the property allocationId.")
  allocationId?: string;

  @doc("Gets and sets the property iPv6Address.")
  iPv6Address?: string;

  @doc("Gets and sets the property privateIPv4Address.")
  privateIPv4Address?: string;

  @doc("Gets and sets the property subnetId.")
  subnetId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key.")
  key?: string;

  @doc("Gets and sets the property value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface ElasticLoadBalancingV2LoadBalancers {
  get is ArmResourceRead<ElasticLoadBalancingV2LoadBalancer>;
  @doc("Create a ElasticLoadBalancingV2LoadBalancer. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ElasticLoadBalancingV2LoadBalancer>;
  update is ArmCustomPatchAsync<
    ElasticLoadBalancingV2LoadBalancer,
    Azure.ResourceManager.Foundations.TagsUpdateModel<ElasticLoadBalancingV2LoadBalancer>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ElasticLoadBalancingV2LoadBalancer>;
  listByResourceGroup is ArmResourceListByParent<ElasticLoadBalancingV2LoadBalancer>;
  listBySubscription is ArmListBySubscription<ElasticLoadBalancingV2LoadBalancer>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::ElasticLoadBalancingV2::LoadBalancer
//--------------------------------------------------------------------------------------------
