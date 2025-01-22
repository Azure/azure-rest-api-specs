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

//---------------------------------------------- EcsServices ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "ECS Service",
    plural: "ECS Services",
  },
  keywords: ["Microsoft.AwsConnector", "ECS", "Service"],
})
@doc("A Microsoft.AwsConnector resource")
model EcsService is TrackedResource<EcsServiceProperties> {
  @doc("Name of EcsService")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ecsServices")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EcsService")
model EcsServiceProperties {
  @doc("AWS Properties")
  awsProperties?: AwsEcsServiceProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEcsService")
model AwsEcsServiceProperties {
  @doc("The capacity provider strategy to use for the service. If a ``capacityProviderStrategy`` is specified, the ``launchType`` parameter must be omitted. If no ``capacityProviderStrategy`` or ``launchType`` is specified, the ``defaultCapacityProviderStrategy`` for the cluster is used. A capacity provider strategy may contain a maximum of 6 capacity providers.")
  @extension("x-ms-identifiers", [])
  capacityProviderStrategy?: CapacityProviderStrategyItem[];

  @doc("The short name or full Amazon Resource Name (ARN) of the cluster that you run your service on. If you do not specify a cluster, the default cluster is assumed.")
  cluster?: string;

  @doc("Optional deployment parameters that control how many tasks run during the deployment and the ordering of stopping and starting tasks. The ``DeploymentConfiguration`` property specifies optional deployment parameters that control how many tasks run during the deployment and the ordering of stopping and starting tasks.")
  deploymentConfiguration?: DeploymentConfiguration;

  @doc("The deployment controller to use for the service. If no deployment controller is specified, the default value of ``ECS`` is used. The deployment controller to use for the service. For more information, see [Amazon ECS deployment types](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-types.html) in the *Amazon Elastic Container Service Developer Guide*.")
  deploymentController?: DeploymentController;

  @doc("The number of instantiations of the specified task definition to place and keep running in your service. For new services, if a desired count is not specified, a default value of ``1`` is used. When using the ``DAEMON`` scheduling strategy, the desired count is not required. For existing services, if a desired count is not specified, it is omitted from the operation.")
  desiredCount?: int32;

  @doc("Specifies whether to turn on Amazon ECS managed tags for the tasks within the service. For more information, see [Tagging your Amazon ECS resources](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-using-tags.html) in the *Amazon Elastic Container Service Developer Guide*. When you use Amazon ECS managed tags, you need to set the ``propagateTags`` request parameter.")
  enableECSManagedTags?: boolean;

  @doc("Determines whether the execute command functionality is turned on for the service. If ``true``, the execute command functionality is turned on for all containers in tasks as part of the service.")
  enableExecuteCommand?: boolean;

  @doc("The period of time, in seconds, that the Amazon ECS service scheduler ignores unhealthy Elastic Load Balancing target health checks after a task has first started. This is only used when your service is configured to use a load balancer. If your service has a load balancer defined and you don't specify a health check grace period value, the default value of ``0`` is used. If you do not use an Elastic Load Balancing, we recommend that you use the ``startPeriod`` in the task definition health check parameters. For more information, see [Health check](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_HealthCheck.html). If your service's tasks take a while to start and respond to Elastic Load Balancing health checks, you can specify a health check grace period of up to 2,147,483,647 seconds (about 69 years). During that time, the Amazon ECS service scheduler ignores health check status. This grace period can prevent the service scheduler from marking tasks as unhealthy and stopping them before they have time to come up.")
  healthCheckGracePeriodSeconds?: int32;

  @doc("The launch type on which to run your service. For more information, see [Amazon ECS Launch Types](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/launch_types.html) in the *Amazon Elastic Container Service Developer Guide*.")
  launchType?: LaunchType;

  @doc("A list of load balancer objects to associate with the service. If you specify the ``Role`` property, ``LoadBalancers`` must be specified as well. For information about the number of load balancers that you can specify per service, see [Service Load Balancing](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-load-balancing.html) in the *Amazon Elastic Container Service Developer Guide*.")
  @extension("x-ms-identifiers", [])
  loadBalancers?: LoadBalancer[];

  @doc("Property name")
  name?: string;

  @doc("The network configuration for the service. This parameter is required for task definitions that use the ``awsvpc`` network mode to receive their own elastic network interface, and it is not supported for other network modes. For more information, see [Task Networking](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-networking.html) in the *Amazon Elastic Container Service Developer Guide*. The ``NetworkConfiguration`` property specifies an object representing the network configuration for a task or service.")
  networkConfiguration?: NetworkConfiguration;

  @doc("An array of placement constraint objects to use for tasks in your service. You can specify a maximum of 10 constraints for each task. This limit includes constraints in the task definition and those specified at runtime.")
  @extension("x-ms-identifiers", [])
  placementConstraints?: PlacementConstraint[];

  @doc("The placement strategy objects to use for tasks in your service. You can specify a maximum of 5 strategy rules for each service.")
  @extension("x-ms-identifiers", [])
  placementStrategies?: PlacementStrategy[];

  @doc("The platform version that your tasks in the service are running on. A platform version is specified only for tasks using the Fargate launch type. If one isn't specified, the ``LATEST`` platform version is used. For more information, see [platform versions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/platform_versions.html) in the *Amazon Elastic Container Service Developer Guide*.")
  platformVersion?: string = "LATEST";

  @doc("Specifies whether to propagate the tags from the task definition to the task. If no value is specified, the tags aren't propagated. Tags can only be propagated to the task during task creation. To add tags to a task after task creation, use the [TagResource](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_TagResource.html) API action. The default is ``NONE``.")
  propagateTags?: PropagateTags;

  @doc("The name or full Amazon Resource Name (ARN) of the IAM role that allows Amazon ECS to make calls to your load balancer on your behalf. This parameter is only permitted if you are using a load balancer with your service and your task definition doesn't use the ``awsvpc`` network mode. If you specify the ``role`` parameter, you must also specify a load balancer object with the ``loadBalancers`` parameter.  If your account has already created the Amazon ECS service-linked role, that role is used for your service unless you specify a role here. The service-linked role is required if your task definition uses the ``awsvpc`` network mode or if the service is configured to use service discovery, an external deployment controller, multiple target groups, or Elastic Inference accelerators in which case you don't specify a role here. For more information, see [Using service-linked roles for Amazon ECS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using-service-linked-roles.html) in the *Amazon Elastic Container Service Developer Guide*.  If your specified role has a path other than ``/``, then you must either specify the full role ARN (this is recommended) or prefix the role name with the path. For example, if a role with the name ``bar`` has a path of ``/foo/`` then you would specify ``/foo/bar`` as the role name. For more information, see [Friendly names and paths](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-friendly-names) in the *IAM User Guide*.")
  role?: string;

  @doc("The scheduling strategy to use for the service. For more information, see [Services](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs_services.html). There are two service scheduler strategies available:  +   ``REPLICA``-The replica scheduling strategy places and maintains the desired number of tasks across your cluster. By default, the service scheduler spreads tasks across Availability Zones. You can use task placement strategies and constraints to customize task placement decisions. This scheduler strategy is required if the service uses the ``CODE_DEPLOY`` or ``EXTERNAL`` deployment controller types.  +   ``DAEMON``-The daemon scheduling strategy deploys exactly one task on each active container instance that meets all of the task placement constraints that you specify in your cluster. The service scheduler also evaluates the task placement constraints for running tasks and will stop tasks that don't meet the placement constraints. When you're using this strategy, you don't need to specify a desired number of tasks, a task placement strategy, or use Service Auto Scaling policies.  Tasks using the Fargate launch type or the ``CODE_DEPLOY`` or ``EXTERNAL`` deployment controller types don't support the ``DAEMON`` scheduling strategy.")
  schedulingStrategy?: SchedulingStrategy;

  @doc("Property serviceArn")
  serviceArn?: string;

  @doc("The configuration for this service to discover and connect to services, and be discovered by, and connected from, other services within a namespace. Tasks that run in a namespace can use short names to connect to services in the namespace. Tasks can connect to services across all of the clusters in the namespace. Tasks connect through a managed proxy container that collects logs and metrics for increased visibility. Only the tasks that Amazon ECS services create are supported with Service Connect. For more information, see [Service Connect](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-connect.html) in the *Amazon Elastic Container Service Developer Guide*. The Service Connect configuration of your Amazon ECS service. The configuration for this service to discover and connect to services, and be discovered by, and connected from, other services within a namespace. Tasks that run in a namespace can use short names to connect to services in the namespace. Tasks can connect to services across all of the clusters in the namespace. Tasks connect through a managed proxy container that collects logs and metrics for increased visibility. Only the tasks that Amazon ECS services create are supported with Service Connect. For more information, see [Service Connect](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-connect.html) in the *Amazon Elastic Container Service Developer Guide*.")
  serviceConnectConfiguration?: ServiceConnectConfiguration;

  @doc("The name of your service. Up to 255 letters (uppercase and lowercase), numbers, underscores, and hyphens are allowed. Service names must be unique within a cluster, but you can have similarly named services in multiple clusters within a Region or across multiple Regions.  The stack update fails if you change any properties that require replacement and the ``ServiceName`` is configured. This is because AWS CloudFormation creates the replacement service first, but each ``ServiceName`` must be unique in the cluster.")
  serviceName?: string;

  @doc("The details of the service discovery registry to associate with this service. For more information, see [Service discovery](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-discovery.html).  Each service may be associated with one service registry. Multiple service registries for each service isn't supported.")
  @extension("x-ms-identifiers", [])
  serviceRegistries?: ServiceRegistry[];

  @doc("The metadata that you apply to the service to help you categorize and organize them. Each tag consists of a key and an optional value, both of which you define. When a service is deleted, the tags are deleted as well. The following basic restrictions apply to tags:  +  Maximum number of tags per resource - 50  +  For each resource, each tag key must be unique, and each tag key can have only one value.  +  Maximum key length - 128 Unicode characters in UTF-8  +  Maximum value length - 256 Unicode characters in UTF-8  +  If your tagging schema is used across multiple services and resources, remember that other services may have restrictions on allowed characters. Generally allowed characters are: letters, numbers, and spaces representable in UTF-8, and the following characters: + - = . _ : / @.  +  Tag keys and values are case-sensitive.  +  Do not use ``aws:``, ``AWS:``, or any upper or lowercase combination of such as a prefix for either keys or values as it is reserved for AWS use. You cannot edit or delete tag keys or values with this prefix. Tags with this prefix do not count against your tags per resource limit.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("The ``family`` and ``revision`` (``family:revision``) or full ARN of the task definition to run in your service. If a ``revision`` isn't specified, the latest ``ACTIVE`` revision is used. A task definition must be specified if the service uses either the ``ECS`` or ``CODE_DEPLOY`` deployment controllers. For more information about deployment types, see [Amazon ECS deployment types](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-types.html).")
  taskDefinition?: string;

  @doc("The configuration for a volume specified in the task definition as a volume that is configured at launch time. Currently, the only supported volume type is an Amazon EBS volume.")
  @extension("x-ms-identifiers", [])
  volumeConfigurations?: ServiceVolumeConfiguration[];
}

@doc("LaunchType enum")
union LaunchType {
  @doc("LaunchType enum EC2")
  EC2: "EC2",

  @doc("LaunchType enum EXTERNAL")
  EXTERNAL: "EXTERNAL",

  @doc("LaunchType enum FARGATE")
  FARGATE: "FARGATE",

  string,
}

@doc("SchedulingStrategy enum")
union SchedulingStrategy {
  @doc("SchedulingStrategy enum DAEMON")
  DAEMON: "DAEMON",

  @doc("SchedulingStrategy enum REPLICA")
  REPLICA: "REPLICA",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CapacityProviderStrategyItem")
model CapacityProviderStrategyItem {
  @doc("The *base* value designates how many tasks, at a minimum, to run on the specified capacity provider. Only one capacity provider in a capacity provider strategy can have a *base* defined. If no value is specified, the default value of ``0`` is used.")
  base?: int32;

  @doc("The short name of the capacity provider.")
  capacityProvider?: string;

  @doc("The *weight* value designates the relative percentage of the total number of tasks launched that should use the specified capacity provider. The ``weight`` value is taken into consideration after the ``base`` value, if defined, is satisfied. If no ``weight`` value is specified, the default value of ``0`` is used. When multiple capacity providers are specified within a capacity provider strategy, at least one of the capacity providers must have a weight value greater than zero and any capacity providers with a weight of ``0`` can't be used to place tasks. If you specify multiple capacity providers in a strategy that all have a weight of ``0``, any ``RunTask`` or ``CreateService`` actions using the capacity provider strategy will fail. An example scenario for using weights is defining a strategy that contains two capacity providers and both have a weight of ``1``, then when the ``base`` is satisfied, the tasks will be split evenly across the two capacity providers. Using that same logic, if you specify a weight of ``1`` for *capacityProviderA* and a weight of ``4`` for *capacityProviderB*, then for every one task that's run using *capacityProviderA*, four tasks would use *capacityProviderB*.")
  weight?: int32;
}

@doc("PropagateTags enum")
union PropagateTags {
  @doc("PropagateTags enum SERVICE")
  SERVICE: "SERVICE",

  @doc("PropagateTags enum TASK_DEFINITION")
  TASK_DEFINITION: "TASK_DEFINITION",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DeploymentConfiguration")
model DeploymentConfiguration {
  @doc("Information about the CloudWatch alarms. One of the methods which provide a way for you to quickly identify when a deployment has failed, and then to optionally roll back the failure to the last working deployment. When the alarms are generated, Amazon ECS sets the service deployment to failed. Set the rollback parameter to have Amazon ECS to roll back your service to the last completed deployment after a failure. You can only use the ``DeploymentAlarms`` method to detect failures when the ``DeploymentController`` is set to ``ECS`` (rolling update). For more information, see [Rolling update](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-type-ecs.html) in the *Amazon Elastic Container Service Developer Guide*.")
  alarms?: DeploymentAlarms;

  @doc("The deployment circuit breaker can only be used for services using the rolling update (``ECS``) deployment type.  The *deployment circuit breaker* determines whether a service deployment will fail if the service can't reach a steady state. If you use the deployment circuit breaker, a service deployment will transition to a failed state and stop launching new tasks. If you use the rollback option, when a service deployment fails, the service is rolled back to the last deployment that completed successfully. For more information, see [Rolling update](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-type-ecs.html) in the *Amazon Elastic Container Service Developer Guide* The deployment circuit breaker can only be used for services using the rolling update (``ECS``) deployment type.  The *deployment circuit breaker* determines whether a service deployment will fail if the service can't reach a steady state. If it is turned on, a service deployment will transition to a failed state and stop launching new tasks. You can also configure Amazon ECS to roll back your service to the last completed deployment after a failure. For more information, see [Rolling update](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-type-ecs.html) in the *Amazon Elastic Container Service Developer Guide*. For more information about API failure reasons, see [API failure reasons](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/api_failures_messages.html) in the *Amazon Elastic Container Service Developer Guide*.")
  deploymentCircuitBreaker?: DeploymentCircuitBreaker;

  @doc("If a service is using the rolling update (``ECS``) deployment type, the ``maximumPercent`` parameter represents an upper limit on the number of your service's tasks that are allowed in the ``RUNNING`` or ``PENDING`` state during a deployment, as a percentage of the ``desiredCount`` (rounded down to the nearest integer). This parameter enables you to define the deployment batch size. For example, if your service is using the ``REPLICA`` service scheduler and has a ``desiredCount`` of four tasks and a ``maximumPercent`` value of 200%, the scheduler may start four new tasks before stopping the four older tasks (provided that the cluster resources required to do this are available). The default ``maximumPercent`` value for a service using the ``REPLICA`` service scheduler is 200%. If a service is using either the blue/green (``CODE_DEPLOY``) or ``EXTERNAL`` deployment types and tasks that use the EC2 launch type, the *maximum percent* value is set to the default value and is used to define the upper limit on the number of the tasks in the service that remain in the ``RUNNING`` state while the container instances are in the ``DRAINING`` state. If the tasks in the service use the Fargate launch type, the maximum percent value is not used, although it is returned when describing your service.")
  maximumPercent?: int32;

  @doc("If a service is using the rolling update (``ECS``) deployment type, the ``minimumHealthyPercent`` represents a lower limit on the number of your service's tasks that must remain in the ``RUNNING`` state during a deployment, as a percentage of the ``desiredCount`` (rounded up to the nearest integer). This parameter enables you to deploy without using additional cluster capacity. For example, if your service has a ``desiredCount`` of four tasks and a ``minimumHealthyPercent`` of 50%, the service scheduler may stop two existing tasks to free up cluster capacity before starting two new tasks.  For services that *do not* use a load balancer, the following should be noted:  +  A service is considered healthy if all essential containers within the tasks in the service pass their health checks.  +  If a task has no essential containers with a health check defined, the service scheduler will wait for 40 seconds after a task reaches a ``RUNNING`` state before the task is counted towards the minimum healthy percent total.  +  If a task has one or more essential containers with a health check defined, the service scheduler will wait for the task to reach a healthy status before counting it towards the minimum healthy percent total. A task is considered healthy when all essential containers within the task have passed their health checks. The amount of time the service scheduler can wait for is determined by the container health check settings.    For services that *do* use a load balancer, the following should be noted:  +  If a task has no essential containers with a health check defined, the service scheduler will wait for the load balancer target group health check to return a healthy status before counting the task towards the minimum healthy percent total.  +  If a task has an essential container with a health check defined, the service scheduler will wait for both the task to reach a healthy status and the load balancer target group health check to return a healthy status before counting the task towards the minimum healthy percent total.   If a service is using either the blue/green (``CODE_DEPLOY``) or ``EXTERNAL`` deployment types and is running tasks that use the EC2 launch type, the *minimum healthy percent* value is set to the default value and is used to define the lower limit on the number of the tasks in the service that remain in the ``RUNNING`` state while the container instances are in the ``DRAINING`` state. If a service is using either the blue/green (``CODE_DEPLOY``) or ``EXTERNAL`` deployment types and is running tasks that use the Fargate launch type, the minimum healthy percent value is not used, although it is returned when describing your service.")
  minimumHealthyPercent?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DeploymentController")
model DeploymentController {
  @doc("The deployment controller type to use. There are three deployment controller types available:  + ECS The rolling update (ECS) deployment type involves replacing the current running version of the container with the latest version. The number of containers Amazon ECS adds or removes from the service during a rolling update is controlled by adjusting the minimum and maximum number of healthy tasks allowed during a service deployment, as specified in the DeploymentConfiguration. + CODE_DEPLOY The blue/green (CODE_DEPLOY) deployment type uses the blue/green deployment model powered by , which allows you to verify a new deployment of a service before sending production traffic to it. + EXTERNAL The external (EXTERNAL) deployment type enables you to use any third-party deployment controller for full control over the deployment process for an Amazon ECS service.")
  type?: DeploymentControllerType;
}

@doc("DeploymentControllerType enum")
union DeploymentControllerType {
  @doc("DeploymentControllerType enum CODE_DEPLOY")
  CODE_DEPLOY: "CODE_DEPLOY",

  @doc("DeploymentControllerType enum ECS")
  ECS: "ECS",

  @doc("DeploymentControllerType enum EXTERNAL")
  EXTERNAL: "EXTERNAL",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LoadBalancer")
model LoadBalancer {
  @doc("The name of the container (as it appears in a container definition) to associate with the load balancer. You need to specify the container name when configuring the target group for an Amazon ECS load balancer.")
  containerName?: string;

  @doc("The port on the container to associate with the load balancer. This port must correspond to a ``containerPort`` in the task definition the tasks in the service are using. For tasks that use the EC2 launch type, the container instance they're launched on must allow ingress traffic on the ``hostPort`` of the port mapping.")
  containerPort?: int32;

  @doc("The name of the load balancer to associate with the Amazon ECS service or task set. If you are using an Application Load Balancer or a Network Load Balancer the load balancer name parameter should be omitted.")
  loadBalancerName?: string;

  @doc("The full Amazon Resource Name (ARN) of the Elastic Load Balancing target group or groups associated with a service or task set. A target group ARN is only specified when using an Application Load Balancer or Network Load Balancer.  For services using the ``ECS`` deployment controller, you can specify one or multiple target groups. For more information, see [Registering multiple target groups with a service](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/register-multiple-targetgroups.html) in the *Amazon Elastic Container Service Developer Guide*. For services using the ``CODE_DEPLOY`` deployment controller, you're required to define two target groups for the load balancer. For more information, see [Blue/green deployment with CodeDeploy](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-type-bluegreen.html) in the *Amazon Elastic Container Service Developer Guide*.  If your service's task definition uses the ``awsvpc`` network mode, you must choose ``ip`` as the target type, not ``instance``. Do this when creating your target groups because tasks that use the ``awsvpc`` network mode are associated with an elastic network interface, not an Amazon EC2 instance. This network mode is required for the Fargate launch type.")
  targetGroupArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NetworkConfiguration")
model NetworkConfiguration {
  @doc("The VPC subnets and security groups that are associated with a task.  All specified subnets and security groups must be from the same VPC. An object representing the networking details for a task or service. For example ``awsvpcConfiguration={subnets=['subnet-12344321'],securityGroups=['sg-12344321']}``")
  awsvpcConfiguration?: AwsVpcConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PlacementConstraint")
model PlacementConstraint {
  @doc("A cluster query language expression to apply to the constraint. The expression can have a maximum length of 2000 characters. You can't specify an expression if the constraint type is ``distinctInstance``. For more information, see [Cluster query language](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cluster-query-language.html) in the *Amazon Elastic Container Service Developer Guide*.")
  expression?: string;

  @doc("The type of constraint. Use ``distinctInstance`` to ensure that each task in a particular group is running on a different container instance. Use ``memberOf`` to restrict the selection to a group of valid candidates.")
  type?: PlacementConstraintType;
}

@doc("PlacementConstraintType enum")
union PlacementConstraintType {
  @doc("PlacementConstraintType enum distinctInstance")
  distinctInstance: "distinctInstance",

  @doc("PlacementConstraintType enum memberOf")
  memberOf: "memberOf",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PlacementStrategy")
model PlacementStrategy {
  @doc("The field to apply the placement strategy against. For the ``spread`` placement strategy, valid values are ``instanceId`` (or ``host``, which has the same effect), or any platform or custom attribute that is applied to a container instance, such as ``attribute:ecs.availability-zone``. For the ``binpack`` placement strategy, valid values are ``CPU`` and ``MEMORY``. For the ``random`` placement strategy, this field is not used.")
  field?: string;

  @doc("The type of placement strategy. The ``random`` placement strategy randomly places tasks on available candidates. The ``spread`` placement strategy spreads placement across available candidates evenly based on the ``field`` parameter. The ``binpack`` strategy places tasks on available candidates that have the least available amount of the resource that's specified with the ``field`` parameter. For example, if you binpack on memory, a task is placed on the instance with the least amount of remaining memory but still enough to run the task.")
  type?: PlacementStrategyType;
}

@doc("PlacementStrategyType enum")
union PlacementStrategyType {
  @doc("PlacementStrategyType enum binpack")
  binpack: "binpack",

  @doc("PlacementStrategyType enum random")
  random: "random",

  @doc("PlacementStrategyType enum spread")
  spread: "spread",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ServiceConnectConfiguration")
model ServiceConnectConfiguration {
  @doc("Specifies whether to use Service Connect with this service.")
  enabled?: boolean;

  @doc("The log configuration for the container. This parameter maps to ``LogConfig`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--log-driver`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/commandline/run/). By default, containers use the same logging driver that the Docker daemon uses. However, the container might use a different logging driver than the Docker daemon by specifying a log driver configuration in the container definition. For more information about the options for different supported log drivers, see [Configure logging drivers](https://docs.aws.amazon.com/https://docs.docker.com/engine/admin/logging/overview/) in the Docker documentation. Understand the following when specifying a log configuration for your containers.  +  Amazon ECS currently supports a subset of the logging drivers available to the Docker daemon. Additional log drivers may be available in future releases of the Amazon ECS container agent. For tasks on FARGATElong, the supported log drivers are ``awslogs``, ``splunk``, and ``awsfirelens``. For tasks hosted on Amazon EC2 instances, the supported log drivers are ``awslogs``, ``fluentd``, ``gelf``, ``json-file``, ``journald``, ``logentries``,``syslog``, ``splunk``, and ``awsfirelens``.  +  This parameter requires version 1.18 of the Docker Remote API or greater on your container instance.  +  For tasks that are hosted on Amazon EC2 instances, the Amazon ECS container agent must register the available logging drivers with the ``ECS_AVAILABLE_LOGGING_DRIVERS`` environment variable before containers placed on that instance can use these log configuration options. For more information, see [Amazon ECS container agent configuration](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-config.html) in the *Amazon Elastic Container Service Developer Guide*.  +  For tasks that are on FARGATElong, because you don't have access to the underlying infrastructure your tasks are hosted on, any additional software needed must be installed outside of the task. For example, the Fluentd output aggregators or a remote host running Logstash to send Gelf logs to. The log configuration for the container. This parameter maps to ``LogConfig`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--log-driver`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/commandline/run/). By default, containers use the same logging driver that the Docker daemon uses. However, the container might use a different logging driver than the Docker daemon by specifying a log driver configuration in the container definition. For more information about the options for different supported log drivers, see [Configure logging drivers](https://docs.aws.amazon.com/https://docs.docker.com/engine/admin/logging/overview/) in the Docker documentation. Understand the following when specifying a log configuration for your containers.  +  Amazon ECS currently supports a subset of the logging drivers available to the Docker daemon. Additional log drivers may be available in future releases of the Amazon ECS container agent. For tasks on FARGATElong, the supported log drivers are ``awslogs``, ``splunk``, and ``awsfirelens``. For tasks hosted on Amazon EC2 instances, the supported log drivers are ``awslogs``, ``fluentd``, ``gelf``, ``json-file``, ``journald``, ``logentries``,``syslog``, ``splunk``, and ``awsfirelens``.  +  This parameter requires version 1.18 of the Docker Remote API or greater on your container instance.  +  For tasks that are hosted on Amazon EC2 instances, the Amazon ECS container agent must register the available logging drivers with the ``ECS_AVAILABLE_LOGGING_DRIVERS`` environment variable before containers placed on that instance can use these log configuration options. For more information, see [Amazon ECS container agent configuration](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-config.html) in the *Amazon Elastic Container Service Developer Guide*.  +  For tasks that are on FARGATElong, because you don't have access to the underlying infrastructure your tasks are hosted on, any additional software needed must be installed outside of the task. For example, the Fluentd output aggregators or a remote host running Logstash to send Gelf logs to.")
  logConfiguration?: LogConfiguration;

  @doc("The namespace name or full Amazon Resource Name (ARN) of the CMAPlong namespace for use with Service Connect. The namespace must be in the same AWS Region as the Amazon ECS service and cluster. The type of namespace doesn't affect Service Connect. For more information about CMAPlong, see [Working with Services](https://docs.aws.amazon.com/cloud-map/latest/dg/working-with-services.html) in the *Developer Guide*.")
  `namespace`?: string;

  @doc("The list of Service Connect service objects. These are names and aliases (also known as endpoints) that are used by other Amazon ECS services to connect to this service.  This field is not required for a 'client' Amazon ECS service that's a member of a namespace only to connect to other services within the namespace. An example of this would be a frontend application that accepts incoming requests from either a load balancer that's attached to the service or by other means. An object selects a port from the task definition, assigns a name for the CMAPlong service, and a list of aliases (endpoints) and ports for client applications to refer to this service.")
  @extension("x-ms-identifiers", [])
  services?: ServiceConnectService[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ServiceRegistry")
model ServiceRegistry {
  @doc("The container name value to be used for your service discovery service. It's already specified in the task definition. If the task definition that your service task specifies uses the ``bridge`` or ``host`` network mode, you must specify a ``containerName`` and ``containerPort`` combination from the task definition. If the task definition that your service task specifies uses the ``awsvpc`` network mode and a type SRV DNS record is used, you must specify either a ``containerName`` and ``containerPort`` combination or a ``port`` value. However, you can't specify both.")
  containerName?: string;

  @doc("The port value to be used for your service discovery service. It's already specified in the task definition. If the task definition your service task specifies uses the ``bridge`` or ``host`` network mode, you must specify a ``containerName`` and ``containerPort`` combination from the task definition. If the task definition your service task specifies uses the ``awsvpc`` network mode and a type SRV DNS record is used, you must specify either a ``containerName`` and ``containerPort`` combination or a ``port`` value. However, you can't specify both.")
  containerPort?: int32;

  @doc("The port value used if your service discovery service specified an SRV record. This field might be used if both the ``awsvpc`` network mode and SRV records are used.")
  port?: int32;

  @doc("The Amazon Resource Name (ARN) of the service registry. The currently supported service registry is CMAP. For more information, see [CreateService](https://docs.aws.amazon.com/cloud-map/latest/api/API_CreateService.html).")
  registryArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("One part of a key-value pair that make up a tag. A ``key`` is a general label that acts like a category for more specific tag values.")
  key?: string;

  @doc("The optional part of a key-value pair that make up a tag. A ``value`` acts as a descriptor within a tag category (key).")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ServiceVolumeConfiguration")
model ServiceVolumeConfiguration {
  @doc("The configuration for the Amazon EBS volume that Amazon ECS creates and manages on your behalf. These settings are used to create each Amazon EBS volume, with one volume created for each task in the service. The Amazon EBS volumes are visible in your account in the Amazon EC2 console once they are created. The configuration for the Amazon EBS volume that Amazon ECS creates and manages on your behalf. These settings are used to create each Amazon EBS volume, with one volume created for each task in the service. Many of these parameters map 1:1 with the Amazon EBS ``CreateVolume`` API request parameters.")
  managedEBSVolume?: ServiceManagedEBSVolumeConfiguration;

  @doc("The name of the volume. This value must match the volume name from the ``Volume`` object in the task definition.")
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DeploymentAlarms")
model DeploymentAlarms {
  @doc("One or more CloudWatch alarm names. Use a ',' to separate the alarms.")
  @extension("x-ms-identifiers", [])
  alarmNames?: string[];

  @doc("Determines whether to use the CloudWatch alarm option in the service deployment process.")
  enable?: boolean;

  @doc("Determines whether to configure Amazon ECS to roll back the service if a service deployment fails. If rollback is used, when a service deployment fails, the service is rolled back to the last deployment that completed successfully.")
  rollback?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DeploymentCircuitBreaker")
model DeploymentCircuitBreaker {
  @doc("Determines whether to use the deployment circuit breaker logic for the service.")
  enable?: boolean;

  @doc("Determines whether to configure Amazon ECS to roll back the service if a service deployment fails. If rollback is on, when a service deployment fails, the service is rolled back to the last deployment that completed successfully.")
  rollback?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AwsVpcConfiguration")
model AwsVpcConfiguration {
  @doc("Whether the task's elastic network interface receives a public IP address. The default value is ``DISABLED``.")
  assignPublicIp?: AwsVpcConfigurationAssignPublicIp;

  @doc("The IDs of the security groups associated with the task or service. If you don't specify a security group, the default security group for the VPC is used. There's a limit of 5 security groups that can be specified per ``AwsVpcConfiguration``.  All specified security groups must be from the same VPC.")
  @extension("x-ms-identifiers", [])
  securityGroups?: string[];

  @doc("The IDs of the subnets associated with the task or service. There's a limit of 16 subnets that can be specified per ``AwsVpcConfiguration``.  All specified subnets must be from the same VPC.")
  @extension("x-ms-identifiers", [])
  subnets?: string[];
}

@doc("AwsVpcConfigurationAssignPublicIp enum")
union AwsVpcConfigurationAssignPublicIp {
  @doc("AwsVpcConfigurationAssignPublicIp enum DISABLED")
  DISABLED: "DISABLED",

  @doc("AwsVpcConfigurationAssignPublicIp enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LogConfiguration")
model LogConfiguration {
  @doc("The log driver to use for the container. For tasks on FARGATElong, the supported log drivers are ``awslogs``, ``splunk``, and ``awsfirelens``. For tasks hosted on Amazon EC2 instances, the supported log drivers are ``awslogs``, ``fluentd``, ``gelf``, ``json-file``, ``journald``, ``logentries``,``syslog``, ``splunk``, and ``awsfirelens``. For more information about using the ``awslogs`` log driver, see [Using the awslogs log driver](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_awslogs.html) in the *Amazon Elastic Container Service Developer Guide*. For more information about using the ``awsfirelens`` log driver, see [Custom log routing](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_firelens.html) in the *Amazon Elastic Container Service Developer Guide*.  If you have a custom driver that isn't listed, you can fork the Amazon ECS container agent project that's [available on GitHub](https://docs.aws.amazon.com/https://github.com/aws/amazon-ecs-agent) and customize it to work with that driver. We encourage you to submit pull requests for changes that you would like to have included. However, we don't currently provide support for running modified copies of this software.")
  logDriver?: string;

  @doc("The configuration options to send to the log driver. This parameter requires version 1.19 of the Docker Remote API or greater on your container instance. To check the Docker Remote API version on your container instance, log in to your container instance and run the following command: ``sudo docker version --format '{{.Server.APIVersion}}'``")
  options?: unknown;

  @doc("The secrets to pass to the log configuration. For more information, see [Specifying sensitive data](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/specifying-sensitive-data.html) in the *Amazon Elastic Container Service Developer Guide*.")
  @extension("x-ms-identifiers", [])
  secretOptions?: Secret[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ServiceConnectService")
model ServiceConnectService {
  @doc("The list of client aliases for this Service Connect service. You use these to assign names that can be used by client applications. The maximum number of client aliases that you can have in this list is 1. Each alias ('endpoint') is a fully-qualified name and port number that other Amazon ECS tasks ('clients') can use to connect to this service. Each name and port mapping must be unique within the namespace. For each ``ServiceConnectService``, you must provide at least one ``clientAlias`` with one ``port``.")
  @extension("x-ms-identifiers", [])
  clientAliases?: ServiceConnectClientAlias[];

  @doc("The ``discoveryName`` is the name of the new CMAP service that Amazon ECS creates for this Amazon ECS service. This must be unique within the CMAP namespace. The name can contain up to 64 characters. The name can include lowercase letters, numbers, underscores (_), and hyphens (-). The name can't start with a hyphen. If the ``discoveryName`` isn't specified, the port mapping name from the task definition is used in ``portName.namespace``.")
  discoveryName?: string;

  @doc("The port number for the Service Connect proxy to listen on. Use the value of this field to bypass the proxy for traffic on the port number specified in the named ``portMapping`` in the task definition of this application, and then use it in your VPC security groups to allow traffic into the proxy for this Amazon ECS service. In ``awsvpc`` mode and Fargate, the default value is the container port number. The container port number is in the ``portMapping`` in the task definition. In bridge mode, the default value is the ephemeral port of the Service Connect proxy.")
  ingressPortOverride?: int32;

  @doc("The ``portName`` must match the name of one of the ``portMappings`` from all the containers in the task definition of this Amazon ECS service.")
  portName?: string;

  @doc("A reference to an object that represents the configured timeouts for Service Connect. An object that represents the timeout configurations for Service Connect.  If ``idleTimeout`` is set to a time that is less than ``perRequestTimeout``, the connection will close when the ``idleTimeout`` is reached and not the ``perRequestTimeout``.")
  timeout?: TimeoutConfiguration;

  @doc("A reference to an object that represents a Transport Layer Security (TLS) configuration. An object that represents the configuration for Service Connect TLS.")
  tls?: ServiceConnectTlsConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ServiceManagedEBSVolumeConfiguration")
model ServiceManagedEBSVolumeConfiguration {
  @doc("Indicates whether the volume should be encrypted. If no value is specified, encryption is turned on by default. This parameter maps 1:1 with the ``Encrypted`` parameter of the [CreateVolume API](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVolume.html) in the *Amazon EC2 API Reference*.")
  encrypted?: boolean;

  @doc("The Linux filesystem type for the volume. For volumes created from a snapshot, you must specify the same filesystem type that the volume was using when the snapshot was created. If there is a filesystem type mismatch, the task will fail to start. The available filesystem types are  ``ext3``, ``ext4``, and ``xfs``. If no value is specified, the ``xfs`` filesystem type is used by default.")
  filesystemType?: string;

  @doc("The number of I/O operations per second (IOPS). For ``gp3``, ``io1``, and ``io2`` volumes, this represents the number of IOPS that are provisioned for the volume. For ``gp2`` volumes, this represents the baseline performance of the volume and the rate at which the volume accumulates I/O credits for bursting. The following are the supported values for each volume type.  +   ``gp3``: 3,000 - 16,000 IOPS  +   ``io1``: 100 - 64,000 IOPS  +   ``io2``: 100 - 256,000 IOPS   This parameter is required for ``io1`` and ``io2`` volume types. The default for ``gp3`` volumes is ``3,000 IOPS``. This parameter is not supported for ``st1``, ``sc1``, or ``standard`` volume types. This parameter maps 1:1 with the ``Iops`` parameter of the [CreateVolume API](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVolume.html) in the *Amazon EC2 API Reference*.")
  iops?: int32;

  @doc("The Amazon Resource Name (ARN) identifier of the AWS Key Management Service key to use for Amazon EBS encryption. When encryption is turned on and no AWS Key Management Service key is specified, the default AWS managed key for Amazon EBS volumes is used. This parameter maps 1:1 with the ``KmsKeyId`` parameter of the [CreateVolume API](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVolume.html) in the *Amazon EC2 API Reference*.   AWS authenticates the AWS Key Management Service key asynchronously. Therefore, if you specify an ID, alias, or ARN that is invalid, the action can appear to complete, but eventually fails.")
  kmsKeyId?: string;

  @doc("The ARN of the IAM role to associate with this volume. This is the Amazon ECS infrastructure IAM role that is used to manage your AWS infrastructure. We recommend using the Amazon ECS-managed ``AmazonECSInfrastructureRolePolicyForVolumes`` IAM policy with this role. For more information, see [Amazon ECS infrastructure IAM role](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/infrastructure_IAM_role.html) in the *Amazon ECS Developer Guide*.")
  roleArn?: string;

  @doc("The size of the volume in GiB. You must specify either a volume size or a snapshot ID. If you specify a snapshot ID, the snapshot size is used for the volume size by default. You can optionally specify a volume size greater than or equal to the snapshot size. This parameter maps 1:1 with the ``Size`` parameter of the [CreateVolume API](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVolume.html) in the *Amazon EC2 API Reference*. The following are the supported volume size values for each volume type.  +   ``gp2`` and ``gp3``: 1-16,384  +   ``io1`` and ``io2``: 4-16,384  +   ``st1`` and ``sc1``: 125-16,384  +   ``standard``: 1-1,024")
  sizeInGiB?: int32;

  @doc("The snapshot that Amazon ECS uses to create the volume. You must specify either a snapshot ID or a volume size. This parameter maps 1:1 with the ``SnapshotId`` parameter of the [CreateVolume API](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVolume.html) in the *Amazon EC2 API Reference*.")
  snapshotId?: string;

  @doc("The tags to apply to the volume. Amazon ECS applies service-managed tags by default. This parameter maps 1:1 with the ``TagSpecifications.N`` parameter of the [CreateVolume API](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVolume.html) in the *Amazon EC2 API Reference*.")
  @extension("x-ms-identifiers", [])
  tagSpecifications?: EBSTagSpecification[];

  @doc("The throughput to provision for a volume, in MiB/s, with a maximum of 1,000 MiB/s. This parameter maps 1:1 with the ``Throughput`` parameter of the [CreateVolume API](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVolume.html) in the *Amazon EC2 API Reference*.  This parameter is only supported for the ``gp3`` volume type.")
  throughput?: int32;

  @doc("The volume type. This parameter maps 1:1 with the ``VolumeType`` parameter of the [CreateVolume API](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVolume.html) in the *Amazon EC2 API Reference*. For more information, see [Amazon EBS volume types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html) in the *Amazon EC2 User Guide*. The following are the supported volume types.  +  General Purpose SSD: ``gp2``|``gp3``   +  Provisioned IOPS SSD: ``io1``|``io2``   +  Throughput Optimized HDD: ``st1``   +  Cold HDD: ``sc1``   +  Magnetic: ``standard``   The magnetic volume type is not supported on Fargate.")
  volumeType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Secret")
model Secret {
  @doc("The name of the secret.")
  name?: string;

  @doc("The secret to expose to the container. The supported values are either the full ARN of the ASMlong secret or the full ARN of the parameter in the SSM Parameter Store. For information about the require IAMlong permissions, see [Required IAM permissions for Amazon ECS secrets](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/specifying-sensitive-data-secrets.html#secrets-iam) (for Secrets Manager) or [Required IAM permissions for Amazon ECS secrets](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/specifying-sensitive-data-parameters.html) (for Systems Manager Parameter store) in the *Amazon Elastic Container Service Developer Guide*.  If the SSM Parameter Store parameter exists in the same Region as the task you're launching, then you can use either the full ARN or name of the parameter. If the parameter exists in a different Region, then the full ARN must be specified.")
  valueFrom?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ServiceConnectClientAlias")
model ServiceConnectClientAlias {
  @doc("The ``dnsName`` is the name that you use in the applications of client tasks to connect to this service. The name must be a valid DNS name but doesn't need to be fully-qualified. The name can include up to 127 characters. The name can include lowercase letters, numbers, underscores (_), hyphens (-), and periods (.). The name can't start with a hyphen. If this parameter isn't specified, the default value of ``discoveryName.namespace`` is used. If the ``discoveryName`` isn't specified, the port mapping name from the task definition is used in ``portName.namespace``. To avoid changing your applications in client Amazon ECS services, set this to the same name that the client application uses by default. For example, a few common names are ``database``, ``db``, or the lowercase name of a database, such as ``mysql`` or ``redis``. For more information, see [Service Connect](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-connect.html) in the *Amazon Elastic Container Service Developer Guide*.")
  dnsName?: string;

  @doc("The listening port number for the Service Connect proxy. This port is available inside of all of the tasks within the same namespace. To avoid changing your applications in client Amazon ECS services, set this to the same port that the client application uses by default. For more information, see [Service Connect](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-connect.html) in the *Amazon Elastic Container Service Developer Guide*.")
  port?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TimeoutConfiguration")
model TimeoutConfiguration {
  @doc("The amount of time in seconds a connection will stay active while idle. A value of ``0`` can be set to disable ``idleTimeout``. The ``idleTimeout`` default for ``HTTP``/``HTTP2``/``GRPC`` is 5 minutes. The ``idleTimeout`` default for ``TCP`` is 1 hour.")
  idleTimeoutSeconds?: int32;

  @doc("The amount of time waiting for the upstream to respond with a complete response per request. A value of ``0`` can be set to disable ``perRequestTimeout``. ``perRequestTimeout`` can only be set if Service Connect ``appProtocol`` isn't ``TCP``. Only ``idleTimeout`` is allowed for ``TCP`` ``appProtocol``.")
  perRequestTimeoutSeconds?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ServiceConnectTlsConfiguration")
model ServiceConnectTlsConfiguration {
  @doc("The signer certificate authority. An object that represents the AWS Private Certificate Authority certificate.")
  issuerCertificateAuthority?: ServiceConnectTlsCertificateAuthority;

  @doc("The AWS Key Management Service key.")
  kmsKey?: string;

  @doc("The Amazon Resource Name (ARN) of the IAM role that's associated with the Service Connect TLS.")
  roleArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EBSTagSpecification")
model EBSTagSpecification {
  @doc("Determines whether to propagate the tags from the task definition to  the Amazon EBS volume. Tags can only propagate to a ``SERVICE`` specified in  ``ServiceVolumeConfiguration``. If no value is specified, the tags aren't  propagated.")
  propagateTags?: EBSTagSpecificationPropagateTags;

  @doc("The type of volume resource.")
  resourceType?: string;

  @doc("The tags applied to this Amazon EBS volume. ``AmazonECSCreated`` and ``AmazonECSManaged`` are reserved tags that can't be used.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];
}

@doc("EBSTagSpecificationPropagateTags enum")
union EBSTagSpecificationPropagateTags {
  @doc("EBSTagSpecificationPropagateTags enum SERVICE")
  SERVICE: "SERVICE",

  @doc("EBSTagSpecificationPropagateTags enum TASK_DEFINITION")
  TASK_DEFINITION: "TASK_DEFINITION",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ServiceConnectTlsCertificateAuthority")
model ServiceConnectTlsCertificateAuthority {
  @doc("The ARN of the AWS Private Certificate Authority certificate.")
  awsPcaAuthorityArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface EcsServices {
  get is ArmResourceRead<EcsService>;
  @doc("Create a EcsService. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<EcsService>;
  update is ArmCustomPatchAsync<
    EcsService,
    Azure.ResourceManager.Foundations.TagsUpdateModel<EcsService>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<EcsService>;
  listByResourceGroup is ArmResourceListByParent<EcsService>;
  listBySubscription is ArmListBySubscription<EcsService>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::ECS::Service
//--------------------------------------------------------------------------------------------
