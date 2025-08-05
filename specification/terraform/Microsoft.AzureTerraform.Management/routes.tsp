import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.AzureTerraform;

alias LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
  ArmCombinedLroHeaders<FinalResult = TerraformOperationStatus>;

@armResourceOperations
interface Terraform {
  @doc("Exports the Terraform configuration of the specified resource(s).")
  @tag("ExportTerraform")
  @useFinalStateVia("azure-async-operation")
  exportTerraform is ArmProviderActionAsync<
    BaseExportModel,
    ArmAcceptedLroResponse<"Resource operation accepted.", LroHeaders>,
    Scope = SubscriptionActionScope,
    LroHeaders = LroHeaders
  >;
}
