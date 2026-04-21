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

@armResourceOperations(#{ omitTags: true })
interface SqlSiteOperationsStatusOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("masterSites")
        @key
        @pattern("^[a-zA-Z0-9-]{3,24}$")
        siteName: string,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("sqlSites")
        @key
        @pattern("^[a-zA-Z0-9-]{3,24}$")
        sqlSiteName: string,
      },
      {
        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("operationsStatus")
        @key
        @pattern("^[a-zA-Z0-9-]{3,24}$")
        operationStatusName: string,
      }
    > {}

@armResourceOperations(#{ omitTags: true })
interface SqlSites {
  /**
   * Method to get a site.
   */
  @tag("SqlSitesController")
  get is ArmResourceRead<SqlSite>;

  /**
   * Method to create a SQL site.
   */
  @tag("SqlSitesController")
  create is ArmResourceCreateOrReplaceSync<SqlSite>;

  /**
   * Method to update an existing site.
   */
  @tag("SqlSitesController")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<SqlSite, PatchModel = SqlSiteUpdate>;

  /**
   * Deletes the SQL site.
   */
  @tag("SqlSitesController")
  delete is ArmResourceDeleteSync<SqlSite>;

  /**
   * Method to get all sites.
   */
  @tag("SqlSitesController")
  listByMasterSite is ArmResourceListByParent<SqlSite>;

  /**
   * Method to get error summary from SQL site.
   */
  @tag("SqlSitesController")
  errorSummary is ArmResourceActionSync<
    SqlSite,
    ErrorSummaryRequest,
    ArmResponse<SiteErrorSummary>
  >;

  /**
   * Method to generate export/read SAS uri for import.
   */
  @tag("SqlSitesController")
  exportUri is ArmResourceActionSync<
    SqlSite,
    SQLInventoryImportBody,
    ArmResponse<SQLInventoryImportBody>
  >;

  /**
   * Method to generate report containing SQL servers.
   */
  @tag("SqlSitesController")
  exportSqlServerErrors is ArmResourceActionAsync<
    SqlSite,
    unknown,
    unknown,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Method to generate report containing SQL servers.
   */
  @tag("SqlSitesController")
  exportSqlServers is ArmResourceActionAsync<
    SqlSite,
    ExportSqlServersRequest,
    unknown,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Method to refresh a site.
   */
  @tag("SqlSitesController")
  refresh is ArmResourceActionAsync<
    SqlSite,
    SqlSiteRefreshBody,
    unknown,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Method to get site usage/summary.
   */
  @tag("SqlSitesController")
  summary is ArmResourceActionSync<SqlSite, void, ArmResponse<SqlSiteUsage>>;

  /**
   * Initiates SQL inventory import process. This is an asynchronous operation that returns a 202 Accepted response and requires polling for completion status.
   */
  @tag("SqlSitesController")
  importUri is ArmResourceActionAsyncBase<
    SqlSite,
    SQLInventoryImportBody,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<SqlSite>
  >;

  /**
   * Validates SQL inventory data for format and correctness before attempting import. This is a safer alternative to direct import as it prevents failed imports due to invalid data. The operation performs validation checks first and only proceeds with import if all checks pass.
   */
  @tag("SqlSitesController")
  validateAndImportUri is ArmResourceActionSync<
    SqlSite,
    SQLInventoryImportBody,
    ArmResponse<SQLInventoryImportBody>
  >;

  /**
   * Method to get operation status.
   */
  @tag("SqlOperationsStatusController")
  getSqlOperationStatus is SqlSiteOperationsStatusOps.Read<
    OperationStatus,
    OverrideErrorType = ErrorResponse
  >;
}

@@doc(SqlSite.name, "SQL site name.");
@@doc(SqlSite.properties,
  "The resource-specific properties for this resource."
);
@@doc(SqlSites.importUri::parameters.body, "Import parameters");
