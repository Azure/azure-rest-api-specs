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
@doc("The connector resource format.")
@parentResource(Hub)
model ConnectorResourceFormat is ProxyResource<Connector> {
  @doc("The name of the connector.")
  @path
  @key("connectorName")
  @segment("connectors")
  name: string;
}

@armResourceOperations
interface ConnectorResourceFormats {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a connector in the hub.")
  @operationId("Connectors_Get")
  get is ArmResourceRead<ConnectorResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a connector or updates an existing connector in the hub.")
  @operationId("Connectors_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ConnectorResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a connector in the hub.")
  @operationId("Connectors_Delete")
  delete is ArmResourceDeleteAsync<ConnectorResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all the connectors in the specified hub.")
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
