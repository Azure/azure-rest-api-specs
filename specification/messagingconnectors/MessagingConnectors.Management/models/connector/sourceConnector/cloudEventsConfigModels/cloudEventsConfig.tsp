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

  @doc("CdcEventSchemaSetCloudEventsConfig")
  CdcEventSchemaSet: "CdcEventSchemaSet",

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

@doc("Array of CatalogMessageSelf.")
model CatalogMessageSelf {
  @doc("Endpoint of CatalogMessageSelf.")
  endpoint: string;

  @doc("GroupId of message.")
  messageGroupId: string;

  @doc("Id of message.")
  messageId?: string;
}

@doc("EventSchemaSet cloud events transform config.")
model EventSchemaSetCloudEventsConfig extends CloudEventsConfig {
  @doc("Type of EventSchemaSetCloudEventsConfig.")
  type: CloudEventsType.EventSchemaSet;

  @doc("Array of CatalogMessagingSelf.")
  @Azure.ResourceManager.identifiers(#[])
  catalogMessageSelves: CatalogMessageSelf[];

  @doc("Auth of EventSchemaSet")
  authentication: Models.Auth.Authentication;
}

@doc("Base configuration for schema autoRegister.")
model AutoRegisterConfig {
  @doc("The catalog endpoint  of auto register schema.")
  catalogEndpoint: string;

  @doc("The message group id of auto register schema.")
  messageGroupId: string;

  @doc("The schema group id of auto register schema.")
  schemaGroupId: string;

  @doc("The cloud event source of auto register schema.")
  cloudEventSource: string;
}

@doc("EventSchemaSet cloud events transform config for CDC(Change data capture).")
model CdcEventSchemaSetCloudEventsConfig extends CloudEventsConfig {
  @doc("Type of CdcEventSchemaSetCloudEventsConfig.")
  type: CloudEventsType.CdcEventSchemaSet;

  @doc("Array of CatalogMessagingSelf.")
  @Azure.ResourceManager.identifiers(#[])
  catalogMessageSelves: CatalogMessageSelf[];

  @doc("Auth of EventSchemaSet")
  authentication: Models.Auth.Authentication;

  @doc("Configuration for register")
  autoRegisterConfig?: AutoRegisterConfig;
}
