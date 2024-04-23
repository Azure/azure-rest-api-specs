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

//---------------------------------------------- EcsClusters ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model EcsCluster is TrackedResource<EcsClusterProperties> {
  @doc("Name of EcsCluster")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ecsClusters")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EcsCluster")
model EcsClusterProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsEcsClusterProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEcsCluster")
model AwsEcsClusterProperties {
  @doc("Gets and sets the property arn. The Amazon Resource Name (ARN) of the Amazon ECS cluster, such as arn:aws:ecs:us-east-2:123456789012:cluster/MyECSCluster.")
  arn?: string;

  @doc("Gets and sets the property capacityProviders.")
  @extension("x-ms-identifiers", [])
  capacityProviders?: string[];

  @doc("Gets and sets the property clusterName. A user-generated string that you use to identify your cluster. If you don't specify a name, AWS CloudFormation generates a unique physical ID for the name.")
  clusterName?: string;

  @doc("Gets and sets the property clusterSettings.")
  @extension("x-ms-identifiers", [])
  clusterSettings?: ClusterSettings[];

  @doc("Gets and sets the property configuration. The configurations to be set at cluster level.")
  configuration?: ClusterConfiguration;

  @doc("Gets and sets the property defaultCapacityProviderStrategy.")
  @extension("x-ms-identifiers", [])
  defaultCapacityProviderStrategy?: CapacityProviderStrategyItem[];

  @doc("Gets and sets the property serviceConnectDefaults. Service Connect Configuration default for all services or tasks within this cluster")
  serviceConnectDefaults?: ServiceConnectDefaults;

  @doc("Gets and sets the property tags.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ClusterSettings")
model ClusterSettings {
  @doc("Gets and sets the property name.")
  name?: string;

  @doc("Gets and sets the property value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ClusterConfiguration")
model ClusterConfiguration {
  @doc("Gets and sets the property executeCommandConfiguration. The configuration for ExecuteCommand.")
  executeCommandConfiguration?: ExecuteCommandConfiguration;
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ServiceConnectDefaults")
model ServiceConnectDefaults {
  @doc("Gets and sets the property `namespace`. Service Connect Namespace Name or ARN default for all services or tasks within this cluster")
  `namespace`?: string;
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
@doc("Definition of ExecuteCommandConfiguration")
model ExecuteCommandConfiguration {
  @doc("Gets and sets the property kmsKeyId.")
  kmsKeyId?: string;

  @doc("Gets and sets the property logConfiguration. The session logging configuration for ExecuteCommand.")
  logConfiguration?: ExecuteCommandLogConfiguration;

  @doc("Gets and sets the property logging.")
  logging?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ExecuteCommandLogConfiguration")
model ExecuteCommandLogConfiguration {
  @doc("Gets and sets the property cloudWatchEncryptionEnabled.")
  cloudWatchEncryptionEnabled?: boolean;

  @doc("Gets and sets the property cloudWatchLogGroupName.")
  cloudWatchLogGroupName?: string;

  @doc("Gets and sets the property s3BucketName.")
  s3BucketName?: string;

  @doc("Gets and sets the property s3EncryptionEnabled.")
  s3EncryptionEnabled?: boolean;

  @doc("Gets and sets the property s3KeyPrefix.")
  s3KeyPrefix?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface EcsClusters {
  get is ArmResourceRead<EcsCluster>;
  @doc("Create a EcsCluster. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EcsCluster>;
  update is ArmCustomPatchAsync<
    EcsCluster,
    Azure.ResourceManager.Foundations.TagsUpdateModel<EcsCluster>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<EcsCluster>;
  listByResourceGroup is ArmResourceListByParent<EcsCluster>;
  listBySubscription is ArmListBySubscription<EcsCluster>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::ECS::Cluster
//--------------------------------------------------------------------------------------------
