import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AppComplianceAutomation;
@doc("A class represent an AppComplianceAutomation report resource.")
@tenantResource
model ReportResource is ProxyResource<ReportProperties> {
  @doc("Report Name.")
  @pattern("^[-a-zA-Z0-9_]+$")
  @path
  @key("reportName")
  @segment("reports")
  name: string;
}

@armResourceOperations
interface ReportResources {
  @doc("Get the AppComplianceAutomation report and its properties.")
  get is ArmResourceRead<ReportResource>;
  @doc("Create a new AppComplianceAutomation report or update an exiting AppComplianceAutomation report.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ReportResource>;
  @doc("Update an exiting AppComplianceAutomation report.")
  update is ArmResourcePatchAsync<ReportResource, ReportProperties>;
  @doc("Delete an AppComplianceAutomation report.")
  delete is ArmResourceDeleteAsync<ReportResource>;
  @doc("Get the AppComplianceAutomation report list for the tenant.")
  list is ArmResourceListByParent<
    ReportResource,
    {
      ...BaseParameters<ReportResource>;

      @doc("Skip over when retrieving results.")
      @query("$skipToken")
      $skipToken?: string;

      @doc("Number of elements to return when retrieving results.")
      @query("$top")
      $top?: int32;

      @doc("OData Select statement. Limits the properties on each entry to just those requested, e.g. ?$select=reportName,id.")
      @minLength(1)
      @query("$select")
      $select?: string;

      @doc("The offerGuid which mapping to the reports.")
      @minLength(1)
      @query("offerGuid")
      offerGuid?: string;

      @doc("The tenant id of the report creator.")
      @minLength(1)
      @query("reportCreatorTenantId")
      reportCreatorTenantId?: string;
    }
  >;
}
