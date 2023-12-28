import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkServiceDesignGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HybridNetwork;
@doc("network service design version.")
@parentResource(NetworkServiceDesignGroup)
model NetworkServiceDesignVersion
  is TrackedResource<NetworkServiceDesignVersionPropertiesFormat> {
  @doc("The name of the network service design version. The name should conform to the SemVer 2.0.0 specification: https://semver.org/spec/v2.0.0.html.")
  @maxLength(64)
  @pattern("^(0|[1-9]\\d*)\\.(0|[1-9]\\d*)\\.(0|[1-9]\\d*)(?:-((?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\\.(?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\\+([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?$")
  @key("networkServiceDesignVersionName")
  @segment("networkServiceDesignVersions")
  name: string;
}

@armResourceOperations
interface NetworkServiceDesignVersions {
  @doc("Gets information about a network service design version.")
  get is ArmResourceRead<NetworkServiceDesignVersion>;
  @doc("Creates or updates a network service design version.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<NetworkServiceDesignVersion>;
  @doc("Updates a network service design version resource.")
  update is ArmCustomPatchSync<NetworkServiceDesignVersion, TagsObject>;
  @doc("Deletes the specified network service design version.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkServiceDesignVersion>;
  @doc("Gets information about a list of network service design versions under a network service design group.")
  listByNetworkServiceDesignGroup is ArmResourceListByParent<NetworkServiceDesignVersion>;
  @doc("Update network service design version state.")
  updateState is ArmResourceActionAsync<
    NetworkServiceDesignVersion,
    NetworkServiceDesignVersionUpdateState,
    NetworkServiceDesignVersionUpdateState
  >;
}
