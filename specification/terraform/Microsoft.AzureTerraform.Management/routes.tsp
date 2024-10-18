import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using OpenAPI;

namespace Microsoft.AzureTerraform;

@armResourceOperations
interface ExportTerraform {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Need to override operationId to fix LintDiff error"
  @doc("Exports the Terraform configuration of the specified resource(s).")
  @tag("ExportTerraform")
  @useFinalStateVia("azure-async-operation")
  @operationId("ExportTerraform_Export")
  exportTerraform is ArmProviderActionAsync<
    BaseExportModel,
    ExportResult,
    SubscriptionActionScope,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmCombinedLroHeaders<FinalResult = TerraformOperationStatus>
  >;
}
