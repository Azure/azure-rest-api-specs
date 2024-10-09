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

//---------------------------------------------- SecretsManagerResourcePolicies ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Secrets Manager Resource Policy",
    plural: "Secrets Manager Resource Policies",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "Secrets",
    "Manager",
    "Resource",
    "Policy"
  ],
})
@doc("A Microsoft.AwsConnector resource")
model SecretsManagerResourcePolicy
  is TrackedResource<SecretsManagerResourcePolicyProperties> {
  @doc("Name of SecretsManagerResourcePolicy")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("secretsManagerResourcePolicies")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SecretsManagerResourcePolicy")
model SecretsManagerResourcePolicyProperties {
  @doc("AWS Properties")
  awsProperties?: AwsSecretsManagerResourcePolicyProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsSecretsManagerResourcePolicy")
model AwsSecretsManagerResourcePolicyProperties {
  @doc("Property blockPublicPolicy")
  blockPublicPolicy?: boolean;

  @doc("Property id")
  id?: string;

  @doc("Property resourcePolicy")
  resourcePolicy?: unknown;

  @doc("Property secretId")
  secretId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface SecretsManagerResourcePolicies {
  get is ArmResourceRead<SecretsManagerResourcePolicy>;
  @doc("Create a SecretsManagerResourcePolicy. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<SecretsManagerResourcePolicy>;
  update is ArmCustomPatchAsync<
    SecretsManagerResourcePolicy,
    Azure.ResourceManager.Foundations.TagsUpdateModel<SecretsManagerResourcePolicy>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<SecretsManagerResourcePolicy>;
  listByResourceGroup is ArmResourceListByParent<SecretsManagerResourcePolicy>;
  listBySubscription is ArmListBySubscription<SecretsManagerResourcePolicy>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::SecretsManager::ResourcePolicy
//--------------------------------------------------------------------------------------------
