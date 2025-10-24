import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";
import "./models.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.AzureTerraform;

alias LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
  ArmCombinedLroHeaders<FinalResult = TerraformOperationStatus>;

@armResourceOperations
interface Terraform {
  @doc("Exports the Terraform configuration of the specified resource(s).")
  @tag("ExportTerraform")
  @useFinalStateVia("azure-async-operation")
  @returnTypeChangedFrom(
    Versions.v2025_09_01_preview,
    ArmAcceptedLroResponse<
      "Resource operation accepted.",
      LroHeaders
    > | ErrorResponse
  )
  exportTerraform is ArmProviderActionAsync<
    BaseExportModel,
    ArmAcceptedLroResponse<
      "Resource operation accepted.",
      LroHeaders
    > | ArmResponse<TerraformOperationStatus>,
    Scope = SubscriptionActionScope,
    LroHeaders = LroHeaders
  >;
}
