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

//---------------------------------------------- ApplicationAutoScalingScalableTargets ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model ApplicationAutoScalingScalableTarget
  is TrackedResource<ApplicationAutoScalingScalableTargetProperties> {
  @doc("Name of ApplicationAutoScalingScalableTarget")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("applicationAutoScalingScalableTargets")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ApplicationAutoScalingScalableTarget")
model ApplicationAutoScalingScalableTargetProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsApplicationAutoScalingScalableTargetProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsApplicationAutoScalingScalableTarget")
model AwsApplicationAutoScalingScalableTargetProperties {
  @doc("Gets and sets the property id. This value can be returned by using the Ref function. Ref returns the Cloudformation generated ID of the resource in format - ResourceId|ScalableDimension|ServiceNamespace")
  id?: string;

  @doc("Gets and sets the property maxCapacity. The maximum value that you plan to scale in to. When a scaling policy is in effect, Application Auto Scaling can scale in (contract) as needed to the minimum capacity limit in response to changing demand")
  maxCapacity?: int32;

  @doc("Gets and sets the property minCapacity. The minimum value that you plan to scale in to. When a scaling policy is in effect, Application Auto Scaling can scale in (contract) as needed to the minimum capacity limit in response to changing demand")
  minCapacity?: int32;

  @doc("Gets and sets the property resourceId. The identifier of the resource associated with the scalable target")
  resourceId?: string;

  @doc("Gets and sets the property roleARN. Specify the Amazon Resource Name (ARN) of an Identity and Access Management (IAM) role that allows Application Auto Scaling to modify the scalable target on your behalf. ")
  roleARN?: string;

  @doc("Gets and sets the property scalableDimension. The scalable dimension associated with the scalable target. This string consists of the service namespace, resource type, and scaling property")
  scalableDimension?: string;

  @doc("Gets and sets the property scheduledActions. The scheduled actions for the scalable target. Duplicates aren't allowed.")
  @extension("x-ms-identifiers", [])
  scheduledActions?: ScheduledAction[];

  @doc("Gets and sets the property serviceNamespace. The namespace of the AWS service that provides the resource, or a custom-resource")
  serviceNamespace?: string;

  @doc("Gets and sets the property suspendedState. An embedded object that contains attributes and attribute values that are used to suspend and resume automatic scaling. Setting the value of an attribute to true suspends the specified scaling activities. Setting it to false (default) resumes the specified scaling activities. specifies whether the scaling activities for a scalable target are in a suspended state")
  suspendedState?: SuspendedState;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ScheduledAction")
model ScheduledAction {
  @doc("Gets and sets the property endTime.")
  endTime?: string;

  @doc("Gets and sets the property scalableTargetAction. specifies the minimum and maximum capacity")
  scalableTargetAction?: ScalableTargetAction;

  @doc("Gets and sets the property schedule.")
  schedule?: string;

  @doc("Gets and sets the property scheduledActionName.")
  scheduledActionName?: string;

  @doc("Gets and sets the property startTime.")
  startTime?: string;

  @doc("Gets and sets the property timezone.")
  timezone?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SuspendedState")
model SuspendedState {
  @doc("Gets and sets the property dynamicScalingInSuspended.")
  dynamicScalingInSuspended?: boolean;

  @doc("Gets and sets the property dynamicScalingOutSuspended.")
  dynamicScalingOutSuspended?: boolean;

  @doc("Gets and sets the property scheduledScalingSuspended.")
  scheduledScalingSuspended?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ScalableTargetAction")
model ScalableTargetAction {
  @doc("Gets and sets the property maxCapacity.")
  maxCapacity?: int32;

  @doc("Gets and sets the property minCapacity.")
  minCapacity?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface ApplicationAutoScalingScalableTargets {
  get is ArmResourceRead<ApplicationAutoScalingScalableTarget>;
  @doc("Create a ApplicationAutoScalingScalableTarget. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ApplicationAutoScalingScalableTarget>;
  update is ArmCustomPatchAsync<
    ApplicationAutoScalingScalableTarget,
    Azure.ResourceManager.Foundations.TagsUpdateModel<ApplicationAutoScalingScalableTarget>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ApplicationAutoScalingScalableTarget>;
  listByResourceGroup is ArmResourceListByParent<ApplicationAutoScalingScalableTarget>;
  listBySubscription is ArmListBySubscription<ApplicationAutoScalingScalableTarget>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::ApplicationAutoScaling::ScalableTarget
//--------------------------------------------------------------------------------------------
