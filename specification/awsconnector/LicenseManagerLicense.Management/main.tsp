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
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsLicenseManagerLicenseProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsLicenseManagerLicense")
model AwsLicenseManagerLicenseProperties {
  @doc("Gets and sets the property beneficiary. Beneficiary of the license.")
  beneficiary?: string;

  @doc("Gets and sets the property consumptionConfiguration.")
  consumptionConfiguration?: ConsumptionConfiguration;

  @doc("Gets and sets the property entitlements.")
  @extension("x-ms-identifiers", [])
  entitlements?: Entitlement[];

  @doc("Gets and sets the property homeRegion. Home region for the created license.")
  homeRegion?: string;

  @doc("Gets and sets the property issuer.")
  issuer?: IssuerData;

  @doc("Gets and sets the property licenseArn. Amazon Resource Name is a unique name for each resource.")
  licenseArn?: string;

  @doc("Gets and sets the property licenseMetadata.")
  @extension("x-ms-identifiers", [])
  licenseMetadata?: Metadata[];

  @doc("Gets and sets the property licenseName. Name for the created license.")
  licenseName?: string;

  @doc("Gets and sets the property productName. Product name for the created license.")
  productName?: string;

  @doc("Gets and sets the property productSKU. ProductSKU of the license.")
  productSKU?: string;

  @doc("Gets and sets the property status.")
  status?: string;

  @doc("Gets and sets the property validity.")
  validity?: ValidityDateFormat;

  @doc("Gets and sets the property version. The version of the license.")
  version?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ConsumptionConfiguration")
model ConsumptionConfiguration {
  @doc("Gets and sets the property borrowConfiguration.")
  borrowConfiguration?: BorrowConfiguration;

  @doc("Gets and sets the property provisionalConfiguration.")
  provisionalConfiguration?: ProvisionalConfiguration;

  @doc("Gets and sets the property renewType.")
  renewType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Entitlement")
model Entitlement {
  @doc("Gets and sets the property allowCheckIn.")
  allowCheckIn?: boolean;

  @doc("Gets and sets the property maxCount.")
  maxCount?: int32;

  @doc("Gets and sets the property name.")
  name?: string;

  @doc("Gets and sets the property overage.")
  overage?: boolean;

  @doc("Gets and sets the property unit.")
  unit?: string;

  @doc("Gets and sets the property value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IssuerData")
model IssuerData {
  @doc("Gets and sets the property name.")
  name?: string;

  @doc("Gets and sets the property signKey.")
  signKey?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Metadata")
model Metadata {
  @doc("Gets and sets the property name.")
  name?: string;

  @doc("Gets and sets the property value.")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ValidityDateFormat")
model ValidityDateFormat {
  @doc("Gets and sets the property begin. Validity begin date for the license.")
  begin?: string;

  @doc("Gets and sets the property end. Validity begin date for the license.")
  end?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BorrowConfiguration")
model BorrowConfiguration {
  @doc("Gets and sets the property allowEarlyCheckIn.")
  allowEarlyCheckIn?: boolean;

  @doc("Gets and sets the property maxTimeToLiveInMinutes.")
  maxTimeToLiveInMinutes?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProvisionalConfiguration")
model ProvisionalConfiguration {
  @doc("Gets and sets the property maxTimeToLiveInMinutes.")
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
