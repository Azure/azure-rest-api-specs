import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ConnectorResourceFormat.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CustomerInsights;
/**
 * The connector mapping resource format.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ConnectorResourceFormat)
@includeInapplicableMetadataInPayload(false)
model ConnectorMappingResourceFormat extends ProxyResource {
  /**
   * The name of the connector mapping.
   */
  @path
  @key("mappingName")
  @segment("mappings")
  @visibility("read")
  name: string;

  /**
   * The connector mapping definition.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ConnectorMapping;
}

@armResourceOperations
interface ConnectorMappingResourceFormats {
  /**
   * Gets a connector mapping in the connector.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectorMappings_Get")
  get is ArmResourceRead<ConnectorMappingResourceFormat>;

  /**
   * Creates a connector mapping or updates an existing connector mapping in the connector.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectorMappings_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConnectorMappingResourceFormat>;

  /**
   * Deletes a connector mapping in the connector.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectorMappings_Delete")
  delete is ArmResourceDeleteSync<ConnectorMappingResourceFormat>;

  /**
   * Gets all the connector mappings in the specified connector.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectorMappings_ListByConnector")
  listByConnector is ArmResourceListByParent<ConnectorMappingResourceFormat>;
}

@@projectedName(ConnectorMappingResourceFormats.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ConnectorMappingResourceFormats.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ConnectorMappingResourceFormats.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate Connector Mapping operation."
);
