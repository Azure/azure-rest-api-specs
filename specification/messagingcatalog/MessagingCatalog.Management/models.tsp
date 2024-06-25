import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.MessagingCatalog;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning State")
@Azure.Core.lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Resource is updating.")
  Updating: "Updating",

  @doc("Resource is deleting.")
  Deleting: "Deleting",
}

@doc("Details of the Message Catalog.")
model MessagingCatalogProperties {
  @doc("A unique absolute URL for an catalog.")
  @visibility("read")
  self?: string;

  @doc("A summary of the purpose of the catalog.")
  description?: string;

  @doc("A URL to additional information about this catalog.")
  documentation?: string;

  @doc("An array of additional metadata about the catalog.")
  @extension("x-ms-identifiers", ["name"])
  labels?: ResourceLabel[];

  @doc("A unique absolute URL for the list of endpoints for this catalog.")
  @visibility("read")
  endpointsUrl?: string;

  @doc("A count of the amount of endpoints in this catalog.")
  @visibility("read")
  endpointsCount?: int32;

  @doc("A unique absolute URL for the list of message groups for this catalog.")
  @visibility("read")
  messageGroupsUrl?: string;

  @doc("A count of the amount of message groups in this catalog.")
  @visibility("read")
  messageGroupsCount?: int32;

  @doc("A unique absolute URL for the list of schema groups for this catalog.")
  @visibility("read")
  schemaGroupsUrl?: string;

  @doc("A count of the amount of schema groups in this catalog.")
  @visibility("read")
  schemaGroupsCount?: int32;

  @doc("The provisioning state of the application rule collection resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Additional metadata about the entity.")
@extension("x-ms-identifiers", ["name"])
model ResourceLabel {
  @doc("The name of the metadata label.")
  name?: string;

  @doc("The value of the metadata label.")
  value?: string;
}

@doc("The type used for update operations of the Messaging Catalog.")
model MessagingCatalogUpdate {
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The updatable properties of the Messaging Catalog.")
  @extension("x-ms-client-flatten", true)
  properties?: MessagingCatalogUpdateProperties;
}

@doc("The updatable properties of the Messaging Catalog.")
model MessagingCatalogUpdateProperties {
  @doc("A summary of the purpose of the catalog.")
  description?: string;

  @doc("A URL to additional information about this catalog.")
  documentation?: string;

  @doc("An array of additional metadata about the catalog.")
  @extension("x-ms-identifiers", ["name"])
  labels?: ResourceLabel[];
}

@doc("Details about the error result.")
model ProblemDetails {
  @doc("Type of issue encountered.")
  type?: string;

  @doc("Title of issue encountered.")
  title?: string;

  @doc("Status code of issue encountered.")
  status?: int32;

  @doc("Brief description of issue encountered.")
  detail?: string;

  @doc("Details about the error result.")
  instance?: string;
}
