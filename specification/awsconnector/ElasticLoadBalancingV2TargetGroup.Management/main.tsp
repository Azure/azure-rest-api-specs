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

//---------------------------------------------- ElasticLoadBalancingV2TargetGroups ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model ElasticLoadBalancingV2TargetGroup
  is TrackedResource<ElasticLoadBalancingV2TargetGroupProperties> {
  @doc("Name of ElasticLoadBalancingV2TargetGroup")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("elasticLoadBalancingV2TargetGroups")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ElasticLoadBalancingV2TargetGroup")
model ElasticLoadBalancingV2TargetGroupProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsElasticLoadBalancingV2TargetGroupProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsElasticLoadBalancingV2TargetGroup")
model AwsElasticLoadBalancingV2TargetGroupProperties {
  @doc("Gets and sets the property healthCheckEnabled. Indicates whether health checks are enabled. If the target type is lambda, health checks are disabled by default but can be enabled. If the target type is instance, ip, or alb, health checks are always enabled and cannot be disabled.")
  healthCheckEnabled?: boolean;

  @doc("Gets and sets the property healthCheckIntervalSeconds. The approximate amount of time, in seconds, between health checks of an individual target.")
  healthCheckIntervalSeconds?: int32;

  @doc("Gets and sets the property healthCheckPath. [HTTP/HTTPS health checks] The destination for health checks on the targets. [HTTP1 or HTTP2 protocol version] The ping path. The default is /. [GRPC protocol version] The path of a custom health check method with the format /package.service/method. The default is /AWS.ALB/healthcheck.")
  healthCheckPath?: string;

  @doc("Gets and sets the property healthCheckPort. The port the load balancer uses when performing health checks on targets. ")
  healthCheckPort?: string;

  @doc("Gets and sets the property healthCheckProtocol. The protocol the load balancer uses when performing health checks on targets. ")
  healthCheckProtocol?: string;

  @doc("Gets and sets the property healthCheckTimeoutSeconds. The amount of time, in seconds, during which no response from a target means a failed health check.")
  healthCheckTimeoutSeconds?: int32;

  @doc("Gets and sets the property healthyThresholdCount. The number of consecutive health checks successes required before considering an unhealthy target healthy. ")
  healthyThresholdCount?: int32;

  @doc("Gets and sets the property ipAddressType. The type of IP address used for this target group. The possible values are ipv4 and ipv6. ")
  ipAddressType?: string;

  @doc("Gets and sets the property loadBalancerArns. The Amazon Resource Names (ARNs) of the load balancers that route traffic to this target group.")
  @extension("x-ms-identifiers", [])
  loadBalancerArns?: string[];

  @doc("Gets and sets the property matcher. [HTTP/HTTPS health checks] The HTTP or gRPC codes to use when checking for a successful response from a target.")
  matcher?: Matcher;

  @doc("Gets and sets the property name. The name of the target group.")
  name?: string;

  @doc("Gets and sets the property port. The port on which the targets receive traffic. This port is used unless you specify a port override when registering the target. If the target is a Lambda function, this parameter does not apply. If the protocol is GENEVE, the supported port is 6081.")
  port?: int32;

  @doc("Gets and sets the property protocol. The protocol to use for routing traffic to the targets.")
  protocol?: string;

  @doc("Gets and sets the property protocolVersion. [HTTP/HTTPS protocol] The protocol version. The possible values are GRPC, HTTP1, and HTTP2.")
  protocolVersion?: string;

  @doc("Gets and sets the property tags. The tags.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Gets and sets the property targetGroupArn. The ARN of the Target Group")
  targetGroupArn?: string;

  @doc("Gets and sets the property targetGroupAttributes. The attributes.")
  @extension("x-ms-identifiers", [])
  targetGroupAttributes?: TargetGroupAttribute[];

  @doc("Gets and sets the property targetGroupFullName. The full name of the target group.")
  targetGroupFullName?: string;

  @doc("Gets and sets the property targetGroupName. The name of the target group.")
  targetGroupName?: string;

  @doc("Gets and sets the property targetType. The type of target that you must specify when registering targets with this target group. You can't specify targets for a target group using more than one target type.")
  targetType?: string;

  @doc("Gets and sets the property targets. The targets.")
  @extension("x-ms-identifiers", [])
  targets?: TargetDescription[];

  @doc("Gets and sets the property unhealthyThresholdCount. The number of consecutive health check failures required before considering a target unhealthy.")
  unhealthyThresholdCount?: int32;

  @doc("Gets and sets the property vpcId. The identifier of the virtual private cloud (VPC). If the target is a Lambda function, this parameter does not apply.")
  vpcId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Matcher")
model Matcher {
  @doc("Gets and sets the property grpcCode. You can specify values between 0 and 99. You can specify multiple values, or a range of values. The default value is 12.")
  grpcCode?: string;

  @doc("Gets and sets the property httpCode. For Application Load Balancers, you can specify values between 200 and 499, and the default value is 200. You can specify multiple values or a range of values. ")
  httpCode?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key. The value for the tag. ")
  key?: string;

  @doc("Gets and sets the property value. The key name of the tag. ")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TargetGroupAttribute")
model TargetGroupAttribute {
  @doc("Gets and sets the property key. The value of the attribute.")
  key?: string;

  @doc("Gets and sets the property value. The name of the attribute.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TargetDescription")
model TargetDescription {
  @doc("Gets and sets the property availabilityZone. An Availability Zone or all. This determines whether the target receives traffic from the load balancer nodes in the specified Availability Zone or from all enabled Availability Zones for the load balancer.")
  availabilityZone?: string;

  @doc("Gets and sets the property id. The ID of the target. If the target type of the target group is instance, specify an instance ID. If the target type is ip, specify an IP address. If the target type is lambda, specify the ARN of the Lambda function. If the target type is alb, specify the ARN of the Application Load Balancer target. ")
  id?: string;

  @doc("Gets and sets the property port. The port on which the target is listening. If the target group protocol is GENEVE, the supported port is 6081. If the target type is alb, the targeted Application Load Balancer must have at least one listener whose port matches the target group port. Not used if the target is a Lambda function.")
  port?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface ElasticLoadBalancingV2TargetGroups {
  get is ArmResourceRead<ElasticLoadBalancingV2TargetGroup>;
  @doc("Create a ElasticLoadBalancingV2TargetGroup. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ElasticLoadBalancingV2TargetGroup>;
  update is ArmCustomPatchAsync<
    ElasticLoadBalancingV2TargetGroup,
    Azure.ResourceManager.Foundations.TagsUpdateModel<ElasticLoadBalancingV2TargetGroup>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ElasticLoadBalancingV2TargetGroup>;
  listByResourceGroup is ArmResourceListByParent<ElasticLoadBalancingV2TargetGroup>;
  listBySubscription is ArmListBySubscription<ElasticLoadBalancingV2TargetGroup>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::ElasticLoadBalancingV2::TargetGroup
//--------------------------------------------------------------------------------------------
