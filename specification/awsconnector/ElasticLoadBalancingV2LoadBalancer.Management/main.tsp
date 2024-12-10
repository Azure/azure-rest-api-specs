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
@service({
  title: "Microsoft.AwsConnector",
})
@doc("Microsoft.AwsConnector Resource Provider management API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AwsConnector;

/** Api versions */
enum Versions {
  /** 2024-12-01 api version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-12-01`,
}

//---------------------------------------------- ElasticLoadBalancingV2LoadBalancers ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Elastic Load Balancing V2 Load Balancer",
    plural: "Elastic Load Balancing V2 Load Balancers",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "Elastic",
    "Load",
    "Balancing",
    "V2",
    "Load",
    "Balancer"
  ],
})
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
  @doc("AWS Properties")
  awsProperties?: AwsElasticLoadBalancingV2LoadBalancerProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsElasticLoadBalancingV2LoadBalancer")
model AwsElasticLoadBalancingV2LoadBalancerProperties {
  @doc("Property canonicalHostedZoneID")
  canonicalHostedZoneID?: string;

  @doc("Property dnsName")
  dnsName?: string;

  @doc("Indicates whether to evaluate inbound security group rules for traffic sent to a Network Load Balancer through privatelink.")
  enforceSecurityGroupInboundRulesOnPrivateLinkTraffic?: string;

  @doc("The IP address type. The possible values are ``ipv4`` (for IPv4 addresses) and ``dualstack`` (for IPv4 and IPv6 addresses). You can’t specify ``dualstack`` for a load balancer with a UDP or TCP_UDP listener.")
  ipAddressType?: string;

  @doc("Property loadBalancerArn")
  loadBalancerArn?: string;

  @doc("The load balancer attributes.")
  @extension("x-ms-identifiers", [])
  loadBalancerAttributes?: LoadBalancerAttribute[];

  @doc("Property loadBalancerFullName")
  loadBalancerFullName?: string;

  @doc("Property loadBalancerName")
  loadBalancerName?: string;

  @doc("The name of the load balancer. This name must be unique per region per account, can have a maximum of 32 characters, must contain only alphanumeric characters or hyphens, must not begin or end with a hyphen, and must not begin with 'internal-'. If you don't specify a name, AWS CloudFormation generates a unique physical ID for the load balancer. If you specify a name, you cannot perform updates that require replacement of this resource, but you can perform other updates. To replace the resource, specify a new name.")
  name?: string;

  @doc("The nodes of an Internet-facing load balancer have public IP addresses. The DNS name of an Internet-facing load balancer is publicly resolvable to the public IP addresses of the nodes. Therefore, Internet-facing load balancers can route requests from clients over the internet. The nodes of an internal load balancer have only private IP addresses. The DNS name of an internal load balancer is publicly resolvable to the private IP addresses of the nodes. Therefore, internal load balancers can route requests only from clients with access to the VPC for the load balancer. The default is an Internet-facing load balancer. You cannot specify a scheme for a Gateway Load Balancer.")
  scheme?: string;

  @doc("[Application Load Balancers and Network Load Balancers] The IDs of the security groups for the load balancer.")
  @extension("x-ms-identifiers", [])
  securityGroups?: string[];

  @doc("The IDs of the subnets. You can specify only one subnet per Availability Zone. You must specify either subnets or subnet mappings, but not both. [Application Load Balancers] You must specify subnets from at least two Availability Zones. You cannot specify Elastic IP addresses for your subnets. [Application Load Balancers on Outposts] You must specify one Outpost subnet. [Application Load Balancers on Local Zones] You can specify subnets from one or more Local Zones. [Network Load Balancers] You can specify subnets from one or more Availability Zones. You can specify one Elastic IP address per subnet if you need static IP addresses for your internet-facing load balancer. For internal load balancers, you can specify one private IP address per subnet from the IPv4 range of the subnet. For internet-facing load balancer, you can specify one IPv6 address per subnet. [Gateway Load Balancers] You can specify subnets from one or more Availability Zones. You cannot specify Elastic IP addresses for your subnets.")
  @extension("x-ms-identifiers", [])
  subnetMappings?: SubnetMapping[];

  @doc("The IDs of the subnets. You can specify only one subnet per Availability Zone. You must specify either subnets or subnet mappings, but not both. To specify an Elastic IP address, specify subnet mappings instead of subnets. [Application Load Balancers] You must specify subnets from at least two Availability Zones. [Application Load Balancers on Outposts] You must specify one Outpost subnet. [Application Load Balancers on Local Zones] You can specify subnets from one or more Local Zones. [Network Load Balancers] You can specify subnets from one or more Availability Zones. [Gateway Load Balancers] You can specify subnets from one or more Availability Zones.")
  @extension("x-ms-identifiers", [])
  subnets?: string[];

  @doc("The tags to assign to the load balancer.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("The type of load balancer. The default is ``application``.")
  type?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LoadBalancerAttribute")
model LoadBalancerAttribute {
  @doc("The name of the attribute. The following attributes are supported by all load balancers:  +   ``deletion_protection.enabled`` - Indicates whether deletion protection is enabled. The value is ``true`` or ``false``. The default is ``false``.  +   ``load_balancing.cross_zone.enabled`` - Indicates whether cross-zone load balancing is enabled. The possible values are ``true`` and ``false``. The default for Network Load Balancers and Gateway Load Balancers is ``false``. The default for Application Load Balancers is ``true``, and cannot be changed.   The following attributes are supported by both Application Load Balancers and Network Load Balancers:  +   ``access_logs.s3.enabled`` - Indicates whether access logs are enabled. The value is ``true`` or ``false``. The default is ``false``.  +   ``access_logs.s3.bucket`` - The name of the S3 bucket for the access logs. This attribute is required if access logs are enabled. The bucket must exist in the same region as the load balancer and have a bucket policy that grants Elastic Load Balancing permissions to write to the bucket.  +   ``access_logs.s3.prefix`` - The prefix for the location in the S3 bucket for the access logs.  +   ``ipv6.deny_all_igw_traffic`` - Blocks internet gateway (IGW) access to the load balancer. It is set to ``false`` for internet-facing load balancers and ``true`` for internal load balancers, preventing unintended access to your internal load balancer through an internet gateway.   The following attributes are supported by only Application Load Balancers:  +   ``idle_timeout.timeout_seconds`` - The idle timeout value, in seconds. The valid range is 1-4000 seconds. The default is 60 seconds.  +   ``client_keep_alive.seconds`` - The client keep alive value, in seconds. The valid range is 60-604800 seconds. The default is 3600 seconds.  +   ``connection_logs.s3.enabled`` - Indicates whether connection logs are enabled. The value is ``true`` or ``false``. The default is ``false``.  +   ``connection_logs.s3.bucket`` - The name of the S3 bucket for the connection logs. This attribute is required if connection logs are enabled. The bucket must exist in the same region as the load balancer and have a bucket policy that grants Elastic Load Balancing permissions to write to the bucket.  +   ``connection_logs.s3.prefix`` - The prefix for the location in the S3 bucket for the connection logs.  +   ``routing.http.desync_mitigation_mode`` - Determines how the load balancer handles requests that might pose a security risk to your application. The possible values are ``monitor``, ``defensive``, and ``strictest``. The default is ``defensive``.  +   ``routing.http.drop_invalid_header_fields.enabled`` - Indicates whether HTTP headers with invalid header fields are removed by the load balancer (``true``) or routed to targets (``false``). The default is ``false``.  +   ``routing.http.preserve_host_header.enabled`` - Indicates whether the Application Load Balancer should preserve the ``Host`` header in the HTTP request and send it to the target without any change. The possible values are ``true`` and ``false``. The default is ``false``.  +   ``routing.http.x_amzn_tls_version_and_cipher_suite.enabled`` - Indicates whether the two headers (``x-amzn-tls-version`` and ``x-amzn-tls-cipher-suite``), which contain information about the negotiated TLS version and cipher suite, are added to the client request before sending it to the target. The ``x-amzn-tls-version`` header has information about the TLS protocol version negotiated with the client, and the ``x-amzn-tls-cipher-suite`` header has information about the cipher suite negotiated with the client. Both headers are in OpenSSL format. The possible values for the attribute are ``true`` and ``false``. The default is ``false``.  +   ``routing.http.xff_client_port.enabled`` - Indicates whether the ``X-Forwarded-For`` header should preserve the source port that the client used to connect to the load balancer. The possible values are ``true`` and ``false``. The default is ``false``.  +   ``routing.http.xff_header_processing.mode`` - Enables you to modify, preserve, or remove the ``X-Forwarded-For`` header in the HTTP request before the Application Load Balancer sends the request to the target. The possible values are ``append``, ``preserve``, and ``remove``. The default is ``append``.  +  If the value is ``append``, the Application Load Balancer adds the client IP address (of the last hop) to the ``X-Forwarded-For`` header in the HTTP request before it sends it to targets.  +  If the value is ``preserve`` the Application Load Balancer preserves the ``X-Forwarded-For`` header in the HTTP request, and sends it to targets without any change.  +  If the value is ``remove``, the Application Load Balancer removes the ``X-Forwarded-For`` header in the HTTP request before it sends it to targets.    +   ``routing.http2.enabled`` - Indicates whether HTTP/2 is enabled. The possible values are ``true`` and ``false``. The default is ``true``. Elastic Load Balancing requires that message header names contain only alphanumeric characters and hyphens.  +   ``waf.fail_open.enabled`` - Indicates whether to allow a WAF-enabled load balancer to route requests to targets if it is unable to forward the request to AWS WAF. The possible values are ``true`` and ``false``. The default is ``false``.   The following attributes are supported by only Network Load Balancers:  +   ``dns_record.client_routing_policy`` - Indicates how traffic is distributed among the load balancer Availability Zones. The possible values are ``availability_zone_affinity`` with 100 percent zonal affinity, ``partial_availability_zone_affinity`` with 85 percent zonal affinity, and ``any_availability_zone`` with 0 percent zonal affinity.")
  key?: string;

  @doc("The value of the attribute.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SubnetMapping")
model SubnetMapping {
  @doc("[Network Load Balancers] The allocation ID of the Elastic IP address for an internet-facing load balancer.")
  allocationId?: string;

  @doc("[Network Load Balancers] The IPv6 address.")
  iPv6Address?: string;

  @doc("[Network Load Balancers] The private IPv4 address for an internal load balancer.")
  privateIPv4Address?: string;

  @doc("The ID of the subnet.")
  subnetId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("The key of the tag.")
  key?: string;

  @doc("The value of the tag.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface ElasticLoadBalancingV2LoadBalancers {
  get is ArmResourceRead<ElasticLoadBalancingV2LoadBalancer>;
  @doc("Create a ElasticLoadBalancingV2LoadBalancer. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<ElasticLoadBalancingV2LoadBalancer>;
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
