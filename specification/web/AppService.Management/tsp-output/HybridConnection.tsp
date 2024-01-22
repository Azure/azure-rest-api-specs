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
/**
 * Hybrid Connection contract. This is used to configure a Hybrid Connection.
 */
@parentResource(AppServicePlan)
model HybridConnection is ProxyResource<HybridConnectionProperties> {
  /**
   * Name of the Service Bus relay.
   */
  @path
  @key("relayName")
  @segment("relays")
  name: string;
}

@armResourceOperations
interface HybridConnections {
  /**
   * Description for Retrieve a Hybrid Connection in use in an App Service plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServicePlans_GetHybridConnection")
  getHybridConnection is ArmResourceRead<HybridConnection>;

  /**
   * Description for Delete a Hybrid Connection in use in an App Service plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServicePlans_DeleteHybridConnection")
  deleteHybridConnection is ArmResourceDeleteSync<HybridConnection>;

  /**
   * Description for Get the send key name and value of a Hybrid Connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServicePlans_ListHybridConnectionKeys")
  listHybridConnectionKeys is ArmResourceActionSync<
    HybridConnection,
    void,
    HybridConnectionKey
  >;

  /**
   * Description for Get all apps that use a Hybrid Connection in an App Service Plan.
   */
  // FIXME: AppServicePlans_ListWebAppsByHybridConnection could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServicePlans_ListWebAppsByHybridConnection")
  @summary("Get all apps that use a Hybrid Connection in an App Service Plan.")
  listWebAppsByHybridConnection is Azure.Core.ResourceList<string>;
}
