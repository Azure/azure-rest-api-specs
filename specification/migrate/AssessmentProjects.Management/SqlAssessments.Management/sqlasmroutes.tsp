import "./SqlApiVersions.tsp";
import "./WebModels/SqlAssessmentV3.tsp";
import "./WebModels/AssessedSqlInstanceV3.tsp";
import "./WebModels/AssessedSqlDatabaseV3.tsp";
import "./WebModels/AssessedSqlMachineV3.tsp";
import "./WebModels/SqlAssessmentV3Summary.tsp";
import "./Normalized Contract/DataModels/DownloadUrl.tsp";
import "./WebModels/SqlGraphAssessmentOptions.tsp";
import "./WebModels/SqlGraphAssessmentOptions.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@armResourceOperations
interface SqlAssessmentV3Operations {
  @added(SqlApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<SqlAssessmentV3>;

  @added(SqlApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<SqlAssessmentV3>;

  @added(SqlApiVersions.v2024_03_03_preview)
  create is ArmResourceCreateOrUpdateAsync<SqlAssessmentV3>;

  @added(SqlApiVersions.v2024_03_03_preview)
  delete is ArmResourceDeleteSync<SqlAssessmentV3>;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Download URL Post Action body is empty."
  @summary("Get download URL for the assessment report.")
  @doc("Get the URL for downloading the assessment in a report format.")
  @added(SqlApiVersions.v2024_03_03_preview)
  downloadUrl is ArmResourceActionAsync<SqlAssessmentV3, {}, DownloadUrl>;
}

@armResourceOperations
interface AssessedSqlMachinesV3Operations {
  @added(SqlApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<AssessedSqlMachineV3>;

  @added(SqlApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<
    AssessedSqlMachineV3,
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
interface AssessedSqlInstanceV3Operations {
  @added(SqlApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<AssessedSqlInstanceV3>;

  @added(SqlApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<
    AssessedSqlInstanceV3,
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
interface AssessedSqlDatabaseV3Operations {
  @added(SqlApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<AssessedSqlDatabaseV3>;

  @added(SqlApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<
    AssessedSqlDatabaseV3,
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
interface SqlAssessmentV3SummaryOperations {
  @added(SqlApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<SqlAssessmentV3Summary>;

  @added(SqlApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<SqlAssessmentV3Summary>;
}

@armResourceOperations
interface SqlGraphAssessmentOptionsOperations {
  @added(SqlApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<SqlGraphAssessmentOptions>;

  @added(SqlApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<SqlGraphAssessmentOptions>;
}
