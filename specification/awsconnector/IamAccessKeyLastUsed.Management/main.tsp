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

//---------------------------------------------- IamAccessKeyLastUseds ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "IAM Access Key Last Used",
    plural: "IAM Access Key Last Useds",
  },
  keywords: ["Microsoft.AwsConnector", "IAM", "Access", "Key", "Last", "Used"],
})
@doc("A Microsoft.AwsConnector resource")
model IamAccessKeyLastUsed is TrackedResource<IamAccessKeyLastUsedProperties> {
  @doc("Name of IamAccessKeyLastUsed")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("iamAccessKeyLastUseds")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IamAccessKeyLastUsed")
model IamAccessKeyLastUsedProperties {
  @doc("AWS Properties")
  awsProperties?: AwsIamAccessKeyLastUsedProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsIamAccessKeyLastUsed")
model AwsIamAccessKeyLastUsedProperties {
  @doc("<p>The date and time, in <a href='http://www.iso.org/iso/iso8601'>ISO 8601 date-time format</a>, when the access key was most recently used. This field is null in the following situations:</p> <ul> <li> <p>The user does not have an access key.</p> </li> <li> <p>An access key exists but has not been used since IAM began tracking this information.</p> </li> <li> <p>There is no sign-in data associated with the user.</p> </li> </ul>")
  lastUsedDate?: utcDateTime;

  @doc("<p>The Amazon Web Services Region where this access key was most recently used. The value for this field is 'N/A' in the following situations:</p> <ul> <li> <p>The user does not have an access key.</p> </li> <li> <p>An access key exists but has not been used since IAM began tracking this information.</p> </li> <li> <p>There is no sign-in data associated with the user.</p> </li> </ul> <p>For more information about Amazon Web Services Regions, see <a href='https://docs.aws.amazon.com/general/latest/gr/rande.html'>Regions and endpoints</a> in the Amazon Web Services General Reference.</p>")
  region?: string;

  @doc("<p>The name of the Amazon Web Services service with which this access key was most recently used. The value of this field is 'N/A' in the following situations:</p> <ul> <li> <p>The user does not have an access key.</p> </li> <li> <p>An access key exists but has not been used since IAM started tracking this information.</p> </li> <li> <p>There is no sign-in data associated with the user.</p> </li> </ul>")
  serviceName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface IamAccessKeyLastUseds {
  get is ArmResourceRead<IamAccessKeyLastUsed>;
  @doc("Create a IamAccessKeyLastUsed. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<IamAccessKeyLastUsed>;
  update is ArmCustomPatchAsync<
    IamAccessKeyLastUsed,
    Azure.ResourceManager.Foundations.TagsUpdateModel<IamAccessKeyLastUsed>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<IamAccessKeyLastUsed>;
  listByResourceGroup is ArmResourceListByParent<IamAccessKeyLastUsed>;
  listBySubscription is ArmListBySubscription<IamAccessKeyLastUsed>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\iam\iam-2010-05-08.normal.json
// AWS Shape: AccessKeyLastUsed
//
// Related information for backend service:
// AWS Servcie : IAM
// Product Version : 3.7.798.0
// SDK Version : 3.7.301.9
//--------------------------------------------------------------------------------------------
