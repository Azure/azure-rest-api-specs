import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Connection.tsp";

using TypeSpec.Rest;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureDataTransfer;
/**
 * The flow resource definition.
 */
@parentResource(Connection)
model Flow is Azure.ResourceManager.TrackedResource<FlowProperties> {
  ...ResourceNameParameter<
    Resource = Flow,
    KeyName = "flowName",
    SegmentName = "flows",
    NamePattern = "^[a-zA-Z0-9-]{3,64}$"
  >;
  ...Azure.ResourceManager.ResourcePlanProperty;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

model ArmFlowResponse is ArmResponse<Flow>;

@armResourceOperations
interface Flows {
  /**
   * Gets flow resource.
   */
  get is ArmResourceRead<Flow>;

  /**
   * Creates or updates the flow resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Flow>;

  /**
   * Updates the flow resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "Prior OpenAPI2 Json spec provides the resource back in the LRO response."
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Flow,
    PatchModel = FlowsPatch,
    Response = ArmResponse<Flow> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Flow;
    })
  >;

  /**
   * Deletes the flow resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Flow>;

  /**
   * Gets flows in a connection.
   */
  listByConnection is ArmResourceListByParent<Flow>;

  /**
   * Disables the specified flow
   */
  disable is ArmResourceActionAsync<Flow, void, ArmFlowResponse>;

  /**
   * Enables the specified flow.
   */
  enable is ArmResourceActionAsync<Flow, void, ArmFlowResponse>;

  /**
   * Generate a compliant passphrase for the specified flow.
   */
  generatePassphrase is ArmResourceActionAsync<Flow, void, ArmFlowResponse>;

  /**
   * Get the destination endpoint ports for the specified flow.
   */
  getDestinationEndpointPorts is ArmResourceActionSync<
    Flow,
    void,
    ArmResponse<GetDestinationEndpointPortsResult>
  >;

  /**
   * Get the destination endpoints for the specified flow.
   */
  getDestinationEndpoints is ArmResourceActionSync<
    Flow,
    void,
    ArmResponse<GetDestinationEndpointsResult>
  >;

  /**
   * Get the source addresses for the specified flow.
   */
  getSourceAddresses is ArmResourceActionSync<
    Flow,
    void,
    ArmResponse<StreamSourceAddresses>
  >;

  /**
   * Get the connection string for the specified flow.
   */
  getStreamConnectionString is ArmResourceActionSync<
    Flow,
    void,
    ArmResponse<GetStreamConnectionStringResult>
  >;

  /**
   * Links the specified flow.
   */
  link is ArmResourceActionAsync<Flow, ResourceBody, ArmFlowResponse>;

  /**
   * Set the destination endpoint ports for the specified flow.
   */
  setDestinationEndpointPorts is ArmResourceActionAsync<
    Flow,
    SetDestinationEndpointPorts,
    ArmFlowResponse
  >;

  /**
   * Set the destination endpoints for the specified flow.
   */
  setDestinationEndpoints is ArmResourceActionAsync<
    Flow,
    SetDestinationEndpoints,
    ArmFlowResponse
  >;

  /**
   * Sets the passphrase of the specified flow.
   */
  setPassphrase is ArmResourceActionAsync<
    Flow,
    SetStreamPassphrase,
    ArmFlowResponse
  >;

  /**
   * Set the source addresses for the specified flow.
   */
  setSourceAddresses is ArmResourceActionAsync<
    Flow,
    SetSourceAddresses,
    ArmFlowResponse
  >;
}

@@maxLength(Flow.name, 64);
@@minLength(Flow.name, 3);
@@doc(Flow.name, "The name for the flow to perform the operation on.");
@@doc(Flow.properties, "Properties of flow");
@@doc(Flows.createOrUpdate::parameters.resource, "Flow body");
@@doc(Flows.update::parameters.properties, "Flow body");
@@doc(Flows.link::parameters.body, "Flow body");
@@doc(Flows.setDestinationEndpointPorts::parameters.body,
  "The destination endpoint ports wanted"
);
@@doc(Flows.setDestinationEndpoints::parameters.body,
  "Destination endpoints wanted."
);
@@doc(Flows.setPassphrase::parameters.body, "Passphrase to set");
@@doc(Flows.setSourceAddresses::parameters.body, "Source addresses wanted");
@@clientName(Flows.createOrUpdate::parameters.resource, "flow");
@@clientName(Flows.update::parameters.properties, "flow");
@@clientName(Flows.link::parameters.body, "flow");
@@clientName(Flows.setDestinationEndpointPorts::parameters.body,
  "streamDestinationEndpointPorts"
);
@@clientName(Flows.setDestinationEndpoints::parameters.body,
  "streamDestinationEndpoints"
);
@@clientName(Flows.setPassphrase::parameters.body, "passphrase");
@@clientName(Flows.setSourceAddresses::parameters.body, "sourceAddresses");
