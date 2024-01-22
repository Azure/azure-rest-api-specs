import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CustomerInsights;
/**
 * The connector resource format.
 */
@parentResource(Hub)
model ConnectorResourceFormat is ProxyResource<Connector> {
  /**
   * The name of the connector.
   */
  @path
  @key("connectorName")
  @segment("connectors")
  name: string;
}

@armResourceOperations
interface ConnectorResourceFormats {
  /**
   * Gets a connector in the hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Connectors_Get")
  get is ArmResourceRead<ConnectorResourceFormat>;

  /**
   * Creates a connector or updates an existing connector in the hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Connectors_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ConnectorResourceFormat>;

  /**
   * Deletes a connector in the hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Connectors_Delete")
  delete is ArmResourceDeleteAsync<ConnectorResourceFormat>;

  /**
   * Gets all the connectors in the specified hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Connectors_ListByHub")
  listByHub is ArmResourceListByParent<ConnectorResourceFormat>;
}

@@projectedName(ConnectorResourceFormats.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ConnectorResourceFormats.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ConnectorResourceFormats.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate Connector operation."
);
