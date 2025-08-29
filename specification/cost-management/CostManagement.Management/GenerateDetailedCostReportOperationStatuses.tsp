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
 * The status of the long running operation for cost detailed report.
 */
@extensionResource
model GenerateDetailedCostReportOperationStatuses
  is Azure.ResourceManager.ExtensionResource<DownloadURL> {
  ...ResourceNameParameter<
    Resource = GenerateDetailedCostReportOperationStatuses,
    KeyName = "operationId",
    SegmentName = "operationStatus",
    NamePattern = ""
  >;

  /**
   * The status of the long running operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  status?: Status;

  /**
   * The startTime of the operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  startTime?: string;

  /**
   * The endTime of the operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  endTime?: string;

  /**
   * The details of the error.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  error?: ErrorDetails;
}

@armResourceOperations
interface GenerateDetailedCostReportOperationStatus {
  /**
   * Get the status of the specified operation. This link is provided in the GenerateDetailedCostReport creation request response header.
   */
  get is Extension.Read<
    Extension.ScopeParameter,
    GenerateDetailedCostReportOperationStatuses
  >;
}

@@doc(GenerateDetailedCostReportOperationStatuses.name,
  "The target operation Id."
);
@@doc(GenerateDetailedCostReportOperationStatuses.properties,
  "The properties of the usage file generated."
);
