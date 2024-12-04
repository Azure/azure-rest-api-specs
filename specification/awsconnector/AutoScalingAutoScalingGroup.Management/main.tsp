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

//---------------------------------------------- AutoScalingAutoScalingGroups ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Auto Scaling Auto Scaling Group",
    plural: "Auto Scaling Auto Scaling Groups",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "Auto",
    "Scaling",
    "Auto",
    "Scaling",
    "Group"
  ],
})
@doc("A Microsoft.AwsConnector resource")
model AutoScalingAutoScalingGroup
  is TrackedResource<AutoScalingAutoScalingGroupProperties> {
  @doc("Name of AutoScalingAutoScalingGroup")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("autoScalingAutoScalingGroups")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AutoScalingAutoScalingGroup")
model AutoScalingAutoScalingGroupProperties {
  @doc("AWS Properties")
  awsProperties?: AwsAutoScalingAutoScalingGroupProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsAutoScalingAutoScalingGroup")
model AwsAutoScalingAutoScalingGroupProperties {
  @doc("The name of the Auto Scaling group. This name must be unique per Region per account. The name can contain any ASCII character 33 to 126 including most punctuation characters, digits, and upper and lowercased letters.  You cannot use a colon (:) in the name.")
  autoScalingGroupName?: string;

  @doc("A list of Availability Zones where instances in the Auto Scaling group can be created. Used for launching into the default VPC subnet in each Availability Zone when not using the ``VPCZoneIdentifier`` property, or for attaching a network interface when an existing network interface ID is specified in a launch template.")
  @extension("x-ms-identifiers", [])
  availabilityZones?: string[];

  @doc("Indicates whether Capacity Rebalancing is enabled. Otherwise, Capacity Rebalancing is disabled. When you turn on Capacity Rebalancing, Amazon EC2 Auto Scaling attempts to launch a Spot Instance whenever Amazon EC2 notifies that a Spot Instance is at an elevated risk of interruption. After launching a new instance, it then terminates an old instance. For more information, see [Use Capacity Rebalancing to handle Amazon EC2 Spot Interruptions](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-capacity-rebalancing.html) in the in the *Amazon EC2 Auto Scaling User Guide*.")
  capacityRebalance?: boolean;

  @doc("Reserved.")
  context?: string;

  @doc("*Only needed if you use simple scaling policies.*  The amount of time, in seconds, between one scaling activity ending and another one starting due to simple scaling policies. For more information, see [Scaling cooldowns for Amazon EC2 Auto Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/Cooldown.html) in the *Amazon EC2 Auto Scaling User Guide*. Default: ``300`` seconds")
  cooldown?: string;

  @doc("The amount of time, in seconds, until a new instance is considered to have finished initializing and resource consumption to become stable after it enters the ``InService`` state.  During an instance refresh, Amazon EC2 Auto Scaling waits for the warm-up period after it replaces an instance before it moves on to replacing the next instance. Amazon EC2 Auto Scaling also waits for the warm-up period before aggregating the metrics for new instances with existing instances in the Amazon CloudWatch metrics that are used for scaling, resulting in more reliable usage data. For more information, see [Set the default instance warmup for an Auto Scaling group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-default-instance-warmup.html) in the *Amazon EC2 Auto Scaling User Guide*.  To manage various warm-up settings at the group level, we recommend that you set the default instance warmup, *even if it is set to 0 seconds*. To remove a value that you previously set, include the property but specify ``-1`` for the value. However, we strongly recommend keeping the default instance warmup enabled by specifying a value of ``0`` or other nominal value.  Default: None")
  defaultInstanceWarmup?: int32;

  @doc("The desired capacity is the initial capacity of the Auto Scaling group at the time of its creation and the capacity it attempts to maintain. It can scale beyond this capacity if you configure automatic scaling. The number must be greater than or equal to the minimum size of the group and less than or equal to the maximum size of the group. If you do not specify a desired capacity when creating the stack, the default is the minimum size of the group. CloudFormation marks the Auto Scaling group as successful (by setting its status to CREATE_COMPLETE) when the desired capacity is reached. However, if a maximum Spot price is set in the launch template or launch configuration that you specified, then desired capacity is not used as a criteria for success. Whether your request is fulfilled depends on Spot Instance capacity and your maximum price.")
  desiredCapacity?: string;

  @doc("The unit of measurement for the value specified for desired capacity. Amazon EC2 Auto Scaling supports ``DesiredCapacityType`` for attribute-based instance type selection only. For more information, see [Creating an Auto Scaling group using attribute-based instance type selection](https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-asg-instance-type-requirements.html) in the *Amazon EC2 Auto Scaling User Guide*. By default, Amazon EC2 Auto Scaling specifies ``units``, which translates into number of instances. Valid values: ``units`` | ``vcpu`` | ``memory-mib``")
  desiredCapacityType?: string;

  @doc("The amount of time, in seconds, that Amazon EC2 Auto Scaling waits before checking the health status of an EC2 instance that has come into service and marking it unhealthy due to a failed health check. This is useful if your instances do not immediately pass their health checks after they enter the ``InService`` state. For more information, see [Set the health check grace period for an Auto Scaling group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/health-check-grace-period.html) in the *Amazon EC2 Auto Scaling User Guide*. Default: ``0`` seconds")
  healthCheckGracePeriod?: int32;

  @doc("A comma-separated value string of one or more health check types. The valid values are ``EC2``, ``ELB``, and ``VPC_LATTICE``. ``EC2`` is the default health check and cannot be disabled. For more information, see [Health checks for Auto Scaling instances](https://docs.aws.amazon.com/autoscaling/ec2/userguide/healthcheck.html) in the *Amazon EC2 Auto Scaling User Guide*. Only specify ``EC2`` if you must clear a value that was previously set.")
  healthCheckType?: string;

  @doc("The ID of the instance used to base the launch configuration on. For more information, see [Create an Auto Scaling group using an EC2 instance](https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-asg-from-instance.html) in the *Amazon EC2 Auto Scaling User Guide*. If you specify ``LaunchTemplate``, ``MixedInstancesPolicy``, or ``LaunchConfigurationName``, don't specify ``InstanceId``.")
  instanceId?: string;

  @doc("An instance maintenance policy. For more information, see [Set instance maintenance policy](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-instance-maintenance-policy.html) in the *Amazon EC2 Auto Scaling User Guide*. ``InstanceMaintenancePolicy`` is a property of the [AWS::AutoScaling::AutoScalingGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-autoscaling-autoscalinggroup.html) resource. For more information, see [Instance maintenance policies](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-instance-maintenance-policy.html) in the *Amazon EC2 Auto Scaling User Guide*.")
  instanceMaintenancePolicy?: InstanceMaintenancePolicy;

  @doc("The name of the launch configuration to use to launch instances. Required only if you don't specify ``LaunchTemplate``, ``MixedInstancesPolicy``, or ``InstanceId``.")
  launchConfigurationName?: string;

  @doc("Information used to specify the launch template and version to use to launch instances. You can alternatively associate a launch template to the Auto Scaling group by specifying a ``MixedInstancesPolicy``. For more information about creating launch templates, see [Create a launch template for an Auto Scaling group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-launch-template.html) in the *Amazon EC2 Auto Scaling User Guide*. If you omit this property, you must specify ``MixedInstancesPolicy``, ``LaunchConfigurationName``, or ``InstanceId``. Specifies a launch template to use when provisioning EC2 instances for an Auto Scaling group. You must specify the following:  +  The ID or the name of the launch template, but not both.  +  The version of the launch template.   ``LaunchTemplateSpecification`` is property of the [AWS::AutoScaling::AutoScalingGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-autoscaling-autoscalinggroup.html) resource. It is also a property of the [AWS::AutoScaling::AutoScalingGroup LaunchTemplate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-autoscaling-autoscalinggroup-launchtemplate.html) and [AWS::AutoScaling::AutoScalingGroup LaunchTemplateOverrides](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-autoscaling-autoscalinggroup-launchtemplateoverrides.html) property types. For information about creating a launch template, see [AWS::EC2::LaunchTemplate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-launchtemplate.html) and [Create a launch template for an Auto Scaling group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-launch-template.html) in the *Amazon EC2 Auto Scaling User Guide*. For examples of launch templates, see [Auto scaling template snippets](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/quickref-autoscaling.html) and the [Examples](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-launchtemplate.html#aws-resource-ec2-launchtemplate--examples) section in the ``AWS::EC2::LaunchTemplate`` resource.")
  launchTemplate?: LaunchTemplateSpecification;

  @doc("One or more lifecycle hooks to add to the Auto Scaling group before instances are launched.")
  @extension("x-ms-identifiers", [])
  lifecycleHookSpecificationList?: LifecycleHookSpecification[];

  @doc("A list of Classic Load Balancers associated with this Auto Scaling group. For Application Load Balancers, Network Load Balancers, and Gateway Load Balancers, specify the ``TargetGroupARNs`` property instead.")
  @extension("x-ms-identifiers", [])
  loadBalancerNames?: string[];

  @doc("The maximum amount of time, in seconds, that an instance can be in service. The default is null. If specified, the value must be either 0 or a number equal to or greater than 86,400 seconds (1 day). For more information, see [Replacing Auto Scaling instances based on maximum instance lifetime](https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-max-instance-lifetime.html) in the *Amazon EC2 Auto Scaling User Guide*.")
  maxInstanceLifetime?: int32;

  @doc("The maximum size of the group.  With a mixed instances policy that uses instance weighting, Amazon EC2 Auto Scaling may need to go above ``MaxSize`` to meet your capacity requirements. In this event, Amazon EC2 Auto Scaling will never go above ``MaxSize`` by more than your largest instance weight (weights that define how many units each instance contributes to the desired capacity of the group).")
  maxSize?: string;

  @doc("Enables the monitoring of group metrics of an Auto Scaling group. By default, these metrics are disabled.")
  @extension("x-ms-identifiers", [])
  metricsCollection?: MetricsCollection[];

  @doc("The minimum size of the group.")
  minSize?: string;

  @doc("An embedded object that specifies a mixed instances policy. The policy includes properties that not only define the distribution of On-Demand Instances and Spot Instances, the maximum price to pay for Spot Instances (optional), and how the Auto Scaling group allocates instance types to fulfill On-Demand and Spot capacities, but also the properties that specify the instance configuration information—the launch template and instance types. The policy can also include a weight for each instance type and different launch templates for individual instance types. For more information, see [Auto Scaling groups with multiple instance types and purchase options](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-mixed-instances-groups.html) in the *Amazon EC2 Auto Scaling User Guide*. Use this structure to launch multiple instance types and On-Demand Instances and Spot Instances within a single Auto Scaling group. A mixed instances policy contains information that Amazon EC2 Auto Scaling can use to launch instances and help optimize your costs. For more information, see [Auto Scaling groups with multiple instance types and purchase options](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-mixed-instances-groups.html) in the *Amazon EC2 Auto Scaling User Guide*. You can create a mixed instances policy for new and existing Auto Scaling groups. You must use a launch template to configure the policy. You cannot use a launch configuration. There are key differences between Spot Instances and On-Demand Instances:  +  The price for Spot Instances varies based on demand  +  Amazon EC2 can terminate an individual Spot Instance as the availability of, or price for, Spot Instances changes   When a Spot Instance is terminated, Amazon EC2 Auto Scaling group attempts to launch a replacement instance to maintain the desired capacity for the group.   ``MixedInstancesPolicy`` is a property of the [AWS::AutoScaling::AutoScalingGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-autoscaling-autoscalinggroup.html) resource.")
  mixedInstancesPolicy?: MixedInstancesPolicy;

  @doc("Indicates whether newly launched instances are protected from termination by Amazon EC2 Auto Scaling when scaling in. For more information about preventing instances from terminating on scale in, see [Using instance scale-in protection](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-instance-protection.html) in the *Amazon EC2 Auto Scaling User Guide*.")
  newInstancesProtectedFromScaleIn?: boolean;

  @doc("A structure that specifies an Amazon SNS notification configuration for the ``NotificationConfigurations`` property of the [AWS::AutoScaling::AutoScalingGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-autoscaling-autoscalinggroup.html) resource. For an example template snippet, see [Auto scaling template snippets](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/quickref-autoscaling.html). For more information, see [Get Amazon SNS notifications when your Auto Scaling group scales](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ASGettingNotifications.html) in the *Amazon EC2 Auto Scaling User Guide*.")
  notificationConfiguration?: NotificationConfiguration;

  @doc("Configures an Auto Scaling group to send notifications when specified events take place.")
  @extension("x-ms-identifiers", [])
  notificationConfigurations?: NotificationConfiguration[];

  @doc("The name of the placement group into which to launch your instances. For more information, see [Placement groups](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html) in the *Amazon EC2 User Guide for Linux Instances*.  A *cluster* placement group is a logical grouping of instances within a single Availability Zone. You cannot specify multiple Availability Zones and a cluster placement group.")
  placementGroup?: string;

  @doc("The Amazon Resource Name (ARN) of the service-linked role that the Auto Scaling group uses to call other AWS service on your behalf. By default, Amazon EC2 Auto Scaling uses a service-linked role named ``AWSServiceRoleForAutoScaling``, which it creates if it does not exist. For more information, see [Service-linked roles](https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-service-linked-role.html) in the *Amazon EC2 Auto Scaling User Guide*.")
  serviceLinkedRoleARN?: string;

  @doc("One or more tags. You can tag your Auto Scaling group and propagate the tags to the Amazon EC2 instances it launches. Tags are not propagated to Amazon EBS volumes. To add tags to Amazon EBS volumes, specify the tags in a launch template but use caution. If the launch template specifies an instance tag with a key that is also specified for the Auto Scaling group, Amazon EC2 Auto Scaling overrides the value of that instance tag with the value specified by the Auto Scaling group. For more information, see [Tag Auto Scaling groups and instances](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-tagging.html) in the *Amazon EC2 Auto Scaling User Guide*.")
  @extension("x-ms-identifiers", [])
  tags?: TagProperty[];

  @doc("The Amazon Resource Names (ARN) of the Elastic Load Balancing target groups to associate with the Auto Scaling group. Instances are registered as targets with the target groups. The target groups receive incoming traffic and route requests to one or more registered targets. For more information, see [Use Elastic Load Balancing to distribute traffic across the instances in your Auto Scaling group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-load-balancer.html) in the *Amazon EC2 Auto Scaling User Guide*.")
  @extension("x-ms-identifiers", [])
  targetGroupARNs?: string[];

  @doc("A policy or a list of policies that are used to select the instance to terminate. These policies are executed in the order that you list them. For more information, see [Work with Amazon EC2 Auto Scaling termination policies](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-termination-policies.html) in the *Amazon EC2 Auto Scaling User Guide*. Valid values: ``Default`` | ``AllocationStrategy`` | ``ClosestToNextInstanceHour`` | ``NewestInstance`` | ``OldestInstance`` | ``OldestLaunchConfiguration`` | ``OldestLaunchTemplate`` | ``arn:aws:lambda:region:account-id:function:my-function:my-alias``")
  @extension("x-ms-identifiers", [])
  terminationPolicies?: string[];

  @doc("A list of subnet IDs for a virtual private cloud (VPC) where instances in the Auto Scaling group can be created. If this resource specifies public subnets and is also in a VPC that is defined in the same stack template, you must use the [DependsOn attribute](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-dependson.html) to declare a dependency on the [VPC-gateway attachment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpc-gateway-attachment.html).  When you update ``VPCZoneIdentifier``, this retains the same Auto Scaling group and replaces old instances with new ones, according to the specified subnets. You can optionally specify how CloudFormation handles these updates by using an [UpdatePolicy attribute](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-updatepolicy.html).  Required to launch instances into a nondefault VPC. If you specify ``VPCZoneIdentifier`` with ``AvailabilityZones``, the subnets that you specify for this property must reside in those Availability Zones.")
  @extension("x-ms-identifiers", [])
  vpcZoneIdentifier?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceMaintenancePolicy")
model InstanceMaintenancePolicy {
  @doc("Specifies the upper threshold as a percentage of the desired capacity of the Auto Scaling group. It represents the maximum percentage of the group that can be in service and healthy, or pending, to support your workload when replacing instances. Value range is 100 to 200. To clear a previously set value, specify a value of ``-1``. Both ``MinHealthyPercentage`` and ``MaxHealthyPercentage`` must be specified, and the difference between them cannot be greater than 100. A large range increases the number of instances that can be replaced at the same time.")
  maxHealthyPercentage?: int32;

  @doc("Specifies the lower threshold as a percentage of the desired capacity of the Auto Scaling group. It represents the minimum percentage of the group to keep in service, healthy, and ready to use to support your workload when replacing instances. Value range is 0 to 100. To clear a previously set value, specify a value of ``-1``.")
  minHealthyPercentage?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LaunchTemplateSpecification")
model LaunchTemplateSpecification {
  @doc("The ID of the launch template. You must specify the ``LaunchTemplateID`` or the ``LaunchTemplateName``, but not both.")
  launchTemplateId?: string;

  @doc("The name of the launch template. You must specify the ``LaunchTemplateName`` or the ``LaunchTemplateID``, but not both.")
  launchTemplateName?: string;

  @doc("The version number of the launch template. Specifying ``$Latest`` or ``$Default`` for the template version number is not supported. However, you can specify ``LatestVersionNumber`` or ``DefaultVersionNumber`` using the ``Fn::GetAtt`` intrinsic function. For more information, see [Fn::GetAtt](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference-getatt.html).  For an example of using the ``Fn::GetAtt`` function, see the [Examples](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-autoscaling-autoscalinggroup.html#aws-resource-autoscaling-autoscalinggroup--examples) section of the ``AWS::AutoScaling::AutoScalingGroup`` resource.")
  version?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LifecycleHookSpecification")
model LifecycleHookSpecification {
  @doc("The action the Auto Scaling group takes when the lifecycle hook timeout elapses or if an unexpected failure occurs. The default value is ``ABANDON``. Valid values: ``CONTINUE`` | ``ABANDON``")
  defaultResult?: string;

  @doc("The maximum time, in seconds, that can elapse before the lifecycle hook times out. The range is from ``30`` to ``7200`` seconds. The default value is ``3600`` seconds (1 hour).")
  heartbeatTimeout?: int32;

  @doc("The name of the lifecycle hook.")
  lifecycleHookName?: string;

  @doc("The lifecycle transition. For Auto Scaling groups, there are two major lifecycle transitions.  +  To create a lifecycle hook for scale-out events, specify ``autoscaling:EC2_INSTANCE_LAUNCHING``.  +  To create a lifecycle hook for scale-in events, specify ``autoscaling:EC2_INSTANCE_TERMINATING``.")
  lifecycleTransition?: string;

  @doc("Additional information that you want to include any time Amazon EC2 Auto Scaling sends a message to the notification target.")
  notificationMetadata?: string;

  @doc("The Amazon Resource Name (ARN) of the notification target that Amazon EC2 Auto Scaling sends notifications to when an instance is in a wait state for the lifecycle hook. You can specify an Amazon SNS topic or an Amazon SQS queue.")
  notificationTargetARN?: string;

  @doc("The ARN of the IAM role that allows the Auto Scaling group to publish to the specified notification target. For information about creating this role, see [Configure a notification target for a lifecycle hook](https://docs.aws.amazon.com/autoscaling/ec2/userguide/prepare-for-lifecycle-notifications.html#lifecycle-hook-notification-target) in the *Amazon EC2 Auto Scaling User Guide*. Valid only if the notification target is an Amazon SNS topic or an Amazon SQS queue.")
  roleARN?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MetricsCollection")
model MetricsCollection {
  @doc("The frequency at which Amazon EC2 Auto Scaling sends aggregated data to CloudWatch. The only valid value is ``1Minute``.")
  granularity?: string;

  @doc("Identifies the metrics to enable. You can specify one or more of the following metrics:  +   ``GroupMinSize``   +   ``GroupMaxSize``   +   ``GroupDesiredCapacity``   +   ``GroupInServiceInstances``   +   ``GroupPendingInstances``   +   ``GroupStandbyInstances``   +   ``GroupTerminatingInstances``   +   ``GroupTotalInstances``   +   ``GroupInServiceCapacity``   +   ``GroupPendingCapacity``   +   ``GroupStandbyCapacity``   +   ``GroupTerminatingCapacity``   +   ``GroupTotalCapacity``   +   ``WarmPoolDesiredCapacity``   +   ``WarmPoolWarmedCapacity``   +   ``WarmPoolPendingCapacity``   +   ``WarmPoolTerminatingCapacity``   +   ``WarmPoolTotalCapacity``   +   ``GroupAndWarmPoolDesiredCapacity``   +   ``GroupAndWarmPoolTotalCapacity``    If you specify ``Granularity`` and don't specify any metrics, all metrics are enabled. For more information, see [Auto Scaling group metrics](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-cloudwatch-monitoring.html#as-group-metrics) in the *Amazon EC2 Auto Scaling User Guide*.")
  @extension("x-ms-identifiers", [])
  metrics?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MixedInstancesPolicy")
model MixedInstancesPolicy {
  @doc("The instances distribution. Use this structure to specify the distribution of On-Demand Instances and Spot Instances and the allocation strategies used to fulfill On-Demand and Spot capacities for a mixed instances policy. For more information, see [Auto Scaling groups with multiple instance types and purchase options](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-mixed-instances-groups.html) in the *Amazon EC2 Auto Scaling User Guide*.  ``InstancesDistribution`` is a property of the [AWS::AutoScaling::AutoScalingGroup MixedInstancesPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-autoscaling-autoscalinggroup-mixedinstancespolicy.html) property type.")
  instancesDistribution?: InstancesDistribution;

  @doc("One or more launch templates and the instance types (overrides) that are used to launch EC2 instances to fulfill On-Demand and Spot capacities. Use this structure to specify the launch templates and instance types (overrides) for a mixed instances policy.  ``LaunchTemplate`` is a property of the [AWS::AutoScaling::AutoScalingGroup MixedInstancesPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-autoscaling-autoscalinggroup-mixedinstancespolicy.html) property type.")
  launchTemplate?: LaunchTemplate;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NotificationConfiguration")
model NotificationConfiguration {
  @doc("A list of event types that send a notification. Event types can include any of the following types.  *Allowed values*:  +   ``autoscaling:EC2_INSTANCE_LAUNCH``   +   ``autoscaling:EC2_INSTANCE_LAUNCH_ERROR``   +   ``autoscaling:EC2_INSTANCE_TERMINATE``   +   ``autoscaling:EC2_INSTANCE_TERMINATE_ERROR``   +   ``autoscaling:TEST_NOTIFICATION``")
  @extension("x-ms-identifiers", [])
  notificationTypes?: string[];

  @doc("The Amazon Resource Name (ARN) of the Amazon SNS topic.")
  topicARN?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TagProperty")
model TagProperty {
  @doc("The tag key.")
  key?: string;

  @doc("Set to ``true`` if you want CloudFormation to copy the tag to EC2 instances that are launched as part of the Auto Scaling group. Set to ``false`` if you want the tag attached only to the Auto Scaling group and not copied to any instances launched as part of the Auto Scaling group.")
  propagateAtLaunch?: boolean;

  @doc("The tag value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstancesDistribution")
model InstancesDistribution {
  @doc("The allocation strategy to apply to your On-Demand Instances when they are launched. Possible instance types are determined by the launch template overrides that you specify. The following lists the valid values:  + lowest-price Uses price to determine which instance types are the highest priority, launching the lowest priced instance types within an Availability Zone first. This is the default value for Auto Scaling groups that specify InstanceRequirements. + prioritized You set the order of instance types for the launch template overrides from highest to lowest priority (from first to last in the list). Amazon EC2 Auto Scaling launches your highest priority instance types first. If all your On-Demand capacity cannot be fulfilled using your highest priority instance type, then Amazon EC2 Auto Scaling launches the remaining capacity using the second priority instance type, and so on. This is the default value for Auto Scaling groups that don't specify InstanceRequirements and cannot be used for groups that do.")
  onDemandAllocationStrategy?: string;

  @doc("The minimum amount of the Auto Scaling group's capacity that must be fulfilled by On-Demand Instances. This base portion is launched first as your group scales. This number has the same unit of measurement as the group's desired capacity. If you change the default unit of measurement (number of instances) by specifying weighted capacity values in your launch template overrides list, or by changing the default desired capacity type setting of the group, you must specify this number using the same unit of measurement. Default: 0  An update to this setting means a gradual replacement of instances to adjust the current On-Demand Instance levels. When replacing instances, Amazon EC2 Auto Scaling launches new instances before terminating the previous ones.")
  onDemandBaseCapacity?: int32;

  @doc("Controls the percentages of On-Demand Instances and Spot Instances for your additional capacity beyond ``OnDemandBaseCapacity``. Expressed as a number (for example, 20 specifies 20% On-Demand Instances, 80% Spot Instances). If set to 100, only On-Demand Instances are used. Default: 100  An update to this setting means a gradual replacement of instances to adjust the current On-Demand and Spot Instance levels for your additional capacity higher than the base capacity. When replacing instances, Amazon EC2 Auto Scaling launches new instances before terminating the previous ones.")
  onDemandPercentageAboveBaseCapacity?: int32;

  @doc("The allocation strategy to apply to your Spot Instances when they are launched. Possible instance types are determined by the launch template overrides that you specify. The following lists the valid values:  + capacity-optimized Requests Spot Instances using pools that are optimally chosen based on the available Spot capacity. This strategy has the lowest risk of interruption. To give certain instance types a higher chance of launching first, use capacity-optimized-prioritized. + capacity-optimized-prioritized You set the order of instance types for the launch template overrides from highest to lowest priority (from first to last in the list). Amazon EC2 Auto Scaling honors the instance type priorities on a best effort basis but optimizes for capacity first. Note that if the On-Demand allocation strategy is set to prioritized, the same priority is applied when fulfilling On-Demand capacity. This is not a valid value for Auto Scaling groups that specify InstanceRequirements. + lowest-price Requests Spot Instances using the lowest priced pools within an Availability Zone, across the number of Spot pools that you specify for the SpotInstancePools property. To ensure that your desired capacity is met, you might receive Spot Instances from several pools. This is the default value, but it might lead to high interruption rates because this strategy only considers instance price and not available capacity. + price-capacity-optimized (recommended) The price and capacity optimized allocation strategy looks at both price and capacity to select the Spot Instance pools that are the least likely to be interrupted and have the lowest possible price.")
  spotAllocationStrategy?: string;

  @doc("The number of Spot Instance pools across which to allocate your Spot Instances. The Spot pools are determined from the different instance types in the overrides. Valid only when the ``SpotAllocationStrategy`` is ``lowest-price``. Value must be in the range of 1–20. Default: 2")
  spotInstancePools?: int32;

  @doc("The maximum price per unit hour that you are willing to pay for a Spot Instance. If your maximum price is lower than the Spot price for the instance types that you selected, your Spot Instances are not launched. We do not recommend specifying a maximum price because it can lead to increased interruptions. When Spot Instances launch, you pay the current Spot price. To remove a maximum price that you previously set, include the property but specify an empty string ('') for the value.  If you specify a maximum price, your instances will be interrupted more frequently than if you do not specify one.  Valid Range: Minimum value of 0.001")
  spotMaxPrice?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LaunchTemplate")
model LaunchTemplate {
  @doc("The launch template. Specifies a launch template to use when provisioning EC2 instances for an Auto Scaling group. You must specify the following:  +  The ID or the name of the launch template, but not both.  +  The version of the launch template.   ``LaunchTemplateSpecification`` is property of the [AWS::AutoScaling::AutoScalingGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-autoscaling-autoscalinggroup.html) resource. It is also a property of the [AWS::AutoScaling::AutoScalingGroup LaunchTemplate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-autoscaling-autoscalinggroup-launchtemplate.html) and [AWS::AutoScaling::AutoScalingGroup LaunchTemplateOverrides](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-autoscaling-autoscalinggroup-launchtemplateoverrides.html) property types. For information about creating a launch template, see [AWS::EC2::LaunchTemplate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-launchtemplate.html) and [Create a launch template for an Auto Scaling group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-launch-template.html) in the *Amazon EC2 Auto Scaling User Guide*. For examples of launch templates, see [Auto scaling template snippets](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/quickref-autoscaling.html) and the [Examples](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-launchtemplate.html#aws-resource-ec2-launchtemplate--examples) section in the ``AWS::EC2::LaunchTemplate`` resource.")
  launchTemplateSpecification?: LaunchTemplateSpecification;

  @doc("Any properties that you specify override the same properties in the launch template.")
  @extension("x-ms-identifiers", [])
  overrides?: LaunchTemplateOverrides[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LaunchTemplateOverrides")
model LaunchTemplateOverrides {
  @doc("The instance requirements. Amazon EC2 Auto Scaling uses your specified requirements to identify instance types. Then, it uses your On-Demand and Spot allocation strategies to launch instances from these instance types. You can specify up to four separate sets of instance requirements per Auto Scaling group. This is useful for provisioning instances from different Amazon Machine Images (AMIs) in the same Auto Scaling group. To do this, create the AMIs and create a new launch template for each AMI. Then, create a compatible set of instance requirements for each launch template.   If you specify ``InstanceRequirements``, you can't specify ``InstanceType``. The attributes for the instance types for a mixed instances policy. Amazon EC2 Auto Scaling uses your specified requirements to identify instance types. Then, it uses your On-Demand and Spot allocation strategies to launch instances from these instance types. When you specify multiple attributes, you get instance types that satisfy all of the specified attributes. If you specify multiple values for an attribute, you get instance types that satisfy any of the specified values. To limit the list of instance types from which Amazon EC2 Auto Scaling can identify matching instance types, you can use one of the following parameters, but not both in the same request:  +  ``AllowedInstanceTypes`` - The instance types to include in the list. All other instance types are ignored, even if they match your specified attributes.  +  ``ExcludedInstanceTypes`` - The instance types to exclude from the list, even if they match your specified attributes.    You must specify ``VCpuCount`` and ``MemoryMiB``. All other attributes are optional. Any unspecified optional attribute is set to its default.  For an example template, see [Auto scaling template snippets](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/quickref-autoscaling.html). For more information, see [Creating an Auto Scaling group using attribute-based instance type selection](https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-asg-instance-type-requirements.html) in the *Amazon EC2 Auto Scaling User Guide*. For help determining which instance types match your attributes before you apply them to your Auto Scaling group, see [Preview instance types with specified attributes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-fleet-attribute-based-instance-type-selection.html#ec2fleet-get-instance-types-from-instance-requirements) in the *Amazon EC2 User Guide for Linux Instances*. ``InstanceRequirements`` is a property of the ``LaunchTemplateOverrides`` property of the [AWS::AutoScaling::AutoScalingGroup LaunchTemplate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-autoscaling-autoscalinggroup-launchtemplate.html) property type.")
  instanceRequirements?: InstanceRequirements;

  @doc("The instance type, such as ``m3.xlarge``. You must specify an instance type that is supported in your requested Region and Availability Zones. For more information, see [Instance types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html) in the *Amazon Elastic Compute Cloud User Guide*. You can specify up to 40 instance types per Auto Scaling group.")
  instanceType?: string;

  @doc("Provides a launch template for the specified instance type or set of instance requirements. For example, some instance types might require a launch template with a different AMI. If not provided, Amazon EC2 Auto Scaling uses the launch template that's specified in the ``LaunchTemplate`` definition. For more information, see [Specifying a different launch template for an instance type](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-mixed-instances-groups-launch-template-overrides.html) in the *Amazon EC2 Auto Scaling User Guide*.  You can specify up to 20 launch templates per Auto Scaling group. The launch templates specified in the overrides and in the ``LaunchTemplate`` definition count towards this limit. Specifies a launch template to use when provisioning EC2 instances for an Auto Scaling group. You must specify the following:  +  The ID or the name of the launch template, but not both.  +  The version of the launch template.   ``LaunchTemplateSpecification`` is property of the [AWS::AutoScaling::AutoScalingGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-autoscaling-autoscalinggroup.html) resource. It is also a property of the [AWS::AutoScaling::AutoScalingGroup LaunchTemplate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-autoscaling-autoscalinggroup-launchtemplate.html) and [AWS::AutoScaling::AutoScalingGroup LaunchTemplateOverrides](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-autoscaling-autoscalinggroup-launchtemplateoverrides.html) property types. For information about creating a launch template, see [AWS::EC2::LaunchTemplate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-launchtemplate.html) and [Create a launch template for an Auto Scaling group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-launch-template.html) in the *Amazon EC2 Auto Scaling User Guide*. For examples of launch templates, see [Auto scaling template snippets](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/quickref-autoscaling.html) and the [Examples](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-launchtemplate.html#aws-resource-ec2-launchtemplate--examples) section in the ``AWS::EC2::LaunchTemplate`` resource.")
  launchTemplateSpecification?: LaunchTemplateSpecification;

  @doc("If you provide a list of instance types to use, you can specify the number of capacity units provided by each instance type in terms of virtual CPUs, memory, storage, throughput, or other relative performance characteristic. When a Spot or On-Demand Instance is launched, the capacity units count toward the desired capacity. Amazon EC2 Auto Scaling launches instances until the desired capacity is totally fulfilled, even if this results in an overage. For example, if there are two units remaining to fulfill capacity, and Amazon EC2 Auto Scaling can only launch an instance with a ``WeightedCapacity`` of five units, the instance is launched, and the desired capacity is exceeded by three units. For more information, see [Configure instance weighting for Amazon EC2 Auto Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-mixed-instances-groups-instance-weighting.html) in the *Amazon EC2 Auto Scaling User Guide*. Value must be in the range of 1-999.  If you specify a value for ``WeightedCapacity`` for one instance type, you must specify a value for ``WeightedCapacity`` for all of them.  Every Auto Scaling group has three size parameters (``DesiredCapacity``, ``MaxSize``, and ``MinSize``). Usually, you set these sizes based on a specific number of instances. However, if you configure a mixed instances policy that defines weights for the instance types, you must specify these sizes with the same units that you use for weighting instances.")
  weightedCapacity?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceRequirements")
model InstanceRequirements {
  @doc("The minimum and maximum number of accelerators (GPUs, FPGAs, or AWS Inferentia chips) for an instance type. To exclude accelerator-enabled instance types, set ``Max`` to ``0``. Default: No minimum or maximum limits ``AcceleratorCountRequest`` is a property of the ``InstanceRequirements`` property of the [AWS::AutoScaling::AutoScalingGroup LaunchTemplateOverrides](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-autoscaling-autoscalinggroup-launchtemplateoverrides.html) property type that describes the minimum and maximum number of accelerators for an instance type.")
  acceleratorCount?: AcceleratorCountRequest;

  @doc("Indicates whether instance types must have accelerators by specific manufacturers.  +  For instance types with NVIDIA devices, specify ``nvidia``.  +  For instance types with AMD devices, specify ``amd``.  +  For instance types with AWS devices, specify ``amazon-web-services``.  +  For instance types with Xilinx devices, specify ``xilinx``.   Default: Any manufacturer")
  @extension("x-ms-identifiers", [])
  acceleratorManufacturers?: string[];

  @doc("Lists the accelerators that must be on an instance type.  +  For instance types with NVIDIA A100 GPUs, specify ``a100``.  +  For instance types with NVIDIA V100 GPUs, specify ``v100``.  +  For instance types with NVIDIA K80 GPUs, specify ``k80``.  +  For instance types with NVIDIA T4 GPUs, specify ``t4``.  +  For instance types with NVIDIA M60 GPUs, specify ``m60``.  +  For instance types with AMD Radeon Pro V520 GPUs, specify ``radeon-pro-v520``.  +  For instance types with Xilinx VU9P FPGAs, specify ``vu9p``.   Default: Any accelerator")
  @extension("x-ms-identifiers", [])
  acceleratorNames?: string[];

  @doc("The minimum and maximum total memory size for the accelerators on an instance type, in MiB. Default: No minimum or maximum limits ``AcceleratorTotalMemoryMiBRequest`` is a property of the ``InstanceRequirements`` property of the [AWS::AutoScaling::AutoScalingGroup LaunchTemplateOverrides](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-autoscaling-autoscalinggroup-launchtemplateoverrides.html) property type that describes the minimum and maximum total memory size for the accelerators for an instance type, in MiB.")
  acceleratorTotalMemoryMiB?: AcceleratorTotalMemoryMiBRequest;

  @doc("Lists the accelerator types that must be on an instance type.  +  For instance types with GPU accelerators, specify ``gpu``.  +  For instance types with FPGA accelerators, specify ``fpga``.  +  For instance types with inference accelerators, specify ``inference``.   Default: Any accelerator type")
  @extension("x-ms-identifiers", [])
  acceleratorTypes?: string[];

  @doc("The instance types to apply your specified attributes against. All other instance types are ignored, even if they match your specified attributes. You can use strings with one or more wild cards, represented by an asterisk (``*``), to allow an instance type, size, or generation. The following are examples: ``m5.8xlarge``, ``c5*.*``, ``m5a.*``, ``r*``, ``*3*``. For example, if you specify ``c5*``, Amazon EC2 Auto Scaling will allow the entire C5 instance family, which includes all C5a and C5n instance types. If you specify ``m5a.*``, Amazon EC2 Auto Scaling will allow all the M5a instance types, but not the M5n instance types.  If you specify ``AllowedInstanceTypes``, you can't specify ``ExcludedInstanceTypes``.  Default: All instance types")
  @extension("x-ms-identifiers", [])
  allowedInstanceTypes?: string[];

  @doc("Indicates whether bare metal instance types are included, excluded, or required. Default: ``excluded``")
  bareMetal?: string;

  @doc("The minimum and maximum baseline bandwidth performance for an instance type, in Mbps. For more information, see [Amazon EBS–optimized instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-optimized.html) in the *Amazon EC2 User Guide for Linux Instances*. Default: No minimum or maximum limits ``BaselineEbsBandwidthMbpsRequest`` is a property of the ``InstanceRequirements`` property of the [AWS::AutoScaling::AutoScalingGroup LaunchTemplateOverrides](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-autoscaling-autoscalinggroup-launchtemplateoverrides.html) property type that describes the minimum and maximum baseline bandwidth performance for an instance type, in Mbps.")
  baselineEbsBandwidthMbps?: BaselineEbsBandwidthMbpsRequest;

  @doc("Indicates whether burstable performance instance types are included, excluded, or required. For more information, see [Burstable performance instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances.html) in the *Amazon EC2 User Guide for Linux Instances*. Default: ``excluded``")
  burstablePerformance?: string;

  @doc("Lists which specific CPU manufacturers to include.  +  For instance types with Intel CPUs, specify ``intel``.  +  For instance types with AMD CPUs, specify ``amd``.  +  For instance types with AWS CPUs, specify ``amazon-web-services``.    Don't confuse the CPU hardware manufacturer with the CPU hardware architecture. Instances will be launched with a compatible CPU architecture based on the Amazon Machine Image (AMI) that you specify in your launch template.   Default: Any manufacturer")
  @extension("x-ms-identifiers", [])
  cpuManufacturers?: string[];

  @doc("The instance types to exclude. You can use strings with one or more wild cards, represented by an asterisk (``*``), to exclude an instance family, type, size, or generation. The following are examples: ``m5.8xlarge``, ``c5*.*``, ``m5a.*``, ``r*``, ``*3*``.  For example, if you specify ``c5*``, you are excluding the entire C5 instance family, which includes all C5a and C5n instance types. If you specify ``m5a.*``, Amazon EC2 Auto Scaling will exclude all the M5a instance types, but not the M5n instance types.  If you specify ``ExcludedInstanceTypes``, you can't specify ``AllowedInstanceTypes``.  Default: No excluded instance types")
  @extension("x-ms-identifiers", [])
  excludedInstanceTypes?: string[];

  @doc("Indicates whether current or previous generation instance types are included.  +  For current generation instance types, specify ``current``. The current generation includes EC2 instance types currently recommended for use. This typically includes the latest two to three generations in each instance family. For more information, see [Instance types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html) in the *Amazon EC2 User Guide for Linux Instances*.  +  For previous generation instance types, specify ``previous``.   Default: Any current or previous generation")
  @extension("x-ms-identifiers", [])
  instanceGenerations?: string[];

  @doc("Indicates whether instance types with instance store volumes are included, excluded, or required. For more information, see [Amazon EC2 instance store](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html) in the *Amazon EC2 User Guide for Linux Instances*. Default: ``included``")
  localStorage?: string;

  @doc("Indicates the type of local storage that is required.  +  For instance types with hard disk drive (HDD) storage, specify ``hdd``.  +  For instance types with solid state drive (SSD) storage, specify ``ssd``.   Default: Any local storage type")
  @extension("x-ms-identifiers", [])
  localStorageTypes?: string[];

  @doc("[Price protection] The price protection threshold for Spot Instances, as a percentage of an identified On-Demand price. The identified On-Demand price is the price of the lowest priced current generation C, M, or R instance type with your specified attributes. If no current generation C, M, or R instance type matches your attributes, then the identified price is from either the lowest priced current generation instance types or, failing that, the lowest priced previous generation instance types that match your attributes. When Amazon EC2 Auto Scaling selects instance types with your attributes, we will exclude instance types whose price exceeds your specified threshold. The parameter accepts an integer, which Amazon EC2 Auto Scaling interprets as a percentage. To indicate no price protection threshold, specify a high value, such as ``999999``.  If you set ``DesiredCapacityType`` to ``vcpu`` or ``memory-mib``, the price protection threshold is based on the per-vCPU or per-memory price instead of the per instance price.   Only one of ``SpotMaxPricePercentageOverLowestPrice`` or ``MaxSpotPriceAsPercentageOfOptimalOnDemandPrice`` can be specified. If you don't specify either, then ``SpotMaxPricePercentageOverLowestPrice`` is used and the value for that parameter defaults to ``100``.")
  maxSpotPriceAsPercentageOfOptimalOnDemandPrice?: int32;

  @doc("The minimum and maximum amount of memory per vCPU for an instance type, in GiB. Default: No minimum or maximum limits ``MemoryGiBPerVCpuRequest`` is a property of the ``InstanceRequirements`` property of the [AWS::AutoScaling::AutoScalingGroup LaunchTemplateOverrides](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-autoscaling-autoscalinggroup-launchtemplateoverrides.html) property type that describes the minimum and maximum amount of memory per vCPU for an instance type, in GiB.")
  memoryGiBPerVCpu?: MemoryGiBPerVCpuRequest;

  @doc("The minimum and maximum instance memory size for an instance type, in MiB. ``MemoryMiBRequest`` is a property of the ``InstanceRequirements`` property of the [AWS::AutoScaling::AutoScalingGroup LaunchTemplateOverrides](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-autoscaling-autoscalinggroup-launchtemplateoverrides.html) property type that describes the minimum and maximum instance memory size for an instance type, in MiB.")
  memoryMiB?: MemoryMiBRequest;

  @doc("The minimum and maximum amount of network bandwidth, in gigabits per second (Gbps). Default: No minimum or maximum limits ``NetworkBandwidthGbpsRequest`` is a property of the ``InstanceRequirements`` property of the [AWS::AutoScaling::AutoScalingGroup LaunchTemplateOverrides](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-autoscaling-autoscalinggroup-launchtemplateoverrides.html) property type that describes the minimum and maximum network bandwidth for an instance type, in Gbps.  Setting the minimum bandwidth does not guarantee that your instance will achieve the minimum bandwidth. Amazon EC2 will identify instance types that support the specified minimum bandwidth, but the actual bandwidth of your instance might go below the specified minimum at times. For more information, see [Available instance bandwidth](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-network-bandwidth.html#available-instance-bandwidth) in the *Amazon EC2 User Guide for Linux Instances*.")
  networkBandwidthGbps?: NetworkBandwidthGbpsRequest;

  @doc("The minimum and maximum number of network interfaces for an instance type. Default: No minimum or maximum limits ``NetworkInterfaceCountRequest`` is a property of the ``InstanceRequirements`` property of the [AWS::AutoScaling::AutoScalingGroup LaunchTemplateOverrides](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-autoscaling-autoscalinggroup-launchtemplateoverrides.html) property type that describes the minimum and maximum number of network interfaces for an instance type.")
  networkInterfaceCount?: NetworkInterfaceCountRequest;

  @doc("[Price protection] The price protection threshold for On-Demand Instances, as a percentage higher than an identified On-Demand price. The identified On-Demand price is the price of the lowest priced current generation C, M, or R instance type with your specified attributes. If no current generation C, M, or R instance type matches your attributes, then the identified price is from either the lowest priced current generation instance types or, failing that, the lowest priced previous generation instance types that match your attributes. When Amazon EC2 Auto Scaling selects instance types with your attributes, we will exclude instance types whose price exceeds your specified threshold.  The parameter accepts an integer, which Amazon EC2 Auto Scaling interprets as a percentage. To turn off price protection, specify a high value, such as ``999999``.  If you set ``DesiredCapacityType`` to ``vcpu`` or ``memory-mib``, the price protection threshold is applied based on the per-vCPU or per-memory price instead of the per instance price.  Default: ``20``")
  onDemandMaxPricePercentageOverLowestPrice?: int32;

  @doc("Indicates whether instance types must provide On-Demand Instance hibernation support. Default: ``false``")
  requireHibernateSupport?: boolean;

  @doc("[Price protection] The price protection threshold for Spot Instances, as a percentage higher than an identified Spot price. The identified Spot price is the price of the lowest priced current generation C, M, or R instance type with your specified attributes. If no current generation C, M, or R instance type matches your attributes, then the identified price is from either the lowest priced current generation instance types or, failing that, the lowest priced previous generation instance types that match your attributes. When Amazon EC2 Auto Scaling selects instance types with your attributes, we will exclude instance types whose price exceeds your specified threshold. The parameter accepts an integer, which Amazon EC2 Auto Scaling interprets as a percentage. To turn off price protection, specify a high value, such as ``999999``.  If you set ``DesiredCapacityType`` to ``vcpu`` or ``memory-mib``, the price protection threshold is based on the per-vCPU or per-memory price instead of the per instance price.   Only one of ``SpotMaxPricePercentageOverLowestPrice`` or ``MaxSpotPriceAsPercentageOfOptimalOnDemandPrice`` can be specified.  Default: ``100``")
  spotMaxPricePercentageOverLowestPrice?: int32;

  @doc("The minimum and maximum total local storage size for an instance type, in GB. Default: No minimum or maximum limits ``TotalLocalStorageGBRequest`` is a property of the ``InstanceRequirements`` property of the [AWS::AutoScaling::AutoScalingGroup LaunchTemplateOverrides](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-autoscaling-autoscalinggroup-launchtemplateoverrides.html) property type that describes the minimum and maximum total local storage size for an instance type, in GB.")
  totalLocalStorageGB?: TotalLocalStorageGBRequest;

  @doc("The minimum and maximum number of vCPUs for an instance type. ``VCpuCountRequest`` is a property of the ``InstanceRequirements`` property of the [AWS::AutoScaling::AutoScalingGroup LaunchTemplateOverrides](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-autoscaling-autoscalinggroup-launchtemplateoverrides.html) property type that describes the minimum and maximum number of vCPUs for an instance type.")
  vCpuCount?: VCpuCountRequest;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AcceleratorCountRequest")
model AcceleratorCountRequest {
  @doc("The maximum value.")
  max?: int32;

  @doc("The minimum value.")
  min?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AcceleratorTotalMemoryMiBRequest")
model AcceleratorTotalMemoryMiBRequest {
  @doc("The memory maximum in MiB.")
  max?: int32;

  @doc("The memory minimum in MiB.")
  min?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BaselineEbsBandwidthMbpsRequest")
model BaselineEbsBandwidthMbpsRequest {
  @doc("The maximum value in Mbps.")
  max?: int32;

  @doc("The minimum value in Mbps.")
  min?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MemoryGiBPerVCpuRequest")
model MemoryGiBPerVCpuRequest {
  @doc("The memory maximum in GiB.")
  max?: int32;

  @doc("The memory minimum in GiB.")
  min?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MemoryMiBRequest")
model MemoryMiBRequest {
  @doc("The memory maximum in MiB.")
  max?: int32;

  @doc("The memory minimum in MiB.")
  min?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NetworkBandwidthGbpsRequest")
model NetworkBandwidthGbpsRequest {
  @doc("The maximum amount of network bandwidth, in gigabits per second (Gbps).")
  max?: int32;

  @doc("The minimum amount of network bandwidth, in gigabits per second (Gbps).")
  min?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NetworkInterfaceCountRequest")
model NetworkInterfaceCountRequest {
  @doc("The maximum number of network interfaces.")
  max?: int32;

  @doc("The minimum number of network interfaces.")
  min?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TotalLocalStorageGBRequest")
model TotalLocalStorageGBRequest {
  @doc("The storage maximum in GB.")
  max?: int32;

  @doc("The storage minimum in GB.")
  min?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VCpuCountRequest")
model VCpuCountRequest {
  @doc("The maximum number of vCPUs.")
  max?: int32;

  @doc("The minimum number of vCPUs.")
  min?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface AutoScalingAutoScalingGroups {
  get is ArmResourceRead<AutoScalingAutoScalingGroup>;
  @doc("Create a AutoScalingAutoScalingGroup. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<AutoScalingAutoScalingGroup>;
  update is ArmCustomPatchAsync<
    AutoScalingAutoScalingGroup,
    Azure.ResourceManager.Foundations.TagsUpdateModel<AutoScalingAutoScalingGroup>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<AutoScalingAutoScalingGroup>;
  listByResourceGroup is ArmResourceListByParent<AutoScalingAutoScalingGroup>;
  listBySubscription is ArmListBySubscription<AutoScalingAutoScalingGroup>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::AutoScaling::AutoScalingGroup
//--------------------------------------------------------------------------------------------
