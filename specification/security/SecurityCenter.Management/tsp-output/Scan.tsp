import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("A vulnerability assessment scan record.")
model Scan is ExtensionResource<ScanProperties> {
  @doc("The scan Id. Type 'latest' to get the scan record for the latest scan.")
  @key("scanId")
  @segment("scans")
  name: string;
}

@armResourceOperations
interface SqlVulnerabilityAssessmentScans {
  @doc("Gets the scan details of a single scan record.")
  get is ArmResourceRead<
    Scan,
    {
      ...BaseParameters<Scan>;

      @doc("The workspace Id.")
      @query("workspaceId")
      workspaceId: string;
    }
  >;
  @doc("Gets a list of scan records.")
  list is ArmResourceListByParent<
    Scan,
    {
      ...BaseParameters<Scan>;

      @doc("The workspace Id.")
      @query("workspaceId")
      workspaceId: string;
    }
  >;
}

@armResourceOperations
interface SqlVulnerabilityAssessmentScanResults {
  @summary("Gets the scan results of a single rule in a scan record.")
  @doc("Gets the scan results of a single rule in a scan record.")
  // FIXME: SqlVulnerabilityAssessmentScanResults_Get could not be converted to a resource operation
  @route("/{resourceId}/providers/Microsoft.Security/sqlVulnerabilityAssessments/default/scans/{scanId}/scanResults/{scanResultId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The scan Id. Type 'latest' to get the scan results for the latest scan.")
      @path
      scanId: string;

      @doc("The rule Id of the results.")
      @path
      scanResultId: string;

      @doc("The workspace Id.")
      @query("workspaceId")
      workspaceId: string;

      @doc("The identifier of the resource.")
      @path
      resourceId: string;
    },
    ScanResult
  >;

  @summary("Gets a list of scan results for a single scan record.")
  @doc("Gets a list of scan results for a single scan record.")
  // FIXME: SqlVulnerabilityAssessmentScanResults_List could not be converted to a resource operation
  @route("/{resourceId}/providers/Microsoft.Security/sqlVulnerabilityAssessments/default/scans/{scanId}/scanResults")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The scan Id. Type 'latest' to get the scan results for the latest scan.")
      @path
      scanId: string;

      @doc("The workspace Id.")
      @query("workspaceId")
      workspaceId: string;

      @doc("The identifier of the resource.")
      @path
      resourceId: string;
    },
    ScanResults
  >;
}
