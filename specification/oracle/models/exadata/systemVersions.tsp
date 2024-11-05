using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Oracle.Database;

@doc("SystemVersion resource Definition")
@parentResource(SubscriptionLocationResource)
model SystemVersion is ProxyResource<SystemVersionProperties> {
  @doc("SystemVersion name")
  @key("systemversionname")
  @path
  @segment("systemVersions")
  @pattern(".*")
  name: string;
}

@doc("SystemVersions filter")
model SystemVersionsFilter {
  @doc("Grid Infrastructure version")
  giVersion: string;

  @doc("Exadata shape")
  shape: string;

  @doc("Check If we have to list only latest versions")
  isLatestVersion?: boolean;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only resource. No provisioning state provided."
@doc("System Version Resource model")
model SystemVersionProperties {
  @doc("A valid Oracle System Version")
  @visibility("read")
  systemVersion?: string;
}
