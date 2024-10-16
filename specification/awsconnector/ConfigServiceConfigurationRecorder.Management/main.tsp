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

//---------------------------------------------- ConfigServiceConfigurationRecorders ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Config  Service Configuration Recorder",
    plural: "Config  Service Configuration Recorders",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "Config ",
    "Service",
    "Configuration",
    "Recorder"
  ],
})
@doc("A Microsoft.AwsConnector resource")
model ConfigServiceConfigurationRecorder
  is TrackedResource<ConfigServiceConfigurationRecorderProperties> {
  @doc("Name of ConfigServiceConfigurationRecorder")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("configServiceConfigurationRecorders")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ConfigServiceConfigurationRecorder")
model ConfigServiceConfigurationRecorderProperties {
  @doc("AWS Properties")
  awsProperties?: AwsConfigServiceConfigurationRecorderProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsConfigServiceConfigurationRecorder")
model AwsConfigServiceConfigurationRecorderProperties {
  @doc("<p>The name of the configuration recorder. Config automatically assigns the name of 'default' when creating the configuration recorder.</p> <note> <p>You cannot change the name of the configuration recorder after it has been created. To change the configuration recorder name, you must delete it and create a new configuration recorder with a new name. </p> </note>")
  name?: string;

  @doc("<p>Specifies which resource types Config records for configuration changes.</p> <note> <p> <b> High Number of Config Evaluations</b> </p> <p>You may notice increased activity in your account during your initial month recording with Config when compared to subsequent months. During the initial bootstrapping process, Config runs evaluations on all the resources in your account that you have selected for Config to record.</p> <p>If you are running ephemeral workloads, you may see increased activity from Config as it records configuration changes associated with creating and deleting these temporary resources. An <i>ephemeral workload</i> is a temporary use of computing resources that are loaded and run when needed. Examples include Amazon Elastic Compute Cloud (Amazon EC2) Spot Instances, Amazon EMR jobs, and Auto Scaling. If you want to avoid the increased activity from running ephemeral workloads, you can run these types of workloads in a separate account with Config turned off to avoid increased configuration recording and rule evaluations.</p> </note>")
  recordingGroup?: RecordingGroup;

  @doc("<p>Specifies the default recording frequency that Config uses to record configuration changes. Config supports <i>Continuous recording</i> and <i>Daily recording</i>.</p> <ul> <li> <p>Continuous recording allows you to record configuration changes continuously whenever a change occurs.</p> </li> <li> <p>Daily recording allows you to receive a configuration item (CI) representing the most recent state of your resources over the last 24-hour period, only if it’s different from the previous CI recorded. </p> </li> </ul> <note> <p>Firewall Manager depends on continuous recording to monitor your resources. If you are using Firewall Manager, it is recommended that you set the recording frequency to Continuous.</p> </note> <p>You can also override the recording frequency for specific resource types.</p>")
  recordingMode?: RecordingMode;

  @doc("<p>Amazon Resource Name (ARN) of the IAM role assumed by Config and used by the configuration recorder.</p> <note> <p>While the API model does not require this field, the server will reject a request without a defined <code>roleARN</code> for the configuration recorder.</p> </note> <note> <p> <b>Pre-existing Config role</b> </p> <p>If you have used an Amazon Web Services service that uses Config, such as Security Hub or Control Tower, and an Config role has already been created, make sure that the IAM role that you use when setting up Config keeps the same minimum permissions as the already created Config role. You must do this so that the other Amazon Web Services service continues to run as expected. </p> <p>For example, if Control Tower has an IAM role that allows Config to read Amazon Simple Storage Service (Amazon S3) objects, make sure that the same permissions are granted within the IAM role you use when setting up Config. Otherwise, it may interfere with how Control Tower operates. For more information about IAM roles for Config, see <a href='https://docs.aws.amazon.com/config/latest/developerguide/security-iam.html'> <b>Identity and Access Management for Config</b> </a> in the <i>Config Developer Guide</i>. </p> </note>")
  roleARN?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RecordingGroup")
model RecordingGroup {
  @doc("<p>Specifies whether Config records configuration changes for all supported resource types, excluding the global IAM resource types.</p> <p>If you set this field to <code>true</code>, when Config adds support for a new resource type, Config starts recording resources of that type automatically.</p> <p>If you set this field to <code>true</code>, you cannot enumerate specific resource types to record in the <code>resourceTypes</code> field of <a href='https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingGroup.html'>RecordingGroup</a>, or to exclude in the <code>resourceTypes</code> field of <a href='https://docs.aws.amazon.com/config/latest/APIReference/API_ExclusionByResourceTypes.html'>ExclusionByResourceTypes</a>.</p> <note> <p> <b>Region availability</b> </p> <p>Check <a href='https://docs.aws.amazon.com/config/latest/developerguide/what-is-resource-config-coverage.html'>Resource Coverage by Region Availability</a> to see if a resource type is supported in the Amazon Web Services Region where you set up Config.</p> </note>")
  allSupported?: boolean;

  @doc("<p>An object that specifies how Config excludes resource types from being recorded by the configuration recorder.</p> <note> <p> <b>Required fields</b> </p> <p>To use this option, you must set the <code>useOnly</code> field of <a href='https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingStrategy.html'>RecordingStrategy</a> to <code>EXCLUSION_BY_RESOURCE_TYPES</code>.</p> </note>")
  exclusionByResourceTypes?: ExclusionByResourceTypes;

  @doc("<p>This option is a bundle which only applies to the global IAM resource types: IAM users, groups, roles, and customer managed policies. These global IAM resource types can only be recorded by Config in Regions where Config was available before February 2022. You cannot be record the global IAM resouce types in Regions supported by Config after February 2022. This list where you cannot record the global IAM resource types includes the following Regions:</p> <ul> <li> <p>Asia Pacific (Hyderabad)</p> </li> <li> <p>Asia Pacific (Melbourne)</p> </li> <li> <p>Canada West (Calgary)</p> </li> <li> <p>Europe (Spain)</p> </li> <li> <p>Europe (Zurich)</p> </li> <li> <p>Israel (Tel Aviv)</p> </li> <li> <p>Middle East (UAE)</p> </li> </ul> <important> <p> <b>Aurora global clusters are recorded in all enabled Regions</b> </p> <p>The <code>AWS::RDS::GlobalCluster</code> resource type will be recorded in all supported Config Regions where the configuration recorder is enabled, even if <code>includeGlobalResourceTypes</code> is set<code>false</code>. The <code>includeGlobalResourceTypes</code> option is a bundle which only applies to IAM users, groups, roles, and customer managed policies. </p> <p>If you do not want to record <code>AWS::RDS::GlobalCluster</code> in all enabled Regions, use one of the following recording strategies:</p> <ol> <li> <p> <b>Record all current and future resource types with exclusions</b> (<code>EXCLUSION_BY_RESOURCE_TYPES</code>), or</p> </li> <li> <p> <b>Record specific resource types</b> (<code>INCLUSION_BY_RESOURCE_TYPES</code>).</p> </li> </ol> <p>For more information, see <a href='https://docs.aws.amazon.com/config/latest/developerguide/select-resources.html#select-resources-all'>Selecting Which Resources are Recorded</a> in the <i>Config developer guide</i>.</p> </important> <important> <p> <b>includeGlobalResourceTypes and the exclusion recording strategy</b> </p> <p>The <code>includeGlobalResourceTypes</code> field has no impact on the <code>EXCLUSION_BY_RESOURCE_TYPES</code> recording strategy. This means that the global IAM resource types (IAM users, groups, roles, and customer managed policies) will not be automatically added as exclusions for <code>exclusionByResourceTypes</code> when <code>includeGlobalResourceTypes</code> is set to <code>false</code>.</p> <p>The <code>includeGlobalResourceTypes</code> field should only be used to modify the <code>AllSupported</code> field, as the default for the <code>AllSupported</code> field is to record configuration changes for all supported resource types excluding the global IAM resource types. To include the global IAM resource types when <code>AllSupported</code> is set to <code>true</code>, make sure to set <code>includeGlobalResourceTypes</code> to <code>true</code>.</p> <p>To exclude the global IAM resource types for the <code>EXCLUSION_BY_RESOURCE_TYPES</code> recording strategy, you need to manually add them to the <code>resourceTypes</code> field of <code>exclusionByResourceTypes</code>.</p> </important> <note> <p> <b>Required and optional fields</b> </p> <p>Before you set this field to <code>true</code>, set the <code>allSupported</code> field of <a href='https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingGroup.html'>RecordingGroup</a> to <code>true</code>. Optionally, you can set the <code>useOnly</code> field of <a href='https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingStrategy.html'>RecordingStrategy</a> to <code>ALL_SUPPORTED_RESOURCE_TYPES</code>.</p> </note> <note> <p> <b>Overriding fields</b> </p> <p>If you set this field to <code>false</code> but list global IAM resource types in the <code>resourceTypes</code> field of <a href='https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingGroup.html'>RecordingGroup</a>, Config will still record configuration changes for those specified resource types <i>regardless</i> of if you set the <code>includeGlobalResourceTypes</code> field to false.</p> <p>If you do not want to record configuration changes to the global IAM resource types (IAM users, groups, roles, and customer managed policies), make sure to not list them in the <code>resourceTypes</code> field in addition to setting the <code>includeGlobalResourceTypes</code> field to false.</p> </note>")
  includeGlobalResourceTypes?: boolean;

  @doc("<p>An object that specifies the recording strategy for the configuration recorder.</p> <ul> <li> <p>If you set the <code>useOnly</code> field of <a href='https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingStrategy.html'>RecordingStrategy</a> to <code>ALL_SUPPORTED_RESOURCE_TYPES</code>, Config records configuration changes for all supported resource types, excluding the global IAM resource types. You also must set the <code>allSupported</code> field of <a href='https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingGroup.html'>RecordingGroup</a> to <code>true</code>. When Config adds support for a new resource type, Config automatically starts recording resources of that type.</p> </li> <li> <p>If you set the <code>useOnly</code> field of <a href='https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingStrategy.html'>RecordingStrategy</a> to <code>INCLUSION_BY_RESOURCE_TYPES</code>, Config records configuration changes for only the resource types you specify in the <code>resourceTypes</code> field of <a href='https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingGroup.html'>RecordingGroup</a>.</p> </li> <li> <p>If you set the <code>useOnly</code> field of <a href='https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingStrategy.html'>RecordingStrategy</a> to <code>EXCLUSION_BY_RESOURCE_TYPES</code>, Config records configuration changes for all supported resource types except the resource types that you specify to exclude from being recorded in the <code>resourceTypes</code> field of <a href='https://docs.aws.amazon.com/config/latest/APIReference/API_ExclusionByResourceTypes.html'>ExclusionByResourceTypes</a>.</p> </li> </ul> <note> <p> <b>Required and optional fields</b> </p> <p>The <code>recordingStrategy</code> field is optional when you set the <code>allSupported</code> field of <a href='https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingGroup.html'>RecordingGroup</a> to <code>true</code>.</p> <p>The <code>recordingStrategy</code> field is optional when you list resource types in the <code>resourceTypes</code> field of <a href='https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingGroup.html'>RecordingGroup</a>.</p> <p>The <code>recordingStrategy</code> field is required if you list resource types to exclude from recording in the <code>resourceTypes</code> field of <a href='https://docs.aws.amazon.com/config/latest/APIReference/API_ExclusionByResourceTypes.html'>ExclusionByResourceTypes</a>.</p> </note> <note> <p> <b>Overriding fields</b> </p> <p>If you choose <code>EXCLUSION_BY_RESOURCE_TYPES</code> for the recording strategy, the <code>exclusionByResourceTypes</code> field will override other properties in the request.</p> <p>For example, even if you set <code>includeGlobalResourceTypes</code> to false, global IAM resource types will still be automatically recorded in this option unless those resource types are specifically listed as exclusions in the <code>resourceTypes</code> field of <code>exclusionByResourceTypes</code>.</p> </note> <note> <p> <b>Global resources types and the resource exclusion recording strategy</b> </p> <p>By default, if you choose the <code>EXCLUSION_BY_RESOURCE_TYPES</code> recording strategy, when Config adds support for a new resource type in the Region where you set up the configuration recorder, including global resource types, Config starts recording resources of that type automatically.</p> <p>Unless specifically listed as exclusions, <code>AWS::RDS::GlobalCluster</code> will be recorded automatically in all supported Config Regions were the configuration recorder is enabled.</p> <p>IAM users, groups, roles, and customer managed policies will be recorded in the Region where you set up the configuration recorder if that is a Region where Config was available before February 2022. You cannot be record the global IAM resouce types in Regions supported by Config after February 2022. This list where you cannot record the global IAM resource types includes the following Regions:</p> <ul> <li> <p>Asia Pacific (Hyderabad)</p> </li> <li> <p>Asia Pacific (Melbourne)</p> </li> <li> <p>Canada West (Calgary)</p> </li> <li> <p>Europe (Spain)</p> </li> <li> <p>Europe (Zurich)</p> </li> <li> <p>Israel (Tel Aviv)</p> </li> <li> <p>Middle East (UAE)</p> </li> </ul> </note>")
  recordingStrategy?: RecordingStrategy;

  @doc("<p>A comma-separated list that specifies which resource types Config records.</p> <p>For a list of valid <code>resourceTypes</code> values, see the <b>Resource Type Value</b> column in <a href='https://docs.aws.amazon.com/config/latest/developerguide/resource-config-reference.html#supported-resources'>Supported Amazon Web Services resource Types</a> in the <i>Config developer guide</i>.</p> <note> <p> <b>Required and optional fields</b> </p> <p>Optionally, you can set the <code>useOnly</code> field of <a href='https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingStrategy.html'>RecordingStrategy</a> to <code>INCLUSION_BY_RESOURCE_TYPES</code>.</p> <p>To record all configuration changes, set the <code>allSupported</code> field of <a href='https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingGroup.html'>RecordingGroup</a> to <code>true</code>, and either omit this field or don't specify any resource types in this field. If you set the <code>allSupported</code> field to <code>false</code> and specify values for <code>resourceTypes</code>, when Config adds support for a new type of resource, it will not record resources of that type unless you manually add that type to your recording group.</p> </note> <note> <p> <b>Region availability</b> </p> <p>Before specifying a resource type for Config to track, check <a href='https://docs.aws.amazon.com/config/latest/developerguide/what-is-resource-config-coverage.html'>Resource Coverage by Region Availability</a> to see if the resource type is supported in the Amazon Web Services Region where you set up Config. If a resource type is supported by Config in at least one Region, you can enable the recording of that resource type in all Regions supported by Config, even if the specified resource type is not supported in the Amazon Web Services Region where you set up Config.</p> </note>")
  @extension("x-ms-identifiers", [])
  resourceTypes?: ResourceType[];
}

@doc("ResourceType enum")
union ResourceType {
  @doc("ResourceType enum AWS::ACM::Certificate")
  AWSACMCertificate: "AWS::ACM::Certificate",

  @doc("ResourceType enum AWS::ACMPCA::CertificateAuthority")
  AWSACMPCACertificateAuthority: "AWS::ACMPCA::CertificateAuthority",

  @doc("ResourceType enum AWS::ACMPCA::CertificateAuthorityActivation")
  AWSACMPCACertificateAuthorityActivation: "AWS::ACMPCA::CertificateAuthorityActivation",

  @doc("ResourceType enum AWS::APS::RuleGroupsNamespace")
  AWSAPSRuleGroupsNamespace: "AWS::APS::RuleGroupsNamespace",

  @doc("ResourceType enum AWS::AccessAnalyzer::Analyzer")
  AWSAccessAnalyzerAnalyzer: "AWS::AccessAnalyzer::Analyzer",

  @doc("ResourceType enum AWS::AmazonMQ::Broker")
  AWSAmazonMQBroker: "AWS::AmazonMQ::Broker",

  @doc("ResourceType enum AWS::Amplify::App")
  AWSAmplifyApp: "AWS::Amplify::App",

  @doc("ResourceType enum AWS::Amplify::Branch")
  AWSAmplifyBranch: "AWS::Amplify::Branch",

  @doc("ResourceType enum AWS::ApiGateway::RestApi")
  AWSApiGatewayRestApi: "AWS::ApiGateway::RestApi",

  @doc("ResourceType enum AWS::ApiGateway::Stage")
  AWSApiGatewayStage: "AWS::ApiGateway::Stage",

  @doc("ResourceType enum AWS::ApiGatewayV2::Api")
  AWSApiGatewayV2Api: "AWS::ApiGatewayV2::Api",

  @doc("ResourceType enum AWS::ApiGatewayV2::Stage")
  AWSApiGatewayV2Stage: "AWS::ApiGatewayV2::Stage",

  @doc("ResourceType enum AWS::AppConfig::Application")
  AWSAppConfigApplication: "AWS::AppConfig::Application",

  @doc("ResourceType enum AWS::AppConfig::ConfigurationProfile")
  AWSAppConfigConfigurationProfile: "AWS::AppConfig::ConfigurationProfile",

  @doc("ResourceType enum AWS::AppConfig::DeploymentStrategy")
  AWSAppConfigDeploymentStrategy: "AWS::AppConfig::DeploymentStrategy",

  @doc("ResourceType enum AWS::AppConfig::Environment")
  AWSAppConfigEnvironment: "AWS::AppConfig::Environment",

  @doc("ResourceType enum AWS::AppConfig::HostedConfigurationVersion")
  AWSAppConfigHostedConfigurationVersion: "AWS::AppConfig::HostedConfigurationVersion",

  @doc("ResourceType enum AWS::AppFlow::Flow")
  AWSAppFlowFlow: "AWS::AppFlow::Flow",

  @doc("ResourceType enum AWS::AppIntegrations::EventIntegration")
  AWSAppIntegrationsEventIntegration: "AWS::AppIntegrations::EventIntegration",

  @doc("ResourceType enum AWS::AppMesh::GatewayRoute")
  AWSAppMeshGatewayRoute: "AWS::AppMesh::GatewayRoute",

  @doc("ResourceType enum AWS::AppMesh::Mesh")
  AWSAppMeshMesh: "AWS::AppMesh::Mesh",

  @doc("ResourceType enum AWS::AppMesh::Route")
  AWSAppMeshRoute: "AWS::AppMesh::Route",

  @doc("ResourceType enum AWS::AppMesh::VirtualGateway")
  AWSAppMeshVirtualGateway: "AWS::AppMesh::VirtualGateway",

  @doc("ResourceType enum AWS::AppMesh::VirtualNode")
  AWSAppMeshVirtualNode: "AWS::AppMesh::VirtualNode",

  @doc("ResourceType enum AWS::AppMesh::VirtualRouter")
  AWSAppMeshVirtualRouter: "AWS::AppMesh::VirtualRouter",

  @doc("ResourceType enum AWS::AppMesh::VirtualService")
  AWSAppMeshVirtualService: "AWS::AppMesh::VirtualService",

  @doc("ResourceType enum AWS::AppRunner::Service")
  AWSAppRunnerService: "AWS::AppRunner::Service",

  @doc("ResourceType enum AWS::AppRunner::VpcConnector")
  AWSAppRunnerVpcConnector: "AWS::AppRunner::VpcConnector",

  @doc("ResourceType enum AWS::AppStream::Application")
  AWSAppStreamApplication: "AWS::AppStream::Application",

  @doc("ResourceType enum AWS::AppStream::DirectoryConfig")
  AWSAppStreamDirectoryConfig: "AWS::AppStream::DirectoryConfig",

  @doc("ResourceType enum AWS::AppStream::Fleet")
  AWSAppStreamFleet: "AWS::AppStream::Fleet",

  @doc("ResourceType enum AWS::AppStream::Stack")
  AWSAppStreamStack: "AWS::AppStream::Stack",

  @doc("ResourceType enum AWS::AppSync::GraphQLApi")
  AWSAppSyncGraphQLApi: "AWS::AppSync::GraphQLApi",

  @doc("ResourceType enum AWS::Athena::DataCatalog")
  AWSAthenaDataCatalog: "AWS::Athena::DataCatalog",

  @doc("ResourceType enum AWS::Athena::PreparedStatement")
  AWSAthenaPreparedStatement: "AWS::Athena::PreparedStatement",

  @doc("ResourceType enum AWS::Athena::WorkGroup")
  AWSAthenaWorkGroup: "AWS::Athena::WorkGroup",

  @doc("ResourceType enum AWS::AuditManager::Assessment")
  AWSAuditManagerAssessment: "AWS::AuditManager::Assessment",

  @doc("ResourceType enum AWS::AutoScaling::AutoScalingGroup")
  AWSAutoScalingAutoScalingGroup: "AWS::AutoScaling::AutoScalingGroup",

  @doc("ResourceType enum AWS::AutoScaling::LaunchConfiguration")
  AWSAutoScalingLaunchConfiguration: "AWS::AutoScaling::LaunchConfiguration",

  @doc("ResourceType enum AWS::AutoScaling::ScalingPolicy")
  AWSAutoScalingScalingPolicy: "AWS::AutoScaling::ScalingPolicy",

  @doc("ResourceType enum AWS::AutoScaling::ScheduledAction")
  AWSAutoScalingScheduledAction: "AWS::AutoScaling::ScheduledAction",

  @doc("ResourceType enum AWS::AutoScaling::WarmPool")
  AWSAutoScalingWarmPool: "AWS::AutoScaling::WarmPool",

  @doc("ResourceType enum AWS::Backup::BackupPlan")
  AWSBackupBackupPlan: "AWS::Backup::BackupPlan",

  @doc("ResourceType enum AWS::Backup::BackupSelection")
  AWSBackupBackupSelection: "AWS::Backup::BackupSelection",

  @doc("ResourceType enum AWS::Backup::BackupVault")
  AWSBackupBackupVault: "AWS::Backup::BackupVault",

  @doc("ResourceType enum AWS::Backup::RecoveryPoint")
  AWSBackupRecoveryPoint: "AWS::Backup::RecoveryPoint",

  @doc("ResourceType enum AWS::Backup::ReportPlan")
  AWSBackupReportPlan: "AWS::Backup::ReportPlan",

  @doc("ResourceType enum AWS::Batch::ComputeEnvironment")
  AWSBatchComputeEnvironment: "AWS::Batch::ComputeEnvironment",

  @doc("ResourceType enum AWS::Batch::JobQueue")
  AWSBatchJobQueue: "AWS::Batch::JobQueue",

  @doc("ResourceType enum AWS::Batch::SchedulingPolicy")
  AWSBatchSchedulingPolicy: "AWS::Batch::SchedulingPolicy",

  @doc("ResourceType enum AWS::Budgets::BudgetsAction")
  AWSBudgetsBudgetsAction: "AWS::Budgets::BudgetsAction",

  @doc("ResourceType enum AWS::Cassandra::Keyspace")
  AWSCassandraKeyspace: "AWS::Cassandra::Keyspace",

  @doc("ResourceType enum AWS::Cloud9::EnvironmentEC2")
  AWSCloud9EnvironmentEC2: "AWS::Cloud9::EnvironmentEC2",

  @doc("ResourceType enum AWS::CloudFormation::Stack")
  AWSCloudFormationStack: "AWS::CloudFormation::Stack",

  @doc("ResourceType enum AWS::CloudFront::Distribution")
  AWSCloudFrontDistribution: "AWS::CloudFront::Distribution",

  @doc("ResourceType enum AWS::CloudFront::StreamingDistribution")
  AWSCloudFrontStreamingDistribution: "AWS::CloudFront::StreamingDistribution",

  @doc("ResourceType enum AWS::CloudTrail::Trail")
  AWSCloudTrailTrail: "AWS::CloudTrail::Trail",

  @doc("ResourceType enum AWS::CloudWatch::Alarm")
  AWSCloudWatchAlarm: "AWS::CloudWatch::Alarm",

  @doc("ResourceType enum AWS::CloudWatch::MetricStream")
  AWSCloudWatchMetricStream: "AWS::CloudWatch::MetricStream",

  @doc("ResourceType enum AWS::CodeArtifact::Repository")
  AWSCodeArtifactRepository: "AWS::CodeArtifact::Repository",

  @doc("ResourceType enum AWS::CodeBuild::Project")
  AWSCodeBuildProject: "AWS::CodeBuild::Project",

  @doc("ResourceType enum AWS::CodeBuild::ReportGroup")
  AWSCodeBuildReportGroup: "AWS::CodeBuild::ReportGroup",

  @doc("ResourceType enum AWS::CodeDeploy::Application")
  AWSCodeDeployApplication: "AWS::CodeDeploy::Application",

  @doc("ResourceType enum AWS::CodeDeploy::DeploymentConfig")
  AWSCodeDeployDeploymentConfig: "AWS::CodeDeploy::DeploymentConfig",

  @doc("ResourceType enum AWS::CodeDeploy::DeploymentGroup")
  AWSCodeDeployDeploymentGroup: "AWS::CodeDeploy::DeploymentGroup",

  @doc("ResourceType enum AWS::CodeGuruProfiler::ProfilingGroup")
  AWSCodeGuruProfilerProfilingGroup: "AWS::CodeGuruProfiler::ProfilingGroup",

  @doc("ResourceType enum AWS::CodeGuruReviewer::RepositoryAssociation")
  AWSCodeGuruReviewerRepositoryAssociation: "AWS::CodeGuruReviewer::RepositoryAssociation",

  @doc("ResourceType enum AWS::CodePipeline::Pipeline")
  AWSCodePipelinePipeline: "AWS::CodePipeline::Pipeline",

  @doc("ResourceType enum AWS::Cognito::UserPool")
  AWSCognitoUserPool: "AWS::Cognito::UserPool",

  @doc("ResourceType enum AWS::Cognito::UserPoolClient")
  AWSCognitoUserPoolClient: "AWS::Cognito::UserPoolClient",

  @doc("ResourceType enum AWS::Cognito::UserPoolGroup")
  AWSCognitoUserPoolGroup: "AWS::Cognito::UserPoolGroup",

  @doc("ResourceType enum AWS::Config::ConformancePackCompliance")
  AWSConfigConformancePackCompliance: "AWS::Config::ConformancePackCompliance",

  @doc("ResourceType enum AWS::Config::ResourceCompliance")
  AWSConfigResourceCompliance: "AWS::Config::ResourceCompliance",

  @doc("ResourceType enum AWS::Connect::Instance")
  AWSConnectInstance: "AWS::Connect::Instance",

  @doc("ResourceType enum AWS::Connect::PhoneNumber")
  AWSConnectPhoneNumber: "AWS::Connect::PhoneNumber",

  @doc("ResourceType enum AWS::Connect::QuickConnect")
  AWSConnectQuickConnect: "AWS::Connect::QuickConnect",

  @doc("ResourceType enum AWS::CustomerProfiles::Domain")
  AWSCustomerProfilesDomain: "AWS::CustomerProfiles::Domain",

  @doc("ResourceType enum AWS::CustomerProfiles::ObjectType")
  AWSCustomerProfilesObjectType: "AWS::CustomerProfiles::ObjectType",

  @doc("ResourceType enum AWS::DMS::Certificate")
  AWSDMSCertificate: "AWS::DMS::Certificate",

  @doc("ResourceType enum AWS::DMS::Endpoint")
  AWSDMSEndpoint: "AWS::DMS::Endpoint",

  @doc("ResourceType enum AWS::DMS::EventSubscription")
  AWSDMSEventSubscription: "AWS::DMS::EventSubscription",

  @doc("ResourceType enum AWS::DMS::ReplicationSubnetGroup")
  AWSDMSReplicationSubnetGroup: "AWS::DMS::ReplicationSubnetGroup",

  @doc("ResourceType enum AWS::DataSync::LocationEFS")
  AWSDataSyncLocationEFS: "AWS::DataSync::LocationEFS",

  @doc("ResourceType enum AWS::DataSync::LocationFSxLustre")
  AWSDataSyncLocationFSxLustre: "AWS::DataSync::LocationFSxLustre",

  @doc("ResourceType enum AWS::DataSync::LocationFSxWindows")
  AWSDataSyncLocationFSxWindows: "AWS::DataSync::LocationFSxWindows",

  @doc("ResourceType enum AWS::DataSync::LocationHDFS")
  AWSDataSyncLocationHDFS: "AWS::DataSync::LocationHDFS",

  @doc("ResourceType enum AWS::DataSync::LocationNFS")
  AWSDataSyncLocationNFS: "AWS::DataSync::LocationNFS",

  @doc("ResourceType enum AWS::DataSync::LocationObjectStorage")
  AWSDataSyncLocationObjectStorage: "AWS::DataSync::LocationObjectStorage",

  @doc("ResourceType enum AWS::DataSync::LocationS3")
  AWSDataSyncLocationS3: "AWS::DataSync::LocationS3",

  @doc("ResourceType enum AWS::DataSync::LocationSMB")
  AWSDataSyncLocationSMB: "AWS::DataSync::LocationSMB",

  @doc("ResourceType enum AWS::DataSync::Task")
  AWSDataSyncTask: "AWS::DataSync::Task",

  @doc("ResourceType enum AWS::Detective::Graph")
  AWSDetectiveGraph: "AWS::Detective::Graph",

  @doc("ResourceType enum AWS::DeviceFarm::InstanceProfile")
  AWSDeviceFarmInstanceProfile: "AWS::DeviceFarm::InstanceProfile",

  @doc("ResourceType enum AWS::DeviceFarm::Project")
  AWSDeviceFarmProject: "AWS::DeviceFarm::Project",

  @doc("ResourceType enum AWS::DeviceFarm::TestGridProject")
  AWSDeviceFarmTestGridProject: "AWS::DeviceFarm::TestGridProject",

  @doc("ResourceType enum AWS::DynamoDB::Table")
  AWSDynamoDBTable: "AWS::DynamoDB::Table",

  @doc("ResourceType enum AWS::EC2::CapacityReservation")
  AWSEC2CapacityReservation: "AWS::EC2::CapacityReservation",

  @doc("ResourceType enum AWS::EC2::CarrierGateway")
  AWSEC2CarrierGateway: "AWS::EC2::CarrierGateway",

  @doc("ResourceType enum AWS::EC2::ClientVpnEndpoint")
  AWSEC2ClientVpnEndpoint: "AWS::EC2::ClientVpnEndpoint",

  @doc("ResourceType enum AWS::EC2::CustomerGateway")
  AWSEC2CustomerGateway: "AWS::EC2::CustomerGateway",

  @doc("ResourceType enum AWS::EC2::DHCPOptions")
  AWSEC2DHCPOptions: "AWS::EC2::DHCPOptions",

  @doc("ResourceType enum AWS::EC2::EC2Fleet")
  AWSEC2EC2Fleet: "AWS::EC2::EC2Fleet",

  @doc("ResourceType enum AWS::EC2::EIP")
  AWSEC2EIP: "AWS::EC2::EIP",

  @doc("ResourceType enum AWS::EC2::EgressOnlyInternetGateway")
  AWSEC2EgressOnlyInternetGateway: "AWS::EC2::EgressOnlyInternetGateway",

  @doc("ResourceType enum AWS::EC2::FlowLog")
  AWSEC2FlowLog: "AWS::EC2::FlowLog",

  @doc("ResourceType enum AWS::EC2::Host")
  AWSEC2Host: "AWS::EC2::Host",

  @doc("ResourceType enum AWS::EC2::IPAM")
  AWSEC2IPAM: "AWS::EC2::IPAM",

  @doc("ResourceType enum AWS::EC2::IPAMPool")
  AWSEC2IPAMPool: "AWS::EC2::IPAMPool",

  @doc("ResourceType enum AWS::EC2::IPAMScope")
  AWSEC2IPAMScope: "AWS::EC2::IPAMScope",

  @doc("ResourceType enum AWS::EC2::Instance")
  AWSEC2Instance: "AWS::EC2::Instance",

  @doc("ResourceType enum AWS::EC2::InternetGateway")
  AWSEC2InternetGateway: "AWS::EC2::InternetGateway",

  @doc("ResourceType enum AWS::EC2::LaunchTemplate")
  AWSEC2LaunchTemplate: "AWS::EC2::LaunchTemplate",

  @doc("ResourceType enum AWS::EC2::NatGateway")
  AWSEC2NatGateway: "AWS::EC2::NatGateway",

  @doc("ResourceType enum AWS::EC2::NetworkAcl")
  AWSEC2NetworkAcl: "AWS::EC2::NetworkAcl",

  @doc("ResourceType enum AWS::EC2::NetworkInsightsAccessScope")
  AWSEC2NetworkInsightsAccessScope: "AWS::EC2::NetworkInsightsAccessScope",

  @doc("ResourceType enum AWS::EC2::NetworkInsightsAccessScopeAnalysis")
  AWSEC2NetworkInsightsAccessScopeAnalysis: "AWS::EC2::NetworkInsightsAccessScopeAnalysis",

  @doc("ResourceType enum AWS::EC2::NetworkInsightsAnalysis")
  AWSEC2NetworkInsightsAnalysis: "AWS::EC2::NetworkInsightsAnalysis",

  @doc("ResourceType enum AWS::EC2::NetworkInsightsPath")
  AWSEC2NetworkInsightsPath: "AWS::EC2::NetworkInsightsPath",

  @doc("ResourceType enum AWS::EC2::NetworkInterface")
  AWSEC2NetworkInterface: "AWS::EC2::NetworkInterface",

  @doc("ResourceType enum AWS::EC2::PrefixList")
  AWSEC2PrefixList: "AWS::EC2::PrefixList",

  @doc("ResourceType enum AWS::EC2::RegisteredHAInstance")
  AWSEC2RegisteredHAInstance: "AWS::EC2::RegisteredHAInstance",

  @doc("ResourceType enum AWS::EC2::RouteTable")
  AWSEC2RouteTable: "AWS::EC2::RouteTable",

  @doc("ResourceType enum AWS::EC2::SecurityGroup")
  AWSEC2SecurityGroup: "AWS::EC2::SecurityGroup",

  @doc("ResourceType enum AWS::EC2::SpotFleet")
  AWSEC2SpotFleet: "AWS::EC2::SpotFleet",

  @doc("ResourceType enum AWS::EC2::Subnet")
  AWSEC2Subnet: "AWS::EC2::Subnet",

  @doc("ResourceType enum AWS::EC2::SubnetRouteTableAssociation")
  AWSEC2SubnetRouteTableAssociation: "AWS::EC2::SubnetRouteTableAssociation",

  @doc("ResourceType enum AWS::EC2::TrafficMirrorFilter")
  AWSEC2TrafficMirrorFilter: "AWS::EC2::TrafficMirrorFilter",

  @doc("ResourceType enum AWS::EC2::TrafficMirrorSession")
  AWSEC2TrafficMirrorSession: "AWS::EC2::TrafficMirrorSession",

  @doc("ResourceType enum AWS::EC2::TrafficMirrorTarget")
  AWSEC2TrafficMirrorTarget: "AWS::EC2::TrafficMirrorTarget",

  @doc("ResourceType enum AWS::EC2::TransitGateway")
  AWSEC2TransitGateway: "AWS::EC2::TransitGateway",

  @doc("ResourceType enum AWS::EC2::TransitGatewayAttachment")
  AWSEC2TransitGatewayAttachment: "AWS::EC2::TransitGatewayAttachment",

  @doc("ResourceType enum AWS::EC2::TransitGatewayConnect")
  AWSEC2TransitGatewayConnect: "AWS::EC2::TransitGatewayConnect",

  @doc("ResourceType enum AWS::EC2::TransitGatewayMulticastDomain")
  AWSEC2TransitGatewayMulticastDomain: "AWS::EC2::TransitGatewayMulticastDomain",

  @doc("ResourceType enum AWS::EC2::TransitGatewayRouteTable")
  AWSEC2TransitGatewayRouteTable: "AWS::EC2::TransitGatewayRouteTable",

  @doc("ResourceType enum AWS::EC2::VPC")
  AWSEC2VPC: "AWS::EC2::VPC",

  @doc("ResourceType enum AWS::EC2::VPCEndpoint")
  AWSEC2VPCEndpoint: "AWS::EC2::VPCEndpoint",

  @doc("ResourceType enum AWS::EC2::VPCEndpointService")
  AWSEC2VPCEndpointService: "AWS::EC2::VPCEndpointService",

  @doc("ResourceType enum AWS::EC2::VPCPeeringConnection")
  AWSEC2VPCPeeringConnection: "AWS::EC2::VPCPeeringConnection",

  @doc("ResourceType enum AWS::EC2::VPNConnection")
  AWSEC2VPNConnection: "AWS::EC2::VPNConnection",

  @doc("ResourceType enum AWS::EC2::VPNGateway")
  AWSEC2VPNGateway: "AWS::EC2::VPNGateway",

  @doc("ResourceType enum AWS::EC2::Volume")
  AWSEC2Volume: "AWS::EC2::Volume",

  @doc("ResourceType enum AWS::ECR::PublicRepository")
  AWSECRPublicRepository: "AWS::ECR::PublicRepository",

  @doc("ResourceType enum AWS::ECR::PullThroughCacheRule")
  AWSECRPullThroughCacheRule: "AWS::ECR::PullThroughCacheRule",

  @doc("ResourceType enum AWS::ECR::RegistryPolicy")
  AWSECRRegistryPolicy: "AWS::ECR::RegistryPolicy",

  @doc("ResourceType enum AWS::ECR::Repository")
  AWSECRRepository: "AWS::ECR::Repository",

  @doc("ResourceType enum AWS::ECS::CapacityProvider")
  AWSECSCapacityProvider: "AWS::ECS::CapacityProvider",

  @doc("ResourceType enum AWS::ECS::Cluster")
  AWSECSCluster: "AWS::ECS::Cluster",

  @doc("ResourceType enum AWS::ECS::Service")
  AWSECSService: "AWS::ECS::Service",

  @doc("ResourceType enum AWS::ECS::TaskDefinition")
  AWSECSTaskDefinition: "AWS::ECS::TaskDefinition",

  @doc("ResourceType enum AWS::ECS::TaskSet")
  AWSECSTaskSet: "AWS::ECS::TaskSet",

  @doc("ResourceType enum AWS::EFS::AccessPoint")
  AWSEFSAccessPoint: "AWS::EFS::AccessPoint",

  @doc("ResourceType enum AWS::EFS::FileSystem")
  AWSEFSFileSystem: "AWS::EFS::FileSystem",

  @doc("ResourceType enum AWS::EKS::Addon")
  AWSEKSAddon: "AWS::EKS::Addon",

  @doc("ResourceType enum AWS::EKS::Cluster")
  AWSEKSCluster: "AWS::EKS::Cluster",

  @doc("ResourceType enum AWS::EKS::FargateProfile")
  AWSEKSFargateProfile: "AWS::EKS::FargateProfile",

  @doc("ResourceType enum AWS::EKS::IdentityProviderConfig")
  AWSEKSIdentityProviderConfig: "AWS::EKS::IdentityProviderConfig",

  @doc("ResourceType enum AWS::EMR::SecurityConfiguration")
  AWSEMRSecurityConfiguration: "AWS::EMR::SecurityConfiguration",

  @doc("ResourceType enum AWS::ElasticBeanstalk::Application")
  AWSElasticBeanstalkApplication: "AWS::ElasticBeanstalk::Application",

  @doc("ResourceType enum AWS::ElasticBeanstalk::ApplicationVersion")
  AWSElasticBeanstalkApplicationVersion: "AWS::ElasticBeanstalk::ApplicationVersion",

  @doc("ResourceType enum AWS::ElasticBeanstalk::Environment")
  AWSElasticBeanstalkEnvironment: "AWS::ElasticBeanstalk::Environment",

  @doc("ResourceType enum AWS::ElasticLoadBalancing::LoadBalancer")
  AWSElasticLoadBalancingLoadBalancer: "AWS::ElasticLoadBalancing::LoadBalancer",

  @doc("ResourceType enum AWS::ElasticLoadBalancingV2::Listener")
  AWSElasticLoadBalancingV2Listener: "AWS::ElasticLoadBalancingV2::Listener",

  @doc("ResourceType enum AWS::ElasticLoadBalancingV2::LoadBalancer")
  AWSElasticLoadBalancingV2LoadBalancer: "AWS::ElasticLoadBalancingV2::LoadBalancer",

  @doc("ResourceType enum AWS::Elasticsearch::Domain")
  AWSElasticsearchDomain: "AWS::Elasticsearch::Domain",

  @doc("ResourceType enum AWS::EventSchemas::Discoverer")
  AWSEventSchemasDiscoverer: "AWS::EventSchemas::Discoverer",

  @doc("ResourceType enum AWS::EventSchemas::Registry")
  AWSEventSchemasRegistry: "AWS::EventSchemas::Registry",

  @doc("ResourceType enum AWS::EventSchemas::RegistryPolicy")
  AWSEventSchemasRegistryPolicy: "AWS::EventSchemas::RegistryPolicy",

  @doc("ResourceType enum AWS::EventSchemas::Schema")
  AWSEventSchemasSchema: "AWS::EventSchemas::Schema",

  @doc("ResourceType enum AWS::Events::ApiDestination")
  AWSEventsApiDestination: "AWS::Events::ApiDestination",

  @doc("ResourceType enum AWS::Events::Archive")
  AWSEventsArchive: "AWS::Events::Archive",

  @doc("ResourceType enum AWS::Events::Connection")
  AWSEventsConnection: "AWS::Events::Connection",

  @doc("ResourceType enum AWS::Events::Endpoint")
  AWSEventsEndpoint: "AWS::Events::Endpoint",

  @doc("ResourceType enum AWS::Events::EventBus")
  AWSEventsEventBus: "AWS::Events::EventBus",

  @doc("ResourceType enum AWS::Events::Rule")
  AWSEventsRule: "AWS::Events::Rule",

  @doc("ResourceType enum AWS::Evidently::Launch")
  AWSEvidentlyLaunch: "AWS::Evidently::Launch",

  @doc("ResourceType enum AWS::Evidently::Project")
  AWSEvidentlyProject: "AWS::Evidently::Project",

  @doc("ResourceType enum AWS::FIS::ExperimentTemplate")
  AWSFISExperimentTemplate: "AWS::FIS::ExperimentTemplate",

  @doc("ResourceType enum AWS::Forecast::Dataset")
  AWSForecastDataset: "AWS::Forecast::Dataset",

  @doc("ResourceType enum AWS::Forecast::DatasetGroup")
  AWSForecastDatasetGroup: "AWS::Forecast::DatasetGroup",

  @doc("ResourceType enum AWS::FraudDetector::EntityType")
  AWSFraudDetectorEntityType: "AWS::FraudDetector::EntityType",

  @doc("ResourceType enum AWS::FraudDetector::Label")
  AWSFraudDetectorLabel: "AWS::FraudDetector::Label",

  @doc("ResourceType enum AWS::FraudDetector::Outcome")
  AWSFraudDetectorOutcome: "AWS::FraudDetector::Outcome",

  @doc("ResourceType enum AWS::FraudDetector::Variable")
  AWSFraudDetectorVariable: "AWS::FraudDetector::Variable",

  @doc("ResourceType enum AWS::GlobalAccelerator::Accelerator")
  AWSGlobalAcceleratorAccelerator: "AWS::GlobalAccelerator::Accelerator",

  @doc("ResourceType enum AWS::GlobalAccelerator::EndpointGroup")
  AWSGlobalAcceleratorEndpointGroup: "AWS::GlobalAccelerator::EndpointGroup",

  @doc("ResourceType enum AWS::GlobalAccelerator::Listener")
  AWSGlobalAcceleratorListener: "AWS::GlobalAccelerator::Listener",

  @doc("ResourceType enum AWS::Glue::Classifier")
  AWSGlueClassifier: "AWS::Glue::Classifier",

  @doc("ResourceType enum AWS::Glue::Job")
  AWSGlueJob: "AWS::Glue::Job",

  @doc("ResourceType enum AWS::Glue::MLTransform")
  AWSGlueMLTransform: "AWS::Glue::MLTransform",

  @doc("ResourceType enum AWS::Grafana::Workspace")
  AWSGrafanaWorkspace: "AWS::Grafana::Workspace",

  @doc("ResourceType enum AWS::GreengrassV2::ComponentVersion")
  AWSGreengrassV2ComponentVersion: "AWS::GreengrassV2::ComponentVersion",

  @doc("ResourceType enum AWS::GroundStation::Config")
  AWSGroundStationConfig: "AWS::GroundStation::Config",

  @doc("ResourceType enum AWS::GroundStation::DataflowEndpointGroup")
  AWSGroundStationDataflowEndpointGroup: "AWS::GroundStation::DataflowEndpointGroup",

  @doc("ResourceType enum AWS::GroundStation::MissionProfile")
  AWSGroundStationMissionProfile: "AWS::GroundStation::MissionProfile",

  @doc("ResourceType enum AWS::GuardDuty::Detector")
  AWSGuardDutyDetector: "AWS::GuardDuty::Detector",

  @doc("ResourceType enum AWS::GuardDuty::Filter")
  AWSGuardDutyFilter: "AWS::GuardDuty::Filter",

  @doc("ResourceType enum AWS::GuardDuty::IPSet")
  AWSGuardDutyIPSet: "AWS::GuardDuty::IPSet",

  @doc("ResourceType enum AWS::GuardDuty::ThreatIntelSet")
  AWSGuardDutyThreatIntelSet: "AWS::GuardDuty::ThreatIntelSet",

  @doc("ResourceType enum AWS::HealthLake::FHIRDatastore")
  AWSHealthLakeFHIRDatastore: "AWS::HealthLake::FHIRDatastore",

  @doc("ResourceType enum AWS::IAM::Group")
  AWSIAMGroup: "AWS::IAM::Group",

  @doc("ResourceType enum AWS::IAM::InstanceProfile")
  AWSIAMInstanceProfile: "AWS::IAM::InstanceProfile",

  @doc("ResourceType enum AWS::IAM::Policy")
  AWSIAMPolicy: "AWS::IAM::Policy",

  @doc("ResourceType enum AWS::IAM::Role")
  AWSIAMRole: "AWS::IAM::Role",

  @doc("ResourceType enum AWS::IAM::SAMLProvider")
  AWSIAMSAMLProvider: "AWS::IAM::SAMLProvider",

  @doc("ResourceType enum AWS::IAM::ServerCertificate")
  AWSIAMServerCertificate: "AWS::IAM::ServerCertificate",

  @doc("ResourceType enum AWS::IAM::User")
  AWSIAMUser: "AWS::IAM::User",

  @doc("ResourceType enum AWS::IVS::Channel")
  AWSIVSChannel: "AWS::IVS::Channel",

  @doc("ResourceType enum AWS::IVS::PlaybackKeyPair")
  AWSIVSPlaybackKeyPair: "AWS::IVS::PlaybackKeyPair",

  @doc("ResourceType enum AWS::IVS::RecordingConfiguration")
  AWSIVSRecordingConfiguration: "AWS::IVS::RecordingConfiguration",

  @doc("ResourceType enum AWS::ImageBuilder::ContainerRecipe")
  AWSImageBuilderContainerRecipe: "AWS::ImageBuilder::ContainerRecipe",

  @doc("ResourceType enum AWS::ImageBuilder::DistributionConfiguration")
  AWSImageBuilderDistributionConfiguration: "AWS::ImageBuilder::DistributionConfiguration",

  @doc("ResourceType enum AWS::ImageBuilder::ImagePipeline")
  AWSImageBuilderImagePipeline: "AWS::ImageBuilder::ImagePipeline",

  @doc("ResourceType enum AWS::ImageBuilder::ImageRecipe")
  AWSImageBuilderImageRecipe: "AWS::ImageBuilder::ImageRecipe",

  @doc("ResourceType enum AWS::ImageBuilder::InfrastructureConfiguration")
  AWSImageBuilderInfrastructureConfiguration: "AWS::ImageBuilder::InfrastructureConfiguration",

  @doc("ResourceType enum AWS::InspectorV2::Filter")
  AWSInspectorV2Filter: "AWS::InspectorV2::Filter",

  @doc("ResourceType enum AWS::IoT::AccountAuditConfiguration")
  AWSIoTAccountAuditConfiguration: "AWS::IoT::AccountAuditConfiguration",

  @doc("ResourceType enum AWS::IoT::Authorizer")
  AWSIoTAuthorizer: "AWS::IoT::Authorizer",

  @doc("ResourceType enum AWS::IoT::CACertificate")
  AWSIoTCACertificate: "AWS::IoT::CACertificate",

  @doc("ResourceType enum AWS::IoT::CustomMetric")
  AWSIoTCustomMetric: "AWS::IoT::CustomMetric",

  @doc("ResourceType enum AWS::IoT::Dimension")
  AWSIoTDimension: "AWS::IoT::Dimension",

  @doc("ResourceType enum AWS::IoT::FleetMetric")
  AWSIoTFleetMetric: "AWS::IoT::FleetMetric",

  @doc("ResourceType enum AWS::IoT::JobTemplate")
  AWSIoTJobTemplate: "AWS::IoT::JobTemplate",

  @doc("ResourceType enum AWS::IoT::MitigationAction")
  AWSIoTMitigationAction: "AWS::IoT::MitigationAction",

  @doc("ResourceType enum AWS::IoT::Policy")
  AWSIoTPolicy: "AWS::IoT::Policy",

  @doc("ResourceType enum AWS::IoT::ProvisioningTemplate")
  AWSIoTProvisioningTemplate: "AWS::IoT::ProvisioningTemplate",

  @doc("ResourceType enum AWS::IoT::RoleAlias")
  AWSIoTRoleAlias: "AWS::IoT::RoleAlias",

  @doc("ResourceType enum AWS::IoT::ScheduledAudit")
  AWSIoTScheduledAudit: "AWS::IoT::ScheduledAudit",

  @doc("ResourceType enum AWS::IoT::SecurityProfile")
  AWSIoTSecurityProfile: "AWS::IoT::SecurityProfile",

  @doc("ResourceType enum AWS::IoTAnalytics::Channel")
  AWSIoTAnalyticsChannel: "AWS::IoTAnalytics::Channel",

  @doc("ResourceType enum AWS::IoTAnalytics::Dataset")
  AWSIoTAnalyticsDataset: "AWS::IoTAnalytics::Dataset",

  @doc("ResourceType enum AWS::IoTAnalytics::Datastore")
  AWSIoTAnalyticsDatastore: "AWS::IoTAnalytics::Datastore",

  @doc("ResourceType enum AWS::IoTAnalytics::Pipeline")
  AWSIoTAnalyticsPipeline: "AWS::IoTAnalytics::Pipeline",

  @doc("ResourceType enum AWS::IoTEvents::AlarmModel")
  AWSIoTEventsAlarmModel: "AWS::IoTEvents::AlarmModel",

  @doc("ResourceType enum AWS::IoTEvents::DetectorModel")
  AWSIoTEventsDetectorModel: "AWS::IoTEvents::DetectorModel",

  @doc("ResourceType enum AWS::IoTEvents::Input")
  AWSIoTEventsInput: "AWS::IoTEvents::Input",

  @doc("ResourceType enum AWS::IoTSiteWise::AssetModel")
  AWSIoTSiteWiseAssetModel: "AWS::IoTSiteWise::AssetModel",

  @doc("ResourceType enum AWS::IoTSiteWise::Dashboard")
  AWSIoTSiteWiseDashboard: "AWS::IoTSiteWise::Dashboard",

  @doc("ResourceType enum AWS::IoTSiteWise::Gateway")
  AWSIoTSiteWiseGateway: "AWS::IoTSiteWise::Gateway",

  @doc("ResourceType enum AWS::IoTSiteWise::Portal")
  AWSIoTSiteWisePortal: "AWS::IoTSiteWise::Portal",

  @doc("ResourceType enum AWS::IoTSiteWise::Project")
  AWSIoTSiteWiseProject: "AWS::IoTSiteWise::Project",

  @doc("ResourceType enum AWS::IoTTwinMaker::ComponentType")
  AWSIoTTwinMakerComponentType: "AWS::IoTTwinMaker::ComponentType",

  @doc("ResourceType enum AWS::IoTTwinMaker::Entity")
  AWSIoTTwinMakerEntity: "AWS::IoTTwinMaker::Entity",

  @doc("ResourceType enum AWS::IoTTwinMaker::Scene")
  AWSIoTTwinMakerScene: "AWS::IoTTwinMaker::Scene",

  @doc("ResourceType enum AWS::IoTTwinMaker::SyncJob")
  AWSIoTTwinMakerSyncJob: "AWS::IoTTwinMaker::SyncJob",

  @doc("ResourceType enum AWS::IoTTwinMaker::Workspace")
  AWSIoTTwinMakerWorkspace: "AWS::IoTTwinMaker::Workspace",

  @doc("ResourceType enum AWS::IoTWireless::FuotaTask")
  AWSIoTWirelessFuotaTask: "AWS::IoTWireless::FuotaTask",

  @doc("ResourceType enum AWS::IoTWireless::MulticastGroup")
  AWSIoTWirelessMulticastGroup: "AWS::IoTWireless::MulticastGroup",

  @doc("ResourceType enum AWS::IoTWireless::ServiceProfile")
  AWSIoTWirelessServiceProfile: "AWS::IoTWireless::ServiceProfile",

  @doc("ResourceType enum AWS::KMS::Alias")
  AWSKMSAlias: "AWS::KMS::Alias",

  @doc("ResourceType enum AWS::KMS::Key")
  AWSKMSKey: "AWS::KMS::Key",

  @doc("ResourceType enum AWS::KafkaConnect::Connector")
  AWSKafkaConnectConnector: "AWS::KafkaConnect::Connector",

  @doc("ResourceType enum AWS::Kendra::Index")
  AWSKendraIndex: "AWS::Kendra::Index",

  @doc("ResourceType enum AWS::Kinesis::Stream")
  AWSKinesisStream: "AWS::Kinesis::Stream",

  @doc("ResourceType enum AWS::Kinesis::StreamConsumer")
  AWSKinesisStreamConsumer: "AWS::Kinesis::StreamConsumer",

  @doc("ResourceType enum AWS::KinesisAnalyticsV2::Application")
  AWSKinesisAnalyticsV2Application: "AWS::KinesisAnalyticsV2::Application",

  @doc("ResourceType enum AWS::KinesisFirehose::DeliveryStream")
  AWSKinesisFirehoseDeliveryStream: "AWS::KinesisFirehose::DeliveryStream",

  @doc("ResourceType enum AWS::KinesisVideo::SignalingChannel")
  AWSKinesisVideoSignalingChannel: "AWS::KinesisVideo::SignalingChannel",

  @doc("ResourceType enum AWS::KinesisVideo::Stream")
  AWSKinesisVideoStream: "AWS::KinesisVideo::Stream",

  @doc("ResourceType enum AWS::Lambda::CodeSigningConfig")
  AWSLambdaCodeSigningConfig: "AWS::Lambda::CodeSigningConfig",

  @doc("ResourceType enum AWS::Lambda::Function")
  AWSLambdaFunction: "AWS::Lambda::Function",

  @doc("ResourceType enum AWS::Lex::Bot")
  AWSLexBot: "AWS::Lex::Bot",

  @doc("ResourceType enum AWS::Lex::BotAlias")
  AWSLexBotAlias: "AWS::Lex::BotAlias",

  @doc("ResourceType enum AWS::Lightsail::Bucket")
  AWSLightsailBucket: "AWS::Lightsail::Bucket",

  @doc("ResourceType enum AWS::Lightsail::Certificate")
  AWSLightsailCertificate: "AWS::Lightsail::Certificate",

  @doc("ResourceType enum AWS::Lightsail::Disk")
  AWSLightsailDisk: "AWS::Lightsail::Disk",

  @doc("ResourceType enum AWS::Lightsail::StaticIp")
  AWSLightsailStaticIp: "AWS::Lightsail::StaticIp",

  @doc("ResourceType enum AWS::Logs::Destination")
  AWSLogsDestination: "AWS::Logs::Destination",

  @doc("ResourceType enum AWS::LookoutMetrics::Alert")
  AWSLookoutMetricsAlert: "AWS::LookoutMetrics::Alert",

  @doc("ResourceType enum AWS::LookoutVision::Project")
  AWSLookoutVisionProject: "AWS::LookoutVision::Project",

  @doc("ResourceType enum AWS::M2::Environment")
  AWSM2Environment: "AWS::M2::Environment",

  @doc("ResourceType enum AWS::MSK::BatchScramSecret")
  AWSMSKBatchScramSecret: "AWS::MSK::BatchScramSecret",

  @doc("ResourceType enum AWS::MSK::Cluster")
  AWSMSKCluster: "AWS::MSK::Cluster",

  @doc("ResourceType enum AWS::MSK::Configuration")
  AWSMSKConfiguration: "AWS::MSK::Configuration",

  @doc("ResourceType enum AWS::MediaConnect::FlowEntitlement")
  AWSMediaConnectFlowEntitlement: "AWS::MediaConnect::FlowEntitlement",

  @doc("ResourceType enum AWS::MediaConnect::FlowSource")
  AWSMediaConnectFlowSource: "AWS::MediaConnect::FlowSource",

  @doc("ResourceType enum AWS::MediaConnect::FlowVpcInterface")
  AWSMediaConnectFlowVpcInterface: "AWS::MediaConnect::FlowVpcInterface",

  @doc("ResourceType enum AWS::MediaPackage::PackagingConfiguration")
  AWSMediaPackagePackagingConfiguration: "AWS::MediaPackage::PackagingConfiguration",

  @doc("ResourceType enum AWS::MediaPackage::PackagingGroup")
  AWSMediaPackagePackagingGroup: "AWS::MediaPackage::PackagingGroup",

  @doc("ResourceType enum AWS::MediaTailor::PlaybackConfiguration")
  AWSMediaTailorPlaybackConfiguration: "AWS::MediaTailor::PlaybackConfiguration",

  @doc("ResourceType enum AWS::NetworkFirewall::Firewall")
  AWSNetworkFirewallFirewall: "AWS::NetworkFirewall::Firewall",

  @doc("ResourceType enum AWS::NetworkFirewall::FirewallPolicy")
  AWSNetworkFirewallFirewallPolicy: "AWS::NetworkFirewall::FirewallPolicy",

  @doc("ResourceType enum AWS::NetworkFirewall::RuleGroup")
  AWSNetworkFirewallRuleGroup: "AWS::NetworkFirewall::RuleGroup",

  @doc("ResourceType enum AWS::NetworkManager::ConnectPeer")
  AWSNetworkManagerConnectPeer: "AWS::NetworkManager::ConnectPeer",

  @doc("ResourceType enum AWS::NetworkManager::CustomerGatewayAssociation")
  AWSNetworkManagerCustomerGatewayAssociation: "AWS::NetworkManager::CustomerGatewayAssociation",

  @doc("ResourceType enum AWS::NetworkManager::Device")
  AWSNetworkManagerDevice: "AWS::NetworkManager::Device",

  @doc("ResourceType enum AWS::NetworkManager::GlobalNetwork")
  AWSNetworkManagerGlobalNetwork: "AWS::NetworkManager::GlobalNetwork",

  @doc("ResourceType enum AWS::NetworkManager::Link")
  AWSNetworkManagerLink: "AWS::NetworkManager::Link",

  @doc("ResourceType enum AWS::NetworkManager::LinkAssociation")
  AWSNetworkManagerLinkAssociation: "AWS::NetworkManager::LinkAssociation",

  @doc("ResourceType enum AWS::NetworkManager::Site")
  AWSNetworkManagerSite: "AWS::NetworkManager::Site",

  @doc("ResourceType enum AWS::NetworkManager::TransitGatewayRegistration")
  AWSNetworkManagerTransitGatewayRegistration: "AWS::NetworkManager::TransitGatewayRegistration",

  @doc("ResourceType enum AWS::OpenSearch::Domain")
  AWSOpenSearchDomain: "AWS::OpenSearch::Domain",

  @doc("ResourceType enum AWS::Panorama::Package")
  AWSPanoramaPackage: "AWS::Panorama::Package",

  @doc("ResourceType enum AWS::Personalize::Dataset")
  AWSPersonalizeDataset: "AWS::Personalize::Dataset",

  @doc("ResourceType enum AWS::Personalize::DatasetGroup")
  AWSPersonalizeDatasetGroup: "AWS::Personalize::DatasetGroup",

  @doc("ResourceType enum AWS::Personalize::Schema")
  AWSPersonalizeSchema: "AWS::Personalize::Schema",

  @doc("ResourceType enum AWS::Personalize::Solution")
  AWSPersonalizeSolution: "AWS::Personalize::Solution",

  @doc("ResourceType enum AWS::Pinpoint::App")
  AWSPinpointApp: "AWS::Pinpoint::App",

  @doc("ResourceType enum AWS::Pinpoint::ApplicationSettings")
  AWSPinpointApplicationSettings: "AWS::Pinpoint::ApplicationSettings",

  @doc("ResourceType enum AWS::Pinpoint::Campaign")
  AWSPinpointCampaign: "AWS::Pinpoint::Campaign",

  @doc("ResourceType enum AWS::Pinpoint::EmailChannel")
  AWSPinpointEmailChannel: "AWS::Pinpoint::EmailChannel",

  @doc("ResourceType enum AWS::Pinpoint::EmailTemplate")
  AWSPinpointEmailTemplate: "AWS::Pinpoint::EmailTemplate",

  @doc("ResourceType enum AWS::Pinpoint::EventStream")
  AWSPinpointEventStream: "AWS::Pinpoint::EventStream",

  @doc("ResourceType enum AWS::Pinpoint::InAppTemplate")
  AWSPinpointInAppTemplate: "AWS::Pinpoint::InAppTemplate",

  @doc("ResourceType enum AWS::Pinpoint::Segment")
  AWSPinpointSegment: "AWS::Pinpoint::Segment",

  @doc("ResourceType enum AWS::QLDB::Ledger")
  AWSQLDBLedger: "AWS::QLDB::Ledger",

  @doc("ResourceType enum AWS::QuickSight::DataSource")
  AWSQuickSightDataSource: "AWS::QuickSight::DataSource",

  @doc("ResourceType enum AWS::QuickSight::Template")
  AWSQuickSightTemplate: "AWS::QuickSight::Template",

  @doc("ResourceType enum AWS::QuickSight::Theme")
  AWSQuickSightTheme: "AWS::QuickSight::Theme",

  @doc("ResourceType enum AWS::RDS::DBCluster")
  AWSRDSDBCluster: "AWS::RDS::DBCluster",

  @doc("ResourceType enum AWS::RDS::DBClusterSnapshot")
  AWSRDSDBClusterSnapshot: "AWS::RDS::DBClusterSnapshot",

  @doc("ResourceType enum AWS::RDS::DBInstance")
  AWSRDSDBInstance: "AWS::RDS::DBInstance",

  @doc("ResourceType enum AWS::RDS::DBSecurityGroup")
  AWSRDSDBSecurityGroup: "AWS::RDS::DBSecurityGroup",

  @doc("ResourceType enum AWS::RDS::DBSnapshot")
  AWSRDSDBSnapshot: "AWS::RDS::DBSnapshot",

  @doc("ResourceType enum AWS::RDS::DBSubnetGroup")
  AWSRDSDBSubnetGroup: "AWS::RDS::DBSubnetGroup",

  @doc("ResourceType enum AWS::RDS::EventSubscription")
  AWSRDSEventSubscription: "AWS::RDS::EventSubscription",

  @doc("ResourceType enum AWS::RDS::GlobalCluster")
  AWSRDSGlobalCluster: "AWS::RDS::GlobalCluster",

  @doc("ResourceType enum AWS::RDS::OptionGroup")
  AWSRDSOptionGroup: "AWS::RDS::OptionGroup",

  @doc("ResourceType enum AWS::RUM::AppMonitor")
  AWSRUMAppMonitor: "AWS::RUM::AppMonitor",

  @doc("ResourceType enum AWS::Redshift::Cluster")
  AWSRedshiftCluster: "AWS::Redshift::Cluster",

  @doc("ResourceType enum AWS::Redshift::ClusterParameterGroup")
  AWSRedshiftClusterParameterGroup: "AWS::Redshift::ClusterParameterGroup",

  @doc("ResourceType enum AWS::Redshift::ClusterSecurityGroup")
  AWSRedshiftClusterSecurityGroup: "AWS::Redshift::ClusterSecurityGroup",

  @doc("ResourceType enum AWS::Redshift::ClusterSnapshot")
  AWSRedshiftClusterSnapshot: "AWS::Redshift::ClusterSnapshot",

  @doc("ResourceType enum AWS::Redshift::ClusterSubnetGroup")
  AWSRedshiftClusterSubnetGroup: "AWS::Redshift::ClusterSubnetGroup",

  @doc("ResourceType enum AWS::Redshift::EndpointAccess")
  AWSRedshiftEndpointAccess: "AWS::Redshift::EndpointAccess",

  @doc("ResourceType enum AWS::Redshift::EventSubscription")
  AWSRedshiftEventSubscription: "AWS::Redshift::EventSubscription",

  @doc("ResourceType enum AWS::Redshift::ScheduledAction")
  AWSRedshiftScheduledAction: "AWS::Redshift::ScheduledAction",

  @doc("ResourceType enum AWS::ResilienceHub::App")
  AWSResilienceHubApp: "AWS::ResilienceHub::App",

  @doc("ResourceType enum AWS::ResilienceHub::ResiliencyPolicy")
  AWSResilienceHubResiliencyPolicy: "AWS::ResilienceHub::ResiliencyPolicy",

  @doc("ResourceType enum AWS::ResourceExplorer2::Index")
  AWSResourceExplorer2Index: "AWS::ResourceExplorer2::Index",

  @doc("ResourceType enum AWS::RoboMaker::RobotApplication")
  AWSRoboMakerRobotApplication: "AWS::RoboMaker::RobotApplication",

  @doc("ResourceType enum AWS::RoboMaker::RobotApplicationVersion")
  AWSRoboMakerRobotApplicationVersion: "AWS::RoboMaker::RobotApplicationVersion",

  @doc("ResourceType enum AWS::RoboMaker::SimulationApplication")
  AWSRoboMakerSimulationApplication: "AWS::RoboMaker::SimulationApplication",

  @doc("ResourceType enum AWS::Route53::HostedZone")
  AWSRoute53HostedZone: "AWS::Route53::HostedZone",

  @doc("ResourceType enum AWS::Route53RecoveryControl::Cluster")
  AWSRoute53RecoveryControlCluster: "AWS::Route53RecoveryControl::Cluster",

  @doc("ResourceType enum AWS::Route53RecoveryControl::ControlPanel")
  AWSRoute53RecoveryControlControlPanel: "AWS::Route53RecoveryControl::ControlPanel",

  @doc("ResourceType enum AWS::Route53RecoveryControl::RoutingControl")
  AWSRoute53RecoveryControlRoutingControl: "AWS::Route53RecoveryControl::RoutingControl",

  @doc("ResourceType enum AWS::Route53RecoveryControl::SafetyRule")
  AWSRoute53RecoveryControlSafetyRule: "AWS::Route53RecoveryControl::SafetyRule",

  @doc("ResourceType enum AWS::Route53RecoveryReadiness::Cell")
  AWSRoute53RecoveryReadinessCell: "AWS::Route53RecoveryReadiness::Cell",

  @doc("ResourceType enum AWS::Route53RecoveryReadiness::ReadinessCheck")
  AWSRoute53RecoveryReadinessReadinessCheck: "AWS::Route53RecoveryReadiness::ReadinessCheck",

  @doc("ResourceType enum AWS::Route53RecoveryReadiness::RecoveryGroup")
  AWSRoute53RecoveryReadinessRecoveryGroup: "AWS::Route53RecoveryReadiness::RecoveryGroup",

  @doc("ResourceType enum AWS::Route53RecoveryReadiness::ResourceSet")
  AWSRoute53RecoveryReadinessResourceSet: "AWS::Route53RecoveryReadiness::ResourceSet",

  @doc("ResourceType enum AWS::Route53Resolver::FirewallDomainList")
  AWSRoute53ResolverFirewallDomainList: "AWS::Route53Resolver::FirewallDomainList",

  @doc("ResourceType enum AWS::Route53Resolver::FirewallRuleGroup")
  AWSRoute53ResolverFirewallRuleGroup: "AWS::Route53Resolver::FirewallRuleGroup",

  @doc("ResourceType enum AWS::Route53Resolver::FirewallRuleGroupAssociation")
  AWSRoute53ResolverFirewallRuleGroupAssociation: "AWS::Route53Resolver::FirewallRuleGroupAssociation",

  @doc("ResourceType enum AWS::Route53Resolver::ResolverEndpoint")
  AWSRoute53ResolverResolverEndpoint: "AWS::Route53Resolver::ResolverEndpoint",

  @doc("ResourceType enum AWS::Route53Resolver::ResolverQueryLoggingConfig")
  AWSRoute53ResolverResolverQueryLoggingConfig: "AWS::Route53Resolver::ResolverQueryLoggingConfig",

  @doc("ResourceType enum AWS::Route53Resolver::ResolverQueryLoggingConfigAssociation")
  AWSRoute53ResolverResolverQueryLoggingConfigAssociation: "AWS::Route53Resolver::ResolverQueryLoggingConfigAssociation",

  @doc("ResourceType enum AWS::Route53Resolver::ResolverRule")
  AWSRoute53ResolverResolverRule: "AWS::Route53Resolver::ResolverRule",

  @doc("ResourceType enum AWS::Route53Resolver::ResolverRuleAssociation")
  AWSRoute53ResolverResolverRuleAssociation: "AWS::Route53Resolver::ResolverRuleAssociation",

  @doc("ResourceType enum AWS::S3::AccessPoint")
  AWSS3AccessPoint: "AWS::S3::AccessPoint",

  @doc("ResourceType enum AWS::S3::AccountPublicAccessBlock")
  AWSS3AccountPublicAccessBlock: "AWS::S3::AccountPublicAccessBlock",

  @doc("ResourceType enum AWS::S3::Bucket")
  AWSS3Bucket: "AWS::S3::Bucket",

  @doc("ResourceType enum AWS::S3::MultiRegionAccessPoint")
  AWSS3MultiRegionAccessPoint: "AWS::S3::MultiRegionAccessPoint",

  @doc("ResourceType enum AWS::S3::StorageLens")
  AWSS3StorageLens: "AWS::S3::StorageLens",

  @doc("ResourceType enum AWS::SES::ConfigurationSet")
  AWSSESConfigurationSet: "AWS::SES::ConfigurationSet",

  @doc("ResourceType enum AWS::SES::ContactList")
  AWSSESContactList: "AWS::SES::ContactList",

  @doc("ResourceType enum AWS::SES::ReceiptFilter")
  AWSSESReceiptFilter: "AWS::SES::ReceiptFilter",

  @doc("ResourceType enum AWS::SES::ReceiptRuleSet")
  AWSSESReceiptRuleSet: "AWS::SES::ReceiptRuleSet",

  @doc("ResourceType enum AWS::SES::Template")
  AWSSESTemplate: "AWS::SES::Template",

  @doc("ResourceType enum AWS::SNS::Topic")
  AWSSNSTopic: "AWS::SNS::Topic",

  @doc("ResourceType enum AWS::SQS::Queue")
  AWSSQSQueue: "AWS::SQS::Queue",

  @doc("ResourceType enum AWS::SSM::AssociationCompliance")
  AWSSSMAssociationCompliance: "AWS::SSM::AssociationCompliance",

  @doc("ResourceType enum AWS::SSM::Document")
  AWSSSMDocument: "AWS::SSM::Document",

  @doc("ResourceType enum AWS::SSM::FileData")
  AWSSSMFileData: "AWS::SSM::FileData",

  @doc("ResourceType enum AWS::SSM::ManagedInstanceInventory")
  AWSSSMManagedInstanceInventory: "AWS::SSM::ManagedInstanceInventory",

  @doc("ResourceType enum AWS::SSM::PatchCompliance")
  AWSSSMPatchCompliance: "AWS::SSM::PatchCompliance",

  @doc("ResourceType enum AWS::SageMaker::AppImageConfig")
  AWSSageMakerAppImageConfig: "AWS::SageMaker::AppImageConfig",

  @doc("ResourceType enum AWS::SageMaker::CodeRepository")
  AWSSageMakerCodeRepository: "AWS::SageMaker::CodeRepository",

  @doc("ResourceType enum AWS::SageMaker::Domain")
  AWSSageMakerDomain: "AWS::SageMaker::Domain",

  @doc("ResourceType enum AWS::SageMaker::FeatureGroup")
  AWSSageMakerFeatureGroup: "AWS::SageMaker::FeatureGroup",

  @doc("ResourceType enum AWS::SageMaker::Image")
  AWSSageMakerImage: "AWS::SageMaker::Image",

  @doc("ResourceType enum AWS::SageMaker::Model")
  AWSSageMakerModel: "AWS::SageMaker::Model",

  @doc("ResourceType enum AWS::SageMaker::NotebookInstanceLifecycleConfig")
  AWSSageMakerNotebookInstanceLifecycleConfig: "AWS::SageMaker::NotebookInstanceLifecycleConfig",

  @doc("ResourceType enum AWS::SageMaker::Workteam")
  AWSSageMakerWorkteam: "AWS::SageMaker::Workteam",

  @doc("ResourceType enum AWS::SecretsManager::Secret")
  AWSSecretsManagerSecret: "AWS::SecretsManager::Secret",

  @doc("ResourceType enum AWS::ServiceCatalog::CloudFormationProduct")
  AWSServiceCatalogCloudFormationProduct: "AWS::ServiceCatalog::CloudFormationProduct",

  @doc("ResourceType enum AWS::ServiceCatalog::CloudFormationProvisionedProduct")
  AWSServiceCatalogCloudFormationProvisionedProduct: "AWS::ServiceCatalog::CloudFormationProvisionedProduct",

  @doc("ResourceType enum AWS::ServiceCatalog::Portfolio")
  AWSServiceCatalogPortfolio: "AWS::ServiceCatalog::Portfolio",

  @doc("ResourceType enum AWS::ServiceDiscovery::HttpNamespace")
  AWSServiceDiscoveryHttpNamespace: "AWS::ServiceDiscovery::HttpNamespace",

  @doc("ResourceType enum AWS::ServiceDiscovery::Instance")
  AWSServiceDiscoveryInstance: "AWS::ServiceDiscovery::Instance",

  @doc("ResourceType enum AWS::ServiceDiscovery::PublicDnsNamespace")
  AWSServiceDiscoveryPublicDnsNamespace: "AWS::ServiceDiscovery::PublicDnsNamespace",

  @doc("ResourceType enum AWS::ServiceDiscovery::Service")
  AWSServiceDiscoveryService: "AWS::ServiceDiscovery::Service",

  @doc("ResourceType enum AWS::Shield::Protection")
  AWSShieldProtection: "AWS::Shield::Protection",

  @doc("ResourceType enum AWS::ShieldRegional::Protection")
  AWSShieldRegionalProtection: "AWS::ShieldRegional::Protection",

  @doc("ResourceType enum AWS::Signer::SigningProfile")
  AWSSignerSigningProfile: "AWS::Signer::SigningProfile",

  @doc("ResourceType enum AWS::StepFunctions::Activity")
  AWSStepFunctionsActivity: "AWS::StepFunctions::Activity",

  @doc("ResourceType enum AWS::StepFunctions::StateMachine")
  AWSStepFunctionsStateMachine: "AWS::StepFunctions::StateMachine",

  @doc("ResourceType enum AWS::Transfer::Agreement")
  AWSTransferAgreement: "AWS::Transfer::Agreement",

  @doc("ResourceType enum AWS::Transfer::Certificate")
  AWSTransferCertificate: "AWS::Transfer::Certificate",

  @doc("ResourceType enum AWS::Transfer::Connector")
  AWSTransferConnector: "AWS::Transfer::Connector",

  @doc("ResourceType enum AWS::Transfer::Workflow")
  AWSTransferWorkflow: "AWS::Transfer::Workflow",

  @doc("ResourceType enum AWS::WAF::RateBasedRule")
  AWSWAFRateBasedRule: "AWS::WAF::RateBasedRule",

  @doc("ResourceType enum AWS::WAF::Rule")
  AWSWAFRule: "AWS::WAF::Rule",

  @doc("ResourceType enum AWS::WAF::RuleGroup")
  AWSWAFRuleGroup: "AWS::WAF::RuleGroup",

  @doc("ResourceType enum AWS::WAF::WebACL")
  AWSWAFWebACL: "AWS::WAF::WebACL",

  @doc("ResourceType enum AWS::WAFRegional::RateBasedRule")
  AWSWAFRegionalRateBasedRule: "AWS::WAFRegional::RateBasedRule",

  @doc("ResourceType enum AWS::WAFRegional::Rule")
  AWSWAFRegionalRule: "AWS::WAFRegional::Rule",

  @doc("ResourceType enum AWS::WAFRegional::RuleGroup")
  AWSWAFRegionalRuleGroup: "AWS::WAFRegional::RuleGroup",

  @doc("ResourceType enum AWS::WAFRegional::WebACL")
  AWSWAFRegionalWebACL: "AWS::WAFRegional::WebACL",

  @doc("ResourceType enum AWS::WAFv2::IPSet")
  AWSWAFv2IPSet: "AWS::WAFv2::IPSet",

  @doc("ResourceType enum AWS::WAFv2::ManagedRuleSet")
  AWSWAFv2ManagedRuleSet: "AWS::WAFv2::ManagedRuleSet",

  @doc("ResourceType enum AWS::WAFv2::RegexPatternSet")
  AWSWAFv2RegexPatternSet: "AWS::WAFv2::RegexPatternSet",

  @doc("ResourceType enum AWS::WAFv2::RuleGroup")
  AWSWAFv2RuleGroup: "AWS::WAFv2::RuleGroup",

  @doc("ResourceType enum AWS::WAFv2::WebACL")
  AWSWAFv2WebACL: "AWS::WAFv2::WebACL",

  @doc("ResourceType enum AWS::WorkSpaces::ConnectionAlias")
  AWSWorkSpacesConnectionAlias: "AWS::WorkSpaces::ConnectionAlias",

  @doc("ResourceType enum AWS::WorkSpaces::Workspace")
  AWSWorkSpacesWorkspace: "AWS::WorkSpaces::Workspace",

  @doc("ResourceType enum AWS::XRay::EncryptionConfig")
  AWSXRayEncryptionConfig: "AWS::XRay::EncryptionConfig",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ResourceTypeEnumValue")
model ResourceTypeEnumValue {
  @doc("Property value")
  value?: ResourceType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RecordingMode")
model RecordingMode {
  @doc("<p>The default recording frequency that Config uses to record configuration changes.</p> <important> <p>Daily recording is not supported for the following resource types:</p> <ul> <li> <p> <code>AWS::Config::ResourceCompliance</code> </p> </li> <li> <p> <code>AWS::Config::ConformancePackCompliance</code> </p> </li> <li> <p> <code>AWS::Config::ConfigurationRecorder</code> </p> </li> </ul> <p>For the <b>allSupported</b> (<code>ALL_SUPPORTED_RESOURCE_TYPES</code>) recording strategy, these resource types will be set to Continuous recording.</p> </important>")
  recordingFrequency?: RecordingFrequencyEnumValue;

  @doc("<p>An array of <code>recordingModeOverride</code> objects for you to specify your overrides for the recording mode. The <code>recordingModeOverride</code> object in the <code>recordingModeOverrides</code> array consists of three fields: a <code>description</code>, the new <code>recordingFrequency</code>, and an array of <code>resourceTypes</code> to override.</p>")
  @extension("x-ms-identifiers", [])
  recordingModeOverrides?: RecordingModeOverride[];
}

@doc("RecordingFrequency enum")
union RecordingFrequency {
  @doc("RecordingFrequency enum CONTINUOUS")
  CONTINUOUS: "CONTINUOUS",

  @doc("RecordingFrequency enum DAILY")
  DAILY: "DAILY",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RecordingFrequencyEnumValue")
model RecordingFrequencyEnumValue {
  @doc("Property value")
  value?: RecordingFrequency;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ExclusionByResourceTypes")
model ExclusionByResourceTypes {
  @doc("<p>A comma-separated list of resource types to exclude from recording by the configuration recorder.</p>")
  @extension("x-ms-identifiers", [])
  resourceTypes?: ResourceType[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RecordingStrategy")
model RecordingStrategy {
  @doc("<p>The recording strategy for the configuration recorder.</p> <ul> <li> <p>If you set this option to <code>ALL_SUPPORTED_RESOURCE_TYPES</code>, Config records configuration changes for all supported resource types, excluding the global IAM resource types. You also must set the <code>allSupported</code> field of <a href='https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingGroup.html'>RecordingGroup</a> to <code>true</code>. When Config adds support for a new resource type, Config automatically starts recording resources of that type. For a list of supported resource types, see <a href='https://docs.aws.amazon.com/config/latest/developerguide/resource-config-reference.html#supported-resources'>Supported Resource Types</a> in the <i>Config developer guide</i>.</p> </li> <li> <p>If you set this option to <code>INCLUSION_BY_RESOURCE_TYPES</code>, Config records configuration changes for only the resource types that you specify in the <code>resourceTypes</code> field of <a href='https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingGroup.html'>RecordingGroup</a>.</p> </li> <li> <p>If you set this option to <code>EXCLUSION_BY_RESOURCE_TYPES</code>, Config records configuration changes for all supported resource types, except the resource types that you specify to exclude from being recorded in the <code>resourceTypes</code> field of <a href='https://docs.aws.amazon.com/config/latest/APIReference/API_ExclusionByResourceTypes.html'>ExclusionByResourceTypes</a>.</p> </li> </ul> <note> <p> <b>Required and optional fields</b> </p> <p>The <code>recordingStrategy</code> field is optional when you set the <code>allSupported</code> field of <a href='https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingGroup.html'>RecordingGroup</a> to <code>true</code>.</p> <p>The <code>recordingStrategy</code> field is optional when you list resource types in the <code>resourceTypes</code> field of <a href='https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingGroup.html'>RecordingGroup</a>.</p> <p>The <code>recordingStrategy</code> field is required if you list resource types to exclude from recording in the <code>resourceTypes</code> field of <a href='https://docs.aws.amazon.com/config/latest/APIReference/API_ExclusionByResourceTypes.html'>ExclusionByResourceTypes</a>.</p> </note> <note> <p> <b>Overriding fields</b> </p> <p>If you choose <code>EXCLUSION_BY_RESOURCE_TYPES</code> for the recording strategy, the <code>exclusionByResourceTypes</code> field will override other properties in the request.</p> <p>For example, even if you set <code>includeGlobalResourceTypes</code> to false, global IAM resource types will still be automatically recorded in this option unless those resource types are specifically listed as exclusions in the <code>resourceTypes</code> field of <code>exclusionByResourceTypes</code>.</p> </note> <note> <p> <b>Global resource types and the exclusion recording strategy</b> </p> <p>By default, if you choose the <code>EXCLUSION_BY_RESOURCE_TYPES</code> recording strategy, when Config adds support for a new resource type in the Region where you set up the configuration recorder, including global resource types, Config starts recording resources of that type automatically.</p> <p>Unless specifically listed as exclusions, <code>AWS::RDS::GlobalCluster</code> will be recorded automatically in all supported Config Regions were the configuration recorder is enabled.</p> <p>IAM users, groups, roles, and customer managed policies will be recorded in the Region where you set up the configuration recorder if that is a Region where Config was available before February 2022. You cannot be record the global IAM resouce types in Regions supported by Config after February 2022. This list where you cannot record the global IAM resource types includes the following Regions:</p> <ul> <li> <p>Asia Pacific (Hyderabad)</p> </li> <li> <p>Asia Pacific (Melbourne)</p> </li> <li> <p>Canada West (Calgary)</p> </li> <li> <p>Europe (Spain)</p> </li> <li> <p>Europe (Zurich)</p> </li> <li> <p>Israel (Tel Aviv)</p> </li> <li> <p>Middle East (UAE)</p> </li> </ul> </note>")
  useOnly?: RecordingStrategyTypeEnumValue;
}

@doc("RecordingStrategyType enum")
union RecordingStrategyType {
  @doc("RecordingStrategyType enum ALL_SUPPORTED_RESOURCE_TYPES")
  ALL_SUPPORTED_RESOURCE_TYPES: "ALL_SUPPORTED_RESOURCE_TYPES",

  @doc("RecordingStrategyType enum EXCLUSION_BY_RESOURCE_TYPES")
  EXCLUSION_BY_RESOURCE_TYPES: "EXCLUSION_BY_RESOURCE_TYPES",

  @doc("RecordingStrategyType enum INCLUSION_BY_RESOURCE_TYPES")
  INCLUSION_BY_RESOURCE_TYPES: "INCLUSION_BY_RESOURCE_TYPES",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RecordingStrategyTypeEnumValue")
model RecordingStrategyTypeEnumValue {
  @doc("Property value")
  value?: RecordingStrategyType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RecordingModeOverride")
model RecordingModeOverride {
  @doc("<p>A description that you provide for the override.</p>")
  description?: string;

  @doc("<p>The recording frequency that will be applied to all the resource types specified in the override.</p> <ul> <li> <p>Continuous recording allows you to record configuration changes continuously whenever a change occurs.</p> </li> <li> <p>Daily recording allows you to receive a configuration item (CI) representing the most recent state of your resources over the last 24-hour period, only if it’s different from the previous CI recorded. </p> </li> </ul> <note> <p>Firewall Manager depends on continuous recording to monitor your resources. If you are using Firewall Manager, it is recommended that you set the recording frequency to Continuous.</p> </note>")
  recordingFrequency?: RecordingFrequencyEnumValue;

  @doc("<p>A comma-separated list that specifies which resource types Config includes in the override.</p> <important> <p>Daily recording is not supported for the following resource types:</p> <ul> <li> <p> <code>AWS::Config::ResourceCompliance</code> </p> </li> <li> <p> <code>AWS::Config::ConformancePackCompliance</code> </p> </li> <li> <p> <code>AWS::Config::ConfigurationRecorder</code> </p> </li> </ul> </important>")
  @extension("x-ms-identifiers", [])
  resourceTypes?: ResourceType[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface ConfigServiceConfigurationRecorders {
  get is ArmResourceRead<ConfigServiceConfigurationRecorder>;
  @doc("Create a ConfigServiceConfigurationRecorder. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<ConfigServiceConfigurationRecorder>;
  update is ArmCustomPatchAsync<
    ConfigServiceConfigurationRecorder,
    Azure.ResourceManager.Foundations.TagsUpdateModel<ConfigServiceConfigurationRecorder>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ConfigServiceConfigurationRecorder>;
  listByResourceGroup is ArmResourceListByParent<ConfigServiceConfigurationRecorder>;
  listBySubscription is ArmListBySubscription<ConfigServiceConfigurationRecorder>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\config\config-2014-11-12.normal.json
// AWS Shape: ConfigurationRecorder
//
// Related information for backend service:
// AWS Servcie : Config Service
// Product Version : 3.7.798.0
// SDK Version : 3.7.302.55
//--------------------------------------------------------------------------------------------
