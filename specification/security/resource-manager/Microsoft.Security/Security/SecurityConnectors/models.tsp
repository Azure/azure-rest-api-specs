import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
namespace Microsoft.Security;

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * The multi cloud resource's cloud name.
 */
union CloudName {
  string,

  /**
   * Azure
   */
  Azure: "Azure",

  /**
   * AWS
   */
  AWS: "AWS",

  /**
   * GCP
   */
  GCP: "GCP",

  /**
   * Github
   */
  Github: "Github",

  /**
   * AzureDevOps
   */
  AzureDevOps: "AzureDevOps",

  /**
   * GitLab
   */
  GitLab: "GitLab",

  /**
   * DockerHub
   */
  DockerHub: "DockerHub",

  /**
   * JFrog
   */
  JFrog: "JFrog",
}

/**
 * The type of the security offering.
 */
union OfferingType {
  string,

  /**
   * CspmMonitorAws
   */
  CspmMonitorAws: "CspmMonitorAws",

  /**
   * DefenderForContainersAws
   */
  DefenderForContainersAws: "DefenderForContainersAws",

  /**
   * DefenderForServersAws
   */
  DefenderForServersAws: "DefenderForServersAws",

  /**
   * DefenderForDatabasesAws
   */
  DefenderForDatabasesAws: "DefenderForDatabasesAws",

  /**
   * CspmMonitorGcp
   */
  CspmMonitorGcp: "CspmMonitorGcp",

  /**
   * CspmMonitorGithub
   */
  CspmMonitorGithub: "CspmMonitorGithub",

  /**
   * CspmMonitorAzureDevOps
   */
  CspmMonitorAzureDevOps: "CspmMonitorAzureDevOps",

  /**
   * DefenderForServersGcp
   */
  DefenderForServersGcp: "DefenderForServersGcp",

  /**
   * DefenderForContainersGcp
   */
  DefenderForContainersGcp: "DefenderForContainersGcp",

  /**
   * DefenderForDatabasesGcp
   */
  DefenderForDatabasesGcp: "DefenderForDatabasesGcp",

  /**
   * DefenderCspmAws
   */
  DefenderCspmAws: "DefenderCspmAws",

  /**
   * DefenderCspmGcp
   */
  DefenderCspmGcp: "DefenderCspmGcp",

  /**
   * CspmMonitorGitLab
   */
  CspmMonitorGitLab: "CspmMonitorGitLab",

  /**
   * CspmMonitorDockerHub
   */
  CspmMonitorDockerHub: "CspmMonitorDockerHub",

  /**
   * DefenderForContainersDockerHub
   */
  DefenderForContainersDockerHub: "DefenderForContainersDockerHub",

  /**
   * DefenderCspmDockerHub
   */
  DefenderCspmDockerHub: "DefenderCspmDockerHub",

  /**
   * CspmMonitorJFrog
   */
  CspmMonitorJFrog: "CspmMonitorJFrog",

  /**
   * DefenderForContainersJFrog
   */
  DefenderForContainersJFrog: "DefenderForContainersJFrog",

  /**
   * DefenderCspmJFrog
   */
  DefenderCspmJFrog: "DefenderCspmJFrog",
}

/**
 * The type of the environment data.
 */
union EnvironmentType {
  string,

  /**
   * AwsAccount
   */
  AwsAccount: "AwsAccount",

  /**
   * GcpProject
   */
  GcpProject: "GcpProject",

  /**
   * GithubScope
   */
  GithubScope: "GithubScope",

  /**
   * AzureDevOpsScope
   */
  AzureDevOpsScope: "AzureDevOpsScope",

  /**
   * GitlabScope
   */
  GitlabScope: "GitlabScope",

  /**
   * DockerHubOrganization
   */
  DockerHubOrganization: "DockerHubOrganization",

  /**
   * JFrogArtifactory
   */
  JFrogArtifactory: "JFrogArtifactory",
}

/**
 * The multi cloud account's membership type in the organization
 */
union OrganizationMembershipType {
  string,

  /**
   * Member
   */
  Member: "Member",

  /**
   * Organization
   */
  Organization: "Organization",
}

/**
 * The authentication type
 */
union AuthenticationType {
  string,

  /**
   * AccessToken
   */
  AccessToken: "AccessToken",
}

/**
 * The scanning mode for the VM scan.
 */
union ScanningMode {
  string,

  /**
   * Default
   */
  Default: "Default",
}

/**
 * The Vulnerability Assessment solution to be provisioned. Can be either 'TVM' or 'Qualys'
 */
union Type {
  string,

  /**
   * Qualys
   */
  Qualys: "Qualys",

  /**
   * TVM
   */
  TVM: "TVM",
}

/**
 * The available sub plans
 */
union SubPlan {
  string,

  /**
   * P1
   */
  P1: "P1",

  /**
   * P2
   */
  P2: "P2",
}

/**
 * List of security connectors response.
 */
model SecurityConnectorsList is Azure.Core.Page<SecurityConnector>;

/**
 * A set of properties that defines the security connector configuration.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SecurityConnectorProperties {
  /**
   * The multi cloud resource identifier (account id in case of AWS connector, project number in case of GCP connector).
   */
  hierarchyIdentifier?: string;

  /**
   * The date on which the trial period will end, if applicable. Trial period exists for 30 days after upgrading to payed offerings.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  hierarchyIdentifierTrialEndDate?: utcDateTime;

  /**
   * The multi cloud resource's cloud name.
   */
  environmentName?: CloudName;

  /**
   * A collection of offerings for the security connector.
   */
  @identifiers(#[])
  offerings?: cloudOffering[];

  /**
   * The security connector environment data.
   */
  environmentData?: EnvironmentData;
}

/**
 * The security offering details
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("offeringType")
model cloudOffering {
  /**
   * The type of the security offering.
   */
  offeringType: OfferingType;

  /**
   * The offering description.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * The security connector environment data.
 */
@discriminator("environmentType")
model EnvironmentData {
  /**
   * The type of the environment data.
   */
  environmentType: EnvironmentType;
}

/**
 * The AWS connector environment data
 */
model AwsEnvironmentData extends EnvironmentData {
  /**
   * The AWS account's organizational data
   */
  organizationalData?: AwsOrganizationalData;

  /**
   * list of regions to scan
   */
  regions?: string[];

  /**
   * The AWS account name
   */
  @visibility(Lifecycle.Read)
  accountName?: string;

  /**
   * Scan interval in hours (value should be between 1-hour to 24-hours)
   */
  scanInterval?: int64;

  /**
   * The type of the environment data.
   */
  environmentType: "AwsAccount";
}

/**
 * The AWS organization data
 */
@discriminator("organizationMembershipType")
model AwsOrganizationalData {
  /**
   * The multi cloud account's membership type in the organization
   */
  organizationMembershipType: OrganizationMembershipType;
}

/**
 * The AWS organization data for the master account
 */
model AwsOrganizationalDataMaster extends AwsOrganizationalData {
  /**
   * If the multi cloud account is of membership type organization, this will be the name of the onboarding stackset
   */
  stacksetName?: string;

  /**
   * If the multi cloud account is of membership type organization, list of accounts excluded from offering
   */
  excludedAccountIds?: string[];

  /**
   * The multi cloud account's membership type in the organization
   */
  organizationMembershipType: "Organization";
}

/**
 * The AWS organization data for the member account
 */
model AwsOrganizationalDataMember extends AwsOrganizationalData {
  /**
   * If the multi cloud account is not of membership type organization, this will be the ID of the account's parent
   */
  parentHierarchyId?: string;

  /**
   * The multi cloud account's membership type in the organization
   */
  organizationMembershipType: "Member";
}

/**
 * The GCP project connector environment data
 */
model GcpProjectEnvironmentData extends EnvironmentData {
  /**
   * The Gcp project's organizational data
   */
  organizationalData?: GcpOrganizationalData;

  /**
   * The Gcp project's details
   */
  projectDetails?: GcpProjectDetails;

  /**
   * Scan interval in hours (value should be between 1-hour to 24-hours)
   */
  scanInterval?: int64;

  /**
   * The type of the environment data.
   */
  environmentType: "GcpProject";
}

/**
 * The gcpOrganization data
 */
@discriminator("organizationMembershipType")
model GcpOrganizationalData {
  /**
   * The multi cloud account's membership type in the organization
   */
  organizationMembershipType: OrganizationMembershipType;
}

/**
 * The details about the project represented by the security connector
 */
model GcpProjectDetails {
  /**
   * The unique GCP Project number
   */
  projectNumber?: string;

  /**
   * The GCP Project id
   */
  projectId?: string;

  /**
   * The GCP workload identity federation pool id
   */
  @visibility(Lifecycle.Read)
  workloadIdentityPoolId?: string;

  /**
   * GCP project name
   */
  @visibility(Lifecycle.Read)
  projectName?: string;
}

/**
 * The gcpOrganization data for the parent account
 */
model GcpOrganizationalDataOrganization extends GcpOrganizationalData {
  /**
   * If the multi cloud account is of membership type organization, list of accounts excluded from offering
   */
  excludedProjectNumbers?: string[];

  /**
   * The service account email address which represents the organization level permissions container.
   */
  serviceAccountEmailAddress?: string;

  /**
   * The GCP workload identity provider id which represents the permissions required to auto provision security connectors
   */
  workloadIdentityProviderId?: string;

  /**
   * GCP organization name
   */
  @visibility(Lifecycle.Read)
  organizationName?: string;

  /**
   * The multi cloud account's membership type in the organization
   */
  organizationMembershipType: "Organization";
}

/**
 * The gcpOrganization data for the member account
 */
model GcpOrganizationalDataMember extends GcpOrganizationalData {
  /**
   * If the multi cloud account is not of membership type organization, this will be the ID of the project's parent
   */
  parentHierarchyId?: string;

  /**
   * The GCP management project number from organizational onboarding
   */
  managementProjectNumber?: string;

  /**
   * The multi cloud account's membership type in the organization
   */
  organizationMembershipType: "Member";
}

/**
 * The github scope connector's environment data
 */
model GithubScopeEnvironmentData extends EnvironmentData {
  /**
   * The type of the environment data.
   */
  environmentType: "GithubScope";
}

/**
 * The AzureDevOps scope connector's environment data
 */
model AzureDevOpsScopeEnvironmentData extends EnvironmentData {
  /**
   * The type of the environment data.
   */
  environmentType: "AzureDevOpsScope";
}

/**
 * The GitLab scope connector's environment data
 */
model GitlabScopeEnvironmentData extends EnvironmentData {
  /**
   * The type of the environment data.
   */
  environmentType: "GitlabScope";
}

/**
 * The Docker Hub connector environment data
 */
model DockerHubEnvironmentData extends EnvironmentData {
  /**
   * The Docker Hub organization authentication details
   */
  authentication?: Authentication;

  /**
   * Scan interval in hours (value should be between 1-hour to 24-hours)
   */
  scanInterval?: int64;

  /**
   * The type of the environment data.
   */
  environmentType: "DockerHubOrganization";
}

/**
 * The environment authentication details
 */
@discriminator("authenticationType")
model Authentication {
  /**
   * The authentication type
   */
  authenticationType: AuthenticationType;
}

/**
 * The environment authentication details
 */
model AccessTokenAuthentication extends Authentication {
  /**
   * The user name that will be used while authenticating with the onboarded environment
   */
  username?: string;

  /**
   * The access token that will be used while authenticating with the onboarded environment
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  accessToken?: string;

  /**
   * The authentication type
   */
  authenticationType: "AccessToken";
}

/**
 * The JFrog Artifactory connector environment data
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model JFrogEnvironmentData extends EnvironmentData {
  /**
   * Scan interval in hours (value should be between 1-hour to 24-hours)
   */
  @maxValue(24)
  @minValue(1)
  scanInterval?: int32;

  /**
   * The type of the environment data.
   */
  environmentType: "JFrogArtifactory";
}

/**
 * The CSPM monitoring for AWS offering
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model cspmMonitorAwsOffering extends cloudOffering {
  /**
   * The native cloud connection configuration
   */
  nativeCloudConnection?: CspmMonitorAwsOfferingNativeCloudConnection;

  /**
   * The type of the security offering.
   */
  offeringType: "CspmMonitorAws";
}

/**
 * The native cloud connection configuration
 */
model CspmMonitorAwsOfferingNativeCloudConnection {
  /**
   * The cloud role ARN in AWS for this feature
   */
  cloudRoleArn?: string;
}

/**
 * The Defender for Containers AWS offering
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model defenderForContainersAwsOffering extends cloudOffering {
  /**
   * The kubernetes service connection configuration
   */
  kubernetesService?: DefenderForContainersAwsOfferingKubernetesService;

  /**
   * The kubernetes data collection connection configuration
   */
  kubernetesDataCollection?: DefenderForContainersAwsOfferingKubernetesDataCollection;

  /**
   * The cloudwatch to kinesis connection configuration
   */
  cloudWatchToKinesis?: DefenderForContainersAwsOfferingCloudWatchToKinesis;

  /**
   * The kinesis to s3 connection configuration
   */
  kinesisToS3?: DefenderForContainersAwsOfferingKinesisToS3;

  /**
   * Is audit logs data collection enabled
   */
  enableAuditLogsAutoProvisioning?: boolean;

  /**
   * Is Microsoft Defender for Cloud Kubernetes agent auto provisioning enabled
   */
  enableDefenderAgentAutoProvisioning?: boolean;

  /**
   * Is Policy Kubernetes agent auto provisioning enabled
   */
  enablePolicyAgentAutoProvisioning?: boolean;

  /**
   * The retention time in days of kube audit logs set on the CloudWatch log group
   */
  kubeAuditRetentionTime?: int64;

  /**
   * The externalId used by the data reader to prevent the confused deputy attack
   */
  dataCollectionExternalId?: string;

  /**
   * The Microsoft Defender container image assessment configuration
   */
  mdcContainersImageAssessment?: DefenderForContainersAwsOfferingMdcContainersImageAssessment;

  /**
   * The Microsoft Defender container agentless discovery K8s configuration
   */
  mdcContainersAgentlessDiscoveryK8s?: DefenderForContainersAwsOfferingMdcContainersAgentlessDiscoveryK8S;

  /**
   * The Microsoft Defender for Container K8s VM host scanning configuration
   */
  vmScanners?: defenderForContainersAwsOfferingVmScanners;

  /**
   * The type of the security offering.
   */
  offeringType: "DefenderForContainersAws";
}

/**
 * The kubernetes service connection configuration
 */
model DefenderForContainersAwsOfferingKubernetesService {
  /**
   * The cloud role ARN in AWS for this feature used for provisioning resources
   */
  cloudRoleArn?: string;
}

/**
 * The kubernetes data collection connection configuration
 */
model DefenderForContainersAwsOfferingKubernetesDataCollection {
  /**
   * The cloud role ARN in AWS for this feature used for reading data
   */
  cloudRoleArn?: string;
}

/**
 * The cloudwatch to kinesis connection configuration
 */
model DefenderForContainersAwsOfferingCloudWatchToKinesis {
  /**
   * The cloud role ARN in AWS used by CloudWatch to transfer data into Kinesis
   */
  cloudRoleArn?: string;
}

/**
 * The kinesis to s3 connection configuration
 */
model DefenderForContainersAwsOfferingKinesisToS3 {
  /**
   * The cloud role ARN in AWS used by Kinesis to transfer data into S3
   */
  cloudRoleArn?: string;
}

/**
 * The Microsoft Defender container image assessment configuration
 */
model DefenderForContainersAwsOfferingMdcContainersImageAssessment {
  /**
   * Is Microsoft Defender container image assessment enabled
   */
  enabled?: boolean;

  /**
   * The cloud role ARN in AWS for this feature
   */
  cloudRoleArn?: string;
}

/**
 * The Microsoft Defender container agentless discovery K8s configuration
 */
model DefenderForContainersAwsOfferingMdcContainersAgentlessDiscoveryK8S {
  /**
   * Is Microsoft Defender container agentless discovery K8s enabled
   */
  enabled?: boolean;

  /**
   * The cloud role ARN in AWS for this feature
   */
  cloudRoleArn?: string;
}

/**
 * The Microsoft Defender for Container K8s VM host scanning configuration
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model defenderForContainersAwsOfferingVmScanners extends vmScannersAws {}

/**
 * A VM scanning configuration for a security offering of a Aws environment
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model vmScannersAws extends vmScannersBase {
  /**
   * The cloud role ARN in AWS for this feature
   */
  cloudRoleArn?: string;
}

/**
 * A VM scanning configuration for a security offering of a given environment
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model vmScannersBase {
  /**
   * Is VM scanning enabled
   */
  enabled?: boolean;

  /**
   * Configuration for VM scanning
   */
  configuration?: VmScannersBaseConfiguration;
}

/**
 * Configuration for VM scanning
 */
model VmScannersBaseConfiguration {
  /**
   * The scanning mode for the VM scan.
   */
  scanningMode?: ScanningMode;

  /**
   * Tags that indicates that a resource should not be scanned
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  exclusionTags?: Record<string>;
}

/**
 * The Defender for Servers AWS offering
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model defenderForServersAwsOffering extends cloudOffering {
  /**
   * The Defender for servers connection configuration
   */
  defenderForServers?: DefenderForServersAwsOfferingDefenderForServers;

  /**
   * The ARC autoprovisioning configuration
   */
  arcAutoProvisioning?: DefenderForServersAwsOfferingArcAutoProvisioning;

  /**
   * The Vulnerability Assessment autoprovisioning configuration
   */
  vaAutoProvisioning?: DefenderForServersAwsOfferingVaAutoProvisioning;

  /**
   * The Microsoft Defender for Endpoint autoprovisioning configuration
   */
  mdeAutoProvisioning?: DefenderForServersAwsOfferingMdeAutoProvisioning;

  /**
   * configuration for the servers offering subPlan
   */
  subPlan?: DefenderForServersAwsOfferingSubPlan;

  /**
   * The Microsoft Defender for Server VM scanning configuration
   */
  vmScanners?: defenderForServersAwsOfferingVmScanners;

  /**
   * The type of the security offering.
   */
  offeringType: "DefenderForServersAws";
}

/**
 * The Defender for servers connection configuration
 */
model DefenderForServersAwsOfferingDefenderForServers {
  /**
   * The cloud role ARN in AWS for this feature
   */
  cloudRoleArn?: string;
}

/**
 * The ARC autoprovisioning configuration
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DefenderForServersAwsOfferingArcAutoProvisioning
  extends arcAutoProvisioningAws {}

/**
 * The ARC autoprovisioning configuration for an AWS environment
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model arcAutoProvisioningAws extends arcAutoProvisioning {
  /**
   * The cloud role ARN in AWS for this feature
   */
  cloudRoleArn?: string;
}

/**
 * The ARC autoprovisioning configuration
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model arcAutoProvisioning {
  /**
   * Is arc auto provisioning enabled
   */
  enabled?: boolean;

  /**
   * Configuration for servers Arc auto provisioning for a given environment
   */
  configuration?: ArcAutoProvisioningConfiguration;
}

/**
 * Configuration for servers Arc auto provisioning for a given environment
 */
model ArcAutoProvisioningConfiguration {
  /**
   * Optional HTTP proxy endpoint to use for the Arc agent
   */
  proxy?: string;

  /**
   * Optional Arc private link scope resource id to link the Arc agent
   */
  privateLinkScope?: string;
}

/**
 * The Vulnerability Assessment autoprovisioning configuration
 */
model DefenderForServersAwsOfferingVaAutoProvisioning {
  /**
   * Is Vulnerability Assessment auto provisioning enabled
   */
  enabled?: boolean;

  /**
   * configuration for Vulnerability Assessment autoprovisioning
   */
  configuration?: DefenderForServersAwsOfferingVaAutoProvisioningConfiguration;
}

/**
 * configuration for Vulnerability Assessment autoprovisioning
 */
model DefenderForServersAwsOfferingVaAutoProvisioningConfiguration {
  /**
   * The Vulnerability Assessment solution to be provisioned. Can be either 'TVM' or 'Qualys'
   */
  type?: Type;
}

/**
 * The Microsoft Defender for Endpoint autoprovisioning configuration
 */
model DefenderForServersAwsOfferingMdeAutoProvisioning {
  /**
   * Is Microsoft Defender for Endpoint auto provisioning enabled
   */
  enabled?: boolean;

  /**
   * configuration for Microsoft Defender for Endpoint autoprovisioning
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  configuration?: unknown;
}

/**
 * configuration for the servers offering subPlan
 */
model DefenderForServersAwsOfferingSubPlan {
  /**
   * The available sub plans
   */
  type?: SubPlan;
}

/**
 * The Microsoft Defender for Server VM scanning configuration
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model defenderForServersAwsOfferingVmScanners extends vmScannersAws {}

/**
 * The Defender for Databases AWS offering
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model defenderFoDatabasesAwsOffering extends cloudOffering {
  /**
   * The ARC autoprovisioning configuration
   */
  arcAutoProvisioning?: DefenderFoDatabasesAwsOfferingArcAutoProvisioning;

  /**
   * The RDS configuration
   */
  rds?: DefenderFoDatabasesAwsOfferingRds;

  /**
   * The databases data security posture management (DSPM) configuration
   */
  databasesDspm?: DefenderFoDatabasesAwsOfferingDatabasesDspm;

  /**
   * The type of the security offering.
   */
  offeringType: "DefenderForDatabasesAws";
}

/**
 * The ARC autoprovisioning configuration
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DefenderFoDatabasesAwsOfferingArcAutoProvisioning
  extends arcAutoProvisioningAws {}

/**
 * The RDS configuration
 */
model DefenderFoDatabasesAwsOfferingRds {
  /**
   * Is RDS protection enabled
   */
  enabled?: boolean;

  /**
   * The cloud role ARN in AWS for this feature
   */
  cloudRoleArn?: string;
}

/**
 * The databases data security posture management (DSPM) configuration
 */
model DefenderFoDatabasesAwsOfferingDatabasesDspm {
  /**
   * Is databases data security posture management (DSPM) protection enabled
   */
  enabled?: boolean;

  /**
   * The cloud role ARN in AWS for this feature
   */
  cloudRoleArn?: string;
}

/**
 * The CSPM monitoring for GCP offering
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model cspmMonitorGcpOffering extends cloudOffering {
  /**
   * The native cloud connection configuration
   */
  nativeCloudConnection?: CspmMonitorGcpOfferingNativeCloudConnection;

  /**
   * The type of the security offering.
   */
  offeringType: "CspmMonitorGcp";
}

/**
 * The native cloud connection configuration
 */
model CspmMonitorGcpOfferingNativeCloudConnection {
  /**
   * The GCP workload identity provider id for the offering
   */
  workloadIdentityProviderId?: string;

  /**
   * The service account email address in GCP for this offering
   */
  serviceAccountEmailAddress?: string;
}

/**
 * The Defender for Servers GCP offering configurations
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model defenderForServersGcpOffering extends cloudOffering {
  /**
   * The Defender for servers connection configuration
   */
  defenderForServers?: DefenderForServersGcpOfferingDefenderForServers;

  /**
   * The ARC autoprovisioning configuration
   */
  arcAutoProvisioning?: DefenderForServersGcpOfferingArcAutoProvisioning;

  /**
   * The Vulnerability Assessment autoprovisioning configuration
   */
  vaAutoProvisioning?: DefenderForServersGcpOfferingVaAutoProvisioning;

  /**
   * The Microsoft Defender for Endpoint autoprovisioning configuration
   */
  mdeAutoProvisioning?: DefenderForServersGcpOfferingMdeAutoProvisioning;

  /**
   * configuration for the servers offering subPlan
   */
  subPlan?: DefenderForServersGcpOfferingSubPlan;

  /**
   * The Microsoft Defender for Server VM scanning configuration
   */
  vmScanners?: defenderForServersGcpOfferingVmScanners;

  /**
   * The type of the security offering.
   */
  offeringType: "DefenderForServersGcp";
}

/**
 * The Defender for servers connection configuration
 */
model DefenderForServersGcpOfferingDefenderForServers {
  /**
   * The workload identity provider id in GCP for this feature
   */
  workloadIdentityProviderId?: string;

  /**
   * The service account email address in GCP for this feature
   */
  serviceAccountEmailAddress?: string;
}

/**
 * The ARC autoprovisioning configuration
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DefenderForServersGcpOfferingArcAutoProvisioning
  extends arcAutoProvisioningGcp {}

/**
 * The ARC autoprovisioning configuration for an GCP environment
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model arcAutoProvisioningGcp extends arcAutoProvisioning {}

/**
 * The Vulnerability Assessment autoprovisioning configuration
 */
model DefenderForServersGcpOfferingVaAutoProvisioning {
  /**
   * Is Vulnerability Assessment auto provisioning enabled
   */
  enabled?: boolean;

  /**
   * configuration for Vulnerability Assessment autoprovisioning
   */
  configuration?: DefenderForServersGcpOfferingVaAutoProvisioningConfiguration;
}

/**
 * configuration for Vulnerability Assessment autoprovisioning
 */
model DefenderForServersGcpOfferingVaAutoProvisioningConfiguration {
  /**
   * The Vulnerability Assessment solution to be provisioned. Can be either 'TVM' or 'Qualys'
   */
  type?: Type;
}

/**
 * The Microsoft Defender for Endpoint autoprovisioning configuration
 */
model DefenderForServersGcpOfferingMdeAutoProvisioning {
  /**
   * Is Microsoft Defender for Endpoint auto provisioning enabled
   */
  enabled?: boolean;

  /**
   * configuration for Microsoft Defender for Endpoint autoprovisioning
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  configuration?: unknown;
}

/**
 * configuration for the servers offering subPlan
 */
model DefenderForServersGcpOfferingSubPlan {
  /**
   * The available sub plans
   */
  type?: SubPlan;
}

/**
 * The Microsoft Defender for Server VM scanning configuration
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model defenderForServersGcpOfferingVmScanners extends vmScannersGcp {}

/**
 * A VM scanning configuration for a security offering of a GCP environment
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model vmScannersGcp extends vmScannersBase {}

/**
 * The Defender for Databases GCP offering configurations
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model defenderForDatabasesGcpOffering extends cloudOffering {
  /**
   * The ARC autoprovisioning configuration
   */
  arcAutoProvisioning?: DefenderForDatabasesGcpOfferingArcAutoProvisioning;

  /**
   * The native cloud connection configuration
   */
  defenderForDatabasesArcAutoProvisioning?: DefenderForDatabasesGcpOfferingDefenderForDatabasesArcAutoProvisioning;

  /**
   * The type of the security offering.
   */
  offeringType: "DefenderForDatabasesGcp";
}

/**
 * The ARC autoprovisioning configuration
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DefenderForDatabasesGcpOfferingArcAutoProvisioning
  extends arcAutoProvisioningGcp {}

/**
 * The native cloud connection configuration
 */
model DefenderForDatabasesGcpOfferingDefenderForDatabasesArcAutoProvisioning {
  /**
   * The service account email address in GCP for this offering
   */
  serviceAccountEmailAddress?: string;

  /**
   * The GCP workload identity provider id for this offering
   */
  workloadIdentityProviderId?: string;
}

/**
 * The containers GCP offering
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model defenderForContainersGcpOffering extends cloudOffering {
  /**
   * The native cloud connection configuration
   */
  nativeCloudConnection?: DefenderForContainersGcpOfferingNativeCloudConnection;

  /**
   * The native cloud connection configuration
   */
  dataPipelineNativeCloudConnection?: DefenderForContainersGcpOfferingDataPipelineNativeCloudConnection;

  /**
   * Is audit logs data collection enabled
   */
  enableAuditLogsAutoProvisioning?: boolean;

  /**
   * Is Microsoft Defender for Cloud Kubernetes agent auto provisioning enabled
   */
  enableDefenderAgentAutoProvisioning?: boolean;

  /**
   * Is Policy Kubernetes agent auto provisioning enabled
   */
  enablePolicyAgentAutoProvisioning?: boolean;

  /**
   * The Microsoft Defender Container image assessment configuration
   */
  mdcContainersImageAssessment?: DefenderForContainersGcpOfferingMdcContainersImageAssessment;

  /**
   * The Microsoft Defender Container agentless discovery configuration
   */
  mdcContainersAgentlessDiscoveryK8s?: DefenderForContainersGcpOfferingMdcContainersAgentlessDiscoveryK8S;

  /**
   * The Microsoft Defender for Container K8s VM host scanning configuration
   */
  vmScanners?: defenderForContainersGcpOfferingVmScanners;

  /**
   * The type of the security offering.
   */
  offeringType: "DefenderForContainersGcp";
}

/**
 * The native cloud connection configuration
 */
model DefenderForContainersGcpOfferingNativeCloudConnection {
  /**
   * The service account email address in GCP for this offering
   */
  serviceAccountEmailAddress?: string;

  /**
   * The GCP workload identity provider id for this offering
   */
  workloadIdentityProviderId?: string;
}

/**
 * The native cloud connection configuration
 */
model DefenderForContainersGcpOfferingDataPipelineNativeCloudConnection {
  /**
   * The data collection service account email address in GCP for this offering
   */
  serviceAccountEmailAddress?: string;

  /**
   * The data collection GCP workload identity provider id for this offering
   */
  workloadIdentityProviderId?: string;
}

/**
 * The Microsoft Defender Container image assessment configuration
 */
model DefenderForContainersGcpOfferingMdcContainersImageAssessment {
  /**
   * Is Microsoft Defender container image assessment enabled
   */
  enabled?: boolean;

  /**
   * The workload identity provider id in GCP for this feature
   */
  workloadIdentityProviderId?: string;

  /**
   * The service account email address in GCP for this feature
   */
  serviceAccountEmailAddress?: string;
}

/**
 * The Microsoft Defender Container agentless discovery configuration
 */
model DefenderForContainersGcpOfferingMdcContainersAgentlessDiscoveryK8S {
  /**
   * Is Microsoft Defender container agentless discovery enabled
   */
  enabled?: boolean;

  /**
   * The workload identity provider id in GCP for this feature
   */
  workloadIdentityProviderId?: string;

  /**
   * The service account email address in GCP for this feature
   */
  serviceAccountEmailAddress?: string;
}

/**
 * The Microsoft Defender for Container K8s VM host scanning configuration
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model defenderForContainersGcpOfferingVmScanners extends vmScannersGcp {}

/**
 * The CSPM monitoring for github offering
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model cspmMonitorGithubOffering extends cloudOffering {
  /**
   * The type of the security offering.
   */
  offeringType: "CspmMonitorGithub";
}

/**
 * The CSPM monitoring for AzureDevOps offering
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model cspmMonitorAzureDevOpsOffering extends cloudOffering {
  /**
   * The type of the security offering.
   */
  offeringType: "CspmMonitorAzureDevOps";
}

/**
 * The CSPM P1 for AWS offering
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model defenderCspmAwsOffering extends cloudOffering {
  /**
   * The Microsoft Defender for CSPM offering VM scanning configuration
   */
  vmScanners?: defenderCspmAwsOfferingVmScanners;

  /**
   * The Microsoft Defender Data Sensitivity discovery configuration
   */
  dataSensitivityDiscovery?: DefenderCspmAwsOfferingDataSensitivityDiscovery;

  /**
   * The databases DSPM configuration
   */
  databasesDspm?: DefenderCspmAwsOfferingDatabasesDspm;

  /**
   * Defenders CSPM Permissions Management offering configurations
   */
  ciem?: DefenderCspmAwsOfferingCiem;

  /**
   * The Microsoft Defender container image assessment configuration
   */
  mdcContainersImageAssessment?: DefenderCspmAwsOfferingMdcContainersImageAssessment;

  /**
   * The Microsoft Defender container agentless discovery K8s configuration
   */
  mdcContainersAgentlessDiscoveryK8s?: DefenderCspmAwsOfferingMdcContainersAgentlessDiscoveryK8S;

  /**
   * The type of the security offering.
   */
  offeringType: "DefenderCspmAws";
}

/**
 * The Microsoft Defender for CSPM offering VM scanning configuration
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model defenderCspmAwsOfferingVmScanners extends vmScannersAws {}

/**
 * The Microsoft Defender Data Sensitivity discovery configuration
 */
model DefenderCspmAwsOfferingDataSensitivityDiscovery {
  /**
   * Is Microsoft Defender Data Sensitivity discovery enabled
   */
  enabled?: boolean;

  /**
   * The cloud role ARN in AWS for this feature
   */
  cloudRoleArn?: string;
}

/**
 * The databases DSPM configuration
 */
model DefenderCspmAwsOfferingDatabasesDspm {
  /**
   * Is databases DSPM protection enabled
   */
  enabled?: boolean;

  /**
   * The cloud role ARN in AWS for this feature
   */
  cloudRoleArn?: string;
}

/**
 * Defenders CSPM Permissions Management offering configurations
 */
model DefenderCspmAwsOfferingCiem {
  /**
   * Defender CSPM Permissions Management discovery configuration
   */
  ciemDiscovery?: DefenderCspmAwsOfferingCiemCiemDiscovery;

  /**
   * AWS Defender CSPM Permissions Management OIDC (open id connect) connection configurations
   */
  ciemOidc?: DefenderCspmAwsOfferingCiemCiemOidc;
}

/**
 * Defender CSPM Permissions Management discovery configuration
 */
model DefenderCspmAwsOfferingCiemCiemDiscovery {
  /**
   * The cloud role ARN in AWS for Permissions Management discovery
   */
  cloudRoleArn?: string;
}

/**
 * AWS Defender CSPM Permissions Management OIDC (open id connect) connection configurations
 */
model DefenderCspmAwsOfferingCiemCiemOidc {
  /**
   * The cloud role ARN in AWS for Permissions Management used for oidc connection
   */
  cloudRoleArn?: string;

  /**
   * the azure active directory app name used of authenticating against AWS
   */
  azureActiveDirectoryAppName?: string;
}

/**
 * The Microsoft Defender container image assessment configuration
 */
model DefenderCspmAwsOfferingMdcContainersImageAssessment {
  /**
   * Is Microsoft Defender container image assessment enabled
   */
  enabled?: boolean;

  /**
   * The cloud role ARN in AWS for this feature
   */
  cloudRoleArn?: string;
}

/**
 * The Microsoft Defender container agentless discovery K8s configuration
 */
model DefenderCspmAwsOfferingMdcContainersAgentlessDiscoveryK8S {
  /**
   * Is Microsoft Defender container agentless discovery K8s enabled
   */
  enabled?: boolean;

  /**
   * The cloud role ARN in AWS for this feature
   */
  cloudRoleArn?: string;
}

/**
 * The CSPM P1 for GCP offering
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model defenderCspmGcpOffering extends cloudOffering {
  /**
   * GCP Defenders CSPM Permissions Management OIDC (Open ID connect) connection configurations
   */
  ciemDiscovery?: DefenderCspmGcpOfferingCiemDiscovery;

  /**
   * The Microsoft Defender for CSPM VM scanning configuration
   */
  vmScanners?: defenderCspmGcpOfferingVmScanners;

  /**
   * The Microsoft Defender Data Sensitivity discovery configuration
   */
  dataSensitivityDiscovery?: DefenderCspmGcpOfferingDataSensitivityDiscovery;

  /**
   * The Microsoft Defender Container image assessment configuration
   */
  mdcContainersImageAssessment?: DefenderCspmGcpOfferingMdcContainersImageAssessment;

  /**
   * The Microsoft Defender Container agentless discovery configuration
   */
  mdcContainersAgentlessDiscoveryK8s?: DefenderCspmGcpOfferingMdcContainersAgentlessDiscoveryK8S;

  /**
   * The type of the security offering.
   */
  offeringType: "DefenderCspmGcp";
}

/**
 * GCP Defenders CSPM Permissions Management OIDC (Open ID connect) connection configurations
 */
model DefenderCspmGcpOfferingCiemDiscovery {
  /**
   * The GCP workload identity provider id for Permissions Management offering
   */
  workloadIdentityProviderId?: string;

  /**
   * The service account email address in GCP for Permissions Management offering
   */
  serviceAccountEmailAddress?: string;

  /**
   * the azure active directory app name used of authenticating against GCP workload identity federation
   */
  azureActiveDirectoryAppName?: string;
}

/**
 * The Microsoft Defender for CSPM VM scanning configuration
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model defenderCspmGcpOfferingVmScanners extends vmScannersGcp {}

/**
 * The Microsoft Defender Data Sensitivity discovery configuration
 */
model DefenderCspmGcpOfferingDataSensitivityDiscovery {
  /**
   * Is Microsoft Defender Data Sensitivity discovery enabled
   */
  enabled?: boolean;

  /**
   * The workload identity provider id in GCP for this feature
   */
  workloadIdentityProviderId?: string;

  /**
   * The service account email address in GCP for this feature
   */
  serviceAccountEmailAddress?: string;
}

/**
 * The Microsoft Defender Container image assessment configuration
 */
model DefenderCspmGcpOfferingMdcContainersImageAssessment {
  /**
   * Is Microsoft Defender container image assessment enabled
   */
  enabled?: boolean;

  /**
   * The workload identity provider id in GCP for this feature
   */
  workloadIdentityProviderId?: string;

  /**
   * The service account email address in GCP for this feature
   */
  serviceAccountEmailAddress?: string;
}

/**
 * The Microsoft Defender Container agentless discovery configuration
 */
model DefenderCspmGcpOfferingMdcContainersAgentlessDiscoveryK8S {
  /**
   * Is Microsoft Defender container agentless discovery enabled
   */
  enabled?: boolean;

  /**
   * The workload identity provider id in GCP for this feature
   */
  workloadIdentityProviderId?: string;

  /**
   * The service account email address in GCP for this feature
   */
  serviceAccountEmailAddress?: string;
}

/**
 * The CSPM (Cloud security posture management) monitoring for gitlab offering
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model cspmMonitorGitLabOffering extends cloudOffering {
  /**
   * The type of the security offering.
   */
  offeringType: "CspmMonitorGitLab";
}

/**
 * The CSPM (Cloud security posture management) monitoring for Docker Hub offering
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model cspmMonitorDockerHubOffering extends cloudOffering {
  /**
   * The type of the security offering.
   */
  offeringType: "CspmMonitorDockerHub";
}

/**
 * The Defender for containers Docker Hub offering configurations
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model defenderForContainersDockerHubOffering extends cloudOffering {
  /**
   * The type of the security offering.
   */
  offeringType: "DefenderForContainersDockerHub";
}

/**
 * The Defender for CSPM Docker Hub offering configurations
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model defenderCspmDockerHubOffering extends cloudOffering {
  /**
   * The type of the security offering.
   */
  offeringType: "DefenderCspmDockerHub";
}

/**
 * The CSPM (Cloud security posture management) monitoring for JFrog Artifactory offering
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model cspmMonitorJFrogOffering extends cloudOffering {
  /**
   * The type of the security offering.
   */
  offeringType: "CspmMonitorJFrog";
}

/**
 * The Defender for Containers for JFrog Artifactory offering
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model defenderForContainersJFrogOffering extends cloudOffering {
  /**
   * The type of the security offering.
   */
  offeringType: "DefenderForContainersJFrog";
}

/**
 * The CSPM P1 for JFrog Artifactory offering
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model defenderCspmJFrogOffering extends cloudOffering {
  /**
   * The Microsoft Defender Container image assessment configuration
   */
  mdcContainersImageAssessment?: DefenderCspmJFrogOfferingMdcContainersImageAssessment;

  /**
   * The type of the security offering.
   */
  offeringType: "DefenderCspmJFrog";
}

/**
 * The Microsoft Defender Container image assessment configuration
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DefenderCspmJFrogOfferingMdcContainersImageAssessment {
  /**
   * Is Microsoft Defender container image assessment enabled
   */
  enabled?: boolean;
}
