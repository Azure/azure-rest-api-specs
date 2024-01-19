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
@doc("The connector mapping resource format.")
@parentResource(ConnectorResourceFormat)
model ConnectorMappingResourceFormat is ProxyResource<ConnectorMapping> {
  @doc("The name of the connector mapping.")
  @path
  @key("mappingName")
  @segment("mappings")
  name: string;
}

@armResourceOperations
interface ConnectorMappingResourceFormats {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a connector mapping in the connector.")
  @operationId("ConnectorMappings_Get")
  get is ArmResourceRead<ConnectorMappingResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a connector mapping or updates an existing connector mapping in the connector.")
  @operationId("ConnectorMappings_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConnectorMappingResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a connector mapping in the connector.")
  @operationId("ConnectorMappings_Delete")
  delete is ArmResourceDeleteSync<ConnectorMappingResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all the connector mappings in the specified connector.")
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
