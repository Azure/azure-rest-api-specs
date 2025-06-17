import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;

namespace BicepClient;

@armResourceOperations
interface DecompileOperationGroup {
  /**
   * Decompiles an ARM json template into a Bicep template
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @autoRoute
  @action("decompileBicep")
  @operationId("Decompile_Bicep")
  bicep is ArmProviderActionSync<
    Request = DecompileOperationRequest,
    Response = DecompileOperationSuccessResponse,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

@@clientName(DecompileOperationGroup.bicep::parameters.body,
  "decompileOperationRequest"
);
