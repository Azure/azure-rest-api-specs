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

//---------------------------------------------- EcsTaskDefinitions ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
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
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsEcsTaskDefinitionProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEcsTaskDefinition")
model AwsEcsTaskDefinitionProperties {
  @doc("Gets and sets the property containerDefinitions.")
  @extension("x-ms-identifiers", [])
  containerDefinitions?: ContainerDefinition[];

  @doc("Gets and sets the property cpu.")
  cpu?: string;

  @doc("Gets and sets the property ephemeralStorage.")
  ephemeralStorage?: EphemeralStorage;

  @doc("Gets and sets the property executionRoleArn.")
  executionRoleArn?: string;

  @doc("Gets and sets the property family.")
  family?: string;

  @doc("Gets and sets the property inferenceAccelerators.")
  @extension("x-ms-identifiers", [])
  inferenceAccelerators?: InferenceAccelerator[];

  @doc("Gets and sets the property ipcMode.")
  ipcMode?: string;

  @doc("Gets and sets the property memory.")
  memory?: string;

  @doc("Gets and sets the property networkMode.")
  networkMode?: string;

  @doc("Gets and sets the property pidMode.")
  pidMode?: string;

  @doc("Gets and sets the property placementConstraints.")
  @extension("x-ms-identifiers", [])
  placementConstraints?: TaskDefinitionPlacementConstraint[];

  @doc("Gets and sets the property proxyConfiguration.")
  proxyConfiguration?: ProxyConfiguration;

  @doc("Gets and sets the property requiresCompatibilities.")
  @extension("x-ms-identifiers", [])
  requiresCompatibilities?: string[];

  @doc("Gets and sets the property runtimePlatform.")
  runtimePlatform?: RuntimePlatform;

  @doc("Gets and sets the property tags.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Gets and sets the property taskDefinitionArn. The Amazon Resource Name (ARN) of the Amazon ECS task definition")
  taskDefinitionArn?: string;

  @doc("Gets and sets the property taskRoleArn.")
  taskRoleArn?: string;

  @doc("Gets and sets the property volumes.")
  @extension("x-ms-identifiers", [])
  volumes?: Volume[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ContainerDefinition")
model ContainerDefinition {
  @doc("Gets and sets the property command.")
  @extension("x-ms-identifiers", [])
  command?: string[];

  @doc("Gets and sets the property cpu.")
  cpu?: int32;

  @doc("Gets and sets the property credentialSpecs.")
  @extension("x-ms-identifiers", [])
  credentialSpecs?: string[];

  @doc("Gets and sets the property dependsOn.")
  @extension("x-ms-identifiers", [])
  dependsOn?: ContainerDependency[];

  @doc("Gets and sets the property disableNetworking.")
  disableNetworking?: boolean;

  @doc("Gets and sets the property dnsSearchDomains.")
  @extension("x-ms-identifiers", [])
  dnsSearchDomains?: string[];

  @doc("Gets and sets the property dnsServers.")
  @extension("x-ms-identifiers", [])
  dnsServers?: string[];

  @doc("Gets and sets the property dockerLabels.")
  dockerLabels?: unknown;

  @doc("Gets and sets the property dockerSecurityOptions.")
  @extension("x-ms-identifiers", [])
  dockerSecurityOptions?: string[];

  @doc("Gets and sets the property entryPoint.")
  @extension("x-ms-identifiers", [])
  entryPoint?: string[];

  @doc("Gets and sets the property environment. The environment variables to pass to a container")
  @extension("x-ms-identifiers", [])
  environment?: KeyValuePair[];

  @doc("Gets and sets the property environmentFiles. The list of one or more files that contain the environment variables to pass to a container")
  @extension("x-ms-identifiers", [])
  environmentFiles?: EnvironmentFile[];

  @doc("Gets and sets the property essential.")
  essential?: boolean;

  @doc("Gets and sets the property extraHosts.")
  @extension("x-ms-identifiers", [])
  extraHosts?: HostEntry[];

  @doc("Gets and sets the property firelensConfiguration.")
  firelensConfiguration?: FirelensConfiguration;

  @doc("Gets and sets the property healthCheck. The health check command and associated configuration parameters for the container.")
  healthCheck?: HealthCheck;

  @doc("Gets and sets the property hostname.")
  hostname?: string;

  @doc("Gets and sets the property image. The image used to start a container. This string is passed directly to the Docker daemon.")
  image?: string;

  @doc("Gets and sets the property interactive.")
  interactive?: boolean;

  @doc("Gets and sets the property links.")
  @extension("x-ms-identifiers", [])
  links?: string[];

  @doc("Gets and sets the property linuxParameters.")
  linuxParameters?: LinuxParameters;

  @doc("Gets and sets the property logConfiguration.")
  logConfiguration?: LogConfiguration;

  @doc("Gets and sets the property memory. The amount (in MiB) of memory to present to the container. If your container attempts to exceed the memory specified here, the container is killed.")
  memory?: int32;

  @doc("Gets and sets the property memoryReservation.")
  memoryReservation?: int32;

  @doc("Gets and sets the property mountPoints.")
  @extension("x-ms-identifiers", [])
  mountPoints?: MountPoint[];

  @doc("Gets and sets the property name. The name of a container. Up to 255 letters (uppercase and lowercase), numbers, hyphens, and underscores are allowed")
  name?: string;

  @doc("Gets and sets the property portMappings. Port mappings allow containers to access ports on the host container instance to send or receive traffic.")
  @extension("x-ms-identifiers", [])
  portMappings?: PortMapping[];

  @doc("Gets and sets the property privileged.")
  privileged?: boolean;

  @doc("Gets and sets the property pseudoTerminal.")
  pseudoTerminal?: boolean;

  @doc("Gets and sets the property readonlyRootFilesystem.")
  readonlyRootFilesystem?: boolean;

  @doc("Gets and sets the property repositoryCredentials.")
  repositoryCredentials?: RepositoryCredentials;

  @doc("Gets and sets the property resourceRequirements.")
  @extension("x-ms-identifiers", [])
  resourceRequirements?: ResourceRequirement[];

  @doc("Gets and sets the property secrets.")
  @extension("x-ms-identifiers", [])
  secrets?: Secret[];

  @doc("Gets and sets the property startTimeout.")
  startTimeout?: int32;

  @doc("Gets and sets the property stopTimeout.")
  stopTimeout?: int32;

  @doc("Gets and sets the property systemControls.")
  @extension("x-ms-identifiers", [])
  systemControls?: SystemControl[];

  @doc("Gets and sets the property ulimits.")
  @extension("x-ms-identifiers", [])
  ulimits?: Ulimit[];

  @doc("Gets and sets the property user.")
  user?: string;

  @doc("Gets and sets the property volumesFrom.")
  @extension("x-ms-identifiers", [])
  volumesFrom?: VolumeFrom[];

  @doc("Gets and sets the property workingDirectory.")
  workingDirectory?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EphemeralStorage")
model EphemeralStorage {
  @doc("Gets and sets the property sizeInGiB.")
  sizeInGiB?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InferenceAccelerator")
model InferenceAccelerator {
  @doc("Gets and sets the property deviceName.")
  deviceName?: string;

  @doc("Gets and sets the property deviceType.")
  deviceType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TaskDefinitionPlacementConstraint")
model TaskDefinitionPlacementConstraint {
  @doc("Gets and sets the property expression.")
  expression?: string;

  @doc("Gets and sets the property type.")
  type?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProxyConfiguration")
model ProxyConfiguration {
  @doc("Gets and sets the property containerName.")
  containerName?: string;

  @doc("Gets and sets the property proxyConfigurationProperties.")
  @extension("x-ms-identifiers", [])
  proxyConfigurationProperties?: KeyValuePair[];

  @doc("Gets and sets the property type.")
  type?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RuntimePlatform")
model RuntimePlatform {
  @doc("Gets and sets the property cpuArchitecture.")
  cpuArchitecture?: string;

  @doc("Gets and sets the property operatingSystemFamily.")
  operatingSystemFamily?: string;
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Volume")
model Volume {
  @doc("Gets and sets the property configuredAtLaunch.")
  configuredAtLaunch?: boolean;

  @doc("Gets and sets the property dockerVolumeConfiguration.")
  dockerVolumeConfiguration?: DockerVolumeConfiguration;

  @doc("Gets and sets the property efsVolumeConfiguration.")
  efsVolumeConfiguration?: EFSVolumeConfiguration;

  @doc("Gets and sets the property host.")
  host?: HostVolumeProperties;

  @doc("Gets and sets the property name.")
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ContainerDependency")
model ContainerDependency {
  @doc("Gets and sets the property condition.")
  condition?: string;

  @doc("Gets and sets the property containerName.")
  containerName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of KeyValuePair")
model KeyValuePair {
  @doc("Gets and sets the property name.")
  name?: string;

  @doc("Gets and sets the property value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EnvironmentFile")
model EnvironmentFile {
  @doc("Gets and sets the property type.")
  type?: string;

  @doc("Gets and sets the property value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of HostEntry")
model HostEntry {
  @doc("Gets and sets the property hostname.")
  hostname?: string;

  @doc("Gets and sets the property ipAddress.")
  ipAddress?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FirelensConfiguration")
model FirelensConfiguration {
  @doc("Gets and sets the property options.")
  options?: unknown;

  @doc("Gets and sets the property type.")
  type?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of HealthCheck")
model HealthCheck {
  @doc("Gets and sets the property command. A string array representing the command that the container runs to determine if it is healthy.")
  @extension("x-ms-identifiers", [])
  command?: string[];

  @doc("Gets and sets the property interval. The time period in seconds between each health check execution. You may specify between 5 and 300 seconds. The default value is 30 seconds.")
  interval?: int32;

  @doc("Gets and sets the property retries. The number of times to retry a failed health check before the container is considered unhealthy. You may specify between 1 and 10 retries. The default value is three retries.")
  retries?: int32;

  @doc("Gets and sets the property startPeriod. The optional grace period within which to provide containers time to bootstrap before failed health checks count towards the maximum number of retries. You may specify between 0 and 300 seconds. The startPeriod is disabled by default.")
  startPeriod?: int32;

  @doc("Gets and sets the property timeout. The time period in seconds to wait for a health check to succeed before it is considered a failure. You may specify between 2 and 60 seconds. The default value is 5 seconds.")
  timeout?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LinuxParameters")
model LinuxParameters {
  @doc("Gets and sets the property capabilities.")
  capabilities?: KernelCapabilities;

  @doc("Gets and sets the property devices.")
  @extension("x-ms-identifiers", [])
  devices?: Device[];

  @doc("Gets and sets the property initProcessEnabled.")
  initProcessEnabled?: boolean;

  @doc("Gets and sets the property maxSwap.")
  maxSwap?: int32;

  @doc("Gets and sets the property sharedMemorySize.")
  sharedMemorySize?: int32;

  @doc("Gets and sets the property swappiness.")
  swappiness?: int32;

  @doc("Gets and sets the property tmpfs.")
  @extension("x-ms-identifiers", [])
  tmpfs?: Tmpfs[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LogConfiguration")
model LogConfiguration {
  @doc("Gets and sets the property logDriver.")
  logDriver?: string;

  @doc("Gets and sets the property options.")
  options?: unknown;

  @doc("Gets and sets the property secretOptions.")
  @extension("x-ms-identifiers", [])
  secretOptions?: Secret[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MountPoint")
model MountPoint {
  @doc("Gets and sets the property containerPath.")
  containerPath?: string;

  @doc("Gets and sets the property readOnly.")
  readOnly?: boolean;

  @doc("Gets and sets the property sourceVolume.")
  sourceVolume?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PortMapping")
model PortMapping {
  @doc("Gets and sets the property appProtocol.")
  appProtocol?: PortMappingAppProtocol;

  @doc("Gets and sets the property containerPort.")
  containerPort?: int32;

  @doc("Gets and sets the property containerPortRange.")
  containerPortRange?: string;

  @doc("Gets and sets the property hostPort.")
  hostPort?: int32;

  @doc("Gets and sets the property name.")
  name?: string;

  @doc("Gets and sets the property protocol.")
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
  @doc("Gets and sets the property credentialsParameter.")
  credentialsParameter?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ResourceRequirement")
model ResourceRequirement {
  @doc("Gets and sets the property type.")
  type?: string;

  @doc("Gets and sets the property value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Secret")
model Secret {
  @doc("Gets and sets the property name.")
  name?: string;

  @doc("Gets and sets the property valueFrom.")
  valueFrom?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SystemControl")
model SystemControl {
  @doc("Gets and sets the property `namespace`.")
  `namespace`?: string;

  @doc("Gets and sets the property value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Ulimit")
model Ulimit {
  @doc("Gets and sets the property hardLimit.")
  hardLimit?: int32;

  @doc("Gets and sets the property name.")
  name?: string;

  @doc("Gets and sets the property softLimit.")
  softLimit?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VolumeFrom")
model VolumeFrom {
  @doc("Gets and sets the property readOnly.")
  readOnly?: boolean;

  @doc("Gets and sets the property sourceContainer.")
  sourceContainer?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DockerVolumeConfiguration")
model DockerVolumeConfiguration {
  @doc("Gets and sets the property autoprovision.")
  autoprovision?: boolean;

  @doc("Gets and sets the property driver.")
  driver?: string;

  @doc("Gets and sets the property driverOpts.")
  driverOpts?: unknown;

  @doc("Gets and sets the property labels.")
  labels?: unknown;

  @doc("Gets and sets the property scope.")
  scope?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EFSVolumeConfiguration")
model EFSVolumeConfiguration {
  @doc("Gets and sets the property authorizationConfig.")
  authorizationConfig?: AuthorizationConfig;

  @doc("Gets and sets the property filesystemId.")
  filesystemId?: string;

  @doc("Gets and sets the property rootDirectory.")
  rootDirectory?: string;

  @doc("Gets and sets the property transitEncryption.")
  transitEncryption?: EFSVolumeConfigurationTransitEncryption;

  @doc("Gets and sets the property transitEncryptionPort.")
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
@doc("Definition of HostVolumeProperties")
model HostVolumeProperties {
  @doc("Gets and sets the property sourcePath.")
  sourcePath?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of KernelCapabilities")
model KernelCapabilities {
  @doc("Gets and sets the property add.")
  @extension("x-ms-identifiers", [])
  add?: string[];

  @doc("Gets and sets the property drop.")
  @extension("x-ms-identifiers", [])
  drop?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Device")
model Device {
  @doc("Gets and sets the property containerPath.")
  containerPath?: string;

  @doc("Gets and sets the property hostPath.")
  hostPath?: string;

  @doc("Gets and sets the property permissions.")
  @extension("x-ms-identifiers", [])
  permissions?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tmpfs")
model Tmpfs {
  @doc("Gets and sets the property containerPath.")
  containerPath?: string;

  @doc("Gets and sets the property mountOptions.")
  @extension("x-ms-identifiers", [])
  mountOptions?: string[];

  @doc("Gets and sets the property size.")
  size?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AuthorizationConfig")
model AuthorizationConfig {
  @doc("Gets and sets the property accessPointId.")
  accessPointId?: string;

  @doc("Gets and sets the property iam.")
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface EcsTaskDefinitions {
  get is ArmResourceRead<EcsTaskDefinition>;
  @doc("Create a EcsTaskDefinition. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EcsTaskDefinition>;
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
