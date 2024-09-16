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

//---------------------------------------------- S3MultiRegionAccessPointPolicies ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "S3 Multi Region Access Point Policy",
    plural: "S3 Multi Region Access Point Policies",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "S3",
    "Multi",
    "Region",
    "Access",
    "Point",
    "Policy"
  ],
})
@doc("A Microsoft.AwsConnector resource")
model S3MultiRegionAccessPointPolicy
  is TrackedResource<S3MultiRegionAccessPointPolicyProperties> {
  @doc("Name of S3MultiRegionAccessPointPolicy")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("s3MultiRegionAccessPointPolicies")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of S3MultiRegionAccessPointPolicy")
model S3MultiRegionAccessPointPolicyProperties {
  @doc("AWS Properties")
  awsProperties?: AwsS3MultiRegionAccessPointPolicyProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsS3MultiRegionAccessPointPolicy")
model AwsS3MultiRegionAccessPointPolicyProperties {
  @doc("The name of the Multi Region Access Point to apply policy")
  mrapName?: string;

  @doc("Policy document to apply to a Multi Region Access Point")
  policy?: unknown;

  @doc("The Policy Status associated with this Multi Region Access Point")
  policyStatus?: PolicyStatusModelProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PolicyStatusModelProperties")
model PolicyStatusModelProperties {
  @doc("Specifies whether the policy is public or not.")
  isPublic?: IsPublic;
}

@doc("IsPublic enum")
union IsPublic {
  @doc("IsPublic enum false")
  False: "false",

  @doc("IsPublic enum true")
  True: "true",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface S3MultiRegionAccessPointPolicies {
  get is ArmResourceRead<S3MultiRegionAccessPointPolicy>;
  @doc("Create a S3MultiRegionAccessPointPolicy. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<S3MultiRegionAccessPointPolicy>;
  update is ArmCustomPatchAsync<
    S3MultiRegionAccessPointPolicy,
    Azure.ResourceManager.Foundations.TagsUpdateModel<S3MultiRegionAccessPointPolicy>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<S3MultiRegionAccessPointPolicy>;
  listByResourceGroup is ArmResourceListByParent<S3MultiRegionAccessPointPolicy>;
  listBySubscription is ArmListBySubscription<S3MultiRegionAccessPointPolicy>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::S3::MultiRegionAccessPointPolicy
//--------------------------------------------------------------------------------------------
