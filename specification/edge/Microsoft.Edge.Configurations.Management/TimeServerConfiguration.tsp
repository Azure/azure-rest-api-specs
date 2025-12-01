import "./Configuration.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@removed(Versions.v2025_06_01)
@added(Versions.v2025_12_01_preview)
@armResourceOperations
interface TimeServerConfigurations {
  get is ArmResourceRead<TimeServerConfiguration>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<TimeServerConfiguration>;
  update is ArmResourcePatchSync<
    TimeServerConfiguration,
    TimeServerConfigurationProperties
  >;
  delete is ArmResourceDeleteSync<TimeServerConfiguration>;
  listByConfiguration is ArmResourceListByParent<TimeServerConfiguration>;
}

@removed(Versions.v2025_06_01)
@added(Versions.v2025_12_01_preview)
@doc("TimeServerConfiguration Resource")
@parentResource(Configuration)
model TimeServerConfiguration
  is ProxyResource<TimeServerConfigurationProperties> {
  ...ResourceNameParameter<
    TimeServerConfiguration,
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$"
  >;
}

@removed(Versions.v2025_06_01)
@added(Versions.v2025_12_01_preview)
@doc("ArcGatewayConfigurationProperties Properties")
model TimeServerConfigurationProperties {
  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("Scenario in which this configuration is used")
  scenario: Scenario;

  @doc("timezone value, the available list can be obtained by executing 'Get-TimeZone -ListAvailable' in PowerShell. An example of valid timezone id is 'Pacific Standard Time' or 'UTC'.")
  timezone: string;

  @doc("NTP Configuration choice")
  ntpConfigurationChoice: NtpConfigurationChoice;

  @doc("Configuration for NTP Server. If the choice is set-to Custom then only need to set value for this.")
  ntpServerConfiguration?: NtpServerConfiguration;
}

@removed(Versions.v2025_06_01)
@added(Versions.v2025_12_01_preview)
@doc("Ntp Server Configuration")
model NtpServerConfiguration {
  @doc("Ntp Server")
  ntpServer: string;

  @doc("Alternate Ntp Server")
  alternateNtpServer?: string;
}

@removed(Versions.v2025_06_01)
@added(Versions.v2025_12_01_preview)
@doc("Choices for NTP Server selection")
union NtpConfigurationChoice {
  @doc("Automatic selection of NTP Server")
  Automatic: "Automatic",

  @doc("Custom/Manual selection of NTP Server")
  Custom: "Custom",

  string,
}
