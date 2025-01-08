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

//---------------------------------------------- IamAccessKeyMetadata ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "IAM Access Key Metadata",
    plural: "IAM Access Key Metadata",
  },
  keywords: ["Microsoft.AwsConnector", "IAM", "Access", "Key", "Metadata"],
})
@doc("A Microsoft.AwsConnector resource")
model IamAccessKeyMetadata is TrackedResource<IamAccessKeyMetadataProperties> {
  @doc("Name of IamAccessKeyMetadata")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("iamAccessKeyMetadata")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IamAccessKeyMetadata")
model IamAccessKeyMetadataProperties {
  @doc("AWS Properties")
  awsProperties?: AwsIamAccessKeyMetadataProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsIamAccessKeyMetadata")
model AwsIamAccessKeyMetadataProperties {
  @doc("<p>The ID for this access key.</p>")
  accessKeyId?: string;

  @doc("<p>The date when the access key was created.</p>")
  createDate?: utcDateTime;

  @doc("<p>The status of the access key. <code>Active</code> means that the key is valid for API calls; <code>Inactive</code> means it is not.</p>")
  status?: statusTypeEnumValue;

  @doc("<p>The name of the IAM user that the key is associated with.</p>")
  userName?: string;
}

@doc("statusType enum")
union statusType {
  @doc("statusType enum Active")
  Active: "Active",

  @doc("statusType enum Inactive")
  Inactive: "Inactive",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of statusTypeEnumValue")
model statusTypeEnumValue {
  @doc("Property value")
  value?: statusType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface IamAccessKeyMetadataInfo {
  get is ArmResourceRead<IamAccessKeyMetadata>;
  @doc("Create a IamAccessKeyMetadata. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<IamAccessKeyMetadata>;
  update is ArmCustomPatchAsync<
    IamAccessKeyMetadata,
    Azure.ResourceManager.Foundations.TagsUpdateModel<IamAccessKeyMetadata>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<IamAccessKeyMetadata>;
  listByResourceGroup is ArmResourceListByParent<IamAccessKeyMetadata>;
  listBySubscription is ArmListBySubscription<IamAccessKeyMetadata>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\iam\iam-2010-05-08.normal.json
// AWS Shape: AccessKeyMetadata
//
// Related information for backend service:
// AWS Servcie : IAM
// Product Version : 3.7.798.0
// SDK Version : 3.7.301.9
//--------------------------------------------------------------------------------------------
