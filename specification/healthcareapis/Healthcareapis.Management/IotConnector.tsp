import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HealthcareApis;
/**
 * IoT Connector definition.
 */
@parentResource(Workspace)
model IotConnector
  is Azure.ResourceManager.TrackedResource<IotConnectorProperties> {
  ...ResourceNameParameter<
    Resource = IotConnector,
    KeyName = "iotConnectorName",
    SegmentName = "iotconnectors",
    NamePattern = ""
  >;
}

@armResourceOperations
interface IotConnectors {
  /**
   * Gets the properties of the specified IoT Connector.
   */
  get is ArmResourceRead<IotConnector>;

  /**
   * Creates or updates an IoT Connector resource with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    IotConnector,
    Response = ArmResourceUpdatedResponse<IotConnector> | ArmResourceCreatedResponse<
      IotConnector,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: IotConnector;
    })
  >;

  /**
   * Patch an IoT Connector.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    IotConnector,
    PatchModel = IotConnectorPatchResource,
    Response = ArmResponse<IotConnector> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: IotConnector;
    })
  >;

  /**
   * Deletes an IoT Connector.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    IotConnector,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all IoT Connectors for the given workspace
   */
  listByWorkspace is ArmResourceListByParent<
    IotConnector,
    Response = ArmResponse<IotConnectorCollection>
  >;
}

@@maxLength(IotConnector.name, 24);
@@minLength(IotConnector.name, 3);
@@doc(IotConnector.name, "The name of IoT Connector resource.");
@@doc(IotConnector.properties, "IoT Connector configuration.");
@@doc(IotConnectors.createOrUpdate::parameters.resource,
  "The parameters for creating or updating an IoT Connectors resource."
);
@@doc(IotConnectors.update::parameters.properties,
  "The parameters for updating an IoT Connector."
);
