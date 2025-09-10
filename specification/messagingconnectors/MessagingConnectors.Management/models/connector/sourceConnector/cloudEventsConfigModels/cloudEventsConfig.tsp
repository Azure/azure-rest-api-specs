import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.Connector.SourceConnector.CloudEventsConfig;

@doc("CloudEvents types")
union CloudEventsType {
  @doc("CatalogCloudEventsConfig")
  Catalog: "Catalog",

  @doc("EventSchemaSetCloudEventsConfig")
  EventSchemaSet: "EventSchemaSet",

  string,
}

@doc("Cloud events config")
@discriminator("type")
model CloudEventsConfig {
  @doc("Type of CloudEventsConfig.")
  type: CloudEventsType;
}

@doc("Catalog schema id config")
model CatalogSchemaId {
  @doc("The schema group id in the catalog, which can be obtained from the catalog cloud provider.")
  schemaGroupId: string;

  @doc("The schema id in schema group.")
  schemaId: string;

  @doc("Endpoint for catalog.")
  endpoint: string;
}

@doc("Catalog cloud events transform config.")
model CatalogCloudEventsConfig extends CloudEventsConfig {
  @doc("Type of CatalogCloudEventsConfig.")
  type: CloudEventsType.Catalog;

  @doc("Whether auto-register new schemas.")
  autoRegisterSchemas: boolean;

  @doc("Catalog schemaIds.")
  @Azure.ResourceManager.identifiers(#[])
  catalogSchemaIds: CatalogSchemaId[];

  @doc("Auth of Catalog")
  authentication: Models.Auth.Authentication;
}

@doc("EventSchemaSet cloud events transform config.")
model EventSchemaSetCloudEventsConfig extends CloudEventsConfig {
  @doc("Type of EventSchemaSetCloudEventsConfig.")
  type: CloudEventsType.EventSchemaSet;

  @doc("Endpoint of EventSchemaSet.")
  endpoint: string;

  @doc("Id list of MessagingGroup.")
  messageGroupIds: string[];

  @doc("Auth of EventSchemaSet")
  authentication: Models.Auth.Authentication;
}
