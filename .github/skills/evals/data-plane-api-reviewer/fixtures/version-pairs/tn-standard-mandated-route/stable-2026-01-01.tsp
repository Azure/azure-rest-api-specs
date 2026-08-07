import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@service(#{ title: "Artifact Registry" })
@versioned(Versions)
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials,
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      scopes: ["https://artifactregistry.azure.com/.default"],
    }
  ]>
)
@server(
  "{endpoint}",
  "Artifact Registry service",
  {
    endpoint: url,
  }
)
@doc("""
  Registry API for container images and other OCI artifacts.

  The whole API surface is rooted at `/v2/`. That prefix is fixed by the OCI
  Distribution Specification, which defines the registry endpoint as `/v2/` and
  requires clients to probe it to discover whether a host speaks the registry
  protocol. Docker, containerd, ORAS and every other OCI client build this path
  themselves, so it is a conformance requirement rather than a choice this
  service makes.
  """)
@route("/v2")
namespace ArtifactRegistry;

@doc("Service API versions.")
enum Versions {
  @doc("The 2025-01-01 stable version.")
  v2025_01_01: "2025-01-01",

  @doc("The 2026-01-01 stable version.")
  v2026_01_01: "2026-01-01",
}

@doc("A named collection of artifacts.")
@resource("repositories")
model Repository {
  @doc("Name of the repository, for example `contoso/frontend`.")
  @key("repositoryName")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Time at which the repository was created, in UTC.")
  @visibility(Lifecycle.Read)
  createdAt: utcDateTime;
}

@doc("A container image manifest stored in a repository.")
@resource("manifests")
@parentResource(Repository)
model Manifest {
  @doc("Digest of the manifest, in `<algorithm>:<hex>` form.")
  @key("digest")
  @visibility(Lifecycle.Read)
  digest: string;

  @doc("Media type of the manifest document, for example `application/vnd.oci.image.manifest.v1+json`.")
  mediaType: string;

  @doc("Size of the manifest document in bytes.")
  sizeInBytes: int64;

  @doc("Tags in the repository that currently point at this manifest.")
  tags: string[];

  @doc("Platforms this manifest provides an image for. Absent for single-platform manifests.")
  @added(Versions.v2026_01_01)
  platforms?: Platform[];
}

@doc("An operating system and architecture combination an image targets.")
@added(Versions.v2026_01_01)
model Platform {
  @doc("Operating system the image targets, for example `linux`.")
  os: string;

  @doc("CPU architecture the image targets, for example `amd64`.")
  architecture: string;
}

@doc("Operations on repositories.")
interface Repositories {
  @doc("Gets a repository by name.")
  get is StandardResourceOperations.ResourceRead<Repository>;

  @doc("Lists the repositories in the registry.")
  list is StandardResourceOperations.ResourceList<
    Repository,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;
}

@doc("Operations on manifests within a repository.")
interface Manifests {
  @doc("Gets a manifest by digest.")
  get is StandardResourceOperations.ResourceRead<Manifest>;

  @doc("Lists the manifests in a repository.")
  list is StandardResourceOperations.ResourceList<
    Manifest,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @doc("Deletes a manifest. Deleting a manifest that does not exist succeeds.")
  delete is StandardResourceOperations.ResourceDelete<Manifest>;
}

