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
/**
 * IoT Connector definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Workspace)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(IotConnectorProperties)
model IotConnector extends TrackedResourceBase {
  /**
   * The name of IoT Connector resource.
   */
  @maxLength(24)
  @minLength(3)
  @path
  @key("iotConnectorName")
  @segment("iotconnectors")
  @visibility("read")
  name: string;

  /**
   * IoT Connector configuration.
   */
  @extension("x-ms-client-flatten", true)
  properties?: IotConnectorProperties;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<IotConnector>;

  /**
   * Patch an IoT Connector.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<IotConnector, IotConnectorPatchResource>;

  /**
   * Deletes an IoT Connector.
   */
  delete is ArmResourceDeleteAsync<IotConnector>;

  /**
   * Lists all IoT Connectors for the given workspace
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotConnectors_ListByWorkspace")
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
