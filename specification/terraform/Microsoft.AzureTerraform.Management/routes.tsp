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

alias LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
  ArmCombinedLroHeaders<FinalResult = TerraformOperationStatus>;

@armResourceOperations
interface Terraform {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Need to override operationId to fix LintDiff error"
  @doc("Exports the Terraform configuration of the specified resource(s).")
  @tag("ExportTerraform")
  @useFinalStateVia("azure-async-operation")
  @operationId("Terraform_Export")
  exportTerraform is ArmProviderActionAsync<
    BaseExportModel,
    ArmAcceptedLroResponse<"Resource operation accepted.", LroHeaders>,
    Scope = SubscriptionActionScope,
    LroHeaders = LroHeaders
  >;
}
