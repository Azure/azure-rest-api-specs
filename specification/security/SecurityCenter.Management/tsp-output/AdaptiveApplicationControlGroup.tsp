import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SecurityCenterLocation.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;

@parentResource(SecurityCenterLocation)
model AdaptiveApplicationControlGroup
  is ProxyResource<AdaptiveApplicationControlGroupData> {
  @doc("Name of an application control machine group")
  @path
  @key("groupName")
  @segment("applicationWhitelistings")
  name: string;
}

@armResourceOperations
interface AdaptiveApplicationControlGroups {
  @doc("Gets an application control VM/server group.")
  get is ArmResourceRead<AdaptiveApplicationControlGroup>;
  @doc("Update an application control machine group")
  put is ArmResourceCreateOrReplaceSync<AdaptiveApplicationControlGroup>;
  @doc("Delete an application control machine group")
  delete is ArmResourceDeleteSync<AdaptiveApplicationControlGroup>;
  @doc("Gets a list of application control machine groups for the subscription.")
  list is ArmListBySubscription<AdaptiveApplicationControlGroup>;
}
