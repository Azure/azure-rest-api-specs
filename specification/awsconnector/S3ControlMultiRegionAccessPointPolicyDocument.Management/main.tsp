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

//---------------------------------------------- S3ControlMultiRegionAccessPointPolicyDocuments ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "S3  Control Multi Region Access Point Policy Document",
    plural: "S3  Control Multi Region Access Point Policy Documents",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "S3 ",
    "Control",
    "Multi",
    "Region",
    "Access",
    "Point",
    "Policy",
    "Document"
  ],
})
@doc("A Microsoft.AwsConnector resource")
model S3ControlMultiRegionAccessPointPolicyDocument
  is TrackedResource<S3ControlMultiRegionAccessPointPolicyDocumentProperties> {
  @doc("Name of S3ControlMultiRegionAccessPointPolicyDocument")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("s3ControlMultiRegionAccessPointPolicyDocuments")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of S3ControlMultiRegionAccessPointPolicyDocument")
model S3ControlMultiRegionAccessPointPolicyDocumentProperties {
  @doc("AWS Properties")
  awsProperties?: AwsS3ControlMultiRegionAccessPointPolicyDocumentProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsS3ControlMultiRegionAccessPointPolicyDocument")
model AwsS3ControlMultiRegionAccessPointPolicyDocumentProperties {
  @doc("<p>The last established policy for the Multi-Region Access Point.</p>")
  established?: EstablishedMultiRegionAccessPointPolicy;

  @doc("<p>The proposed policy for the Multi-Region Access Point.</p>")
  proposed?: ProposedMultiRegionAccessPointPolicy;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EstablishedMultiRegionAccessPointPolicy")
model EstablishedMultiRegionAccessPointPolicy {
  @doc("<p>The details of the last established policy.</p>")
  policy?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProposedMultiRegionAccessPointPolicy")
model ProposedMultiRegionAccessPointPolicy {
  @doc("<p>The details of the proposed policy.</p>")
  policy?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface S3ControlMultiRegionAccessPointPolicyDocuments {
  get is ArmResourceRead<S3ControlMultiRegionAccessPointPolicyDocument>;
  @doc("Create a S3ControlMultiRegionAccessPointPolicyDocument. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<S3ControlMultiRegionAccessPointPolicyDocument>;
  update is ArmCustomPatchAsync<
    S3ControlMultiRegionAccessPointPolicyDocument,
    Azure.ResourceManager.Foundations.TagsUpdateModel<S3ControlMultiRegionAccessPointPolicyDocument>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<S3ControlMultiRegionAccessPointPolicyDocument>;
  listByResourceGroup is ArmResourceListByParent<S3ControlMultiRegionAccessPointPolicyDocument>;
  listBySubscription is ArmListBySubscription<S3ControlMultiRegionAccessPointPolicyDocument>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\s3control\s3control-2018-08-20.normal.json
// AWS Shape: MultiRegionAccessPointPolicyDocument
//
// Related information for backend service:
// AWS Servcie : S3 Control
// Product Version : 3.7.798.0
// SDK Version : 3.7.305.48
//--------------------------------------------------------------------------------------------
