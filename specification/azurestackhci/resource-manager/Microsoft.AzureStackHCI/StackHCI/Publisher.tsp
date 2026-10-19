import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.AzureStackHCI;
/**
 * Publisher details.
 */
@parentResource(Cluster)
@added(Versions.v2026_11_01_preview)
model Publisher is Azure.ResourceManager.ProxyResource<PublisherProperties> {
  ...ResourceNameParameter<
    Resource = Publisher,
    KeyName = "publisherName",
    SegmentName = "publishers",
    NamePattern = ""
  >;
}

@@doc(
  Publisher.name,
  "The name of the publisher available within HCI cluster."
);
@@doc(Publisher.properties, "Publisher properties.");
