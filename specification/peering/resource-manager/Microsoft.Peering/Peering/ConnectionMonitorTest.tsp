import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PeeringService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Peering;
/**
 * The Connection Monitor Test class.
 */
@parentResource(PeeringService)
model ConnectionMonitorTest
  is Azure.ResourceManager.ProxyResource<ConnectionMonitorTestProperties> {
  ...ResourceNameParameter<
    Resource = ConnectionMonitorTest,
    KeyName = "connectionMonitorTestName",
    SegmentName = "connectionMonitorTests",
    NamePattern = "[A-Za-z0-9_.-]{1,63}"
  >;
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
  listByPeeringService is ArmResourceListByParent<ConnectionMonitorTest>;
}

@@doc(ConnectionMonitorTest.name, "The name of the connection monitor test");
@@doc(ConnectionMonitorTest.properties,
  "The properties that define a Connection Monitor Test."
);
@@doc(ConnectionMonitorTests.createOrUpdate::parameters.resource,
  "The properties needed to create a connection monitor test"
);
