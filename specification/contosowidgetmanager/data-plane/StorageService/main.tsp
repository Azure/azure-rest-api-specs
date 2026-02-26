// StorageService main.tsp - Data-plane service level TypeSpec project
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service({
  title: "Contoso Storage Service",
})
@versioned(Versions)
@server(
  "{endpoint}/storage",
  "Contoso Storage Service",
  {
    endpoint: url,
  }
)
namespace Contoso.StorageService;

enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_01_01_preview: "2024-01-01-preview",
}

@doc("A storage container")
model Container {
  @doc("Container name")
  name: string;

  @doc("Container metadata")
  metadata?: Record<string>;

  @doc("Creation time")
  createdTime?: utcDateTime;
}

@doc("List containers response")
model ContainerListResult {
  @doc("List of containers")
  value: Container[];

  @doc("Next page link")
  nextLink?: url;
}

@route("/containers")
interface Containers {
  @doc("List all containers")
  list(): ContainerListResult;

  @doc("Get a container")
  @route("/{name}")
  get(@path name: string): Container;

  @doc("Create a container")
  @route("/{name}")
  @put
  create(@path name: string, @body container: Container): Container;

  @doc("Delete a container")
  @route("/{name}")
  @delete
  delete(@path name: string): void;
}
