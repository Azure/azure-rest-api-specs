import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Fixture parent resource for VpnServerConfigurationPolicyGroup."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Fixture parent resource for VpnServerConfigurationPolicyGroup."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Fixture parent resource for VpnServerConfigurationPolicyGroup."
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
@Http.Private.includeInapplicableMetadataInPayload(false)
model VpnServerConfiguration extends Resource {
  properties?: VpnServerConfigurationProperties;

  @visibility(Lifecycle.Read)
  @path
  @key("vpnServerConfigurationName")
  @segment("vpnServerConfigurations")
  name: string;

  @visibility(Lifecycle.Read)
  etag?: string;
}
