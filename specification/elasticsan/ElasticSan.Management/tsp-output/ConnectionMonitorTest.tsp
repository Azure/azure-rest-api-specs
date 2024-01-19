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
@doc("The Connection Monitor Test class.")
@parentResource(PeeringService)
model ConnectionMonitorTest is ProxyResource<ConnectionMonitorTestProperties> {
  @doc("The name of the connection monitor test")
  @path
  @key("connectionMonitorTestName")
  @segment("connectionMonitorTests")
  name: string;
}

@armResourceOperations
interface ConnectionMonitorTests {
  @doc("Gets an existing connection monitor test with the specified name under the given subscription, resource group and peering service.")
  get is ArmResourceRead<ConnectionMonitorTest>;

  @doc("Creates or updates a connection monitor test with the specified name under the given subscription, resource group and peering service.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConnectionMonitorTest>;

  @doc("Deletes an existing connection monitor test with the specified name under the given subscription, resource group and peering service.")
  delete is ArmResourceDeleteSync<ConnectionMonitorTest>;

  @doc("Lists all connection monitor tests under the given subscription, resource group and peering service.")
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
