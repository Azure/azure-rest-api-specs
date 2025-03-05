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

//---------------------------------------------- ElasticLoadBalancingv2TargetHealthDescriptions ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Elastic  Load  Balancing v2 Target Health Description",
    plural: "Elastic  Load  Balancing v2 Target Health Descriptions",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "Elastic ",
    "Load ",
    "Balancing v2",
    "Target",
    "Health",
    "Description"
  ],
})
@doc("A Microsoft.AwsConnector resource")
model ElasticLoadBalancingv2TargetHealthDescription
  is TrackedResource<ElasticLoadBalancingv2TargetHealthDescriptionProperties> {
  @doc("Name of ElasticLoadBalancingv2TargetHealthDescription")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("elasticLoadBalancingV2TargetHealthDescriptions")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ElasticLoadBalancingv2TargetHealthDescription")
model ElasticLoadBalancingv2TargetHealthDescriptionProperties {
  @doc("AWS Properties")
  awsProperties?: AwsElasticLoadBalancingv2TargetHealthDescriptionProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsElasticLoadBalancingv2TargetHealthDescription")
model AwsElasticLoadBalancingv2TargetHealthDescriptionProperties {
  @doc("<p>The anomaly detection result for the target.</p> <p>If no anomalies were detected, the result is <code>normal</code>.</p> <p>If anomalies were detected, the result is <code>anomalous</code>.</p>")
  anomalyDetection?: AnomalyDetection;

  @doc("<p>The port to use to connect with the target.</p>")
  healthCheckPort?: string;

  @doc("<p>The description of the target.</p>")
  target?: TargetDescription;

  @doc("<p>The health information for the target.</p>")
  targetHealth?: TargetHealth;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AnomalyDetection")
model AnomalyDetection {
  @doc("<p>Indicates whether anomaly mitigation is in progress.</p>")
  mitigationInEffect?: MitigationInEffectEnumEnumValue;

  @doc("<p>The latest anomaly detection result.</p>")
  result?: AnomalyResultEnumEnumValue;
}

@doc("MitigationInEffectEnum enum")
union MitigationInEffectEnum {
  @doc("MitigationInEffectEnum enum no")
  No: "no",

  @doc("MitigationInEffectEnum enum yes")
  Yes: "yes",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MitigationInEffectEnumEnumValue")
model MitigationInEffectEnumEnumValue {
  @doc("Property value")
  value?: MitigationInEffectEnum;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TargetDescription")
model TargetDescription {
  @doc("<p>An Availability Zone or <code>all</code>. This determines whether the target receives traffic from the load balancer nodes in the specified Availability Zone or from all enabled Availability Zones for the load balancer.</p> <p>For Application Load Balancer target groups, the specified Availability Zone value is only applicable when cross-zone load balancing is off. Otherwise the parameter is ignored and treated as <code>all</code>.</p> <p>This parameter is not supported if the target type of the target group is <code>instance</code> or <code>alb</code>.</p> <p>If the target type is <code>ip</code> and the IP address is in a subnet of the VPC for the target group, the Availability Zone is automatically detected and this parameter is optional. If the IP address is outside the VPC, this parameter is required.</p> <p>For Application Load Balancer target groups with cross-zone load balancing off, if the target type is <code>ip</code> and the IP address is outside of the VPC for the target group, this should be an Availability Zone inside the VPC for the target group.</p> <p>If the target type is <code>lambda</code>, this parameter is optional and the only supported value is <code>all</code>.</p>")
  availabilityZone?: string;

  @doc("<p>The ID of the target. If the target type of the target group is <code>instance</code>, specify an instance ID. If the target type is <code>ip</code>, specify an IP address. If the target type is <code>lambda</code>, specify the ARN of the Lambda function. If the target type is <code>alb</code>, specify the ARN of the Application Load Balancer target. </p>")
  id?: string;

  @doc("<p>The port on which the target is listening. If the target group protocol is GENEVE, the supported port is 6081. If the target type is <code>alb</code>, the targeted Application Load Balancer must have at least one listener whose port matches the target group port. This parameter is not used if the target is a Lambda function.</p>")
  port?: int32;
}

@doc("AnomalyResultEnum enum")
union AnomalyResultEnum {
  @doc("AnomalyResultEnum enum anomalous")
  Anomalous: "anomalous",

  @doc("AnomalyResultEnum enum normal")
  Normal: "normal",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AnomalyResultEnumEnumValue")
model AnomalyResultEnumEnumValue {
  @doc("Property value")
  value?: AnomalyResultEnum;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TargetHealth")
model TargetHealth {
  @doc("<p>A description of the target health that provides additional details. If the state is <code>healthy</code>, a description is not provided.</p>")
  description?: string;

  @doc("<p>The reason code.</p> <p>If the target state is <code>healthy</code>, a reason code is not provided.</p> <p>If the target state is <code>initial</code>, the reason code can be one of the following values:</p> <ul> <li> <p> <code>Elb.RegistrationInProgress</code> - The target is in the process of being registered with the load balancer.</p> </li> <li> <p> <code>Elb.InitialHealthChecking</code> - The load balancer is still sending the target the minimum number of health checks required to determine its health status.</p> </li> </ul> <p>If the target state is <code>unhealthy</code>, the reason code can be one of the following values:</p> <ul> <li> <p> <code>Target.ResponseCodeMismatch</code> - The health checks did not return an expected HTTP code. Applies only to Application Load Balancers and Gateway Load Balancers.</p> </li> <li> <p> <code>Target.Timeout</code> - The health check requests timed out. Applies only to Application Load Balancers and Gateway Load Balancers.</p> </li> <li> <p> <code>Target.FailedHealthChecks</code> - The load balancer received an error while establishing a connection to the target or the target response was malformed.</p> </li> <li> <p> <code>Elb.InternalError</code> - The health checks failed due to an internal error. Applies only to Application Load Balancers.</p> </li> </ul> <p>If the target state is <code>unused</code>, the reason code can be one of the following values:</p> <ul> <li> <p> <code>Target.NotRegistered</code> - The target is not registered with the target group.</p> </li> <li> <p> <code>Target.NotInUse</code> - The target group is not used by any load balancer or the target is in an Availability Zone that is not enabled for its load balancer.</p> </li> <li> <p> <code>Target.InvalidState</code> - The target is in the stopped or terminated state.</p> </li> <li> <p> <code>Target.IpUnusable</code> - The target IP address is reserved for use by a load balancer.</p> </li> </ul> <p>If the target state is <code>draining</code>, the reason code can be the following value:</p> <ul> <li> <p> <code>Target.DeregistrationInProgress</code> - The target is in the process of being deregistered and the deregistration delay period has not expired.</p> </li> </ul> <p>If the target state is <code>unavailable</code>, the reason code can be the following value:</p> <ul> <li> <p> <code>Target.HealthCheckDisabled</code> - Health checks are disabled for the target group. Applies only to Application Load Balancers.</p> </li> <li> <p> <code>Elb.InternalError</code> - Target health is unavailable due to an internal error. Applies only to Network Load Balancers.</p> </li> </ul>")
  reason?: TargetHealthReasonEnumEnumValue;

  @doc("<p>The state of the target.</p>")
  state?: TargetHealthStateEnumEnumValue;
}

@doc("TargetHealthReasonEnum enum")
union TargetHealthReasonEnum {
  @doc("TargetHealthReasonEnum enum Elb.InitialHealthChecking")
  ElbInitialHealthChecking: "Elb.InitialHealthChecking",

  @doc("TargetHealthReasonEnum enum Elb.InternalError")
  ElbInternalError: "Elb.InternalError",

  @doc("TargetHealthReasonEnum enum Elb.RegistrationInProgress")
  ElbRegistrationInProgress: "Elb.RegistrationInProgress",

  @doc("TargetHealthReasonEnum enum Target.DeregistrationInProgress")
  TargetDeregistrationInProgress: "Target.DeregistrationInProgress",

  @doc("TargetHealthReasonEnum enum Target.FailedHealthChecks")
  TargetFailedHealthChecks: "Target.FailedHealthChecks",

  @doc("TargetHealthReasonEnum enum Target.HealthCheckDisabled")
  TargetHealthCheckDisabled: "Target.HealthCheckDisabled",

  @doc("TargetHealthReasonEnum enum Target.InvalidState")
  TargetInvalidState: "Target.InvalidState",

  @doc("TargetHealthReasonEnum enum Target.IpUnusable")
  TargetIpUnusable: "Target.IpUnusable",

  @doc("TargetHealthReasonEnum enum Target.NotInUse")
  TargetNotInUse: "Target.NotInUse",

  @doc("TargetHealthReasonEnum enum Target.NotRegistered")
  TargetNotRegistered: "Target.NotRegistered",

  @doc("TargetHealthReasonEnum enum Target.ResponseCodeMismatch")
  TargetResponseCodeMismatch: "Target.ResponseCodeMismatch",

  @doc("TargetHealthReasonEnum enum Target.Timeout")
  TargetTimeout: "Target.Timeout",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TargetHealthReasonEnumEnumValue")
model TargetHealthReasonEnumEnumValue {
  @doc("Property value")
  value?: TargetHealthReasonEnum;
}

@doc("TargetHealthStateEnum enum")
union TargetHealthStateEnum {
  @doc("TargetHealthStateEnum enum draining")
  Draining: "draining",

  @doc("TargetHealthStateEnum enum healthy")
  Healthy: "healthy",

  @doc("TargetHealthStateEnum enum initial")
  Initial: "initial",

  @doc("TargetHealthStateEnum enum unavailable")
  Unavailable: "unavailable",

  @doc("TargetHealthStateEnum enum unhealthy")
  Unhealthy: "unhealthy",

  @doc("TargetHealthStateEnum enum unhealthy.draining")
  UnhealthyDraining: "unhealthy.draining",

  @doc("TargetHealthStateEnum enum unused")
  Unused: "unused",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TargetHealthStateEnumEnumValue")
model TargetHealthStateEnumEnumValue {
  @doc("Property value")
  value?: TargetHealthStateEnum;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface ElasticLoadBalancingv2TargetHealthDescriptions {
  get is ArmResourceRead<ElasticLoadBalancingv2TargetHealthDescription>;
  @doc("Create a ElasticLoadBalancingv2TargetHealthDescription. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<ElasticLoadBalancingv2TargetHealthDescription>;
  update is ArmCustomPatchAsync<
    ElasticLoadBalancingv2TargetHealthDescription,
    Azure.ResourceManager.Foundations.TagsUpdateModel<ElasticLoadBalancingv2TargetHealthDescription>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ElasticLoadBalancingv2TargetHealthDescription>;
  listByResourceGroup is ArmResourceListByParent<ElasticLoadBalancingv2TargetHealthDescription>;
  listBySubscription is ArmListBySubscription<ElasticLoadBalancingv2TargetHealthDescription>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\elasticloadbalancingv2\elasticloadbalancingv2-2015-12-01.normal.json
// AWS Shape: TargetHealthDescription
//
// Related information for backend service:
// AWS Servcie : Elastic Load Balancing v2
// Product Version : 3.7.798.0
// SDK Version : 3.7.302.39
//--------------------------------------------------------------------------------------------
