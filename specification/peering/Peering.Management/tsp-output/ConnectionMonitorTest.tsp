import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PeeringService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Peering;
/**
 * The Connection Monitor Test class.
 */
@parentResource(PeeringService)
model ConnectionMonitorTest is ProxyResource<ConnectionMonitorTestProperties> {
  /**
   * The name of the connection monitor test
   */
  @path
  @key("connectionMonitorTestName")
  @segment("connectionMonitorTests")
  name: string;
}

@armResourceOperations
interface ConnectionMonitorTests {
  /**
   * Gets an existing connection monitor test with the specified name under the given subscription, resource group and peering service.
   */
  get is ArmResourceRead<ConnectionMonitorTest>;

  /**
   * Creates or updates a connection monitor test with the specified name under the given subscription, resource group and peering service.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConnectionMonitorTest>;

  /**
   * Deletes an existing connection monitor test with the specified name under the given subscription, resource group and peering service.
   */
  delete is ArmResourceDeleteSync<ConnectionMonitorTest>;

  /**
   * Lists all connection monitor tests under the given subscription, resource group and peering service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectionMonitorTests_ListByPeeringService")
  listByPeeringService is ArmResourceListByParent<ConnectionMonitorTest>;
}

@@projectedName(ConnectionMonitorTests.createOrUpdate::parameters.resource,
  "json",
  "connectionMonitorTest"
);
@@extension(ConnectionMonitorTests.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "connectionMonitorTest"
);
@@doc(ConnectionMonitorTests.createOrUpdate::parameters.resource,
  "The properties needed to create a connection monitor test"
);
