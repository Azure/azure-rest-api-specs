import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppComplianceAutomation;
/**
 * A class represent an AppComplianceAutomation report resource.
 */
@tenantResource
model ReportResource is ProxyResource<ReportProperties> {
  /**
   * Report Name.
   */
  @pattern("^[-a-zA-Z0-9_]+$")
  @path
  @key("reportName")
  @segment("reports")
  name: string;
}

@armResourceOperations
interface ReportResources {
  /**
   * Get the AppComplianceAutomation report and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Report_Get")
  get is ArmResourceRead<ReportResource>;

  /**
   * Create a new AppComplianceAutomation report or update an exiting AppComplianceAutomation report.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Report_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ReportResource,
    BaseParameters<ReportResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update an exiting AppComplianceAutomation report.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Report_Update")
  update is ArmCustomPatchAsync<
    ReportResource,
    ReportResourcePatch,
    BaseParameters<ReportResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete an AppComplianceAutomation report.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Report_Delete")
  delete is ArmResourceDeleteAsync<
    ReportResource,
    BaseParameters<ReportResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Get the AppComplianceAutomation report list for the tenant.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Reports_List")
  list is ArmResourceListByParent<
    ReportResource,
    {
      ...BaseParameters<ReportResource>;

      /**
       * Skip over when retrieving results.
       */
      @query("$skipToken")
      $skipToken?: string;

      /**
       * Number of elements to return when retrieving results.
       */
      @maxValue(100)
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * OData Select statement. Limits the properties on each entry to just those requested, e.g. ?$select=reportName,id.
       */
      @minLength(1)
      @query("$select")
      $select?: string;

      /**
       * The offerGuid which mapping to the reports.
       */
      @minLength(1)
      @query("offerGuid")
      offerGuid?: string;

      /**
       * The tenant id of the report creator.
       */
      @minLength(1)
      @query("reportCreatorTenantId")
      reportCreatorTenantId?: string;
    }
  >;
}

@@projectedName(ReportResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ReportResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ReportResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@projectedName(ReportResources.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ReportResources.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ReportResources.update::parameters.properties,
  "Parameters for the create or update operation"
);
