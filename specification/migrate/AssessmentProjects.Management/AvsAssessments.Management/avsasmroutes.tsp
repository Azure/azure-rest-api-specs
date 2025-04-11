import "./WebModels/AvsAssessmentV2.tsp";
import "./WebModels/AvsAssessedMachineV2.tsp";
import "./WebModels/AvsAssessmentV2Summary.tsp";
import "../Common/DataModels/DownloadUrl.tsp";
import "./WebModels/AvsGraphAssessmentOptions.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@armResourceOperations
interface AvsAssessmentsV2Operations {
  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning"
  @added(AvsApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<AvsAssessmentV2>;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning"
  @added(AvsApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<AvsAssessmentV2>;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning"
  @added(AvsApiVersions.v2024_03_03_preview)
  create is ArmResourceCreateOrUpdateAsync<AvsAssessmentV2>;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning"
  @added(AvsApiVersions.v2024_03_03_preview)
  delete is ArmResourceDeleteSync<AvsAssessmentV2>;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Download URL Post Action body is empty."
  @summary("Get download URL for the assessment report.")
  @doc("Get the URL for downloading the assessment in a report format.")
  @added(AvsApiVersions.v2024_03_03_preview)
  downloadUrl is ArmResourceActionAsync<AvsAssessmentV2, {}, DownloadUrl>;
}

@armResourceOperations
interface AvsAssessedMachinesV2Operations {
  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning"
  @added(AvsApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<AvsAssessedMachineV2>;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning"
  @added(AvsApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<
    AvsAssessedMachineV2,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;

      #suppress "@azure-tools/typespec-azure-core/casing-style" "OData Filter"
      @doc("Filter query.")
      @query
      $filter?: string;

      @doc("Optional parameter for page size.")
      @query
      pageSize?: int32;

      @doc("Optional parameter for continuation token.")
      @query
      continuationToken?: string;

      @doc("Total record count.")
      @query
      totalRecordCount?: int32;
    }
  >;
}

@armResourceOperations
interface AvsAssessmentV2SummaryOperations {
  @added(AvsApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<AvsAssessmentV2Summary>;

  @added(AvsApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<AvsAssessmentV2Summary>;
}

@armResourceOperations
interface AvsGraphAssessmentOptionsOperations {
  @added(AvsApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<AvsGraphAssessmentOptions>;

  @added(AvsApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<AvsGraphAssessmentOptions>;
}
