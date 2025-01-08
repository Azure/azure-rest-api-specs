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

//---------------------------------------------- MacieAllowLists ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Macie Allow List",
    plural: "Macie Allow Lists",
  },
  keywords: ["Microsoft.AwsConnector", "Macie", "Allow", "List"],
})
@doc("A Microsoft.AwsConnector resource")
model MacieAllowList is TrackedResource<MacieAllowListProperties> {
  @doc("Name of MacieAllowList")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("macieAllowLists")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MacieAllowList")
model MacieAllowListProperties {
  @doc("AWS Properties")
  awsProperties?: AwsMacieAllowListProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsMacieAllowList")
model AwsMacieAllowListProperties {
  @doc("AllowList ARN.")
  arn?: string;

  @doc("AllowList criteria. The regex or s3 object to use for the AllowList.")
  criteria?: Criteria;

  @doc("Description of AllowList.")
  description?: string;

  @doc("AllowList ID.")
  id?: string;

  @doc("Name of AllowList.")
  name?: string;

  @doc("AllowList status. The status for the AllowList")
  status?: Status;

  @doc("A collection of tags associated with a resource")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];
}

@doc("Status enum")
union Status {
  @doc("Status enum OK")
  OK: "OK",

  @doc("Status enum S3_OBJECT_ACCESS_DENIED")
  S3_OBJECT_ACCESS_DENIED: "S3_OBJECT_ACCESS_DENIED",

  @doc("Status enum S3_OBJECT_EMPTY")
  S3_OBJECT_EMPTY: "S3_OBJECT_EMPTY",

  @doc("Status enum S3_OBJECT_NOT_FOUND")
  S3_OBJECT_NOT_FOUND: "S3_OBJECT_NOT_FOUND",

  @doc("Status enum S3_OBJECT_OVERSIZE")
  S3_OBJECT_OVERSIZE: "S3_OBJECT_OVERSIZE",

  @doc("Status enum S3_THROTTLED")
  S3_THROTTLED: "S3_THROTTLED",

  @doc("Status enum S3_USER_ACCESS_DENIED")
  S3_USER_ACCESS_DENIED: "S3_USER_ACCESS_DENIED",

  @doc("Status enum UNKNOWN_ERROR")
  UNKNOWN_ERROR: "UNKNOWN_ERROR",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Criteria")
model Criteria {
  @doc("The S3 object key for the AllowList.")
  regex?: string;

  @doc("The S3 location for the AllowList.")
  s3WordsList?: S3WordsList;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("The tag's key.")
  key?: string;

  @doc("The tag's value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of S3WordsList")
model S3WordsList {
  @doc("Property bucketName")
  bucketName?: string;

  @doc("Property objectKey")
  objectKey?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface MacieAllowLists {
  get is ArmResourceRead<MacieAllowList>;
  @doc("Create a MacieAllowList. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<MacieAllowList>;
  update is ArmCustomPatchAsync<
    MacieAllowList,
    Azure.ResourceManager.Foundations.TagsUpdateModel<MacieAllowList>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<MacieAllowList>;
  listByResourceGroup is ArmResourceListByParent<MacieAllowList>;
  listBySubscription is ArmListBySubscription<MacieAllowList>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Macie::AllowList
//--------------------------------------------------------------------------------------------
