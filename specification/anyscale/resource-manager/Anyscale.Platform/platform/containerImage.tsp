import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./versions.tsp";
import "./cloud.tsp";

using Rest;
using Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Anyscale.Platform;

/** A container image used by Anyscale workloads. */
@parentResource(Cloud)
@resource("containerImages")
model ContainerImage is ProxyResource<ContainerImageProperties> {
  /** The name of container image. */
  @pattern("^[a-zA-Z0-9_-]+$")
  @maxLength(256)
  @key("containerImageName")
  @path
  @segment("containerImages")
  name: string;
}

/** Properties of a container image. Exactly one of `containerfile` or `containerImageUri` must be provided. */
model ContainerImageProperties {
  /** Containerfile content to use to build the container image. Mutually exclusive with containerImageUri. */
  containerfile?: string;

  /** A pre-built container image reference from an external registry, such as registry/repository:tag or registry/repository\@sha256:digest. Mutually exclusive with containerfile. */
  containerImageUri?: string;

  /** The URL link of the container image to the Anyscale console. */
  @visibility(Lifecycle.Read)
  url?: url;

  /** The current revision number. This is incremented when the container image is updated. */
  @visibility(Lifecycle.Read)
  revision?: int32;

  /** The current state of the container image build. */
  @visibility(Lifecycle.Read)
  buildState?: ContainerImageBuildState;

  /** The provisioning state of the container image. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** State of a container image build. */
union ContainerImageBuildState {
  /** Build is queued; has not started yet. */
  BuildPending: "BuildPending",

  /** Build is in progress. */
  BuildInProgress: "BuildInProgress",

  /** Build has completed successfully. */
  BuildSucceeded: "BuildSucceeded",

  /** Build has completed with a failure. */
  BuildFailed: "BuildFailed",

  string,
}

@armResourceOperations
interface ContainerImages {
  /** Gets a container image. */
  get is ArmResourceRead<ContainerImage>;
  /** Creates or updates a container image. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ContainerImage>;
  /** Updates a container image. */
  update is ArmCustomPatchSync<
    ContainerImage,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ContainerImage,
      ContainerImageProperties
    >
  >;
  /** Deletes a container image. */
  delete is ArmResourceDeleteWithoutOkAsync<
    ContainerImage,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;
  /** Lists container images in a cloud. */
  listByResourceGroup is ArmResourceListByParent<ContainerImage>;
}
