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
openapi-subtype: providerHub
tag: package-2024-08-01-preview
```

### Tag: package-2023-12-01-preview

These settings apply only when `--tag=package-2023-12-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-12-01-preview'
input-file:
  - Microsoft.AwsConnector/preview/2023-12-01-preview/ec2Instance.json
  - Microsoft.AwsConnector/preview/2023-12-01-preview/lambdaFunctionConfiguration.json
  - Microsoft.AwsConnector/preview/2023-12-01-preview/operations.json
  - Microsoft.AwsConnector/preview/2023-12-01-preview/s3Bucket.json
```

### Tag: package-2024-08-01-preview

These settings apply only when `--tag=package-2024-08-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2024-08-01-preview'
input-file:
  - Microsoft.AwsConnector/preview/2024-08-01-preview/apiGatewayRestApi.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/apiGatewayStage.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/applicationAutoScalingScalableTarget.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/cloudFormationStack.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/cloudFormationStackSet.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/cloudTrailTrail.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/cloudWatchAlarm.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/dynamoDBTable.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ec2Instance.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ec2InstanceStatus.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ec2KeyPair.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ec2NetworkAcl.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ec2NetworkInterface.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ec2RouteTable.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ec2SecurityGroup.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ec2Subnet.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ec2Volume.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ec2Vpc.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ec2VPCEndpoint.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ec2VPCPeeringConnection.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ecrRepository.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ecsCluster.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ecsService.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ecsTaskDefinition.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/efsFileSystem.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/efsMountTarget.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/eksCluster.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/eksNodegroup.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/elasticBeanstalkEnvironment.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/elasticLoadBalancingV2Listener.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/elasticLoadBalancingV2LoadBalancer.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/elasticLoadBalancingV2TargetGroup.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/elasticsearchDomain.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/guardDutyDetector.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/iamGroup.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/iamInstanceProfile.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/iamManagedPolicy.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/iamServerCertificate.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/iamUserPolicy.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/iamVirtualMFADevice.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/kmsKey.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/lambdaFunction.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/licenseManagerLicense.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/lightsailBucket.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/lightsailInstance.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/logsLogGroup.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/logsLogStream.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/logsMetricFilter.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/logsSubscriptionFilter.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/macieAllowList.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/networkFirewallFirewall.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/networkFirewallFirewallPolicy.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/networkFirewallRuleGroup.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/openSearchServiceDomain.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/operations.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/organizationsAccount.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/organizationsOrganization.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/rdsDBCluster.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/rdsDBInstance.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/rdsEventSubscription.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/redshiftCluster.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/redshiftClusterParameterGroup.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/route53HostedZone.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/s3AccessPoint.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/s3Bucket.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/s3BucketPolicy.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/sageMakerApp.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/sageMakerDevice.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/sageMakerImage.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/snsTopic.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/sqsQueue.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/wafv2IPSet.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/wafv2WebACLAssociation.json
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
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go-track2
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
