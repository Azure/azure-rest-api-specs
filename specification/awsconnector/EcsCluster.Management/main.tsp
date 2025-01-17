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

//---------------------------------------------- EcsClusters ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "ECS Cluster",
    plural: "ECS Clusters",
  },
  keywords: ["Microsoft.AwsConnector", "ECS", "Cluster"],
})
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
  @doc("AWS Properties")
  awsProperties?: AwsEcsClusterProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEcsCluster")
model AwsEcsClusterProperties {
  @doc("Property arn")
  arn?: string;

  @doc("The short name of one or more capacity providers to associate with the cluster. A capacity provider must be associated with a cluster before it can be included as part of the default capacity provider strategy of the cluster or used in a capacity provider strategy when calling the [CreateService](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_CreateService.html) or [RunTask](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_RunTask.html) actions. If specifying a capacity provider that uses an Auto Scaling group, the capacity provider must be created but not associated with another cluster. New Auto Scaling group capacity providers can be created with the [CreateCapacityProvider](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_CreateCapacityProvider.html) API operation. To use a FARGATElong capacity provider, specify either the ``FARGATE`` or ``FARGATE_SPOT`` capacity providers. The FARGATElong capacity providers are available to all accounts and only need to be associated with a cluster to be used. The [PutCapacityProvider](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_PutCapacityProvider.html) API operation is used to update the list of available capacity providers for a cluster after the cluster is created.")
  @extension("x-ms-identifiers", [])
  capacityProviders?: string[];

  @doc("A user-generated string that you use to identify your cluster. If you don't specify a name, CFNlong generates a unique physical ID for the name.")
  clusterName?: string;

  @doc("The settings to use when creating a cluster. This parameter is used to turn on CloudWatch Container Insights for a cluster.")
  @extension("x-ms-identifiers", [])
  clusterSettings?: ClusterSettings[];

  @doc("The execute command configuration for the cluster. The execute command configuration for the cluster.")
  configuration?: ClusterConfiguration;

  @doc("The default capacity provider strategy for the cluster. When services or tasks are run in the cluster with no launch type or capacity provider strategy specified, the default capacity provider strategy is used.")
  @extension("x-ms-identifiers", [])
  defaultCapacityProviderStrategy?: CapacityProviderStrategyItem[];

  @doc("Use this parameter to set a default Service Connect namespace. After you set a default Service Connect namespace, any new services with Service Connect turned on that are created in the cluster are added as client services in the namespace. This setting only applies to new services that set the ``enabled`` parameter to ``true`` in the ``ServiceConnectConfiguration``. You can set the namespace of each service individually in the ``ServiceConnectConfiguration`` to override this default parameter. Tasks that run in a namespace can use short names to connect to services in the namespace. Tasks can connect to services across all of the clusters in the namespace. Tasks connect through a managed proxy container that collects logs and metrics for increased visibility. Only the tasks that Amazon ECS services create are supported with Service Connect. For more information, see [Service Connect](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-connect.html) in the *Amazon Elastic Container Service Developer Guide*. Use this parameter to set a default Service Connect namespace. After you set a default Service Connect namespace, any new services with Service Connect turned on that are created in the cluster are added as client services in the namespace. This setting only applies to new services that set the ``enabled`` parameter to ``true`` in the ``ServiceConnectConfiguration``. You can set the namespace of each service individually in the ``ServiceConnectConfiguration`` to override this default parameter. Tasks that run in a namespace can use short names to connect to services in the namespace. Tasks can connect to services across all of the clusters in the namespace. Tasks connect through a managed proxy container that collects logs and metrics for increased visibility. Only the tasks that Amazon ECS services create are supported with Service Connect. For more information, see [Service Connect](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-connect.html) in the *Amazon Elastic Container Service Developer Guide*.")
  serviceConnectDefaults?: ServiceConnectDefaults;

  @doc("The metadata that you apply to the cluster to help you categorize and organize them. Each tag consists of a key and an optional value. You define both. The following basic restrictions apply to tags:  +  Maximum number of tags per resource - 50  +  For each resource, each tag key must be unique, and each tag key can have only one value.  +  Maximum key length - 128 Unicode characters in UTF-8  +  Maximum value length - 256 Unicode characters in UTF-8  +  If your tagging schema is used across multiple services and resources, remember that other services may have restrictions on allowed characters. Generally allowed characters are: letters, numbers, and spaces representable in UTF-8, and the following characters: + - = . _ : / @.  +  Tag keys and values are case-sensitive.  +  Do not use ``aws:``, ``AWS:``, or any upper or lowercase combination of such as a prefix for either keys or values as it is reserved for AWS use. You cannot edit or delete tag keys or values with this prefix. Tags with this prefix do not count against your tags per resource limit.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ClusterSettings")
model ClusterSettings {
  @doc("The name of the cluster setting. The value is ``containerInsights`` .")
  name?: string;

  @doc("The value to set for the cluster setting. The supported values are ``enabled`` and ``disabled``.  If you set ``name`` to ``containerInsights`` and ``value`` to ``enabled``, CloudWatch Container Insights will be on for the cluster, otherwise it will be off unless the ``containerInsights`` account setting is turned on. If a cluster value is specified, it will override the ``containerInsights`` value set with [PutAccountSetting](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_PutAccountSetting.html) or [PutAccountSettingDefault](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_PutAccountSettingDefault.html).")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ClusterConfiguration")
model ClusterConfiguration {
  @doc("The details of the execute command configuration. The details of the execute command configuration.")
  executeCommandConfiguration?: ExecuteCommandConfiguration;
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ServiceConnectDefaults")
model ServiceConnectDefaults {
  @doc("The namespace name or full Amazon Resource Name (ARN) of the CMAPlong namespace that's used when you create a service and don't specify a Service Connect configuration. The namespace name can include up to 1024 characters. The name is case-sensitive. The name can't include hyphens (-), tilde (~), greater than (>), less than (<), or slash (/). If you enter an existing namespace name or ARN, then that namespace will be used. Any namespace type is supported. The namespace must be in this account and this AWS Region. If you enter a new name, a CMAPlong namespace will be created. Amazon ECS creates a CMAP namespace with the 'API calls' method of instance discovery only. This instance discovery method is the 'HTTP' namespace type in the CLIlong. Other types of instance discovery aren't used by Service Connect. If you update the cluster with an empty string ``''`` for the namespace name, the cluster configuration for Service Connect is removed. Note that the namespace will remain in CMAP and must be deleted separately. For more information about CMAPlong, see [Working with Services](https://docs.aws.amazon.com/cloud-map/latest/dg/working-with-services.html) in the *Developer Guide*.")
  `namespace`?: string;
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
@doc("Definition of ExecuteCommandConfiguration")
model ExecuteCommandConfiguration {
  @doc("Specify an KMSlong key ID to encrypt the data between the local client and the container.")
  kmsKeyId?: string;

  @doc("The log configuration for the results of the execute command actions. The logs can be sent to CloudWatch Logs or an Amazon S3 bucket. When ``logging=OVERRIDE`` is specified, a ``logConfiguration`` must be provided. The log configuration for the results of the execute command actions. The logs can be sent to CloudWatch Logs or an Amazon S3 bucket.")
  logConfiguration?: ExecuteCommandLogConfiguration;

  @doc("The log setting to use for redirecting logs for your execute command results. The following log settings are available.  +   ``NONE``: The execute command session is not logged.  +   ``DEFAULT``: The ``awslogs`` configuration in the task definition is used. If no logging parameter is specified, it defaults to this value. If no ``awslogs`` log driver is configured in the task definition, the output won't be logged.  +   ``OVERRIDE``: Specify the logging details as a part of ``logConfiguration``. If the ``OVERRIDE`` logging option is specified, the ``logConfiguration`` is required.")
  logging?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ExecuteCommandLogConfiguration")
model ExecuteCommandLogConfiguration {
  @doc("Determines whether to use encryption on the CloudWatch logs. If not specified, encryption will be off.")
  cloudWatchEncryptionEnabled?: boolean;

  @doc("The name of the CloudWatch log group to send logs to.  The CloudWatch log group must already be created.")
  cloudWatchLogGroupName?: string;

  @doc("The name of the S3 bucket to send logs to.  The S3 bucket must already be created.")
  s3BucketName?: string;

  @doc("Determines whether to use encryption on the S3 logs. If not specified, encryption is not used.")
  s3EncryptionEnabled?: boolean;

  @doc("An optional folder in the S3 bucket to place logs in.")
  s3KeyPrefix?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface EcsClusters {
  get is ArmResourceRead<EcsCluster>;
  @doc("Create a EcsCluster. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<EcsCluster>;
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
