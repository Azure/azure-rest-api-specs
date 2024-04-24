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

//---------------------------------------------- ElasticBeanstalkEnvironments ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model ElasticBeanstalkEnvironment
  is TrackedResource<ElasticBeanstalkEnvironmentProperties> {
  @doc("Name of ElasticBeanstalkEnvironment")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("elasticBeanstalkEnvironments")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ElasticBeanstalkEnvironment")
model ElasticBeanstalkEnvironmentProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsElasticBeanstalkEnvironmentProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsElasticBeanstalkEnvironment")
model AwsElasticBeanstalkEnvironmentProperties {
  @doc("Gets and sets the property applicationName. The name of the application that is associated with this environment.")
  applicationName?: string;

  @doc("Gets and sets the property cnamePrefix. If specified, the environment attempts to use this value as the prefix for the CNAME in your Elastic Beanstalk environment URL. If not specified, the CNAME is generated automatically by appending a random alphanumeric string to the environment name.")
  cnamePrefix?: string;

  @doc("Gets and sets the property description. Your description for this environment.")
  description?: string;

  @doc("Gets and sets the property endpointURL.")
  endpointURL?: string;

  @doc("Gets and sets the property environmentName. A unique name for the environment.")
  environmentName?: string;

  @doc("Gets and sets the property operationsRole. The Amazon Resource Name (ARN) of an existing IAM role to be used as the environment's operations role.")
  operationsRole?: string;

  @doc("Gets and sets the property optionSettings. Key-value pairs defining configuration options for this environment, such as the instance type.")
  @extension("x-ms-identifiers", [])
  optionSettings?: OptionSetting[];

  @doc("Gets and sets the property platformArn. The Amazon Resource Name (ARN) of the custom platform to use with the environment.")
  platformArn?: string;

  @doc("Gets and sets the property solutionStackName. The name of an Elastic Beanstalk solution stack (platform version) to use with the environment.")
  solutionStackName?: string;

  @doc("Gets and sets the property tags. Specifies the tags applied to resources in the environment.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Gets and sets the property templateName. The name of the Elastic Beanstalk configuration template to use with the environment.")
  templateName?: string;

  @doc("Gets and sets the property tier. Specifies the tier to use in creating this environment. The environment tier that you choose determines whether Elastic Beanstalk provisions resources to support a web application that handles HTTP(S) requests or a web application that handles background-processing tasks.")
  tier?: Tier;

  @doc("Gets and sets the property versionLabel. The name of the application version to deploy.")
  versionLabel?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OptionSetting")
model OptionSetting {
  @doc("Gets and sets the property `namespace`. A unique namespace that identifies the option's associated AWS resource.")
  `namespace`?: string;

  @doc("Gets and sets the property optionName. The name of the configuration option.")
  optionName?: string;

  @doc("Gets and sets the property resourceName. A unique resource name for the option setting. Use it for a time–based scaling configuration option.")
  resourceName?: string;

  @doc("Gets and sets the property value. The current value for the configuration option.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key. The key name of the tag.")
  key?: string;

  @doc("Gets and sets the property value. The value for the tag.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tier")
model Tier {
  @doc("Gets and sets the property name. The name of this environment tier.")
  name?: string;

  @doc("Gets and sets the property type. The type of this environment tier.")
  type?: string;

  @doc("Gets and sets the property version. The version of this environment tier. When you don't set a value to it, Elastic Beanstalk uses the latest compatible worker tier version.")
  version?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface ElasticBeanstalkEnvironments {
  get is ArmResourceRead<ElasticBeanstalkEnvironment>;
  @doc("Create a ElasticBeanstalkEnvironment. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ElasticBeanstalkEnvironment>;
  update is ArmCustomPatchAsync<
    ElasticBeanstalkEnvironment,
    Azure.ResourceManager.Foundations.TagsUpdateModel<ElasticBeanstalkEnvironment>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ElasticBeanstalkEnvironment>;
  listByResourceGroup is ArmResourceListByParent<ElasticBeanstalkEnvironment>;
  listBySubscription is ArmListBySubscription<ElasticBeanstalkEnvironment>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::ElasticBeanstalk::Environment
//--------------------------------------------------------------------------------------------
