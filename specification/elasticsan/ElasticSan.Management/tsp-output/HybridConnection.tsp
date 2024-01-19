import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppServicePlan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
@doc("Hybrid Connection contract. This is used to configure a Hybrid Connection.")
@parentResource(AppServicePlan)
model HybridConnection is ProxyResource<HybridConnectionProperties> {
  @doc("Name of the Service Bus relay.")
  @path
  @key("relayName")
  @segment("relays")
  name: string;
}

@armResourceOperations
interface HybridConnections {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Retrieve a Hybrid Connection in use in an App Service plan.")
  @operationId("AppServicePlans_GetHybridConnection")
  getHybridConnection is ArmResourceRead<HybridConnection>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Delete a Hybrid Connection in use in an App Service plan.")
  @operationId("AppServicePlans_DeleteHybridConnection")
  deleteHybridConnection is ArmResourceDeleteSync<HybridConnection>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get the send key name and value of a Hybrid Connection.")
  @operationId("AppServicePlans_ListHybridConnectionKeys")
  listHybridConnectionKeys is ArmResourceActionSync<
    HybridConnection,
    void,
    HybridConnectionKey
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServicePlans_ListWebAppsByHybridConnection")
  @summary("Get all apps that use a Hybrid Connection in an App Service Plan.")
  @doc("Description for Get all apps that use a Hybrid Connection in an App Service Plan.")
  // FIXME: AppServicePlans_ListWebAppsByHybridConnection could not be converted to a resource operation
  listWebAppsByHybridConnection is Azure.Core.ResourceList<string>;
}
