import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CostManagement;
/**
 * The result of the long running operation for cost detailed report.
 */
model GenerateDetailedCostReportOperationResult
  is Azure.ResourceManager.ExtensionResource<DownloadURL> {
  ...ResourceNameParameter<
    Resource = GenerateDetailedCostReportOperationResult,
    KeyName = "operationId",
    SegmentName = "operationResults",
    NamePattern = ""
  >;
}

@armResourceOperations
interface GenerateDetailedCostReportOperationResults {
  /**
   * Gets the result of the specified operation. The link with this operationId is provided as a response header of the initial request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ClientGenerator.Core.Legacy.markAsLro
  get is Extension.Read<
    Extension.ScopeParameter,
    GenerateDetailedCostReportOperationResult,
    Response = ArmResponse<GenerateDetailedCostReportOperationResult> | ArmAcceptedResponse,
    Error = ErrorResponse
  >;
}

@@doc(GenerateDetailedCostReportOperationResult.name,
  "The target operation Id."
);
@@doc(GenerateDetailedCostReportOperationResult.properties,
  "The properties of the resource generated."
);
