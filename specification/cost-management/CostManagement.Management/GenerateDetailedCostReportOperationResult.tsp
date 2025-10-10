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
  get is Extension.Read<
    Extension.ScopeParameter,
    GenerateDetailedCostReportOperationResult,
    Response = ArmResponse<GenerateDetailedCostReportOperationResult> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = GenerateDetailedCostReportOperationResult>>,
    Error = ErrorResponse
  >;
}

@@doc(GenerateDetailedCostReportOperationResult.name,
  "The target operation Id."
);
@@doc(GenerateDetailedCostReportOperationResult.properties,
  "The properties of the resource generated."
);
