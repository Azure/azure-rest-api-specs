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

//---------------------------------------------- EcsTaskDefinitions ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "ECS Task Definition",
    plural: "ECS Task Definitions",
  },
  keywords: ["Microsoft.AwsConnector", "ECS", "Task", "Definition"],
})
@doc("A Microsoft.AwsConnector resource")
model EcsTaskDefinition is TrackedResource<EcsTaskDefinitionProperties> {
  @doc("Name of EcsTaskDefinition")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ecsTaskDefinitions")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EcsTaskDefinition")
model EcsTaskDefinitionProperties {
  @doc("AWS Properties")
  awsProperties?: AwsEcsTaskDefinitionProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEcsTaskDefinition")
model AwsEcsTaskDefinitionProperties {
  @doc("A list of container definitions in JSON format that describe the different containers that make up your task. For more information about container definition parameters and defaults, see [Amazon ECS Task Definitions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_defintions.html) in the *Amazon Elastic Container Service Developer Guide*.")
  @extension("x-ms-identifiers", [])
  containerDefinitions?: ContainerDefinition[];

  @doc("The number of ``cpu`` units used by the task. If you use the EC2 launch type, this field is optional. Any value can be used. If you use the Fargate launch type, this field is required. You must use one of the following values. The value that you choose determines your range of valid values for the ``memory`` parameter. The CPU units cannot be less than 1 vCPU when you use Windows containers on Fargate.  +  256 (.25 vCPU) - Available ``memory`` values: 512 (0.5 GB), 1024 (1 GB), 2048 (2 GB)  +  512 (.5 vCPU) - Available ``memory`` values: 1024 (1 GB), 2048 (2 GB), 3072 (3 GB), 4096 (4 GB)  +  1024 (1 vCPU) - Available ``memory`` values: 2048 (2 GB), 3072 (3 GB), 4096 (4 GB), 5120 (5 GB), 6144 (6 GB), 7168 (7 GB), 8192 (8 GB)  +  2048 (2 vCPU) - Available ``memory`` values: 4096 (4 GB) and 16384 (16 GB) in increments of 1024 (1 GB)  +  4096 (4 vCPU) - Available ``memory`` values: 8192 (8 GB) and 30720 (30 GB) in increments of 1024 (1 GB)  +  8192 (8 vCPU) - Available ``memory`` values: 16 GB and 60 GB in 4 GB increments This option requires Linux platform ``1.4.0`` or later.  +  16384 (16vCPU) - Available ``memory`` values: 32GB and 120 GB in 8 GB increments This option requires Linux platform ``1.4.0`` or later.")
  cpu?: string;

  @doc("The ephemeral storage settings to use for tasks run with the task definition. The amount of ephemeral storage to allocate for the task. This parameter is used to expand the total amount of ephemeral storage available, beyond the default amount, for tasks hosted on FARGATElong. For more information, see [Using data volumes in tasks](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_data_volumes.html) in the *Amazon ECS Developer Guide;*.  For tasks using the Fargate launch type, the task requires the following platforms:  +  Linux platform version ``1.4.0`` or later.  +  Windows platform version ``1.0.0`` or later.")
  ephemeralStorage?: EphemeralStorage;

  @doc("The Amazon Resource Name (ARN) of the task execution role that grants the Amazon ECS container agent permission to make AWS API calls on your behalf. The task execution IAM role is required depending on the requirements of your task. For more information, see [Amazon ECS task execution IAM role](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_execution_IAM_role.html) in the *Amazon Elastic Container Service Developer Guide*.")
  executionRoleArn?: string;

  @doc("The name of a family that this task definition is registered to. Up to 255 letters (uppercase and lowercase), numbers, hyphens, and underscores are allowed. A family groups multiple versions of a task definition. Amazon ECS gives the first task definition that you registered to a family a revision number of 1. Amazon ECS gives sequential revision numbers to each task definition that you add.  To use revision numbers when you update a task definition, specify this property. If you don't specify a value, CFNlong generates a new task definition each time that you update it.")
  family?: string;

  @doc("The Elastic Inference accelerators to use for the containers in the task.")
  @extension("x-ms-identifiers", [])
  inferenceAccelerators?: InferenceAccelerator[];

  @doc("The IPC resource namespace to use for the containers in the task. The valid values are ``host``, ``task``, or ``none``. If ``host`` is specified, then all containers within the tasks that specified the ``host`` IPC mode on the same container instance share the same IPC resources with the host Amazon EC2 instance. If ``task`` is specified, all containers within the specified task share the same IPC resources. If ``none`` is specified, then IPC resources within the containers of a task are private and not shared with other containers in a task or on the container instance. If no value is specified, then the IPC resource namespace sharing depends on the Docker daemon setting on the container instance. For more information, see [IPC settings](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#ipc-settings---ipc) in the *Docker run reference*. If the ``host`` IPC mode is used, be aware that there is a heightened risk of undesired IPC namespace expose. For more information, see [Docker security](https://docs.aws.amazon.com/https://docs.docker.com/engine/security/security/). If you are setting namespaced kernel parameters using ``systemControls`` for the containers in the task, the following will apply to your IPC resource namespace. For more information, see [System Controls](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html) in the *Amazon Elastic Container Service Developer Guide*.  +  For tasks that use the ``host`` IPC mode, IPC namespace related ``systemControls`` are not supported.  +  For tasks that use the ``task`` IPC mode, IPC namespace related ``systemControls`` will apply to all containers within a task.    This parameter is not supported for Windows containers or tasks run on FARGATElong.")
  ipcMode?: string;

  @doc("The amount (in MiB) of memory used by the task. If your tasks runs on Amazon EC2 instances, you must specify either a task-level memory value or a container-level memory value. This field is optional and any value can be used. If a task-level memory value is specified, the container-level memory value is optional. For more information regarding container-level memory and memory reservation, see [ContainerDefinition](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html). If your tasks runs on FARGATElong, this field is required. You must use one of the following values. The value you choose determines your range of valid values for the ``cpu`` parameter.  +  512 (0.5 GB), 1024 (1 GB), 2048 (2 GB) - Available ``cpu`` values: 256 (.25 vCPU)  +  1024 (1 GB), 2048 (2 GB), 3072 (3 GB), 4096 (4 GB) - Available ``cpu`` values: 512 (.5 vCPU)  +  2048 (2 GB), 3072 (3 GB), 4096 (4 GB), 5120 (5 GB), 6144 (6 GB), 7168 (7 GB), 8192 (8 GB) - Available ``cpu`` values: 1024 (1 vCPU)  +  Between 4096 (4 GB) and 16384 (16 GB) in increments of 1024 (1 GB) - Available ``cpu`` values: 2048 (2 vCPU)  +  Between 8192 (8 GB) and 30720 (30 GB) in increments of 1024 (1 GB) - Available ``cpu`` values: 4096 (4 vCPU)  +  Between 16 GB and 60 GB in 4 GB increments - Available ``cpu`` values: 8192 (8 vCPU) This option requires Linux platform ``1.4.0`` or later.  +  Between 32GB and 120 GB in 8 GB increments - Available ``cpu`` values: 16384 (16 vCPU) This option requires Linux platform ``1.4.0`` or later.")
  memory?: string;

  @doc("The Docker networking mode to use for the containers in the task. The valid values are ``none``, ``bridge``, ``awsvpc``, and ``host``. If no network mode is specified, the default is ``bridge``. For Amazon ECS tasks on Fargate, the ``awsvpc`` network mode is required. For Amazon ECS tasks on Amazon EC2 Linux instances, any network mode can be used. For Amazon ECS tasks on Amazon EC2 Windows instances, ``<default>`` or ``awsvpc`` can be used. If the network mode is set to ``none``, you cannot specify port mappings in your container definitions, and the tasks containers do not have external connectivity. The ``host`` and ``awsvpc`` network modes offer the highest networking performance for containers because they use the EC2 network stack instead of the virtualized network stack provided by the ``bridge`` mode. With the ``host`` and ``awsvpc`` network modes, exposed container ports are mapped directly to the corresponding host port (for the ``host`` network mode) or the attached elastic network interface port (for the ``awsvpc`` network mode), so you cannot take advantage of dynamic host port mappings.   When using the ``host`` network mode, you should not run containers using the root user (UID 0). It is considered best practice to use a non-root user.  If the network mode is ``awsvpc``, the task is allocated an elastic network interface, and you must specify a NetworkConfiguration value when you create a service or run a task with the task definition. For more information, see [Task Networking](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-networking.html) in the *Amazon Elastic Container Service Developer Guide*. If the network mode is ``host``, you cannot run multiple instantiations of the same task on a single container instance when port mappings are used. For more information, see [Network settings](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#network-settings) in the *Docker run reference*.")
  networkMode?: string;

  @doc("The process namespace to use for the containers in the task. The valid values are ``host`` or ``task``. On Fargate for Linux containers, the only valid value is ``task``. For example, monitoring sidecars might need ``pidMode`` to access information about other containers running in the same task. If ``host`` is specified, all containers within the tasks that specified the ``host`` PID mode on the same container instance share the same process namespace with the host Amazon EC2 instance. If ``task`` is specified, all containers within the specified task share the same process namespace. If no value is specified, the default is a private namespace for each container. For more information, see [PID settings](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#pid-settings---pid) in the *Docker run reference*. If the ``host`` PID mode is used, there's a heightened risk of undesired process namespace exposure. For more information, see [Docker security](https://docs.aws.amazon.com/https://docs.docker.com/engine/security/security/).  This parameter is not supported for Windows containers.   This parameter is only supported for tasks that are hosted on FARGATElong if the tasks are using platform version ``1.4.0`` or later (Linux). This isn't supported for Windows containers on Fargate.")
  pidMode?: string;

  @doc("An array of placement constraint objects to use for tasks.  This parameter isn't supported for tasks run on FARGATElong.")
  @extension("x-ms-identifiers", [])
  placementConstraints?: TaskDefinitionPlacementConstraint[];

  @doc("The configuration details for the App Mesh proxy. Your Amazon ECS container instances require at least version 1.26.0 of the container agent and at least version 1.26.0-1 of the ``ecs-init`` package to use a proxy configuration. If your container instances are launched from the Amazon ECS optimized AMI version ``20190301`` or later, they contain the required versions of the container agent and ``ecs-init``. For more information, see [Amazon ECS-optimized Linux AMI](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html) in the *Amazon Elastic Container Service Developer Guide*. The configuration details for the App Mesh proxy. For tasks that use the EC2 launch type, the container instances require at least version 1.26.0 of the container agent and at least version 1.26.0-1 of the ``ecs-init`` package to use a proxy configuration. If your container instances are launched from the Amazon ECS optimized AMI version ``20190301`` or later, then they contain the required versions of the container agent and ``ecs-init``. For more information, see [Amazon ECS-optimized Linux AMI](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html)")
  proxyConfiguration?: ProxyConfiguration;

  @doc("The task launch types the task definition was validated against. The valid values are ``EC2``, ``FARGATE``, and ``EXTERNAL``. For more information, see [Amazon ECS launch types](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/launch_types.html) in the *Amazon Elastic Container Service Developer Guide*.")
  @extension("x-ms-identifiers", [])
  requiresCompatibilities?: string[];

  @doc("The operating system that your tasks definitions run on. A platform family is specified only for tasks using the Fargate launch type.  When you specify a task definition in a service, this value must match the ``runtimePlatform`` value of the service. Information about the platform for the Amazon ECS service or task. For more information about ``RuntimePlatform``, see [RuntimePlatform](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#runtime-platform) in the *Amazon Elastic Container Service Developer Guide*.")
  runtimePlatform?: RuntimePlatform;

  @doc("The metadata that you apply to the task definition to help you categorize and organize them. Each tag consists of a key and an optional value. You define both of them. The following basic restrictions apply to tags:  +  Maximum number of tags per resource - 50  +  For each resource, each tag key must be unique, and each tag key can have only one value.  +  Maximum key length - 128 Unicode characters in UTF-8  +  Maximum value length - 256 Unicode characters in UTF-8  +  If your tagging schema is used across multiple services and resources, remember that other services may have restrictions on allowed characters. Generally allowed characters are: letters, numbers, and spaces representable in UTF-8, and the following characters: + - = . _ : / @.  +  Tag keys and values are case-sensitive.  +  Do not use ``aws:``, ``AWS:``, or any upper or lowercase combination of such as a prefix for either keys or values as it is reserved for AWS use. You cannot edit or delete tag keys or values with this prefix. Tags with this prefix do not count against your tags per resource limit.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Property taskDefinitionArn")
  taskDefinitionArn?: string;

  @doc("The short name or full Amazon Resource Name (ARN) of the IAMlong role that grants containers in the task permission to call AWS APIs on your behalf. For more information, see [Amazon ECS Task Role](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html) in the *Amazon Elastic Container Service Developer Guide*. IAM roles for tasks on Windows require that the ``-EnableTaskIAMRole`` option is set when you launch the Amazon ECS-optimized Windows AMI. Your containers must also run some configuration code to use the feature. For more information, see [Windows IAM roles for tasks](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/windows_task_IAM_roles.html) in the *Amazon Elastic Container Service Developer Guide*.")
  taskRoleArn?: string;

  @doc("The list of data volume definitions for the task. For more information, see [Using data volumes in tasks](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_data_volumes.html) in the *Amazon Elastic Container Service Developer Guide*.  The ``host`` and ``sourcePath`` parameters aren't supported for tasks run on FARGATElong.")
  @extension("x-ms-identifiers", [])
  volumes?: Volume[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ContainerDefinition")
model ContainerDefinition {
  @doc("The command that's passed to the container. This parameter maps to ``Cmd`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``COMMAND`` parameter to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration). For more information, see [https://docs.docker.com/engine/reference/builder/#cmd](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/builder/#cmd). If there are multiple arguments, each argument is a separated string in the array.")
  @extension("x-ms-identifiers", [])
  command?: string[];

  @doc("The number of ``cpu`` units reserved for the container. This parameter maps to ``CpuShares`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--cpu-shares`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration). This field is optional for tasks using the Fargate launch type, and the only requirement is that the total amount of CPU reserved for all containers within a task be lower than the task-level ``cpu`` value.  You can determine the number of CPU units that are available per EC2 instance type by multiplying the vCPUs listed for that instance type on the [Amazon EC2 Instances](https://docs.aws.amazon.com/ec2/instance-types/) detail page by 1,024.  Linux containers share unallocated CPU units with other containers on the container instance with the same ratio as their allocated amount. For example, if you run a single-container task on a single-core instance type with 512 CPU units specified for that container, and that's the only task running on the container instance, that container could use the full 1,024 CPU unit share at any given time. However, if you launched another copy of the same task on that container instance, each task is guaranteed a minimum of 512 CPU units when needed. Moreover, each container could float to higher CPU usage if the other container was not using it. If both tasks were 100% active all of the time, they would be limited to 512 CPU units. On Linux container instances, the Docker daemon on the container instance uses the CPU value to calculate the relative CPU share ratios for running containers. For more information, see [CPU share constraint](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#cpu-share-constraint) in the Docker documentation. The minimum valid CPU share value that the Linux kernel allows is 2. However, the CPU parameter isn't required, and you can use CPU values below 2 in your container definitions. For CPU values below 2 (including null), the behavior varies based on your Amazon ECS container agent version:  +   *Agent versions less than or equal to 1.1.0:* Null and zero CPU values are passed to Docker as 0, which Docker then converts to 1,024 CPU shares. CPU values of 1 are passed to Docker as 1, which the Linux kernel converts to two CPU shares.  +   *Agent versions greater than or equal to 1.2.0:* Null, zero, and CPU values of 1 are passed to Docker as 2.   On Windows container instances, the CPU limit is enforced as an absolute limit, or a quota. Windows containers only have access to the specified amount of CPU that's described in the task definition. A null or zero CPU value is passed to Docker as ``0``, which Windows interprets as 1% of one CPU.")
  cpu?: int32;

  @doc("A list of ARNs in SSM or Amazon S3 to a credential spec (``CredSpec``) file that configures the container for Active Directory authentication. We recommend that you use this parameter instead of the ``dockerSecurityOptions``. The maximum number of ARNs is 1. There are two formats for each ARN.  + credentialspecdomainless:MyARN You use credentialspecdomainless:MyARN to provide a CredSpec with an additional section for a secret in . You provide the login credentials to the domain in the secret. Each task that runs on any container instance can join different domains. You can use this format without joining the container instance to a domain. + credentialspec:MyARN You use credentialspec:MyARN to provide a CredSpec for a single domain. You must join the container instance to the domain before you start any tasks that use this task definition.  In both formats, replace ``MyARN`` with the ARN in SSM or Amazon S3. If you provide a ``credentialspecdomainless:MyARN``, the ``credspec`` must provide a ARN in ASMlong for a secret containing the username, password, and the domain to connect to. For better security, the instance isn't joined to the domain for domainless authentication. Other applications on the instance can't use the domainless credentials. You can use this parameter to run tasks on the same instance, even it the tasks need to join different domains. For more information, see [Using gMSAs for Windows Containers](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/windows-gmsa.html) and [Using gMSAs for Linux Containers](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/linux-gmsa.html).")
  @extension("x-ms-identifiers", [])
  credentialSpecs?: string[];

  @doc("The dependencies defined for container startup and shutdown. A container can contain multiple dependencies. When a dependency is defined for container startup, for container shutdown it is reversed. For tasks using the EC2 launch type, the container instances require at least version 1.26.0 of the container agent to turn on container dependencies. However, we recommend using the latest container agent version. For information about checking your agent version and updating to the latest version, see [Updating the Amazon ECS Container Agent](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-update.html) in the *Amazon Elastic Container Service Developer Guide*. If you're using an Amazon ECS-optimized Linux AMI, your instance needs at least version 1.26.0-1 of the ``ecs-init`` package. If your container instances are launched from version ``20190301`` or later, then they contain the required versions of the container agent and ``ecs-init``. For more information, see [Amazon ECS-optimized Linux AMI](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html) in the *Amazon Elastic Container Service Developer Guide*. For tasks using the Fargate launch type, the task or service requires the following platforms:  +  Linux platform version ``1.3.0`` or later.  +  Windows platform version ``1.0.0`` or later.   If the task definition is used in a blue/green deployment that uses [AWS::CodeDeploy::DeploymentGroup BlueGreenDeploymentConfiguration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-codedeploy-deploymentgroup-bluegreendeploymentconfiguration.html), the ``dependsOn`` parameter is not supported. For more information see [Issue #680](https://docs.aws.amazon.com/https://github.com/aws-cloudformation/cloudformation-coverage-roadmap/issues/680) on the on the GitHub website.")
  @extension("x-ms-identifiers", [])
  dependsOn?: ContainerDependency[];

  @doc("When this parameter is true, networking is off within the container. This parameter maps to ``NetworkDisabled`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/).  This parameter is not supported for Windows containers.")
  disableNetworking?: boolean;

  @doc("A list of DNS search domains that are presented to the container. This parameter maps to ``DnsSearch`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--dns-search`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration).  This parameter is not supported for Windows containers.")
  @extension("x-ms-identifiers", [])
  dnsSearchDomains?: string[];

  @doc("A list of DNS servers that are presented to the container. This parameter maps to ``Dns`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--dns`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration).  This parameter is not supported for Windows containers.")
  @extension("x-ms-identifiers", [])
  dnsServers?: string[];

  @doc("A key/value map of labels to add to the container. This parameter maps to ``Labels`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--label`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration). This parameter requires version 1.18 of the Docker Remote API or greater on your container instance. To check the Docker Remote API version on your container instance, log in to your container instance and run the following command: ``sudo docker version --format '{{.Server.APIVersion}}'``")
  dockerLabels?: unknown;

  @doc("A list of strings to provide custom configuration for multiple security systems. For more information about valid values, see [Docker Run Security Configuration](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration). This field isn't valid for containers in tasks using the Fargate launch type. For Linux tasks on EC2, this parameter can be used to reference custom labels for SELinux and AppArmor multi-level security systems. For any tasks on EC2, this parameter can be used to reference a credential spec file that configures a container for Active Directory authentication. For more information, see [Using gMSAs for Windows Containers](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/windows-gmsa.html) and [Using gMSAs for Linux Containers](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/linux-gmsa.html) in the *Amazon Elastic Container Service Developer Guide*. This parameter maps to ``SecurityOpt`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--security-opt`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration).  The Amazon ECS container agent running on a container instance must register with the ``ECS_SELINUX_CAPABLE=true`` or ``ECS_APPARMOR_CAPABLE=true`` environment variables before containers placed on that instance can use these security options. For more information, see [Amazon ECS Container Agent Configuration](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-config.html) in the *Amazon Elastic Container Service Developer Guide*.  For more information about valid values, see [Docker Run Security Configuration](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration).  Valid values: 'no-new-privileges' | 'apparmor:PROFILE' | 'label:value' | 'credentialspec:CredentialSpecFilePath'")
  @extension("x-ms-identifiers", [])
  dockerSecurityOptions?: string[];

  @doc("Early versions of the Amazon ECS container agent don't properly handle ``entryPoint`` parameters. If you have problems using ``entryPoint``, update your container agent or enter your commands and arguments as ``command`` array items instead.  The entry point that's passed to the container. This parameter maps to ``Entrypoint`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--entrypoint`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration). For more information, see [https://docs.docker.com/engine/reference/builder/#entrypoint](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/builder/#entrypoint).")
  @extension("x-ms-identifiers", [])
  entryPoint?: string[];

  @doc("The environment variables to pass to a container. This parameter maps to ``Env`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--env`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration).  We don't recommend that you use plaintext environment variables for sensitive information, such as credential data.")
  @extension("x-ms-identifiers", [])
  environment?: KeyValuePair[];

  @doc("A list of files containing the environment variables to pass to a container. This parameter maps to the ``--env-file`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration). You can specify up to ten environment files. The file must have a ``.env`` file extension. Each line in an environment file contains an environment variable in ``VARIABLE=VALUE`` format. Lines beginning with ``#`` are treated as comments and are ignored. For more information about the environment variable file syntax, see [Declare default environment variables in file](https://docs.aws.amazon.com/https://docs.docker.com/compose/env-file/). If there are environment variables specified using the ``environment`` parameter in a container definition, they take precedence over the variables contained within an environment file. If multiple environment files are specified that contain the same variable, they're processed from the top down. We recommend that you use unique variable names. For more information, see [Specifying Environment Variables](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/taskdef-envfiles.html) in the *Amazon Elastic Container Service Developer Guide*.")
  @extension("x-ms-identifiers", [])
  environmentFiles?: EnvironmentFile[];

  @doc("If the ``essential`` parameter of a container is marked as ``true``, and that container fails or stops for any reason, all other containers that are part of the task are stopped. If the ``essential`` parameter of a container is marked as ``false``, its failure doesn't affect the rest of the containers in a task. If this parameter is omitted, a container is assumed to be essential. All tasks must have at least one essential container. If you have an application that's composed of multiple containers, group containers that are used for a common purpose into components, and separate the different components into multiple task definitions. For more information, see [Application Architecture](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/application_architecture.html) in the *Amazon Elastic Container Service Developer Guide*.")
  essential?: boolean;

  @doc("A list of hostnames and IP address mappings to append to the ``/etc/hosts`` file on the container. This parameter maps to ``ExtraHosts`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--add-host`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration).  This parameter isn't supported for Windows containers or tasks that use the ``awsvpc`` network mode.")
  @extension("x-ms-identifiers", [])
  extraHosts?: HostEntry[];

  @doc("The FireLens configuration for the container. This is used to specify and configure a log router for container logs. For more information, see [Custom Log Routing](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_firelens.html) in the *Amazon Elastic Container Service Developer Guide*. The FireLens configuration for the container. This is used to specify and configure a log router for container logs. For more information, see [Custom log routing](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_firelens.html) in the *Amazon Elastic Container Service Developer Guide*.")
  firelensConfiguration?: FirelensConfiguration;

  @doc("The container health check command and associated configuration parameters for the container. This parameter maps to ``HealthCheck`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``HEALTHCHECK`` parameter of [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration). The ``HealthCheck`` property specifies an object representing a container health check. Health check parameters that are specified in a container definition override any Docker health checks that exist in the container image (such as those specified in a parent image or from the image's Dockerfile). This configuration maps to the ``HEALTHCHECK`` parameter of [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/).  The Amazon ECS container agent only monitors and reports on the health checks specified in the task definition. Amazon ECS does not monitor Docker health checks that are embedded in a container image and not specified in the container definition. Health check parameters that are specified in a container definition override any Docker health checks that exist in the container image.  If a task is run manually, and not as part of a service, the task will continue its lifecycle regardless of its health status. For tasks that are part of a service, if the task reports as unhealthy then the task will be stopped and the service scheduler will replace it. The following are notes about container health check support:  +  Container health checks require version 1.17.0 or greater of the Amazon ECS container agent. For more information, see [Updating the Amazon ECS Container Agent](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-update.html).  +  Container health checks are supported for Fargate tasks if you are using platform version 1.1.0 or greater. For more information, see [Platform Versions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/platform_versions.html).  +  Container health checks are not supported for tasks that are part of a service that is configured to use a Classic Load Balancer.")
  healthCheck?: HealthCheck;

  @doc("The hostname to use for your container. This parameter maps to ``Hostname`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--hostname`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration).  The ``hostname`` parameter is not supported if you're using the ``awsvpc`` network mode.")
  hostname?: string;

  @doc("The image used to start a container. This string is passed directly to the Docker daemon. By default, images in the Docker Hub registry are available. Other repositories are specified with either ``repository-url/image:tag`` or ``repository-url/image@digest``. Up to 255 letters (uppercase and lowercase), numbers, hyphens, underscores, colons, periods, forward slashes, and number signs are allowed. This parameter maps to ``Image`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``IMAGE`` parameter of [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration).  +  When a new task starts, the Amazon ECS container agent pulls the latest version of the specified image and tag for the container to use. However, subsequent updates to a repository image aren't propagated to already running tasks.  +  Images in Amazon ECR repositories can be specified by either using the full ``registry/repository:tag`` or ``registry/repository@digest``. For example, ``012345678910.dkr.ecr.<region-name>.amazonaws.com/<repository-name>:latest`` or ``012345678910.dkr.ecr.<region-name>.amazonaws.com/<repository-name>@sha256:94afd1f2e64d908bc90dbca0035a5b567EXAMPLE``.   +  Images in official repositories on Docker Hub use a single name (for example, ``ubuntu`` or ``mongo``).  +  Images in other repositories on Docker Hub are qualified with an organization name (for example, ``amazon/amazon-ecs-agent``).  +  Images in other online repositories are qualified further by a domain name (for example, ``quay.io/assemblyline/ubuntu``).")
  image?: string;

  @doc("When this parameter is ``true``, you can deploy containerized applications that require ``stdin`` or a ``tty`` to be allocated. This parameter maps to ``OpenStdin`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--interactive`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration).")
  interactive?: boolean;

  @doc("The ``links`` parameter allows containers to communicate with each other without the need for port mappings. This parameter is only supported if the network mode of a task definition is ``bridge``. The ``name:internalName`` construct is analogous to ``name:alias`` in Docker links. Up to 255 letters (uppercase and lowercase), numbers, underscores, and hyphens are allowed. For more information about linking Docker containers, go to [Legacy container links](https://docs.aws.amazon.com/https://docs.docker.com/network/links/) in the Docker documentation. This parameter maps to ``Links`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--link`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration).  This parameter is not supported for Windows containers.   Containers that are collocated on a single container instance may be able to communicate with each other without requiring links or host port mappings. Network isolation is achieved on the container instance using security groups and VPC settings.")
  @extension("x-ms-identifiers", [])
  links?: string[];

  @doc("Linux-specific modifications that are applied to the container, such as Linux kernel capabilities. For more information see [KernelCapabilities](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_KernelCapabilities.html).  This parameter is not supported for Windows containers. The Linux-specific options that are applied to the container, such as Linux [KernelCapabilities](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_KernelCapabilities.html).")
  linuxParameters?: LinuxParameters;

  @doc("The log configuration specification for the container. This parameter maps to ``LogConfig`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--log-driver`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/). By default, containers use the same logging driver that the Docker daemon uses. However, the container may use a different logging driver than the Docker daemon by specifying a log driver with this parameter in the container definition. To use a different logging driver for a container, the log system must be configured properly on the container instance (or on a different log server for remote logging options). For more information on the options for different supported log drivers, see [Configure logging drivers](https://docs.aws.amazon.com/https://docs.docker.com/engine/admin/logging/overview/) in the Docker documentation.  Amazon ECS currently supports a subset of the logging drivers available to the Docker daemon (shown in the [LogConfiguration](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html) data type). Additional log drivers may be available in future releases of the Amazon ECS container agent.  This parameter requires version 1.18 of the Docker Remote API or greater on your container instance. To check the Docker Remote API version on your container instance, log in to your container instance and run the following command: ``sudo docker version --format '{{.Server.APIVersion}}'``   The Amazon ECS container agent running on a container instance must register the logging drivers available on that instance with the ``ECS_AVAILABLE_LOGGING_DRIVERS`` environment variable before containers placed on that instance can use these log configuration options. For more information, see [Amazon ECS Container Agent Configuration](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-config.html) in the *Amazon Elastic Container Service Developer Guide*. The ``LogConfiguration`` property specifies log configuration options to send to a custom log driver for the container.")
  logConfiguration?: LogConfiguration;

  @doc("The amount (in MiB) of memory to present to the container. If your container attempts to exceed the memory specified here, the container is killed. The total amount of memory reserved for all containers within a task must be lower than the task ``memory`` value, if one is specified. This parameter maps to ``Memory`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--memory`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration). If using the Fargate launch type, this parameter is optional. If using the EC2 launch type, you must specify either a task-level memory value or a container-level memory value. If you specify both a container-level ``memory`` and ``memoryReservation`` value, ``memory`` must be greater than ``memoryReservation``. If you specify ``memoryReservation``, then that value is subtracted from the available memory resources for the container instance where the container is placed. Otherwise, the value of ``memory`` is used. The Docker 20.10.0 or later daemon reserves a minimum of 6 MiB of memory for a container, so you should not specify fewer than 6 MiB of memory for your containers. The Docker 19.03.13-ce or earlier daemon reserves a minimum of 4 MiB of memory for a container, so you should not specify fewer than 4 MiB of memory for your containers.")
  memory?: int32;

  @doc("The soft limit (in MiB) of memory to reserve for the container. When system memory is under heavy contention, Docker attempts to keep the container memory to this soft limit. However, your container can consume more memory when it needs to, up to either the hard limit specified with the ``memory`` parameter (if applicable), or all of the available memory on the container instance, whichever comes first. This parameter maps to ``MemoryReservation`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--memory-reservation`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration). If a task-level memory value is not specified, you must specify a non-zero integer for one or both of ``memory`` or ``memoryReservation`` in a container definition. If you specify both, ``memory`` must be greater than ``memoryReservation``. If you specify ``memoryReservation``, then that value is subtracted from the available memory resources for the container instance where the container is placed. Otherwise, the value of ``memory`` is used. For example, if your container normally uses 128 MiB of memory, but occasionally bursts to 256 MiB of memory for short periods of time, you can set a ``memoryReservation`` of 128 MiB, and a ``memory`` hard limit of 300 MiB. This configuration would allow the container to only reserve 128 MiB of memory from the remaining resources on the container instance, but also allow the container to consume more memory resources when needed. The Docker 20.10.0 or later daemon reserves a minimum of 6 MiB of memory for a container. So, don't specify less than 6 MiB of memory for your containers.  The Docker 19.03.13-ce or earlier daemon reserves a minimum of 4 MiB of memory for a container. So, don't specify less than 4 MiB of memory for your containers.")
  memoryReservation?: int32;

  @doc("The mount points for data volumes in your container. This parameter maps to ``Volumes`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--volume`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration). Windows containers can mount whole directories on the same drive as ``$env:ProgramData``. Windows containers can't mount directories on a different drive, and mount point can't be across drives.")
  @extension("x-ms-identifiers", [])
  mountPoints?: MountPoint[];

  @doc("The name of a container. If you're linking multiple containers together in a task definition, the ``name`` of one container can be entered in the ``links`` of another container to connect the containers. Up to 255 letters (uppercase and lowercase), numbers, underscores, and hyphens are allowed. This parameter maps to ``name`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--name`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration).")
  name?: string;

  @doc("The list of port mappings for the container. Port mappings allow containers to access ports on the host container instance to send or receive traffic. For task definitions that use the ``awsvpc`` network mode, you should only specify the ``containerPort``. The ``hostPort`` can be left blank or it must be the same value as the ``containerPort``. Port mappings on Windows use the ``NetNAT`` gateway address rather than ``localhost``. There is no loopback for port mappings on Windows, so you cannot access a container's mapped port from the host itself.  This parameter maps to ``PortBindings`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--publish`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/). If the network mode of a task definition is set to ``none``, then you can't specify port mappings. If the network mode of a task definition is set to ``host``, then host ports must either be undefined or they must match the container port in the port mapping.  After a task reaches the ``RUNNING`` status, manual and automatic host and container port assignments are visible in the *Network Bindings* section of a container description for a selected task in the Amazon ECS console. The assignments are also visible in the ``networkBindings`` section [DescribeTasks](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_DescribeTasks.html) responses.")
  @extension("x-ms-identifiers", [])
  portMappings?: PortMapping[];

  @doc("When this parameter is true, the container is given elevated privileges on the host container instance (similar to the ``root`` user). This parameter maps to ``Privileged`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--privileged`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration).  This parameter is not supported for Windows containers or tasks run on FARGATElong.")
  privileged?: boolean;

  @doc("When this parameter is ``true``, a TTY is allocated. This parameter maps to ``Tty`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--tty`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration).")
  pseudoTerminal?: boolean;

  @doc("When this parameter is true, the container is given read-only access to its root file system. This parameter maps to ``ReadonlyRootfs`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--read-only`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration).  This parameter is not supported for Windows containers.")
  readonlyRootFilesystem?: boolean;

  @doc("The private repository authentication credentials to use. The repository credentials for private registry authentication.")
  repositoryCredentials?: RepositoryCredentials;

  @doc("The type and amount of a resource to assign to a container. The only supported resource is a GPU.")
  @extension("x-ms-identifiers", [])
  resourceRequirements?: ResourceRequirement[];

  @doc("The secrets to pass to the container. For more information, see [Specifying Sensitive Data](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/specifying-sensitive-data.html) in the *Amazon Elastic Container Service Developer Guide*.")
  @extension("x-ms-identifiers", [])
  secrets?: Secret[];

  @doc("Time duration (in seconds) to wait before giving up on resolving dependencies for a container. For example, you specify two containers in a task definition with containerA having a dependency on containerB reaching a ``COMPLETE``, ``SUCCESS``, or ``HEALTHY`` status. If a ``startTimeout`` value is specified for containerB and it doesn't reach the desired status within that time then containerA gives up and not start. This results in the task transitioning to a ``STOPPED`` state.  When the ``ECS_CONTAINER_START_TIMEOUT`` container agent configuration variable is used, it's enforced independently from this start timeout value.  For tasks using the Fargate launch type, the task or service requires the following platforms:  +  Linux platform version ``1.3.0`` or later.  +  Windows platform version ``1.0.0`` or later.   For tasks using the EC2 launch type, your container instances require at least version ``1.26.0`` of the container agent to use a container start timeout value. However, we recommend using the latest container agent version. For information about checking your agent version and updating to the latest version, see [Updating the Amazon ECS Container Agent](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-update.html) in the *Amazon Elastic Container Service Developer Guide*. If you're using an Amazon ECS-optimized Linux AMI, your instance needs at least version ``1.26.0-1`` of the ``ecs-init`` package. If your container instances are launched from version ``20190301`` or later, then they contain the required versions of the container agent and ``ecs-init``. For more information, see [Amazon ECS-optimized Linux AMI](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html) in the *Amazon Elastic Container Service Developer Guide*. The valid values are 2-120 seconds.")
  startTimeout?: int32;

  @doc("Time duration (in seconds) to wait before the container is forcefully killed if it doesn't exit normally on its own. For tasks using the Fargate launch type, the task or service requires the following platforms:  +  Linux platform version ``1.3.0`` or later.  +  Windows platform version ``1.0.0`` or later.   The max stop timeout value is 120 seconds and if the parameter is not specified, the default value of 30 seconds is used. For tasks that use the EC2 launch type, if the ``stopTimeout`` parameter isn't specified, the value set for the Amazon ECS container agent configuration variable ``ECS_CONTAINER_STOP_TIMEOUT`` is used. If neither the ``stopTimeout`` parameter or the ``ECS_CONTAINER_STOP_TIMEOUT`` agent configuration variable are set, then the default values of 30 seconds for Linux containers and 30 seconds on Windows containers are used. Your container instances require at least version 1.26.0 of the container agent to use a container stop timeout value. However, we recommend using the latest container agent version. For information about checking your agent version and updating to the latest version, see [Updating the Amazon ECS Container Agent](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-update.html) in the *Amazon Elastic Container Service Developer Guide*. If you're using an Amazon ECS-optimized Linux AMI, your instance needs at least version 1.26.0-1 of the ``ecs-init`` package. If your container instances are launched from version ``20190301`` or later, then they contain the required versions of the container agent and ``ecs-init``. For more information, see [Amazon ECS-optimized Linux AMI](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html) in the *Amazon Elastic Container Service Developer Guide*. The valid values are 2-120 seconds.")
  stopTimeout?: int32;

  @doc("A list of namespaced kernel parameters to set in the container. This parameter maps to ``Sysctls`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--sysctl`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration). For example, you can configure ``net.ipv4.tcp_keepalive_time`` setting to maintain longer lived connections.")
  @extension("x-ms-identifiers", [])
  systemControls?: SystemControl[];

  @doc("A list of ``ulimits`` to set in the container. This parameter maps to ``Ulimits`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--ulimit`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/). Valid naming values are displayed in the [Ulimit](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_Ulimit.html) data type. This parameter requires version 1.18 of the Docker Remote API or greater on your container instance. To check the Docker Remote API version on your container instance, log in to your container instance and run the following command: ``sudo docker version --format '{{.Server.APIVersion}}'``   This parameter is not supported for Windows containers.")
  @extension("x-ms-identifiers", [])
  ulimits?: Ulimit[];

  @doc("The user to use inside the container. This parameter maps to ``User`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--user`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration).  When running tasks using the ``host`` network mode, don't run containers using the root user (UID 0). We recommend using a non-root user for better security.  You can specify the ``user`` using the following formats. If specifying a UID or GID, you must specify it as a positive integer.  +   ``user``   +   ``user:group``   +   ``uid``   +   ``uid:gid``   +   ``user:gid``   +   ``uid:group``     This parameter is not supported for Windows containers.")
  user?: string;

  @doc("Data volumes to mount from another container. This parameter maps to ``VolumesFrom`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--volumes-from`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration).")
  @extension("x-ms-identifiers", [])
  volumesFrom?: VolumeFrom[];

  @doc("The working directory to run commands inside the container in. This parameter maps to ``WorkingDir`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--workdir`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration).")
  workingDirectory?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EphemeralStorage")
model EphemeralStorage {
  @doc("The total amount, in GiB, of ephemeral storage to set for the task. The minimum supported value is ``20`` GiB and the maximum supported value is ``200`` GiB.")
  sizeInGiB?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InferenceAccelerator")
model InferenceAccelerator {
  @doc("The Elastic Inference accelerator device name. The ``deviceName`` must also be referenced in a container definition as a [ResourceRequirement](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ResourceRequirement.html).")
  deviceName?: string;

  @doc("The Elastic Inference accelerator type to use.")
  deviceType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TaskDefinitionPlacementConstraint")
model TaskDefinitionPlacementConstraint {
  @doc("A cluster query language expression to apply to the constraint. For more information, see [Cluster query language](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cluster-query-language.html) in the *Amazon Elastic Container Service Developer Guide*.")
  expression?: string;

  @doc("The type of constraint. The ``MemberOf`` constraint restricts selection to be from a group of valid candidates.")
  type?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProxyConfiguration")
model ProxyConfiguration {
  @doc("The name of the container that will serve as the App Mesh proxy.")
  containerName?: string;

  @doc("The set of network configuration parameters to provide the Container Network Interface (CNI) plugin, specified as key-value pairs.  +   ``IgnoredUID`` - (Required) The user ID (UID) of the proxy container as defined by the ``user`` parameter in a container definition. This is used to ensure the proxy ignores its own traffic. If ``IgnoredGID`` is specified, this field can be empty.  +   ``IgnoredGID`` - (Required) The group ID (GID) of the proxy container as defined by the ``user`` parameter in a container definition. This is used to ensure the proxy ignores its own traffic. If ``IgnoredUID`` is specified, this field can be empty.  +   ``AppPorts`` - (Required) The list of ports that the application uses. Network traffic to these ports is forwarded to the ``ProxyIngressPort`` and ``ProxyEgressPort``.  +   ``ProxyIngressPort`` - (Required) Specifies the port that incoming traffic to the ``AppPorts`` is directed to.  +   ``ProxyEgressPort`` - (Required) Specifies the port that outgoing traffic from the ``AppPorts`` is directed to.  +   ``EgressIgnoredPorts`` - (Required) The egress traffic going to the specified ports is ignored and not redirected to the ``ProxyEgressPort``. It can be an empty list.  +   ``EgressIgnoredIPs`` - (Required) The egress traffic going to the specified IP addresses is ignored and not redirected to the ``ProxyEgressPort``. It can be an empty list.")
  @extension("x-ms-identifiers", [])
  proxyConfigurationProperties?: KeyValuePair[];

  @doc("The proxy type. The only supported value is ``APPMESH``.")
  type?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RuntimePlatform")
model RuntimePlatform {
  @doc("The CPU architecture. You can run your Linux tasks on an ARM-based platform by setting the value to ``ARM64``. This option is available for tasks that run on Linux Amazon EC2 instance or Linux containers on Fargate.")
  cpuArchitecture?: string;

  @doc("The operating system.")
  operatingSystemFamily?: string;
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
@doc("Definition of Volume")
model Volume {
  @doc("Indicates whether the volume should be configured at launch time. This is used to create Amazon EBS volumes for standalone tasks or tasks created as part of a service. Each task definition revision may only have one volume configured at launch in the volume configuration. To configure a volume at launch time, use this task definition revision and specify a ``volumeConfigurations`` object when calling the ``CreateService``, ``UpdateService``, ``RunTask`` or ``StartTask`` APIs.")
  configuredAtLaunch?: boolean;

  @doc("This parameter is specified when you use Docker volumes. Windows containers only support the use of the ``local`` driver. To use bind mounts, specify the ``host`` parameter instead.  Docker volumes aren't supported by tasks run on FARGATElong. The ``DockerVolumeConfiguration`` property specifies a Docker volume configuration and is used when you use Docker volumes. Docker volumes are only supported when you are using the EC2 launch type. Windows containers only support the use of the ``local`` driver. To use bind mounts, specify a ``host`` instead.")
  dockerVolumeConfiguration?: DockerVolumeConfiguration;

  @doc("This parameter is specified when you use an Amazon Elastic File System file system for task storage. This parameter is specified when you're using an Amazon Elastic File System file system for task storage. For more information, see [Amazon EFS volumes](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/efs-volumes.html) in the *Amazon Elastic Container Service Developer Guide*.")
  efsVolumeConfiguration?: EFSVolumeConfiguration;

  @doc("This parameter is specified when you use Amazon FSx for Windows File Server file system for task storage. This parameter is specified when you're using [Amazon FSx for Windows File Server](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/what-is.html) file system for task storage. For more information and the input format, see [Amazon FSx for Windows File Server volumes](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/wfsx-volumes.html) in the *Amazon Elastic Container Service Developer Guide*.")
  fSxWindowsFileServerVolumeConfiguration?: FSxWindowsFileServerVolumeConfiguration;

  @doc("This parameter is specified when you use bind mount host volumes. The contents of the ``host`` parameter determine whether your bind mount host volume persists on the host container instance and where it's stored. If the ``host`` parameter is empty, then the Docker daemon assigns a host path for your data volume. However, the data isn't guaranteed to persist after the containers that are associated with it stop running. Windows containers can mount whole directories on the same drive as ``$env:ProgramData``. Windows containers can't mount directories on a different drive, and mount point can't be across drives. For example, you can mount ``C:\\my\\path:C:\\my\\path`` and ``D:\\:D:\\``, but not ``D:\\my\\path:C:\\my\\path`` or ``D:\\:C:\\my\\path``. The ``HostVolumeProperties`` property specifies details on a container instance bind mount host volume.")
  host?: HostVolumeProperties;

  @doc("The name of the volume. Up to 255 letters (uppercase and lowercase), numbers, underscores, and hyphens are allowed. When using a volume configured at launch, the ``name`` is required and must also be specified as the volume name in the ``ServiceVolumeConfiguration`` or ``TaskVolumeConfiguration`` parameter when creating your service or standalone task. For all other types of volumes, this name is referenced in the ``sourceVolume`` parameter of the ``mountPoints`` object in the container definition. When a volume is using the ``efsVolumeConfiguration``, the name is required.")
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ContainerDependency")
model ContainerDependency {
  @doc("The dependency condition of the container. The following are the available conditions and their behavior:  +   ``START`` - This condition emulates the behavior of links and volumes today. It validates that a dependent container is started before permitting other containers to start.  +   ``COMPLETE`` - This condition validates that a dependent container runs to completion (exits) before permitting other containers to start. This can be useful for nonessential containers that run a script and then exit. This condition can't be set on an essential container.  +   ``SUCCESS`` - This condition is the same as ``COMPLETE``, but it also requires that the container exits with a ``zero`` status. This condition can't be set on an essential container.  +   ``HEALTHY`` - This condition validates that the dependent container passes its Docker health check before permitting other containers to start. This requires that the dependent container has health checks configured. This condition is confirmed only at task startup.")
  condition?: string;

  @doc("The name of a container.")
  containerName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of KeyValuePair")
model KeyValuePair {
  @doc("The name of the key-value pair. For environment variables, this is the name of the environment variable.")
  name?: string;

  @doc("The value of the key-value pair. For environment variables, this is the value of the environment variable.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EnvironmentFile")
model EnvironmentFile {
  @doc("The file type to use. Environment files are objects in Amazon S3. The only supported value is ``s3``.")
  type?: string;

  @doc("The Amazon Resource Name (ARN) of the Amazon S3 object containing the environment variable file.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of HostEntry")
model HostEntry {
  @doc("The hostname to use in the ``/etc/hosts`` entry.")
  hostname?: string;

  @doc("The IP address to use in the ``/etc/hosts`` entry.")
  ipAddress?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FirelensConfiguration")
model FirelensConfiguration {
  @doc("The options to use when configuring the log router. This field is optional and can be used to add additional metadata, such as the task, task definition, cluster, and container instance details to the log event.  If specified, valid option keys are:  +   ``enable-ecs-log-metadata``, which can be ``true`` or ``false``   +   ``config-file-type``, which can be ``s3`` or ``file``   +   ``config-file-value``, which is either an S3 ARN or a file path")
  options?: unknown;

  @doc("The log router to use. The valid values are ``fluentd`` or ``fluentbit``.")
  type?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of HealthCheck")
model HealthCheck {
  @doc("A string array representing the command that the container runs to determine if it is healthy. The string array must start with ``CMD`` to run the command arguments directly, or ``CMD-SHELL`` to run the command with the container's default shell.   When you use the AWS Management Console JSON panel, the CLIlong, or the APIs, enclose the list of commands in double quotes and brackets.  ``[ 'CMD-SHELL', 'curl -f http://localhost/ || exit 1' ]``  You don't include the double quotes and brackets when you use the AWS Management Console.  ``CMD-SHELL, curl -f http://localhost/ || exit 1``  An exit code of 0 indicates success, and non-zero exit code indicates failure. For more information, see ``HealthCheck`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/).")
  @extension("x-ms-identifiers", [])
  command?: string[];

  @doc("The time period in seconds between each health check execution. You may specify between 5 and 300 seconds. The default value is 30 seconds.")
  interval?: int32;

  @doc("The number of times to retry a failed health check before the container is considered unhealthy. You may specify between 1 and 10 retries. The default value is 3.")
  retries?: int32;

  @doc("The optional grace period to provide containers time to bootstrap before failed health checks count towards the maximum number of retries. You can specify between 0 and 300 seconds. By default, the ``startPeriod`` is off.  If a health check succeeds within the ``startPeriod``, then the container is considered healthy and any subsequent failures count toward the maximum number of retries.")
  startPeriod?: int32;

  @doc("The time period in seconds to wait for a health check to succeed before it is considered a failure. You may specify between 2 and 60 seconds. The default value is 5.")
  timeout?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LinuxParameters")
model LinuxParameters {
  @doc("The Linux capabilities for the container that are added to or dropped from the default configuration provided by Docker.  For tasks that use the Fargate launch type, ``capabilities`` is supported for all platform versions but the ``add`` parameter is only supported if using platform version 1.4.0 or later. The Linux capabilities to add or remove from the default Docker configuration for a container defined in the task definition. For more information about the default capabilities and the non-default available capabilities, see [Runtime privilege and Linux capabilities](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities) in the *Docker run reference*. For more detailed information about these Linux capabilities, see the [capabilities(7)](https://docs.aws.amazon.com/http://man7.org/linux/man-pages/man7/capabilities.7.html) Linux manual page.")
  capabilities?: KernelCapabilities;

  @doc("Any host devices to expose to the container. This parameter maps to ``Devices`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--device`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration).  If you're using tasks that use the Fargate launch type, the ``devices`` parameter isn't supported.")
  @extension("x-ms-identifiers", [])
  devices?: Device[];

  @doc("Run an ``init`` process inside the container that forwards signals and reaps processes. This parameter maps to the ``--init`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration). This parameter requires version 1.25 of the Docker Remote API or greater on your container instance. To check the Docker Remote API version on your container instance, log in to your container instance and run the following command: ``sudo docker version --format '{{.Server.APIVersion}}'``")
  initProcessEnabled?: boolean;

  @doc("The total amount of swap memory (in MiB) a container can use. This parameter will be translated to the ``--memory-swap`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration) where the value would be the sum of the container memory plus the ``maxSwap`` value. If a ``maxSwap`` value of ``0`` is specified, the container will not use swap. Accepted values are ``0`` or any positive integer. If the ``maxSwap`` parameter is omitted, the container will use the swap configuration for the container instance it is running on. A ``maxSwap`` value must be set for the ``swappiness`` parameter to be used.  If you're using tasks that use the Fargate launch type, the ``maxSwap`` parameter isn't supported. If you're using tasks on Amazon Linux 2023 the ``swappiness`` parameter isn't supported.")
  maxSwap?: int32;

  @doc("The value for the size (in MiB) of the ``/dev/shm`` volume. This parameter maps to the ``--shm-size`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration).  If you are using tasks that use the Fargate launch type, the ``sharedMemorySize`` parameter is not supported.")
  sharedMemorySize?: int32;

  @doc("This allows you to tune a container's memory swappiness behavior. A ``swappiness`` value of ``0`` will cause swapping to not happen unless absolutely necessary. A ``swappiness`` value of ``100`` will cause pages to be swapped very aggressively. Accepted values are whole numbers between ``0`` and ``100``. If the ``swappiness`` parameter is not specified, a default value of ``60`` is used. If a value is not specified for ``maxSwap`` then this parameter is ignored. This parameter maps to the ``--memory-swappiness`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration).  If you're using tasks that use the Fargate launch type, the ``swappiness`` parameter isn't supported. If you're using tasks on Amazon Linux 2023 the ``swappiness`` parameter isn't supported.")
  swappiness?: int32;

  @doc("The container path, mount options, and size (in MiB) of the tmpfs mount. This parameter maps to the ``--tmpfs`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration).  If you're using tasks that use the Fargate launch type, the ``tmpfs`` parameter isn't supported.")
  @extension("x-ms-identifiers", [])
  tmpfs?: Tmpfs[];
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
@doc("Definition of MountPoint")
model MountPoint {
  @doc("The path on the container to mount the host volume at.")
  containerPath?: string;

  @doc("If this value is ``true``, the container has read-only access to the volume. If this value is ``false``, then the container can write to the volume. The default value is ``false``.")
  readOnly?: boolean;

  @doc("The name of the volume to mount. Must be a volume name referenced in the ``name`` parameter of task definition ``volume``.")
  sourceVolume?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PortMapping")
model PortMapping {
  @doc("The application protocol that's used for the port mapping. This parameter only applies to Service Connect. We recommend that you set this parameter to be consistent with the protocol that your application uses. If you set this parameter, Amazon ECS adds protocol-specific connection handling to the Service Connect proxy. If you set this parameter, Amazon ECS adds protocol-specific telemetry in the Amazon ECS console and CloudWatch. If you don't set a value for this parameter, then TCP is used. However, Amazon ECS doesn't add protocol-specific telemetry for TCP.  ``appProtocol`` is immutable in a Service Connect service. Updating this field requires a service deletion and redeployment. Tasks that run in a namespace can use short names to connect to services in the namespace. Tasks can connect to services across all of the clusters in the namespace. Tasks connect through a managed proxy container that collects logs and metrics for increased visibility. Only the tasks that Amazon ECS services create are supported with Service Connect. For more information, see [Service Connect](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-connect.html) in the *Amazon Elastic Container Service Developer Guide*.")
  appProtocol?: PortMappingAppProtocol;

  @doc("The port number on the container that's bound to the user-specified or automatically assigned host port. If you use containers in a task with the ``awsvpc`` or ``host`` network mode, specify the exposed ports using ``containerPort``. If you use containers in a task with the ``bridge`` network mode and you specify a container port and not a host port, your container automatically receives a host port in the ephemeral port range. For more information, see ``hostPort``. Port mappings that are automatically assigned in this way do not count toward the 100 reserved ports limit of a container instance.")
  containerPort?: int32;

  @doc("The port number range on the container that's bound to the dynamically mapped host port range.  The following rules apply when you specify a ``containerPortRange``:  +  You must use either the ``bridge`` network mode or the ``awsvpc`` network mode.  +  This parameter is available for both the EC2 and FARGATElong launch types.  +  This parameter is available for both the Linux and Windows operating systems.  +  The container instance must have at least version 1.67.0 of the container agent and at least version 1.67.0-1 of the ``ecs-init`` package   +  You can specify a maximum of 100 port ranges per container.  +  You do not specify a ``hostPortRange``. The value of the ``hostPortRange`` is set as follows:  +  For containers in a task with the ``awsvpc`` network mode, the ``hostPortRange`` is set to the same value as the ``containerPortRange``. This is a static mapping strategy.  +  For containers in a task with the ``bridge`` network mode, the Amazon ECS agent finds open host ports from the default ephemeral range and passes it to docker to bind them to the container ports.    +  The ``containerPortRange`` valid values are between 1 and 65535.  +  A port can only be included in one port mapping per container.  +  You cannot specify overlapping port ranges.  +  The first port in the range must be less than last port in the range.  +  Docker recommends that you turn off the docker-proxy in the Docker daemon config file when you have a large number of ports. For more information, see [Issue #11185](https://docs.aws.amazon.com/https://github.com/moby/moby/issues/11185) on the Github website. For information about how to turn off the docker-proxy in the Docker daemon config file, see [Docker daemon](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/bootstrap_container_instance.html#bootstrap_docker_daemon) in the *Amazon ECS Developer Guide*.   You can call [DescribeTasks](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_DescribeTasks.html) to view the ``hostPortRange`` which are the host ports that are bound to the container ports.")
  containerPortRange?: string;

  @doc("The port number on the container instance to reserve for your container. If you specify a ``containerPortRange``, leave this field empty and the value of the ``hostPort`` is set as follows:  +  For containers in a task with the ``awsvpc`` network mode, the ``hostPort`` is set to the same value as the ``containerPort``. This is a static mapping strategy.  +  For containers in a task with the ``bridge`` network mode, the Amazon ECS agent finds open ports on the host and automatically binds them to the container ports. This is a dynamic mapping strategy.   If you use containers in a task with the ``awsvpc`` or ``host`` network mode, the ``hostPort`` can either be left blank or set to the same value as the ``containerPort``. If you use containers in a task with the ``bridge`` network mode, you can specify a non-reserved host port for your container port mapping, or you can omit the ``hostPort`` (or set it to ``0``) while specifying a ``containerPort`` and your container automatically receives a port in the ephemeral port range for your container instance operating system and Docker version. The default ephemeral port range for Docker version 1.6.0 and later is listed on the instance under ``/proc/sys/net/ipv4/ip_local_port_range``. If this kernel parameter is unavailable, the default ephemeral port range from 49153 through 65535 (Linux) or 49152 through 65535 (Windows) is used. Do not attempt to specify a host port in the ephemeral port range as these are reserved for automatic assignment. In general, ports below 32768 are outside of the ephemeral port range. The default reserved ports are 22 for SSH, the Docker ports 2375 and 2376, and the Amazon ECS container agent ports 51678-51680. Any host port that was previously specified in a running task is also reserved while the task is running. That is, after a task stops, the host port is released. The current reserved ports are displayed in the ``remainingResources`` of [DescribeContainerInstances](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_DescribeContainerInstances.html) output. A container instance can have up to 100 reserved ports at a time. This number includes the default reserved ports. Automatically assigned ports aren't included in the 100 reserved ports quota.")
  hostPort?: int32;

  @doc("The name that's used for the port mapping. This parameter only applies to Service Connect. This parameter is the name that you use in the ``serviceConnectConfiguration`` of a service. The name can include up to 64 characters. The characters can include lowercase letters, numbers, underscores (_), and hyphens (-). The name can't start with a hyphen. For more information, see [Service Connect](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-connect.html) in the *Amazon Elastic Container Service Developer Guide*.")
  name?: string;

  @doc("The protocol used for the port mapping. Valid values are ``tcp`` and ``udp``. The default is ``tcp``. ``protocol`` is immutable in a Service Connect service. Updating this field requires a service deletion and redeployment.")
  protocol?: string;
}

@doc("PortMappingAppProtocol enum")
union PortMappingAppProtocol {
  @doc("PortMappingAppProtocol enum grpc")
  grpc: "grpc",

  @doc("PortMappingAppProtocol enum http")
  http: "http",

  @doc("PortMappingAppProtocol enum http2")
  http2: "http2",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RepositoryCredentials")
model RepositoryCredentials {
  @doc("The Amazon Resource Name (ARN) of the secret containing the private repository credentials.  When you use the Amazon ECS API, CLI, or AWS SDK, if the secret exists in the same Region as the task that you're launching then you can use either the full ARN or the name of the secret. When you use the AWS Management Console, you must specify the full ARN of the secret.")
  credentialsParameter?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ResourceRequirement")
model ResourceRequirement {
  @doc("The type of resource to assign to a container. The supported values are ``GPU`` or ``InferenceAccelerator``.")
  type?: string;

  @doc("The value for the specified resource type. If the ``GPU`` type is used, the value is the number of physical ``GPUs`` the Amazon ECS container agent reserves for the container. The number of GPUs that's reserved for all containers in a task can't exceed the number of available GPUs on the container instance that the task is launched on. If the ``InferenceAccelerator`` type is used, the ``value`` matches the ``deviceName`` for an [InferenceAccelerator](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_InferenceAccelerator.html) specified in a task definition.")
  value?: string;
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
@doc("Definition of SystemControl")
model SystemControl {
  @doc("The namespaced kernel parameter to set a ``value`` for.")
  `namespace`?: string;

  @doc("The namespaced kernel parameter to set a ``value`` for. Valid IPC namespace values: ``'kernel.msgmax' | 'kernel.msgmnb' | 'kernel.msgmni' | 'kernel.sem' | 'kernel.shmall' | 'kernel.shmmax' | 'kernel.shmmni' | 'kernel.shm_rmid_forced'``, and ``Sysctls`` that start with ``'fs.mqueue.*'``  Valid network namespace values: ``Sysctls`` that start with ``'net.*'``  All of these values are supported by Fargate.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Ulimit")
model Ulimit {
  @doc("The hard limit for the ``ulimit`` type.")
  hardLimit?: int32;

  @doc("The ``type`` of the ``ulimit``.")
  name?: string;

  @doc("The soft limit for the ``ulimit`` type.")
  softLimit?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VolumeFrom")
model VolumeFrom {
  @doc("If this value is ``true``, the container has read-only access to the volume. If this value is ``false``, then the container can write to the volume. The default value is ``false``.")
  readOnly?: boolean;

  @doc("The name of another container within the same task definition to mount volumes from.")
  sourceContainer?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DockerVolumeConfiguration")
model DockerVolumeConfiguration {
  @doc("If this value is ``true``, the Docker volume is created if it doesn't already exist.  This field is only used if the ``scope`` is ``shared``.")
  autoprovision?: boolean;

  @doc("The Docker volume driver to use. The driver value must match the driver name provided by Docker because it is used for task placement. If the driver was installed using the Docker plugin CLI, use ``docker plugin ls`` to retrieve the driver name from your container instance. If the driver was installed using another method, use Docker plugin discovery to retrieve the driver name. For more information, see [Docker plugin discovery](https://docs.aws.amazon.com/https://docs.docker.com/engine/extend/plugin_api/#plugin-discovery). This parameter maps to ``Driver`` in the [Create a volume](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/VolumeCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``xxdriver`` option to [docker volume create](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/commandline/volume_create/).")
  driver?: string;

  @doc("A map of Docker driver-specific options passed through. This parameter maps to ``DriverOpts`` in the [Create a volume](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/VolumeCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``xxopt`` option to [docker volume create](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/commandline/volume_create/).")
  driverOpts?: unknown;

  @doc("Custom metadata to add to your Docker volume. This parameter maps to ``Labels`` in the [Create a volume](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/VolumeCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``xxlabel`` option to [docker volume create](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/commandline/volume_create/).")
  labels?: unknown;

  @doc("The scope for the Docker volume that determines its lifecycle. Docker volumes that are scoped to a ``task`` are automatically provisioned when the task starts and destroyed when the task stops. Docker volumes that are scoped as ``shared`` persist after the task stops.")
  scope?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EFSVolumeConfiguration")
model EFSVolumeConfiguration {
  @doc("The authorization configuration details for the Amazon EFS file system. The authorization configuration details for the Amazon EFS file system.")
  authorizationConfig?: AuthorizationConfig;

  @doc("The Amazon EFS file system ID to use.")
  filesystemId?: string;

  @doc("The directory within the Amazon EFS file system to mount as the root directory inside the host. If this parameter is omitted, the root of the Amazon EFS volume will be used. Specifying ``/`` will have the same effect as omitting this parameter.  If an EFS access point is specified in the ``authorizationConfig``, the root directory parameter must either be omitted or set to ``/`` which will enforce the path set on the EFS access point.")
  rootDirectory?: string;

  @doc("Determines whether to use encryption for Amazon EFS data in transit between the Amazon ECS host and the Amazon EFS server. Transit encryption must be turned on if Amazon EFS IAM authorization is used. If this parameter is omitted, the default value of ``DISABLED`` is used. For more information, see [Encrypting data in transit](https://docs.aws.amazon.com/efs/latest/ug/encryption-in-transit.html) in the *Amazon Elastic File System User Guide*.")
  transitEncryption?: EFSVolumeConfigurationTransitEncryption;

  @doc("The port to use when sending encrypted data between the Amazon ECS host and the Amazon EFS server. If you do not specify a transit encryption port, it will use the port selection strategy that the Amazon EFS mount helper uses. For more information, see [EFS mount helper](https://docs.aws.amazon.com/efs/latest/ug/efs-mount-helper.html) in the *Amazon Elastic File System User Guide*.")
  transitEncryptionPort?: int32;
}

@doc("EFSVolumeConfigurationTransitEncryption enum")
union EFSVolumeConfigurationTransitEncryption {
  @doc("EFSVolumeConfigurationTransitEncryption enum DISABLED")
  DISABLED: "DISABLED",

  @doc("EFSVolumeConfigurationTransitEncryption enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FSxWindowsFileServerVolumeConfiguration")
model FSxWindowsFileServerVolumeConfiguration {
  @doc("The authorization configuration details for the Amazon FSx for Windows File Server file system.")
  authorizationConfig?: FSxAuthorizationConfig;

  @doc("The Amazon FSx for Windows File Server file system ID to use.")
  fileSystemId?: string;

  @doc("The directory within the Amazon FSx for Windows File Server file system to mount as the root directory inside the host.")
  rootDirectory?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of HostVolumeProperties")
model HostVolumeProperties {
  @doc("When the ``host`` parameter is used, specify a ``sourcePath`` to declare the path on the host container instance that's presented to the container. If this parameter is empty, then the Docker daemon has assigned a host path for you. If the ``host`` parameter contains a ``sourcePath`` file location, then the data volume persists at the specified location on the host container instance until you delete it manually. If the ``sourcePath`` value doesn't exist on the host container instance, the Docker daemon creates it. If the location does exist, the contents of the source path folder are exported. If you're using the Fargate launch type, the ``sourcePath`` parameter is not supported.")
  sourcePath?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of KernelCapabilities")
model KernelCapabilities {
  @doc("The Linux capabilities for the container that have been added to the default configuration provided by Docker. This parameter maps to ``CapAdd`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--cap-add`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration).  Tasks launched on FARGATElong only support adding the ``SYS_PTRACE`` kernel capability.  Valid values: ``'ALL' | 'AUDIT_CONTROL' | 'AUDIT_WRITE' | 'BLOCK_SUSPEND' | 'CHOWN' | 'DAC_OVERRIDE' | 'DAC_READ_SEARCH' | 'FOWNER' | 'FSETID' | 'IPC_LOCK' | 'IPC_OWNER' | 'KILL' | 'LEASE' | 'LINUX_IMMUTABLE' | 'MAC_ADMIN' | 'MAC_OVERRIDE' | 'MKNOD' | 'NET_ADMIN' | 'NET_BIND_SERVICE' | 'NET_BROADCAST' | 'NET_RAW' | 'SETFCAP' | 'SETGID' | 'SETPCAP' | 'SETUID' | 'SYS_ADMIN' | 'SYS_BOOT' | 'SYS_CHROOT' | 'SYS_MODULE' | 'SYS_NICE' | 'SYS_PACCT' | 'SYS_PTRACE' | 'SYS_RAWIO' | 'SYS_RESOURCE' | 'SYS_TIME' | 'SYS_TTY_CONFIG' | 'SYSLOG' | 'WAKE_ALARM'``")
  @extension("x-ms-identifiers", [])
  add?: string[];

  @doc("The Linux capabilities for the container that have been removed from the default configuration provided by Docker. This parameter maps to ``CapDrop`` in the [Create a container](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/#operation/ContainerCreate) section of the [Docker Remote API](https://docs.aws.amazon.com/https://docs.docker.com/engine/api/v1.35/) and the ``--cap-drop`` option to [docker run](https://docs.aws.amazon.com/https://docs.docker.com/engine/reference/run/#security-configuration). Valid values: ``'ALL' | 'AUDIT_CONTROL' | 'AUDIT_WRITE' | 'BLOCK_SUSPEND' | 'CHOWN' | 'DAC_OVERRIDE' | 'DAC_READ_SEARCH' | 'FOWNER' | 'FSETID' | 'IPC_LOCK' | 'IPC_OWNER' | 'KILL' | 'LEASE' | 'LINUX_IMMUTABLE' | 'MAC_ADMIN' | 'MAC_OVERRIDE' | 'MKNOD' | 'NET_ADMIN' | 'NET_BIND_SERVICE' | 'NET_BROADCAST' | 'NET_RAW' | 'SETFCAP' | 'SETGID' | 'SETPCAP' | 'SETUID' | 'SYS_ADMIN' | 'SYS_BOOT' | 'SYS_CHROOT' | 'SYS_MODULE' | 'SYS_NICE' | 'SYS_PACCT' | 'SYS_PTRACE' | 'SYS_RAWIO' | 'SYS_RESOURCE' | 'SYS_TIME' | 'SYS_TTY_CONFIG' | 'SYSLOG' | 'WAKE_ALARM'``")
  @extension("x-ms-identifiers", [])
  drop?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Device")
model Device {
  @doc("The path inside the container at which to expose the host device.")
  containerPath?: string;

  @doc("The path for the device on the host container instance.")
  hostPath?: string;

  @doc("The explicit permissions to provide to the container for the device. By default, the container has permissions for ``read``, ``write``, and ``mknod`` for the device.")
  @extension("x-ms-identifiers", [])
  permissions?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tmpfs")
model Tmpfs {
  @doc("The absolute file path where the tmpfs volume is to be mounted.")
  containerPath?: string;

  @doc("The list of tmpfs volume mount options.")
  @extension("x-ms-identifiers", [])
  mountOptions?: string[];

  @doc("The maximum size (in MiB) of the tmpfs volume.")
  size?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AuthorizationConfig")
model AuthorizationConfig {
  @doc("The Amazon EFS access point ID to use. If an access point is specified, the root directory value specified in the ``EFSVolumeConfiguration`` must either be omitted or set to ``/`` which will enforce the path set on the EFS access point. If an access point is used, transit encryption must be on in the ``EFSVolumeConfiguration``. For more information, see [Working with Amazon EFS access points](https://docs.aws.amazon.com/efs/latest/ug/efs-access-points.html) in the *Amazon Elastic File System User Guide*.")
  accessPointId?: string;

  @doc("Determines whether to use the Amazon ECS task role defined in a task definition when mounting the Amazon EFS file system. If it is turned on, transit encryption must be turned on in the ``EFSVolumeConfiguration``. If this parameter is omitted, the default value of ``DISABLED`` is used. For more information, see [Using Amazon EFS access points](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/efs-volumes.html#efs-volume-accesspoints) in the *Amazon Elastic Container Service Developer Guide*.")
  iam?: AuthorizationConfigIAM;
}

@doc("AuthorizationConfigIAM enum")
union AuthorizationConfigIAM {
  @doc("AuthorizationConfigIAM enum DISABLED")
  DISABLED: "DISABLED",

  @doc("AuthorizationConfigIAM enum ENABLED")
  ENABLED: "ENABLED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FSxAuthorizationConfig")
model FSxAuthorizationConfig {
  @doc("Property credentialsParameter")
  credentialsParameter?: string;

  @doc("Property domain")
  domain?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface EcsTaskDefinitions {
  get is ArmResourceRead<EcsTaskDefinition>;
  @doc("Create a EcsTaskDefinition. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<EcsTaskDefinition>;
  update is ArmCustomPatchAsync<
    EcsTaskDefinition,
    Azure.ResourceManager.Foundations.TagsUpdateModel<EcsTaskDefinition>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<EcsTaskDefinition>;
  listByResourceGroup is ArmResourceListByParent<EcsTaskDefinition>;
  listBySubscription is ArmListBySubscription<EcsTaskDefinition>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::ECS::TaskDefinition
//--------------------------------------------------------------------------------------------
