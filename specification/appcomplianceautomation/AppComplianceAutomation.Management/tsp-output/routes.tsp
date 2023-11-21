import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace AppComplianceAutomationToolforMicrosoft365;

interface OperationsOperations {
  @doc("""
Lists all of the available REST API operations of the
Microsoft.AppComplianceAutomation provider.
""")
  @route("/providers/Microsoft.AppComplianceAutomation/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface ReportsOperations {
  @doc("Get the AppComplianceAutomation report list for the tenant.")
  @route("/providers/Microsoft.AppComplianceAutomation/reports")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Skip over when retrieving results.")
      @query
      $skipToken: string;

      @doc("Number of elements to return when retrieving results.")
      @query
      $top: int32;

      @doc("""
OData Select statement. Limits the properties on each entry to just those
requested, e.g. ?$select=reportName,id.
""")
      @query
      $select: string;

      @doc("The offerGuid which mapping to the reports.")
      @query
      offerGuid: string;

      @doc("The tenant id of the report creator.")
      @query
      reportCreatorTenantId: string;
    },
    ReportResourceList
  >;
}

interface ReportOperations {
  @doc("Get the AppComplianceAutomation report and its properties.")
  @route("/providers/Microsoft.AppComplianceAutomation/reports/{reportName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Report Name.")
      @path
      reportName: string;
    },
    ReportResource
  >;

  @doc("""
Create a new AppComplianceAutomation report or update an exiting
AppComplianceAutomation report.
""")
  @route("/providers/Microsoft.AppComplianceAutomation/reports/{reportName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Report Name.")
      @path
      reportName: string;

      @doc("Parameters for the create or update operation")
      @body
      parameters: ReportResource;
    },
    ReportResource
  >;

  @doc("Update an exiting AppComplianceAutomation report.")
  @route("/providers/Microsoft.AppComplianceAutomation/reports/{reportName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("Report Name.")
      @path
      reportName: string;

      @doc("Parameters for the create or update operation")
      @body
      parameters: ReportResourcePatch;
    },
    ReportResource | void
  >;

  @doc("Delete an AppComplianceAutomation report.")
  @route("/providers/Microsoft.AppComplianceAutomation/reports/{reportName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Report Name.")
      @path
      reportName: string;
    },
    void
  >;
}

interface SnapshotsOperations {
  @doc("Get the AppComplianceAutomation snapshot list.")
  @route("/providers/Microsoft.AppComplianceAutomation/reports/{reportName}/snapshots")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Report Name.")
      @path
      reportName: string;

      @doc("Skip over when retrieving results.")
      @query
      $skipToken: string;

      @doc("Number of elements to return when retrieving results.")
      @query
      $top: int32;

      @doc("""
OData Select statement. Limits the properties on each entry to just those
requested, e.g. ?$select=reportName,id.
""")
      @query
      $select: string;

      @doc("The tenant id of the report creator.")
      @query
      reportCreatorTenantId: string;

      @doc("The offerGuid which mapping to the reports.")
      @query
      offerGuid: string;
    },
    SnapshotResourceList
  >;
}

interface SnapshotOperations {
  @doc("Get the AppComplianceAutomation snapshot and its properties.")
  @route("/providers/Microsoft.AppComplianceAutomation/reports/{reportName}/snapshots/{snapshotName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Report Name.")
      @path
      reportName: string;

      @doc("Snapshot Name.")
      @path
      snapshotName: string;
    },
    SnapshotResource
  >;

  @doc("Download compliance needs from snapshot, like: Compliance Report, Resource List.")
  @route("/providers/Microsoft.AppComplianceAutomation/reports/{reportName}/snapshots/{snapshotName}/download")
  @post
  Download is Azure.Core.Foundations.Operation<
    {
      @doc("Report Name.")
      @path
      reportName: string;

      @doc("Snapshot Name.")
      @path
      snapshotName: string;

      @doc("Parameters for the query operation")
      @body
      parameters: SnapshotDownloadRequest;
    },
    DownloadResponse | void
  >;
}
