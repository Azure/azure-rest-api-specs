import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Publisher.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.HybridNetwork;
@doc("network service design group resource.")
@parentResource(Publisher)
model NetworkServiceDesignGroup
  is TrackedResource<NetworkServiceDesignGroupPropertiesFormat> {
  @doc("The name of the network service design group.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @key("networkServiceDesignGroupName")
  @segment("networkServiceDesignGroups")
  name: string;
}

@armResourceOperations
interface NetworkServiceDesignGroups {
  @doc("Gets information about the specified networkServiceDesign group.")
  get is ArmResourceRead<NetworkServiceDesignGroup>;

  @doc("Creates or updates a network service design group.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<NetworkServiceDesignGroup>;

  @doc("Updates a network service design groups resource.")
  update is ArmCustomPatchSync<NetworkServiceDesignGroup, TagsObject>;

  @doc("Deletes a specified network service design group.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkServiceDesignGroup>;

  @doc("Gets information of the network service design groups under a publisher.")
  listByPublisher is ArmResourceListByParent<NetworkServiceDesignGroup>;
}
