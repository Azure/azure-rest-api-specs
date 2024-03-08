import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../AzureDeployments.common/helpers.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.Core.Traits;
using Microsoft.Resources.Deployments.Common;
using TypeSpec.OpenAPI;

namespace Microsoft.Resources.Deployments.Bicep;

@doc("The body of the request for the decompileBicep operation.")
model DecompileOperationRequest {
  @doc("The ARM json template to be decompiled into a Bicep file.")
  template: string;
}

@doc("The definition of a file along with its contents.")
model FileDefinition {
  @visibility("read")
  @doc("The path to the fille.")
  path: string;

  @visibility("read")
  @doc("The file contents.")
  contents: string;
}

@doc("The successful decompilation response.")
model DecompileOperationSuccessResponse {
  @visibility("read")
  @doc("An array of files decompiled from the ARM json template.")
  @extension("x-ms-identifiers", ["path"])
  files: FileDefinition[];

  @visibility("read")
  @doc("The file path to the main Bicep file generated from the decompiled ARM json template.")
  entryPoint: string;
}

@added(Versions.v2023_11_01)
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "@armResourceOperations does not understand subscription-level ARM operations"
interface Bicep {
  @tag("Bicep")
  @route("subscriptions/{subscriptionId}/providers/Microsoft.Resources/decompileBicep")
  @doc("Decompiles an ARM json template into a Bicep template.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "this is not a nested resource operation"
  decompileBicep is ArmActionSync<
    DecompileOperationRequest,
    DecompileOperationSuccessResponse
  >;
}