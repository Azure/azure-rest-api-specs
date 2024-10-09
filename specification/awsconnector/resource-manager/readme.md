# awsconnector

> see https://aka.ms/autorest

This is the AutoRest configuration file for awsconnector.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the awsconnector.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2024-12-01
```

### Tag: package-2024-12-01

These settings apply only when `--tag=package-2024-12-01` is specified on the command line.

``` yaml $(tag) == 'package-2024-12-01'
input-file:
  - Microsoft.AwsConnector/stable/2024-12-01/accessAnalyzerAnalyzer.json
  - Microsoft.AwsConnector/stable/2024-12-01/acmCertificateSummary.json
  - Microsoft.AwsConnector/stable/2024-12-01/apiGatewayRestApi.json
  - Microsoft.AwsConnector/stable/2024-12-01/apiGatewayStage.json
  - Microsoft.AwsConnector/stable/2024-12-01/appSyncGraphqlApi.json
  - Microsoft.AwsConnector/stable/2024-12-01/autoScalingAutoScalingGroup.json
  - Microsoft.AwsConnector/stable/2024-12-01/cloudFormationStack.json
  - Microsoft.AwsConnector/stable/2024-12-01/cloudFormationStackSet.json
  - Microsoft.AwsConnector/stable/2024-12-01/cloudFrontDistribution.json
  - Microsoft.AwsConnector/stable/2024-12-01/cloudTrailTrail.json
  - Microsoft.AwsConnector/stable/2024-12-01/cloudWatchAlarm.json
  - Microsoft.AwsConnector/stable/2024-12-01/codeBuildProject.json
  - Microsoft.AwsConnector/stable/2024-12-01/codeBuildSourceCredentialsInfo.json
  - Microsoft.AwsConnector/stable/2024-12-01/configServiceConfigurationRecorder.json
  - Microsoft.AwsConnector/stable/2024-12-01/configServiceConfigurationRecorderStatus.json
  - Microsoft.AwsConnector/stable/2024-12-01/configServiceDeliveryChannel.json
  - Microsoft.AwsConnector/stable/2024-12-01/databaseMigrationServiceReplicationInstance.json
  - Microsoft.AwsConnector/stable/2024-12-01/daxCluster.json
  - Microsoft.AwsConnector/stable/2024-12-01/dynamoDBContinuousBackupsDescription.json
  - Microsoft.AwsConnector/stable/2024-12-01/dynamoDBTable.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2AccountAttribute.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2Address.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2FlowLog.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2Image.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2Instance.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2InstanceStatus.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2Ipam.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2KeyPair.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2NetworkAcl.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2NetworkInterface.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2RouteTable.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2SecurityGroup.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2Snapshot.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2Subnet.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2Volume.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2Vpc.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2VPCEndpoint.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2VPCPeeringConnection.json
  - Microsoft.AwsConnector/stable/2024-12-01/ecrImageDetail.json
  - Microsoft.AwsConnector/stable/2024-12-01/ecrRepository.json
  - Microsoft.AwsConnector/stable/2024-12-01/ecsCluster.json
  - Microsoft.AwsConnector/stable/2024-12-01/ecsService.json
  - Microsoft.AwsConnector/stable/2024-12-01/ecsTaskDefinition.json
  - Microsoft.AwsConnector/stable/2024-12-01/efsFileSystem.json
  - Microsoft.AwsConnector/stable/2024-12-01/efsMountTarget.json
  - Microsoft.AwsConnector/stable/2024-12-01/eksCluster.json
  - Microsoft.AwsConnector/stable/2024-12-01/eksNodegroup.json
  - Microsoft.AwsConnector/stable/2024-12-01/elasticBeanstalkApplication.json
  - Microsoft.AwsConnector/stable/2024-12-01/elasticBeanstalkConfigurationTemplate.json
  - Microsoft.AwsConnector/stable/2024-12-01/elasticBeanstalkEnvironment.json
  - Microsoft.AwsConnector/stable/2024-12-01/elasticLoadBalancingV2Listener.json
  - Microsoft.AwsConnector/stable/2024-12-01/elasticLoadBalancingV2LoadBalancer.json
  - Microsoft.AwsConnector/stable/2024-12-01/elasticLoadBalancingV2TargetGroup.json
  - Microsoft.AwsConnector/stable/2024-12-01/elasticLoadBalancingV2TargetHealthDescription.json
  - Microsoft.AwsConnector/stable/2024-12-01/emrCluster.json
  - Microsoft.AwsConnector/stable/2024-12-01/emrClusterSummary.json
  - Microsoft.AwsConnector/stable/2024-12-01/guardDutyDetector.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamAccessKeyLastUsed.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamAccessKeyMetadata.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamGroup.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamInstanceProfile.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamMFADevice.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamPasswordPolicy.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamPolicyVersion.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamRole.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamServerCertificate.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamVirtualMFADevice.json
  - Microsoft.AwsConnector/stable/2024-12-01/kmsAlias.json
  - Microsoft.AwsConnector/stable/2024-12-01/kmsKey.json
  - Microsoft.AwsConnector/stable/2024-12-01/lambdaFunction.json
  - Microsoft.AwsConnector/stable/2024-12-01/lambdaFunctionCodeLocation.json
  - Microsoft.AwsConnector/stable/2024-12-01/lightsailBucket.json
  - Microsoft.AwsConnector/stable/2024-12-01/lightsailInstance.json
  - Microsoft.AwsConnector/stable/2024-12-01/logsLogGroup.json
  - Microsoft.AwsConnector/stable/2024-12-01/logsLogStream.json
  - Microsoft.AwsConnector/stable/2024-12-01/logsMetricFilter.json
  - Microsoft.AwsConnector/stable/2024-12-01/logsSubscriptionFilter.json
  - Microsoft.AwsConnector/stable/2024-12-01/macie2JobSummary.json
  - Microsoft.AwsConnector/stable/2024-12-01/macieAllowList.json
  - Microsoft.AwsConnector/stable/2024-12-01/networkFirewallFirewall.json
  - Microsoft.AwsConnector/stable/2024-12-01/networkFirewallFirewallPolicy.json
  - Microsoft.AwsConnector/stable/2024-12-01/networkFirewallRuleGroup.json
  - Microsoft.AwsConnector/stable/2024-12-01/openSearchDomainStatus.json
  - Microsoft.AwsConnector/stable/2024-12-01/operations.json
  - Microsoft.AwsConnector/stable/2024-12-01/organizationsAccount.json
  - Microsoft.AwsConnector/stable/2024-12-01/organizationsOrganization.json
  - Microsoft.AwsConnector/stable/2024-12-01/rdsDBCluster.json
  - Microsoft.AwsConnector/stable/2024-12-01/rdsDBInstance.json
  - Microsoft.AwsConnector/stable/2024-12-01/rdsDBSnapshot.json
  - Microsoft.AwsConnector/stable/2024-12-01/rdsDBSnapshotAttributesResult.json
  - Microsoft.AwsConnector/stable/2024-12-01/rdsEventSubscription.json
  - Microsoft.AwsConnector/stable/2024-12-01/rdsExportTask.json
  - Microsoft.AwsConnector/stable/2024-12-01/redshiftCluster.json
  - Microsoft.AwsConnector/stable/2024-12-01/redshiftClusterParameterGroup.json
  - Microsoft.AwsConnector/stable/2024-12-01/route53DomainsDomainSummary.json
  - Microsoft.AwsConnector/stable/2024-12-01/route53HostedZone.json
  - Microsoft.AwsConnector/stable/2024-12-01/route53ResourceRecordSet.json
  - Microsoft.AwsConnector/stable/2024-12-01/s3AccessPoint.json
  - Microsoft.AwsConnector/stable/2024-12-01/s3Bucket.json
  - Microsoft.AwsConnector/stable/2024-12-01/s3BucketPolicy.json
  - Microsoft.AwsConnector/stable/2024-12-01/s3ControlMultiRegionAccessPointPolicyDocument.json
  - Microsoft.AwsConnector/stable/2024-12-01/sageMakerApp.json
  - Microsoft.AwsConnector/stable/2024-12-01/sageMakerNotebookInstanceSummary.json
  - Microsoft.AwsConnector/stable/2024-12-01/secretsManagerResourcePolicy.json
  - Microsoft.AwsConnector/stable/2024-12-01/secretsManagerSecret.json
  - Microsoft.AwsConnector/stable/2024-12-01/snsSubscription.json
  - Microsoft.AwsConnector/stable/2024-12-01/snsTopic.json
  - Microsoft.AwsConnector/stable/2024-12-01/sqsQueue.json
  - Microsoft.AwsConnector/stable/2024-12-01/ssmInstanceInformation.json
  - Microsoft.AwsConnector/stable/2024-12-01/ssmParameter.json
  - Microsoft.AwsConnector/stable/2024-12-01/ssmResourceComplianceSummaryItem.json
  - Microsoft.AwsConnector/stable/2024-12-01/wafv2LoggingConfiguration.json
  - Microsoft.AwsConnector/stable/2024-12-01/wafWebACLSummary.json
```

## Suppression

``` yaml
directive:
  - suppress: EnumInsteadOfBoolean
    reason: booleans are only used in aws
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Property is CamelCase in aws
  - suppress: AvoidAdditionalProperties
    reason: 1. Property represents user defined awsTags. 2. All swagger has awsTags.So, we cannot add from clause.
  - suppress: PatchPropertiesCorrespondToPutProperties
    reason: 1. Issue in LintDiff tool. 2. In patch we allow tags update only and in our TypeSpec we use ArmCustomPatchAsync{Azure.ResourceManager.Foundations.TagsUpdateModel<Resource>}. So, tags property in patch body and the same is not present in the corresponding put body and causing the issue. In case of the put we are using TrackedResource type and same has tags. 3. All typespec has TagsUpdateModel.So, we cannot add from clause.
  - suppress: EvenSegmentedPathForPutOperation
    reason: 1. Issue in LintDiff tool. 2. In TypeSpec we use @singleton (OpenAPI path ends with /default), we believe this is a false positive.  Related issue:https://github.com/Azure/azure-openapi-validator/issues/646
    from:
      - ec2Instance.json
      - eksCluster.json
  - suppress: XmsPageableForListCalls
    reason: 1. Issue in LintDiff tool. 2. In TypeSpec we use @singleton (OpenAPI path ends with /default), we believe this is a false positive.  Related issue:https://github.com/Azure/azure-openapi-validator/issues/646
    from:
      - ec2Instance.json
      - eksCluster.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-js
  - repo: azure-resource-manager-schemas
  - repo: azure-cli-extensions
  - repo: azure-powershell
```
## Az

See configuration in [readme.az.md](./readme.az.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)

## Java

See configuration in [readme.java.md](./readme.java.md)