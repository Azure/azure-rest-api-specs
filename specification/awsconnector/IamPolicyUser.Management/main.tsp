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

//---------------------------------------------- IamPolicyUsers ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "IAM Policy User",
    plural: "IAM Policy Users",
  },
  keywords: ["Microsoft.AwsConnector", "IAM", "Policy", "User"],
})
@doc("A Microsoft.AwsConnector resource")
model IamPolicyUser is TrackedResource<IamPolicyUserProperties> {
  @doc("Name of IamPolicyUser")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("iamPolicyUsers")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IamPolicyUser")
model IamPolicyUserProperties {
  @doc("AWS Properties")
  awsProperties?: AwsIamPolicyUserProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsIamPolicyUser")
model AwsIamPolicyUserProperties {
  @doc("<p>The stable and unique string identifying the user. For more information about IDs, see <a href='https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html'>IAM identifiers</a> in the <i>IAM User Guide</i>.</p>")
  userId?: string;

  @doc("<p>The name (friendly name, not ARN) identifying the user.</p>")
  userName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface IamPolicyUsers {
  get is ArmResourceRead<IamPolicyUser>;
  @doc("Create a IamPolicyUser. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<IamPolicyUser>;
  update is ArmCustomPatchAsync<
    IamPolicyUser,
    Azure.ResourceManager.Foundations.TagsUpdateModel<IamPolicyUser>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<IamPolicyUser>;
  listByResourceGroup is ArmResourceListByParent<IamPolicyUser>;
  listBySubscription is ArmListBySubscription<IamPolicyUser>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\iam\iam-2010-05-08.normal.json
// AWS Shape: PolicyUser
//
// Related information for backend service:
// AWS Servcie : IAM
// Product Version : 3.7.798.0
// SDK Version : 3.7.301.9
//--------------------------------------------------------------------------------------------
