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

namespace Microsoft.Security;
@doc("A vulnerability assessment scan record.")
model Scan is ExtensionResource<ScanProperties> {
  @doc("The scan Id. Type 'latest' to get the scan record for the latest scan.")
  @path
  @key("scanId")
  @segment("scans")
  name: string;
}

@armResourceOperations
interface Scans {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the scan details of a single scan record.")
  @operationId("SqlVulnerabilityAssessmentScans_Get")
  get is ArmResourceRead<
    Scan,
    {
      ...BaseParameters<Scan>;

      @doc("The workspace Id.")
      @query("workspaceId")
      workspaceId: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a list of scan records.")
  @operationId("SqlVulnerabilityAssessmentScans_List")
  list is ArmResourceListByParent<
    Scan,
    {
      ...BaseParameters<Scan>;

      @doc("The workspace Id.")
      @query("workspaceId")
      workspaceId: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SqlVulnerabilityAssessmentScanResults_Get")
  @summary("Gets the scan results of a single rule in a scan record.")
  @doc("Gets the scan results of a single rule in a scan record.")
  // FIXME: SqlVulnerabilityAssessmentScanResults_Get could not be converted to a resource operation
  @route("/{resourceId}/providers/Microsoft.Security/sqlVulnerabilityAssessments/default/scans/{scanId}/scanResults/{scanResultId}")
  @get
  get is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SqlVulnerabilityAssessmentScanResults_List")
  @summary("Gets a list of scan results for a single scan record.")
  @doc("Gets a list of scan results for a single scan record.")
  // FIXME: SqlVulnerabilityAssessmentScanResults_List could not be converted to a resource operation
  @route("/{resourceId}/providers/Microsoft.Security/sqlVulnerabilityAssessments/default/scans/{scanId}/scanResults")
  @get
  list is Azure.Core.Foundations.Operation<
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
