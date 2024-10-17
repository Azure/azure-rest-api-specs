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
  @doc("Exports the Terraform configuration of the specified resource(s).")
  @tag("ExportTerraform")
  @useFinalStateVia("azure-async-operation")
  exportTerraform is ArmProviderActionAsync<
    BaseExportModel,
    ExportResult,
    SubscriptionActionScope,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmCombinedLroHeaders<FinalResult = TerraformOperationStatus>
  >;
}
