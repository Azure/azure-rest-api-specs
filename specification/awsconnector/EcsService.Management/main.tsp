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

//---------------------------------------------- EcsServices ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
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
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsEcsServiceProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEcsService")
model AwsEcsServiceProperties {
  @doc("Gets and sets the property capacityProviderStrategy.")
  @extension("x-ms-identifiers", [])
  capacityProviderStrategy?: CapacityProviderStrategyItem[];

  @doc("Gets and sets the property cluster.")
  cluster?: string;

  @doc("Gets and sets the property deploymentConfiguration.")
  deploymentConfiguration?: DeploymentConfiguration;

  @doc("Gets and sets the property deploymentController.")
  deploymentController?: DeploymentController;

  @doc("Gets and sets the property desiredCount.")
  desiredCount?: int32;

  @doc("Gets and sets the property enableECSManagedTags.")
  enableECSManagedTags?: boolean;

  @doc("Gets and sets the property enableExecuteCommand.")
  enableExecuteCommand?: boolean;

  @doc("Gets and sets the property healthCheckGracePeriodSeconds.")
  healthCheckGracePeriodSeconds?: int32;

  @doc("Gets and sets the property launchType.")
  launchType?: LaunchType;

  @doc("Gets and sets the property loadBalancers.")
  @extension("x-ms-identifiers", [])
  loadBalancers?: LoadBalancer[];

  @doc("Gets and sets the property name.")
  name?: string;

  @doc("Gets and sets the property networkConfiguration.")
  networkConfiguration?: NetworkConfiguration;

  @doc("Gets and sets the property placementConstraints.")
  @extension("x-ms-identifiers", [])
  placementConstraints?: PlacementConstraint[];

  @doc("Gets and sets the property placementStrategies.")
  @extension("x-ms-identifiers", [])
  placementStrategies?: PlacementStrategy[];

  @doc("Gets and sets the property platformVersion.")
  platformVersion?: string;

  @doc("Gets and sets the property propagateTags.")
  propagateTags?: PropagateTags;

  @doc("Gets and sets the property role.")
  role?: string;

  @doc("Gets and sets the property schedulingStrategy.")
  schedulingStrategy?: SchedulingStrategy;

  @doc("Gets and sets the property serviceArn.")
  serviceArn?: string;

  @doc("Gets and sets the property serviceConnectConfiguration.")
  serviceConnectConfiguration?: ServiceConnectConfiguration;

  @doc("Gets and sets the property serviceName.")
  serviceName?: string;

  @doc("Gets and sets the property serviceRegistries.")
  @extension("x-ms-identifiers", [])
  serviceRegistries?: ServiceRegistry[];

  @doc("Gets and sets the property tags.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Gets and sets the property taskDefinition.")
  taskDefinition?: string;

  @doc("Gets and sets the property volumeConfigurations.")
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
  @doc("Gets and sets the property base.")
  base?: int32;

  @doc("Gets and sets the property capacityProvider.")
  capacityProvider?: string;

  @doc("Gets and sets the property weight.")
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
  @doc("Gets and sets the property alarms.")
  alarms?: DeploymentAlarms;

  @doc("Gets and sets the property deploymentCircuitBreaker.")
  deploymentCircuitBreaker?: DeploymentCircuitBreaker;

  @doc("Gets and sets the property maximumPercent.")
  maximumPercent?: int32;

  @doc("Gets and sets the property minimumHealthyPercent.")
  minimumHealthyPercent?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DeploymentController")
model DeploymentController {
  @doc("Gets and sets the property type.")
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
  @doc("Gets and sets the property containerName.")
  containerName?: string;

  @doc("Gets and sets the property containerPort.")
  containerPort?: int32;

  @doc("Gets and sets the property loadBalancerName.")
  loadBalancerName?: string;

  @doc("Gets and sets the property targetGroupArn.")
  targetGroupArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NetworkConfiguration")
model NetworkConfiguration {
  @doc("Gets and sets the property awsvpcConfiguration.")
  awsvpcConfiguration?: AwsVpcConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PlacementConstraint")
model PlacementConstraint {
  @doc("Gets and sets the property expression.")
  expression?: string;

  @doc("Gets and sets the property type.")
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
  @doc("Gets and sets the property field.")
  field?: string;

  @doc("Gets and sets the property type.")
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
  @doc("Gets and sets the property enabled.")
  enabled?: boolean;

  @doc("Gets and sets the property logConfiguration.")
  logConfiguration?: LogConfiguration;

  @doc("Gets and sets the property `namespace`.")
  `namespace`?: string;

  @doc("Gets and sets the property services.")
  @extension("x-ms-identifiers", [])
  services?: ServiceConnectService[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ServiceRegistry")
model ServiceRegistry {
  @doc("Gets and sets the property containerName.")
  containerName?: string;

  @doc("Gets and sets the property containerPort.")
  containerPort?: int32;

  @doc("Gets and sets the property port.")
  port?: int32;

  @doc("Gets and sets the property registryArn.")
  registryArn?: string;
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
@doc("Definition of ServiceVolumeConfiguration")
model ServiceVolumeConfiguration {
  @doc("Gets and sets the property managedEBSVolume.")
  managedEBSVolume?: ServiceManagedEBSVolumeConfiguration;

  @doc("Gets and sets the property name.")
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DeploymentAlarms")
model DeploymentAlarms {
  @doc("Gets and sets the property alarmNames.")
  @extension("x-ms-identifiers", [])
  alarmNames?: string[];

  @doc("Gets and sets the property enable.")
  enable?: boolean;

  @doc("Gets and sets the property rollback.")
  rollback?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DeploymentCircuitBreaker")
model DeploymentCircuitBreaker {
  @doc("Gets and sets the property enable.")
  enable?: boolean;

  @doc("Gets and sets the property rollback.")
  rollback?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AwsVpcConfiguration")
model AwsVpcConfiguration {
  @doc("Gets and sets the property assignPublicIp.")
  assignPublicIp?: AwsVpcConfigurationAssignPublicIp;

  @doc("Gets and sets the property securityGroups.")
  @extension("x-ms-identifiers", [])
  securityGroups?: string[];

  @doc("Gets and sets the property subnets.")
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
@doc("Definition of ServiceConnectService")
model ServiceConnectService {
  @doc("Gets and sets the property clientAliases.")
  @extension("x-ms-identifiers", [])
  clientAliases?: ServiceConnectClientAlias[];

  @doc("Gets and sets the property discoveryName.")
  discoveryName?: string;

  @doc("Gets and sets the property ingressPortOverride.")
  ingressPortOverride?: int32;

  @doc("Gets and sets the property portName.")
  portName?: string;

  @doc("Gets and sets the property timeout.")
  timeout?: TimeoutConfiguration;

  @doc("Gets and sets the property tls.")
  tls?: ServiceConnectTlsConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ServiceManagedEBSVolumeConfiguration")
model ServiceManagedEBSVolumeConfiguration {
  @doc("Gets and sets the property encrypted.")
  encrypted?: boolean;

  @doc("Gets and sets the property filesystemType.")
  filesystemType?: string;

  @doc("Gets and sets the property iops.")
  iops?: int32;

  @doc("Gets and sets the property kmsKeyId.")
  kmsKeyId?: string;

  @doc("Gets and sets the property roleArn.")
  roleArn?: string;

  @doc("Gets and sets the property sizeInGiB.")
  sizeInGiB?: int32;

  @doc("Gets and sets the property snapshotId.")
  snapshotId?: string;

  @doc("Gets and sets the property tagSpecifications.")
  @extension("x-ms-identifiers", [])
  tagSpecifications?: EBSTagSpecification[];

  @doc("Gets and sets the property throughput.")
  throughput?: int32;

  @doc("Gets and sets the property volumeType.")
  volumeType?: string;
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
@doc("Definition of ServiceConnectClientAlias")
model ServiceConnectClientAlias {
  @doc("Gets and sets the property dnsName.")
  dnsName?: string;

  @doc("Gets and sets the property port.")
  port?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TimeoutConfiguration")
model TimeoutConfiguration {
  @doc("Gets and sets the property idleTimeoutSeconds.")
  idleTimeoutSeconds?: int32;

  @doc("Gets and sets the property perRequestTimeoutSeconds.")
  perRequestTimeoutSeconds?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ServiceConnectTlsConfiguration")
model ServiceConnectTlsConfiguration {
  @doc("Gets and sets the property issuerCertificateAuthority.")
  issuerCertificateAuthority?: ServiceConnectTlsCertificateAuthority;

  @doc("Gets and sets the property kmsKey.")
  kmsKey?: string;

  @doc("Gets and sets the property roleArn.")
  roleArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EBSTagSpecification")
model EBSTagSpecification {
  @doc("Gets and sets the property propagateTags.")
  propagateTags?: EBSTagSpecificationPropagateTags;

  @doc("Gets and sets the property resourceType.")
  resourceType?: string;

  @doc("Gets and sets the property tags.")
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
  @doc("Gets and sets the property awsPcaAuthorityArn.")
  awsPcaAuthorityArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface EcsServices {
  get is ArmResourceRead<EcsService>;
  @doc("Create a EcsService. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EcsService>;
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
