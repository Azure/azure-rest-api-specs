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

//---------------------------------------------- IamPasswordPolicies ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "IAM Password Policy",
    plural: "IAM Password Policies",
  },
  keywords: ["Microsoft.AwsConnector", "IAM", "Password", "Policy"],
})
@doc("A Microsoft.AwsConnector resource")
model IamPasswordPolicy is TrackedResource<IamPasswordPolicyProperties> {
  @doc("Name of IamPasswordPolicy")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("iamPasswordPolicies")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IamPasswordPolicy")
model IamPasswordPolicyProperties {
  @doc("AWS Properties")
  awsProperties?: AwsIamPasswordPolicyProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsIamPasswordPolicy")
model AwsIamPasswordPolicyProperties {
  @doc("<p>Specifies whether IAM users are allowed to change their own password. Gives IAM users permissions to <code>iam:ChangePassword</code> for only their user and to the <code>iam:GetAccountPasswordPolicy</code> action. This option does not attach a permissions policy to each user, rather the permissions are applied at the account-level for all users by IAM.</p>")
  allowUsersToChangePassword?: boolean;

  @doc("<p>Indicates whether passwords in the account expire. Returns true if <code>MaxPasswordAge</code> contains a value greater than 0. Returns false if MaxPasswordAge is 0 or not present.</p>")
  expirePasswords?: boolean;

  @doc("<p>Specifies whether IAM users are prevented from setting a new password via the Amazon Web Services Management Console after their password has expired. The IAM user cannot access the console until an administrator resets the password. IAM users with <code>iam:ChangePassword</code> permission and active access keys can reset their own expired console password using the CLI or API.</p>")
  hardExpiry?: boolean;

  @doc("<p>The number of days that an IAM user password is valid.</p>")
  maxPasswordAge?: int32;

  @doc("<p>Minimum length to require for IAM user passwords.</p>")
  minimumPasswordLength?: int32;

  @doc("<p>Specifies the number of previous passwords that IAM users are prevented from reusing.</p>")
  passwordReusePrevention?: int32;

  @doc("<p>Specifies whether IAM user passwords must contain at least one lowercase character (a to z).</p>")
  requireLowercaseCharacters?: boolean;

  @doc("<p>Specifies whether IAM user passwords must contain at least one numeric character (0 to 9).</p>")
  requireNumbers?: boolean;

  @doc("<p>Specifies whether IAM user passwords must contain at least one of the following symbols:</p> <p>! @ # $ % ^ &amp; * ( ) _ + - = [ ] { } | '</p>")
  requireSymbols?: boolean;

  @doc("<p>Specifies whether IAM user passwords must contain at least one uppercase character (A to Z).</p>")
  requireUppercaseCharacters?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface IamPasswordPolicies {
  get is ArmResourceRead<IamPasswordPolicy>;
  @doc("Create a IamPasswordPolicy. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<IamPasswordPolicy>;
  update is ArmCustomPatchAsync<
    IamPasswordPolicy,
    Azure.ResourceManager.Foundations.TagsUpdateModel<IamPasswordPolicy>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<IamPasswordPolicy>;
  listByResourceGroup is ArmResourceListByParent<IamPasswordPolicy>;
  listBySubscription is ArmListBySubscription<IamPasswordPolicy>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\iam\iam-2010-05-08.normal.json
// AWS Shape: PasswordPolicy
//
// Related information for backend service:
// AWS Servcie : IAM
// Product Version : 3.7.798.0
// SDK Version : 3.7.301.9
//--------------------------------------------------------------------------------------------
