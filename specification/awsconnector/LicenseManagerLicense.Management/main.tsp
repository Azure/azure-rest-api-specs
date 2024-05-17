import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;

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
  /** 2024-08-01-preview api version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-08-01-preview`,
}

//---------------------------------------------- LicenseManagerLicenses ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model LicenseManagerLicense
  is TrackedResource<LicenseManagerLicenseProperties> {
  @doc("Name of LicenseManagerLicense")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("licenseManagerLicenses")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LicenseManagerLicense")
model LicenseManagerLicenseProperties {
  @doc("AWS Properties")
  awsProperties?: AwsLicenseManagerLicenseProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsLicenseManagerLicense")
model AwsLicenseManagerLicenseProperties {
  @doc("Beneficiary of the license.")
  beneficiary?: string;

  @doc("Property consumptionConfiguration")
  consumptionConfiguration?: ConsumptionConfiguration;

  @doc("Property entitlements")
  @extension("x-ms-identifiers", [])
  entitlements?: Entitlement[];

  @doc("Home region for the created license.")
  homeRegion?: string;

  @doc("Property issuer")
  issuer?: IssuerData;

  @doc("Amazon Resource Name is a unique name for each resource.")
  licenseArn?: string;

  @doc("Property licenseMetadata")
  @extension("x-ms-identifiers", [])
  licenseMetadata?: Metadata[];

  @doc("Name for the created license.")
  licenseName?: string;

  @doc("Product name for the created license.")
  productName?: string;

  @doc("ProductSKU of the license.")
  productSKU?: string;

  @doc("Property status")
  status?: string;

  @doc("Property validity")
  validity?: ValidityDateFormat;

  @doc("The version of the license.")
  version?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ConsumptionConfiguration")
model ConsumptionConfiguration {
  @doc("Property borrowConfiguration")
  borrowConfiguration?: BorrowConfiguration;

  @doc("Property provisionalConfiguration")
  provisionalConfiguration?: ProvisionalConfiguration;

  @doc("Property renewType")
  renewType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Entitlement")
model Entitlement {
  @doc("Property allowCheckIn")
  allowCheckIn?: boolean;

  @doc("Property maxCount")
  maxCount?: int32;

  @doc("Property name")
  name?: string;

  @doc("Property overage")
  overage?: boolean;

  @doc("Property unit")
  unit?: string;

  @doc("Property value")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IssuerData")
model IssuerData {
  @doc("Property name")
  name?: string;

  @doc("Property signKey")
  signKey?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Metadata")
model Metadata {
  @doc("Property name")
  name?: string;

  @doc("Property value")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ValidityDateFormat")
model ValidityDateFormat {
  @doc("Validity begin date for the license.")
  begin?: string;

  @doc("Validity begin date for the license.")
  end?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BorrowConfiguration")
model BorrowConfiguration {
  @doc("Property allowEarlyCheckIn")
  allowEarlyCheckIn?: boolean;

  @doc("Property maxTimeToLiveInMinutes")
  maxTimeToLiveInMinutes?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProvisionalConfiguration")
model ProvisionalConfiguration {
  @doc("Property maxTimeToLiveInMinutes")
  maxTimeToLiveInMinutes?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface LicenseManagerLicenses {
  get is ArmResourceRead<LicenseManagerLicense>;
  @doc("Create a LicenseManagerLicense. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LicenseManagerLicense>;
  update is ArmCustomPatchAsync<
    LicenseManagerLicense,
    Azure.ResourceManager.Foundations.TagsUpdateModel<LicenseManagerLicense>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<LicenseManagerLicense>;
  listByResourceGroup is ArmResourceListByParent<LicenseManagerLicense>;
  listBySubscription is ArmListBySubscription<LicenseManagerLicense>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::LicenseManager::License
//--------------------------------------------------------------------------------------------
