import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Publisher.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HybridNetwork;
@doc("Artifact store properties.")
@parentResource(Publisher)
model ArtifactStore is TrackedResource<ArtifactStorePropertiesFormat> {
  @doc("The name of the artifact store.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("artifactStoreName")
  @segment("artifactStores")
  name: string;
}

@armResourceOperations
interface ArtifactStores {
  @doc("Gets information about the specified artifact store.")
  get is ArmResourceRead<ArtifactStore>;
  @doc("Creates or updates a artifact store.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ArtifactStore>;
  @doc("Update artifact store resource.")
  update is ArmTagsPatchSync<ArtifactStore>;
  @doc("Deletes the specified artifact store.")
  delete is ArmResourceDeleteWithoutOkAsync<ArtifactStore>;
  @doc("Gets information of the ArtifactStores under publisher.")
  listByPublisher is ArmResourceListByParent<ArtifactStore>;
}

@armResourceOperations
interface ProxyArtifact {
  @doc("Lists all the available artifacts in the parent Artifact Store.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/artifactStores/{artifactStoreName}/artifacts")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @maxLength(64)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
      @path
      publisherName: string;

      @doc("The name of the artifact store.")
      @maxLength(64)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
      @path
      artifactStoreName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    ProxyArtifactOverviewListResult
  >;

  @doc("Get a Artifact overview information.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridNetwork/publishers/{publisherName}/artifactStores/{artifactStoreName}/artifactVersions")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the publisher.")
      @maxLength(64)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
      @path
      publisherName: string;

      @doc("The name of the artifact store.")
      @maxLength(64)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
      @path
      artifactStoreName: string;

      @doc("The name of the artifact.")
      @maxLength(64)
      @pattern("^[^\\s]*[^\\s]+[^\\s]*$")
      @query("artifactName")
      artifactName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    ProxyArtifactVersionsOverviewListResult
  >;
}
