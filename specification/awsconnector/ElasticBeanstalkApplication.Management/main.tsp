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

//---------------------------------------------- ElasticBeanstalkApplications ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Elastic Beanstalk Application",
    plural: "Elastic Beanstalk Applications",
  },
  keywords: ["Microsoft.AwsConnector", "Elastic", "Beanstalk", "Application"],
})
@doc("A Microsoft.AwsConnector resource")
model ElasticBeanstalkApplication
  is TrackedResource<ElasticBeanstalkApplicationProperties> {
  @doc("Name of ElasticBeanstalkApplication")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("elasticBeanstalkApplications")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ElasticBeanstalkApplication")
model ElasticBeanstalkApplicationProperties {
  @doc("AWS Properties")
  awsProperties?: AwsElasticBeanstalkApplicationProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsElasticBeanstalkApplication")
model AwsElasticBeanstalkApplicationProperties {
  @doc("A name for the Elastic Beanstalk application. If you don't specify a name, AWS CloudFormation generates a unique physical ID and uses that ID for the application name.")
  applicationName?: string;

  @doc("Your description of the application.")
  description?: string;

  @doc("Specifies an application resource lifecycle configuration to prevent your application from accumulating too many versions.")
  resourceLifecycleConfig?: ApplicationResourceLifecycleConfig;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ApplicationResourceLifecycleConfig")
model ApplicationResourceLifecycleConfig {
  @doc("The ARN of an IAM service role that Elastic Beanstalk has permission to assume. The ServiceRole property is required the first time that you provide a ResourceLifecycleConfig for the application. After you provide it once, Elastic Beanstalk persists the Service Role with the application, and you don't need to specify it again. You can, however, specify it in subsequent updates to change the Service Role to another value.")
  serviceRole?: string;

  @doc("Defines lifecycle settings for application versions.")
  versionLifecycleConfig?: ApplicationVersionLifecycleConfig;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ApplicationVersionLifecycleConfig")
model ApplicationVersionLifecycleConfig {
  @doc("Specify a max age rule to restrict the length of time that application versions are retained for an application.")
  maxAgeRule?: MaxAgeRule;

  @doc("Specify a max count rule to restrict the number of application versions that are retained for an application.")
  maxCountRule?: MaxCountRule;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MaxAgeRule")
model MaxAgeRule {
  @doc("Set to true to delete a version's source bundle from Amazon S3 when Elastic Beanstalk deletes the application version.")
  deleteSourceFromS3?: boolean;

  @doc("Specify true to apply the rule, or false to disable it.")
  enabled?: boolean;

  @doc("Specify the number of days to retain an application versions.")
  maxAgeInDays?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MaxCountRule")
model MaxCountRule {
  @doc("Set to true to delete a version's source bundle from Amazon S3 when Elastic Beanstalk deletes the application version.")
  deleteSourceFromS3?: boolean;

  @doc("Specify true to apply the rule, or false to disable it.")
  enabled?: boolean;

  @doc("Specify the maximum number of application versions to retain.")
  maxCount?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface ElasticBeanstalkApplications {
  get is ArmResourceRead<ElasticBeanstalkApplication>;
  @doc("Create a ElasticBeanstalkApplication. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<ElasticBeanstalkApplication>;
  update is ArmCustomPatchAsync<
    ElasticBeanstalkApplication,
    Azure.ResourceManager.Foundations.TagsUpdateModel<ElasticBeanstalkApplication>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ElasticBeanstalkApplication>;
  listByResourceGroup is ArmResourceListByParent<ElasticBeanstalkApplication>;
  listBySubscription is ArmListBySubscription<ElasticBeanstalkApplication>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::ElasticBeanstalk::Application
//--------------------------------------------------------------------------------------------
