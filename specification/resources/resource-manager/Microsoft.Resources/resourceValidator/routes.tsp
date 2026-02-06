import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace ResourceValidationClient;

@armResourceOperations
interface ResourceValidationClient {
  /** Validates multiple ARM resources. */
  @action("validateResources")
  validateResources is ArmProviderActionSync<
    Request = ResourceValidationRequest,
    Response = ResourceValidationResponse,
    Scope = TenantActionScope
  >;
}
