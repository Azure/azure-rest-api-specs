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

//---------------------------------------------- ElasticBeanstalkConfigurationTemplates ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Elastic Beanstalk Configuration Template",
    plural: "Elastic Beanstalk Configuration Templates",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "Elastic",
    "Beanstalk",
    "Configuration",
    "Template"
  ],
})
@doc("A Microsoft.AwsConnector resource")
model ElasticBeanstalkConfigurationTemplate
  is TrackedResource<ElasticBeanstalkConfigurationTemplateProperties> {
  @doc("Name of ElasticBeanstalkConfigurationTemplate")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("elasticBeanstalkConfigurationTemplates")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ElasticBeanstalkConfigurationTemplate")
model ElasticBeanstalkConfigurationTemplateProperties {
  @doc("AWS Properties")
  awsProperties?: AwsElasticBeanstalkConfigurationTemplateProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsElasticBeanstalkConfigurationTemplate")
model AwsElasticBeanstalkConfigurationTemplateProperties {
  @doc("The name of the Elastic Beanstalk application to associate with this configuration template.")
  applicationName?: string;

  @doc("An optional description for this configuration.")
  description?: string;

  @doc("The ID of an environment whose settings you want to use to create the configuration template. You must specify EnvironmentId if you don't specify PlatformArn, SolutionStackName, or SourceConfiguration.")
  environmentId?: string;

  @doc("Option values for the Elastic Beanstalk configuration, such as the instance type. If specified, these values override the values obtained from the solution stack or the source configuration template. For a complete list of Elastic Beanstalk configuration options, see [Option Values](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options.html) in the AWS Elastic Beanstalk Developer Guide.")
  @extension("x-ms-identifiers", [])
  optionSettings?: ConfigurationOptionSetting[];

  @doc("The Amazon Resource Name (ARN) of the custom platform. For more information, see [Custom Platforms](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/custom-platforms.html) in the AWS Elastic Beanstalk Developer Guide.")
  platformArn?: string;

  @doc("The name of an Elastic Beanstalk solution stack (platform version) that this configuration uses. For example, 64bit Amazon Linux 2013.09 running Tomcat 7 Java 7. A solution stack specifies the operating system, runtime, and application server for a configuration template. It also determines the set of configuration options as well as the possible and default values. For more information, see [Supported Platforms](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/concepts.platforms.html) in the AWS Elastic Beanstalk Developer Guide. You must specify SolutionStackName if you don't specify PlatformArn, EnvironmentId, or SourceConfiguration. Use the ListAvailableSolutionStacks API to obtain a list of available solution stacks.")
  solutionStackName?: string;

  @doc("An Elastic Beanstalk configuration template to base this one on. If specified, Elastic Beanstalk uses the configuration values from the specified configuration template to create a new configuration.Values specified in OptionSettings override any values obtained from the SourceConfiguration.You must specify SourceConfiguration if you don't specify PlatformArn, EnvironmentId, or SolutionStackName.Constraint: If both solution stack name and source configuration are specified, the solution stack of the source configuration template must match the specified solution stack name.")
  sourceConfiguration?: SourceConfiguration;

  @doc("The name of the configuration template")
  templateName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ConfigurationOptionSetting")
model ConfigurationOptionSetting {
  @doc("A unique namespace that identifies the option's associated AWS resource.")
  `namespace`?: string;

  @doc("The name of the configuration option.")
  optionName?: string;

  @doc("A unique resource name for the option setting. Use it for a time–based scaling configuration option.")
  resourceName?: string;

  @doc("The current value for the configuration option.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SourceConfiguration")
model SourceConfiguration {
  @doc("The name of the application associated with the configuration.")
  applicationName?: string;

  @doc("The name of the configuration template.")
  templateName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface ElasticBeanstalkConfigurationTemplates {
  get is ArmResourceRead<ElasticBeanstalkConfigurationTemplate>;
  @doc("Create a ElasticBeanstalkConfigurationTemplate. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<ElasticBeanstalkConfigurationTemplate>;
  update is ArmCustomPatchAsync<
    ElasticBeanstalkConfigurationTemplate,
    Azure.ResourceManager.Foundations.TagsUpdateModel<ElasticBeanstalkConfigurationTemplate>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ElasticBeanstalkConfigurationTemplate>;
  listByResourceGroup is ArmResourceListByParent<ElasticBeanstalkConfigurationTemplate>;
  listBySubscription is ArmListBySubscription<ElasticBeanstalkConfigurationTemplate>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::ElasticBeanstalk::ConfigurationTemplate
//--------------------------------------------------------------------------------------------
