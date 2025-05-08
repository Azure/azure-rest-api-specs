import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./../common/provisioningState.tsp";
import "./../common/resourceIds.tsp";
import "./../../Microsoft.HealthcareInterop.Edge.Management/common/models/requirements.tsp";
import "./../../Microsoft.HealthcareInterop.Edge.Management/common/models/hl7Models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.HealthcareInterop;

@doc("The healthcare interop Hl7 connector resource that reads healthcare events/messages from on-prem systems which is processed by the healthcare interop channel resource(s) associated with this connector.")
@resource("hl7Connectors")
model Hl7Connector is TrackedResource<Hl7ConnectorProperties> {
  @doc("The name of the Hl7 connector resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("hl7ConnectorName")
  @segment("hl7Connectors")
  @path
  name: string;
}

@doc("The properties to configure the Hl7 connector resource.")
model Hl7ConnectorProperties {
  @doc("The status of the last provisioning operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningLROState;

  @doc("The resource ID of an existing hub resource to link/associate this hl7Connector resource to.")
  hubResourceId: HubResourceId;

  @doc("The resource ID of the remote connector environment connected cluster where the connector will be deployed.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  connectedClusterId: ConnectedClusterResourceId;

  @doc("The receiver configuration to be used for the Hl7 connector.")
  receiver?: {
    @doc("The receiver endpoint configuration to be used for Hl7 connector.")
    hl7Configuration?: Hl7Configuration;

    @doc("The listener configuration to be used for Hl7 connector.")
    messageListenerConfiguration: MessageListenerConfiguration;

    @doc("The resource requirements for the application (CPU, Memory, and Storage).")
    requirements?: Requirements;
  };

  @visibility(Lifecycle.Read)
  @doc("The resource ID of the hl7EdgeConnector resource managed by this resource.")
  managedHl7EdgeConnectorResourceId?: Hl7EdgeConnectorResourceId;
}

@armResourceOperations
interface Hl7Connectors {
  get is ArmResourceRead<Hl7Connector>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Hl7Connector>;
  update is ArmResourcePatchAsync<Hl7Connector, Hl7ConnectorProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Hl7Connector>;
  listByResourceGroup is ArmResourceListByParent<Hl7Connector>;
  listBySubscription is ArmListBySubscription<Hl7Connector>;
}
