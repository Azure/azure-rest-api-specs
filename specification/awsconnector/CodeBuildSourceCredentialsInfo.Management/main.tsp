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

//---------------------------------------------- CodeBuildSourceCredentialsInfos ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Code Build Source Credentials Info",
    plural: "Code Build Source Credentials Infos",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "Code",
    "Build",
    "Source",
    "Credentials",
    "Info"
  ],
})
@doc("A Microsoft.AwsConnector resource")
model CodeBuildSourceCredentialsInfo
  is TrackedResource<CodeBuildSourceCredentialsInfoProperties> {
  @doc("Name of CodeBuildSourceCredentialsInfo")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("codeBuildSourceCredentialsInfos")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CodeBuildSourceCredentialsInfo")
model CodeBuildSourceCredentialsInfoProperties {
  @doc("AWS Properties")
  awsProperties?: AwsCodeBuildSourceCredentialsInfoProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsCodeBuildSourceCredentialsInfo")
model AwsCodeBuildSourceCredentialsInfoProperties {
  @doc("<p> The Amazon Resource Name (ARN) of the token. </p>")
  arn?: string;

  @doc("<p> The type of authentication used by the credentials. Valid options are OAUTH, BASIC_AUTH, PERSONAL_ACCESS_TOKEN, or CODECONNECTIONS. </p>")
  authType?: AuthTypeEnumValue;

  @doc("<p>The connection ARN if your serverType type is GITLAB or GITLAB_SELF_MANAGED and your authType is CODECONNECTIONS.</p>")
  resource?: string;

  @doc("<p> The type of source provider. The valid options are GITHUB, GITHUB_ENTERPRISE, GITLAB, GITLAB_SELF_MANAGED, or BITBUCKET. </p>")
  serverType?: ServerTypeEnumValue;
}

@doc("AuthType enum")
union AuthType {
  @doc("AuthType enum BASIC_AUTH")
  BASIC_AUTH: "BASIC_AUTH",

  @doc("AuthType enum CODECONNECTIONS")
  CODECONNECTIONS: "CODECONNECTIONS",

  @doc("AuthType enum OAUTH")
  OAUTH: "OAUTH",

  @doc("AuthType enum PERSONAL_ACCESS_TOKEN")
  PERSONAL_ACCESS_TOKEN: "PERSONAL_ACCESS_TOKEN",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AuthTypeEnumValue")
model AuthTypeEnumValue {
  @doc("Property value")
  value?: AuthType;
}

@doc("ServerType enum")
union ServerType {
  @doc("ServerType enum BITBUCKET")
  BITBUCKET: "BITBUCKET",

  @doc("ServerType enum GITHUB")
  GITHUB: "GITHUB",

  @doc("ServerType enum GITHUB_ENTERPRISE")
  GITHUB_ENTERPRISE: "GITHUB_ENTERPRISE",

  @doc("ServerType enum GITLAB")
  GITLAB: "GITLAB",

  @doc("ServerType enum GITLAB_SELF_MANAGED")
  GITLAB_SELF_MANAGED: "GITLAB_SELF_MANAGED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ServerTypeEnumValue")
model ServerTypeEnumValue {
  @doc("Property value")
  value?: ServerType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface CodeBuildSourceCredentialsInfos {
  get is ArmResourceRead<CodeBuildSourceCredentialsInfo>;
  @doc("Create a CodeBuildSourceCredentialsInfo. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<CodeBuildSourceCredentialsInfo>;
  update is ArmCustomPatchAsync<
    CodeBuildSourceCredentialsInfo,
    Azure.ResourceManager.Foundations.TagsUpdateModel<CodeBuildSourceCredentialsInfo>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<CodeBuildSourceCredentialsInfo>;
  listByResourceGroup is ArmResourceListByParent<CodeBuildSourceCredentialsInfo>;
  listBySubscription is ArmListBySubscription<CodeBuildSourceCredentialsInfo>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\codeBuild\codebuild-2016-10-06.normal.json
// AWS Shape: SourceCredentialsInfo
//
// Related information for backend service:
// AWS Servcie : CodeBuild
// Product Version : 3.7.798.0
// SDK Version : 3.7.306.11
//--------------------------------------------------------------------------------------------
