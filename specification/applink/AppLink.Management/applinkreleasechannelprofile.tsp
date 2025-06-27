import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.AppLink;

#suppress "@azure-tools/typespec-azure-core/arm-resource-id" ""
@doc("AppLink Release Channel Profile resource")
@locationResource
model AppLinkReleaseChannelProfile
  is ProxyResource<AppLinkReleaseChannelProfileProperties> {
  ...ResourceNameParameter<AppLinkReleaseChannelProfile>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
@doc("AppLink Release Channel Profile properties")
model AppLinkReleaseChannelProfileProperties {
  @doc("AppLink Release Channels")
  @OpenAPI.extension("x-ms-identifiers", #[])
  appLinkReleaseChannels: AppLinkReleaseChannel[];
}

@doc("AppLink Release Channel")
model AppLinkReleaseChannel {
  @doc("The name of the AppLink Release Channel")
  releaseChannel: string;

  @doc("The version of the AppLink Release Channel")
  revision: string;

  @doc("Compatible with other AppLink Release Channels")
  compatibleWith: CompatibleWith[];
}

@doc("Compatible With version of AppLink Release Channel")
model CompatibleWith {
  @doc("The name of the compatible AppLink Release Channel")
  name: string;

  @doc("The versions of the compatible AppLink Release Channel")
  versions: string[];
}

/** AppLinkReleaseChannelProfiles operations */
@armResourceOperations
interface AppLinkReleaseChannelProfiles {
  listByLocation is ArmResourceListByParent<AppLinkReleaseChannelProfile>;
}
