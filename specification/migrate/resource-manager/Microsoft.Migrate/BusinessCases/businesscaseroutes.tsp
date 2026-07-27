import "./WebModels/BusinessCases/BusinessCase.tsp";
import "./Common/StandardizedContracts/CostComponent.tsp";
import "./Common/StandardizedContracts/CostDetails.tsp";
import "./Common/StandardizedContracts/DataTypes.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@armResourceOperations
interface BusinessCaseOperations {
  get is ArmResourceRead<BusinessCase>;

  listByParent is ArmResourceListByParent<BusinessCase>;

  create is ArmResourceCreateOrUpdateAsync<BusinessCase>;

  delete is ArmResourceDeleteSync<BusinessCase>;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "POST Compare Summary body is empty."
  @doc("A long-running resource action.")
  @removed(BusinessCaseApiVersions.v2025_09_09_preview)
  @summary("Get Compare summary report for Business case.")
  compareSummary is ArmResourceActionAsync<BusinessCase, {}, CompareSummary>;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Download URL POST body is empty."
  @summary("Get download URL for the business case report.")
  @doc("Get the URL for downloading the business case in a report format.")
  getReportDownloadUrl is ArmResourceActionAsync<
    BusinessCase,
    {},
    ReportDownloadUrl
  >;
}

@armResourceOperations
@removed(BusinessCaseApiVersions.v2025_09_09_preview)
interface BusinessCaseIaasSummaryOperations {
  get is ArmResourceRead<IaasSummary>;

  listByParent is ArmResourceListByParent<IaasSummary>;
}

@armResourceOperations
@removed(BusinessCaseApiVersions.v2025_09_09_preview)
interface BusinessCasePaasSummaryOperations {
  get is ArmResourceRead<PaasSummary>;

  listByParent is ArmResourceListByParent<PaasSummary>;
}

@armResourceOperations
interface BusinessCaseOverviewSummaryOperations {
  get is ArmResourceRead<OverviewSummary>;

  listByParent is ArmResourceListByParent<OverviewSummary>;
}

@armResourceOperations
@removed(BusinessCaseApiVersions.v2025_09_09_preview)
interface BusinessCaseAvsSummaryOperations {
  get is ArmResourceRead<AvsSummary>;

  listByParent is ArmResourceListByParent<AvsSummary>;
}

@armResourceOperations
@removed(BusinessCaseApiVersions.v2025_09_09_preview)
interface EvaluatedMachinesOperations {
  get is ArmResourceRead<EvaluatedMachine>;

  listByParent is ArmResourceListByParent<
    EvaluatedMachine,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;

      #suppress "@azure-tools/typespec-azure-core/casing-style" "Odata Filter"
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
@removed(BusinessCaseApiVersions.v2025_09_09_preview)
interface EvaluatedSqlEntitiesOperations {
  get is ArmResourceRead<EvaluatedSqlEntity>;

  listByParent is ArmResourceListByParent<
    EvaluatedSqlEntity,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;

      #suppress "@azure-tools/typespec-azure-core/casing-style" "Odata Filter"
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
@removed(BusinessCaseApiVersions.v2025_09_09_preview)
interface EvaluatedWebAppsOperations {
  get is ArmResourceRead<EvaluatedWebApp>;

  listByParent is ArmResourceListByParent<
    EvaluatedWebApp,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;

      #suppress "@azure-tools/typespec-azure-core/casing-style" "Odata Filter"
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
@removed(BusinessCaseApiVersions.v2025_09_09_preview)
interface EvaluatedAvsMachinesOperations {
  get is ArmResourceRead<EvaluatedAvsMachine>;

  listByParent is ArmResourceListByParent<
    EvaluatedAvsMachine,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;

      #suppress "@azure-tools/typespec-azure-core/casing-style" "Odata Filter"
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
