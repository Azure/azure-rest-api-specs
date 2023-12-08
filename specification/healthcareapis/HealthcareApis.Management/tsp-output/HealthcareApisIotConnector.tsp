import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./HealthcareApisWorkspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HealthcareApis;
@doc("IoT Connector definition.")
@parentResource(HealthcareApisWorkspace)
model HealthcareApisIotConnector is TrackedResource<IotConnectorProperties> {
  @doc("The name of IoT Connector resource.")
  @maxLength(24)
  @minLength(3)
  @path
  @key("iotConnectorName")
  @segment("iotconnectors")
  name: string;
}

@armResourceOperations
interface HealthcareApisIotConnectors {
  @doc("Gets the properties of the specified IoT Connector.")
  get is ArmResourceRead<HealthcareApisIotConnector>;
  @doc("Creates or updates an IoT Connector resource with the specified parameters.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<HealthcareApisIotConnector>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Patch an IoT Connector.")
  update is ArmCustomPatchAsync<
    HealthcareApisIotConnector,
    IotConnectorPatchResource
  >;
  @doc("Deletes an IoT Connector.")
  delete is ArmResourceDeleteAsync<HealthcareApisIotConnector>;
  @doc("Lists all IoT Connectors for the given workspace")
  listByWorkspace is ArmResourceListByParent<HealthcareApisIotConnector>;
}
