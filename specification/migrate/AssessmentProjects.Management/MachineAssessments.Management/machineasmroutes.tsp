import "./WebModels/MachineAssessmentsV2.tsp";
import "./WebModels/AssessedMachineV2.tsp";
import "./WebModels/MachineAssessmentV2Summary.tsp";
import "./Normalized Contract/DataModels/DownloadUrl.tsp";
import "./WebModels/MachineGraphAssessmentOptions.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@armResourceOperations
interface MachineAssessmentsV2Operations {
  @added(MachineApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<MachineAssessmentV2>;

  @added(MachineApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<MachineAssessmentV2>;

  @added(MachineApiVersions.v2024_03_03_preview)
  create is ArmResourceCreateOrUpdateAsync<MachineAssessmentV2>;

  @added(MachineApiVersions.v2024_03_03_preview)
  delete is ArmResourceDeleteSync<MachineAssessmentV2>;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Download URL Post Action body is empty."
  @summary("Get download URL for the assessment report.")
  @doc("Get the URL for downloading the assessment in a report format.")
  @added(MachineApiVersions.v2024_03_03_preview)
  downloadUrl is ArmResourceActionAsync<MachineAssessmentV2, {}, DownloadUrl>;
}

@armResourceOperations
interface AssessedMachinesV2Operations {
  @added(MachineApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<AssessedMachineV2>;

  @added(MachineApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<
    AssessedMachineV2,
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
interface MachineAssessmentV2SummaryOperations {
  @added(MachineApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<MachineAssessmentV2Summary>;

  @added(MachineApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<MachineAssessmentV2Summary>;
}

@armResourceOperations
interface MachineGraphAssessmentOptionsOperations {
  @added(MachineApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<MachineGraphAssessmentOptions>;

  @added(MachineApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<MachineGraphAssessmentOptions>;
}
