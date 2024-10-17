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

//---------------------------------------------- S3AccessControlPolicies ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "S3 Access Control Policy",
    plural: "S3 Access Control Policies",
  },
  keywords: ["Microsoft.AwsConnector", "S3", "Access", "Control", "Policy"],
})
@doc("A Microsoft.AwsConnector resource")
model S3AccessControlPolicy
  is TrackedResource<S3AccessControlPolicyProperties> {
  @doc("Name of S3AccessControlPolicy")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("s3AccessControlPolicies")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of S3AccessControlPolicy")
model S3AccessControlPolicyProperties {
  @doc("AWS Properties")
  awsProperties?: AwsS3AccessControlPolicyProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsS3AccessControlPolicy")
model AwsS3AccessControlPolicyProperties {
  @doc("<p>A list of grants.</p>")
  @extension("x-ms-identifiers", [])
  grants?: Grant[];

  @doc("<p>Container for the bucket owner's display name and ID.</p>")
  owner?: Owner;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Grant")
model Grant {
  @doc("<p>The person being granted permissions.</p>")
  grantee?: Grantee;

  @doc("<p>Specifies the permission given to the grantee.</p>")
  permission?: PermissionEnumValue;
}

@doc("Permission enum")
union Permission {
  @doc("Permission enum FULL_CONTROL")
  FULL_CONTROL: "FULL_CONTROL",

  @doc("Permission enum READ")
  READ: "READ",

  @doc("Permission enum READ_ACP")
  READ_ACP: "READ_ACP",

  @doc("Permission enum WRITE")
  WRITE: "WRITE",

  @doc("Permission enum WRITE_ACP")
  WRITE_ACP: "WRITE_ACP",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PermissionEnumValue")
model PermissionEnumValue {
  @doc("Property value")
  value?: Permission;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Owner")
model Owner {
  @doc("<p>Container for the display name of the owner. This value is only supported in the following Amazon Web Services Regions:</p> <ul> <li> <p>US East (N. Virginia)</p> </li> <li> <p>US West (N. California)</p> </li> <li> <p>US West (Oregon)</p> </li> <li> <p>Asia Pacific (Singapore)</p> </li> <li> <p>Asia Pacific (Sydney)</p> </li> <li> <p>Asia Pacific (Tokyo)</p> </li> <li> <p>Europe (Ireland)</p> </li> <li> <p>South America (São Paulo)</p> </li> </ul> <note> <p>This functionality is not supported for directory buckets.</p> </note>")
  displayName?: string;

  @doc("<p>Container for the ID of the owner.</p>")
  id?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Grantee")
model Grantee {
  @doc("<p>Screen name of the grantee.</p>")
  displayName?: string;

  @doc("<p>Email address of the grantee.</p> <note> <p>Using email addresses to specify a grantee is only supported in the following Amazon Web Services Regions: </p> <ul> <li> <p>US East (N. Virginia)</p> </li> <li> <p>US West (N. California)</p> </li> <li> <p> US West (Oregon)</p> </li> <li> <p> Asia Pacific (Singapore)</p> </li> <li> <p>Asia Pacific (Sydney)</p> </li> <li> <p>Asia Pacific (Tokyo)</p> </li> <li> <p>Europe (Ireland)</p> </li> <li> <p>South America (São Paulo)</p> </li> </ul> <p>For a list of all the Amazon S3 supported Regions and endpoints, see <a href='https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region'>Regions and Endpoints</a> in the Amazon Web Services General Reference.</p> </note>")
  emailAddress?: string;

  @doc("<p>The canonical user ID of the grantee.</p>")
  id?: string;

  @doc("<p>Type of grantee</p>")
  type?: TypeEnumValue;

  @doc("<p>URI of the grantee group.</p>")
  uri?: string;
}

@doc("Type enum")
union Type {
  @doc("Type enum AmazonCustomerByEmail")
  AmazonCustomerByEmail: "AmazonCustomerByEmail",

  @doc("Type enum CanonicalUser")
  CanonicalUser: "CanonicalUser",

  @doc("Type enum Group")
  Group: "Group",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TypeEnumValue")
model TypeEnumValue {
  @doc("Property value")
  value?: Type;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface S3AccessControlPolicies {
  get is ArmResourceRead<S3AccessControlPolicy>;
  @doc("Create a S3AccessControlPolicy. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<S3AccessControlPolicy>;
  update is ArmCustomPatchAsync<
    S3AccessControlPolicy,
    Azure.ResourceManager.Foundations.TagsUpdateModel<S3AccessControlPolicy>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<S3AccessControlPolicy>;
  listByResourceGroup is ArmResourceListByParent<S3AccessControlPolicy>;
  listBySubscription is ArmListBySubscription<S3AccessControlPolicy>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\s3\s3-2006-03-01.normal.json
// AWS Shape: AccessControlPolicy
//
// Related information for backend service:
// AWS Servcie : S3
// Product Version : 3.7.798.0
// SDK Version : 3.7.307.24
//--------------------------------------------------------------------------------------------
