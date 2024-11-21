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

//---------------------------------------------- EcrImageDetails ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "ECR Image Detail",
    plural: "ECR Image Details",
  },
  keywords: ["Microsoft.AwsConnector", "ECR", "Image", "Detail"],
})
@doc("A Microsoft.AwsConnector resource")
model EcrImageDetail is TrackedResource<EcrImageDetailProperties> {
  @doc("Name of EcrImageDetail")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ecrImageDetails")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EcrImageDetail")
model EcrImageDetailProperties {
  @doc("AWS Properties")
  awsProperties?: AwsEcrImageDetailProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEcrImageDetail")
model AwsEcrImageDetailProperties {
  @doc("<p>The artifact media type of the image.</p>")
  artifactMediaType?: string;

  @doc("<p>The <code>sha256</code> digest of the image manifest.</p>")
  imageDigest?: string;

  @doc("<p>The media type of the image manifest.</p>")
  imageManifestMediaType?: string;

  @doc("<p>The date and time, expressed in standard JavaScript date format, at which the current image was pushed to the repository. </p>")
  imagePushedAt?: utcDateTime;

  @doc("<p>A summary of the last completed image scan.</p>")
  imageScanFindingsSummary?: ImageScanFindingsSummary;

  @doc("<p>The current state of the scan.</p>")
  imageScanStatus?: ImageScanStatus;

  @doc("<p>The size, in bytes, of the image in the repository.</p> <p>If the image is a manifest list, this will be the max size of all manifests in the list.</p> <note> <p>Beginning with Docker version 1.9, the Docker client compresses image layers before pushing them to a V2 Docker registry. The output of the <code>docker images</code> command shows the uncompressed image size, so it may return a larger image size than the image sizes returned by <a>DescribeImages</a>.</p> </note>")
  imageSizeInBytes?: int64;

  @doc("<p>The list of tags associated with this image.</p>")
  @extension("x-ms-identifiers", [])
  imageTags?: string[];

  @doc("<p>The date and time, expressed in standard JavaScript date format, when Amazon ECR recorded the last image pull.</p> <note> <p>Amazon ECR refreshes the last image pull timestamp at least once every 24 hours. For example, if you pull an image once a day then the <code>lastRecordedPullTime</code> timestamp will indicate the exact time that the image was last pulled. However, if you pull an image once an hour, because Amazon ECR refreshes the <code>lastRecordedPullTime</code> timestamp at least once every 24 hours, the result may not be the exact time that the image was last pulled.</p> </note>")
  lastRecordedPullTime?: utcDateTime;

  @doc("<p>The Amazon Web Services account ID associated with the registry to which this image belongs.</p>")
  registryId?: string;

  @doc("<p>The name of the repository to which this image belongs.</p>")
  repositoryName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ImageScanFindingsSummary")
model ImageScanFindingsSummary {
  @doc("<p>The image vulnerability counts, sorted by severity.</p>")
  findingSeverityCounts?: Record<int32>;

  @doc("<p>The time of the last completed image scan.</p>")
  imageScanCompletedAt?: utcDateTime;

  @doc("<p>The time when the vulnerability data was last scanned.</p>")
  vulnerabilitySourceUpdatedAt?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ImageScanStatus")
model ImageScanStatus {
  @doc("<p>The description of the image scan status.</p>")
  description?: string;

  @doc("<p>The current state of an image scan.</p>")
  status?: ScanStatusEnumValue;
}

@doc("ScanStatus enum")
union ScanStatus {
  @doc("ScanStatus enum ACTIVE")
  ACTIVE: "ACTIVE",

  @doc("ScanStatus enum COMPLETE")
  COMPLETE: "COMPLETE",

  @doc("ScanStatus enum FAILED")
  FAILED: "FAILED",

  @doc("ScanStatus enum FINDINGS_UNAVAILABLE")
  FINDINGS_UNAVAILABLE: "FINDINGS_UNAVAILABLE",

  @doc("ScanStatus enum IN_PROGRESS")
  IN_PROGRESS: "IN_PROGRESS",

  @doc("ScanStatus enum PENDING")
  PENDING: "PENDING",

  @doc("ScanStatus enum SCAN_ELIGIBILITY_EXPIRED")
  SCAN_ELIGIBILITY_EXPIRED: "SCAN_ELIGIBILITY_EXPIRED",

  @doc("ScanStatus enum UNSUPPORTED_IMAGE")
  UNSUPPORTED_IMAGE: "UNSUPPORTED_IMAGE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ScanStatusEnumValue")
model ScanStatusEnumValue {
  @doc("Property value")
  value?: ScanStatus;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface EcrImageDetails {
  get is ArmResourceRead<EcrImageDetail>;
  @doc("Create a EcrImageDetail. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<EcrImageDetail>;
  update is ArmCustomPatchAsync<
    EcrImageDetail,
    Azure.ResourceManager.Foundations.TagsUpdateModel<EcrImageDetail>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<EcrImageDetail>;
  listByResourceGroup is ArmResourceListByParent<EcrImageDetail>;
  listBySubscription is ArmListBySubscription<EcrImageDetail>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\ecr\ecr-2015-09-21.normal.json
// AWS Shape: ImageDetail
//
// Related information for backend service:
// AWS Servcie : ECR
// Product Version : 3.7.798.0
// SDK Version : 3.7.301.78
//--------------------------------------------------------------------------------------------
