import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MasterSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * SQL site web model.
 */
@parentResource(MasterSite)
model SqlSite is Azure.ResourceManager.ProxyResource<SqlSiteProperties> {
  ...ResourceNameParameter<
    Resource = SqlSite,
    KeyName = "sqlSiteName",
    SegmentName = "sqlSites"
  >;
}

@armResourceOperations
interface SqlSites {
  /**
   * Method to get a site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlSitesController_Get")
  get is ArmResourceRead<SqlSite>;

  /**
   * Method to create a SQL site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlSitesController_Create")
  create is ArmResourceCreateOrReplaceSync<SqlSite>;

  /**
   * Method to update an existing site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlSitesController_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<SqlSite, PatchModel = SqlSiteUpdate>;

  /**
   * Deletes the SQL site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlSitesController_Delete")
  delete is ArmResourceDeleteSync<SqlSite>;

  /**
   * Method to get all sites.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlSitesController_ListByMasterSite")
  listByMasterSite is ArmResourceListByParent<SqlSite>;

  /**
   * Method to get error summary from SQL site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlSitesController_ErrorSummary")
  errorSummary is ArmResourceActionSync<
    SqlSite,
    ErrorSummaryRequest,
    ArmResponse<SiteErrorSummary>
  >;

  /**
   * Method to generate export/read SAS uri for import.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlSitesController_ExportUri")
  exportUri is ArmResourceActionSync<
    SqlSite,
    SQLInventoryImportBody,
    ArmResponse<SQLInventoryImportBody>
  >;

  /**
   * Method to generate report containing SQL servers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlSitesController_ExportSqlServerErrors")
  exportSqlServerErrors is ArmResourceActionAsync<
    SqlSite,
    unknown,
    ArmResponse<unknown>
  >;

  /**
   * Method to generate report containing SQL servers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlSitesController_ExportSqlServers")
  exportSqlServers is ArmResourceActionAsync<
    SqlSite,
    ExportSqlServersRequest,
    ArmResponse<unknown>
  >;

  /**
   * Method to refresh a site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlSitesController_Refresh")
  refresh is ArmResourceActionAsync<
    SqlSite,
    SqlSiteRefreshBody,
    ArmResponse<unknown>
  >;

  /**
   * Method to get site usage/summary.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlSitesController_Summary")
  summary is ArmResourceActionSync<SqlSite, void, ArmResponse<SqlSiteUsage>>;

  /**
   * Initiates SQL inventory import process. This is an asynchronous operation that returns a 202 Accepted response and requires polling for completion status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlSitesController_ImportUri")
  importUri is ArmResourceActionAsyncBase<
    SqlSite,
    SQLInventoryImportBody,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<SqlSite>
  >;

  /**
   * Validates SQL inventory data for format and correctness before attempting import. This is a safer alternative to direct import as it prevents failed imports due to invalid data. The operation performs validation checks first and only proceeds with import if all checks pass.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlSitesController_ValidateAndImportUri")
  validateAndImportUri is ArmResourceActionSync<
    SqlSite,
    SQLInventoryImportBody,
    ArmResponse<SQLInventoryImportBody>
  >;

  /**
   * Method to get operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlOperationsStatusController_GetSqlOperationStatus")
  @get
  @action("{operationStatusName}")
  getSqlOperationStatus is ArmResourceActionSync<
    SqlSite,
    void,
    ArmResponse<OperationStatus>,
    Parameters = {
      /**
       * Operation status  Arm Name.
       */
      @pattern("^[a-zA-Z0-9-]{3,24}$")
      @path
      operationStatusName: string;
    }
  >;
}

@@doc(SqlSite.name, "SQL site name.");
@@doc(SqlSite.properties,
  "The resource-specific properties for this resource."
);
@@doc(SqlSites.importUri::parameters.body, "Import parameters");
