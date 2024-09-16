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

//---------------------------------------------- IamPolicyRoles ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "IAM Policy Role",
    plural: "IAM Policy Roles",
  },
  keywords: ["Microsoft.AwsConnector", "IAM", "Policy", "Role"],
})
@doc("A Microsoft.AwsConnector resource")
model IamPolicyRole is TrackedResource<IamPolicyRoleProperties> {
  @doc("Name of IamPolicyRole")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("iamPolicyRoles")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IamPolicyRole")
model IamPolicyRoleProperties {
  @doc("AWS Properties")
  awsProperties?: AwsIamPolicyRoleProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsIamPolicyRole")
model AwsIamPolicyRoleProperties {
  @doc("<p>The stable and unique string identifying the role. For more information about IDs, see <a href='https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html'>IAM identifiers</a> in the <i>IAM User Guide</i>.</p>")
  roleId?: string;

  @doc("<p>The name (friendly name, not ARN) identifying the role.</p>")
  roleName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface IamPolicyRoles {
  get is ArmResourceRead<IamPolicyRole>;
  @doc("Create a IamPolicyRole. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<IamPolicyRole>;
  update is ArmCustomPatchAsync<
    IamPolicyRole,
    Azure.ResourceManager.Foundations.TagsUpdateModel<IamPolicyRole>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<IamPolicyRole>;
  listByResourceGroup is ArmResourceListByParent<IamPolicyRole>;
  listBySubscription is ArmListBySubscription<IamPolicyRole>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\iam\iam-2010-05-08.normal.json
// AWS Shape: PolicyRole
//
// Related information for backend service:
// AWS Servcie : IAM
// Product Version : 3.7.798.0
// SDK Version : 3.7.301.9
//--------------------------------------------------------------------------------------------
