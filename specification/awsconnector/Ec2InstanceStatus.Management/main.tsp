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

//---------------------------------------------- Ec2InstanceStatuses ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model Ec2InstanceStatus is TrackedResource<Ec2InstanceStatusProperties> {
  @doc("Name of Ec2InstanceStatus")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ec2InstanceStatuses")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of Ec2InstanceStatus")
model Ec2InstanceStatusProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsEc2InstanceStatusProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of awsEc2InstanceStatus")
model AwsEc2InstanceStatusProperties {
  @doc("Gets and sets the property availabilityZone.<p>The Availability Zone of the instance.</p>")
  availabilityZone?: string;

  @doc("Gets and sets the property events.<p>Any scheduled events associated with the instance.</p>")
  @extension("x-ms-identifiers", [])
  events?: InstanceStatusEvent[];

  @doc("Gets and sets the property instanceId.<p>The ID of the instance.</p>")
  instanceId?: string;

  @doc("Gets and sets the property instanceState.<p>The intended state of the instance. <a>DescribeInstanceStatus</a> requires that an instance be in the <code>running</code> state.</p>")
  instanceState?: InstanceState;

  @doc("Gets and sets the property instanceStatus.<p>Reports impaired functionality that stems from issues internal to the instance, such as impaired reachability.</p>")
  instanceStatus?: InstanceStatusSummary;

  @doc("Gets and sets the property outpostArn.<p>The Amazon Resource Name (ARN) of the Outpost.</p>")
  outpostArn?: string;

  @doc("Gets and sets the property systemStatus.<p>Reports impaired functionality that stems from issues related to the systems that support an instance, such as hardware failures and network connectivity problems.</p>")
  systemStatus?: InstanceStatusSummary;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of InstanceStatusEvent")
model InstanceStatusEvent {
  @doc("Gets and sets the property code.<p>The event code.</p>")
  code?: EventCodeEnumValue;

  @doc("Gets and sets the property description.<p>A description of the event.</p> <p>After a scheduled event is completed, it can still be described for up to a week. If the event has been completed, this description starts with the following text: [Completed].</p>")
  description?: string;

  @doc("Gets and sets the property instanceEventId.<p>The ID of the event.</p>")
  instanceEventId?: string;

  @doc("Gets and sets the property notAfter.<p>The latest scheduled end time for the event.</p>")
  notAfter?: utcDateTime;

  @doc("Gets and sets the property notBefore.<p>The earliest scheduled start time for the event.</p>")
  notBefore?: utcDateTime;

  @doc("Gets and sets the property notBeforeDeadline.<p>The deadline for starting the event.</p>")
  notBeforeDeadline?: utcDateTime;
}

@doc("EventCode enum")
enum EventCode {
  @doc("EventCode enum instance-reboot")
  InstanceReboot: "instance-reboot",

  @doc("EventCode enum instance-retirement")
  InstanceRetirement: "instance-retirement",

  @doc("EventCode enum instance-stop")
  InstanceStop: "instance-stop",

  @doc("EventCode enum system-maintenance")
  SystemMaintenance: "system-maintenance",

  @doc("EventCode enum system-reboot")
  SystemReboot: "system-reboot",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of EventCodeEnumValue")
model EventCodeEnumValue {
  @doc("Gets and sets the property value.")
  value?: EventCode;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of InstanceState")
model InstanceState {
  @doc("Gets and sets the property code.<p>The state of the instance as a 16-bit unsigned integer. </p> <p>The high byte is all of the bits between 2^8 and (2^16)-1, which equals decimal values between 256 and 65,535. These numerical values are used for internal purposes and should be ignored.</p> <p>The low byte is all of the bits between 2^0 and (2^8)-1, which equals decimal values between 0 and 255. </p> <p>The valid values for instance-state-code will all be in the range of the low byte and they are:</p> <ul> <li> <p> <code>0</code> : <code>pending</code> </p> </li> <li> <p> <code>16</code> : <code>running</code> </p> </li> <li> <p> <code>32</code> : <code>shutting-down</code> </p> </li> <li> <p> <code>48</code> : <code>terminated</code> </p> </li> <li> <p> <code>64</code> : <code>stopping</code> </p> </li> <li> <p> <code>80</code> : <code>stopped</code> </p> </li> </ul> <p>You can ignore the high byte value by zeroing out all of the bits above 2^8 or 256 in decimal.</p>")
  code?: int32;

  @doc("Gets and sets the property name.<p>The current state of the instance.</p>")
  name?: InstanceStateNameEnumValue;
}

@doc("InstanceStateName enum")
enum InstanceStateName {
  @doc("InstanceStateName enum pending")
  Pending: "pending",

  @doc("InstanceStateName enum running")
  Running: "running",

  @doc("InstanceStateName enum shutting-down")
  ShuttingDown: "shutting-down",

  @doc("InstanceStateName enum stopped")
  Stopped: "stopped",

  @doc("InstanceStateName enum stopping")
  Stopping: "stopping",

  @doc("InstanceStateName enum terminated")
  Terminated: "terminated",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of InstanceStateNameEnumValue")
model InstanceStateNameEnumValue {
  @doc("Gets and sets the property value.")
  value?: InstanceStateName;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of InstanceStatusSummary")
model InstanceStatusSummary {
  @doc("Gets and sets the property details.<p>The system instance health or application instance health.</p>")
  @extension("x-ms-identifiers", [])
  details?: InstanceStatusDetails[];

  @doc("Gets and sets the property status.<p>The status.</p>")
  status?: SummaryStatusEnumValue;
}

@doc("SummaryStatus enum")
enum SummaryStatus {
  @doc("SummaryStatus enum impaired")
  Impaired: "impaired",

  @doc("SummaryStatus enum initializing")
  Initializing: "initializing",

  @doc("SummaryStatus enum insufficient-data")
  InsufficientData: "insufficient-data",

  @doc("SummaryStatus enum not-applicable")
  NotApplicable: "not-applicable",

  @doc("SummaryStatus enum ok")
  Ok: "ok",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of SummaryStatusEnumValue")
model SummaryStatusEnumValue {
  @doc("Gets and sets the property value.")
  value?: SummaryStatus;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of InstanceStatusDetails")
model InstanceStatusDetails {
  @doc("Gets and sets the property impairedSince.<p>The time when a status check failed. For an instance that was launched and impaired, this is the time when the instance was launched.</p>")
  impairedSince?: utcDateTime;

  @doc("Gets and sets the property name.<p>The type of instance status.</p>")
  name?: StatusNameEnumValue;

  @doc("Gets and sets the property status.<p>The status.</p>")
  status?: StatusTypeEnumValue;
}

@doc("StatusName enum")
enum StatusName {
  @doc("StatusName enum reachability")
  Reachability: "reachability",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of StatusNameEnumValue")
model StatusNameEnumValue {
  @doc("Gets and sets the property value.")
  value?: StatusName;
}

@doc("StatusType enum")
enum StatusType {
  @doc("StatusType enum failed")
  Failed: "failed",

  @doc("StatusType enum initializing")
  Initializing: "initializing",

  @doc("StatusType enum insufficient-data")
  InsufficientData: "insufficient-data",

  @doc("StatusType enum passed")
  Passed: "passed",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
@doc("Definition of StatusTypeEnumValue")
model StatusTypeEnumValue {
  @doc("Gets and sets the property value.")
  value?: StatusType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Ec2InstanceStatuses {
  get is ArmResourceRead<Ec2InstanceStatus>;
  @doc("Create a Ec2InstanceStatus. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Ec2InstanceStatus>;
  update is ArmCustomPatchAsync<
    Ec2InstanceStatus,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Ec2InstanceStatus>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Ec2InstanceStatus>;
  listByResourceGroup is ArmResourceListByParent<Ec2InstanceStatus>;
  listBySubscription is ArmListBySubscription<Ec2InstanceStatus>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\ec2\ec2-2016-11-15.normal.json
// AWS Shape: InstanceStatus
//
// Related information for backend service:
// AWS Servcie : EC2
// Product Version : 3.7.660.0
// SDK Version : 3.7.219.0
//--------------------------------------------------------------------------------------------
