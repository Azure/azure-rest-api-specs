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

//---------------------------------------------- SsmParameters ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "SSM Parameter",
    plural: "SSM Parameters",
  },
  keywords: ["Microsoft.AwsConnector", "SSM", "Parameter"],
})
@doc("A Microsoft.AwsConnector resource")
model SsmParameter is TrackedResource<SsmParameterProperties> {
  @doc("Name of SsmParameter")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ssmParameters")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SsmParameter")
model SsmParameterProperties {
  @doc("AWS Properties")
  awsProperties?: AwsSsmParameterProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsSsmParameter")
model AwsSsmParameterProperties {
  @doc("A regular expression used to validate the parameter value. For example, for ``String`` types with values restricted to numbers, you can specify the following: ``AllowedPattern=^\\d+$``")
  allowedPattern?: string;

  @doc("The data type of the parameter, such as ``text`` or ``aws:ec2:image``. The default is ``text``.")
  dataType?: DataType;

  @doc("Information about the parameter.")
  description?: string;

  @doc("The name of the parameter.  The maximum length constraint listed below includes capacity for additional system attributes that aren't part of the name. The maximum length for a parameter name, including the full length of the parameter Amazon Resource Name (ARN), is 1011 characters. For example, the length of the following parameter name is 65 characters, not 20 characters: ``arn:aws:ssm:us-east-2:111222333444:parameter/ExampleParameterName``")
  name?: string;

  @doc("Information about the policies assigned to a parameter.  [Assigning parameter policies](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-policies.html) in the *User Guide*.")
  policies?: string;

  @doc("Optional metadata that you assign to a resource in the form of an arbitrary set of tags (key-value pairs). Tags enable you to categorize a resource in different ways, such as by purpose, owner, or environment. For example, you might want to tag a SYS parameter to identify the type of resource to which it applies, the environment, or the type of configuration data referenced by the parameter.")
  tags?: unknown;

  @doc("The parameter tier.")
  tier?: Tier;

  @doc("The type of parameter.")
  type?: Type;

  @doc("The parameter value.  If type is ``StringList``, the system returns a comma-separated string with no spaces between commas in the ``Value`` field.")
  value?: string;
}

@doc("DataType enum")
union DataType {
  @doc("DataType enum aws:ec2:image")
  AwsEc2Image: "aws:ec2:image",

  @doc("DataType enum text")
  text: "text",

  string,
}

@doc("Type enum")
union Type {
  @doc("Type enum String")
  String: "String",

  @doc("Type enum StringList")
  StringList: "StringList",

  string,
}

@doc("Tier enum")
union Tier {
  @doc("Tier enum Advanced")
  Advanced: "Advanced",

  @doc("Tier enum Intelligent-Tiering")
  IntelligentTiering: "Intelligent-Tiering",

  @doc("Tier enum Standard")
  Standard: "Standard",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface SsmParameters {
  get is ArmResourceRead<SsmParameter>;
  @doc("Create a SsmParameter. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<SsmParameter>;
  update is ArmCustomPatchAsync<
    SsmParameter,
    Azure.ResourceManager.Foundations.TagsUpdateModel<SsmParameter>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<SsmParameter>;
  listByResourceGroup is ArmResourceListByParent<SsmParameter>;
  listBySubscription is ArmListBySubscription<SsmParameter>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::SSM::Parameter
//--------------------------------------------------------------------------------------------
