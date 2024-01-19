import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HealthcareApis;
@doc("IoT Connector definition.")
@parentResource(Workspace)
model IotConnector is TrackedResource<IotConnectorProperties> {
  @doc("The name of IoT Connector resource.")
  @maxLength(24)
  @minLength(3)
  @path
  @key("iotConnectorName")
  @segment("iotconnectors")
  name: string;
}

@armResourceOperations
interface IotConnectors {
  @doc("Gets the properties of the specified IoT Connector.")
  get is ArmResourceRead<IotConnector>;

  @doc("Creates or updates an IoT Connector resource with the specified parameters.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<IotConnector>;

  @doc("Patch an IoT Connector.")
  update is ArmCustomPatchAsync<IotConnector, IotConnectorPatchResource>;

  @doc("Deletes an IoT Connector.")
  delete is ArmResourceDeleteAsync<IotConnector>;

  @doc("Lists all IoT Connectors for the given workspace")
  listByWorkspace is ArmResourceListByParent<IotConnector>;
}

@@projectedName(IotConnectors.createOrUpdate::parameters.resource,
  "json",
  "iotConnector"
);
@@extension(IotConnectors.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "iotConnector"
);
@@doc(IotConnectors.createOrUpdate::parameters.resource,
  "The parameters for creating or updating an IoT Connectors resource."
);
@@projectedName(IotConnectors.update::parameters.properties,
  "json",
  "iotConnectorPatchResource"
);
@@extension(IotConnectors.update::parameters.properties,
  "x-ms-client-name",
  "iotConnectorPatchResource"
);
@@doc(IotConnectors.update::parameters.properties,
  "The parameters for updating an IoT Connector."
);
