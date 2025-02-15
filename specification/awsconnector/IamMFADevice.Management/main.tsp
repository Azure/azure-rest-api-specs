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

//---------------------------------------------- IamMFADevices ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "IAM MFADevice",
    plural: "IAM MFADevices",
  },
  keywords: ["Microsoft.AwsConnector", "IAM", "MFADevice"],
})
@doc("A Microsoft.AwsConnector resource")
model IamMFADevice is TrackedResource<IamMFADeviceProperties> {
  @doc("Name of IamMFADevice")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("iamMFADevices")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IamMFADevice")
model IamMFADeviceProperties {
  @doc("AWS Properties")
  awsProperties?: AwsIamMFADeviceProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsIamMFADevice")
model AwsIamMFADeviceProperties {
  @doc("<p>The date when the MFA device was enabled for the user.</p>")
  enableDate?: utcDateTime;

  @doc("<p>The serial number that uniquely identifies the MFA device. For virtual MFA devices, the serial number is the device ARN.</p>")
  serialNumber?: string;

  @doc("<p>The user with whom the MFA device is associated.</p>")
  userName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface IamMFADevices {
  get is ArmResourceRead<IamMFADevice>;
  @doc("Create a IamMFADevice. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<IamMFADevice>;
  update is ArmCustomPatchAsync<
    IamMFADevice,
    Azure.ResourceManager.Foundations.TagsUpdateModel<IamMFADevice>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<IamMFADevice>;
  listByResourceGroup is ArmResourceListByParent<IamMFADevice>;
  listBySubscription is ArmListBySubscription<IamMFADevice>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\iam\iam-2010-05-08.normal.json
// AWS Shape: MFADevice
//
// Related information for backend service:
// AWS Servcie : IAM
// Product Version : 3.7.798.0
// SDK Version : 3.7.301.9
//--------------------------------------------------------------------------------------------
