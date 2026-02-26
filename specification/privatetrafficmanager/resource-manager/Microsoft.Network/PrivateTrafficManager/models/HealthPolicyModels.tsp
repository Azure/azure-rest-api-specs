import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./ProfileModels.tsp";
using Azure.ResourceManager;

namespace Microsoft.Network;

@doc("Class representing kind of Traffic Manager health policy.")
union HealthPolicyKind {
  string,

  @doc("Health policy that uses probing to monitor endpoint health.")
  Probe: "Probe",
}

@doc("The protocol (HTTP, HTTPS or TCP) used to probe for endpoint health.")
union Protocol {
  string,

  @doc("Hypertext Transfer Protocol for health probing.")
  HTTP: "HTTP",

  @doc("Hypertext Transfer Protocol Secure for health probing.")
  HTTPS: "HTTPS",

  @doc("Transmission Control Protocol for health probing.")
  TCP: "TCP",
}

@doc("Class containing endpoint monitoring settings in a Traffic Manager profile.")
model ProbeConfig {
  @doc("The protocol (HTTP, HTTPS or TCP) used to probe for endpoint health.")
  protocol?: Protocol;

  @doc("The TCP port used to probe for endpoint health.")
  port?: int64;

  @doc("The path relative to the endpoint domain name used to probe for endpoint health.")
  path?: string;

  @doc("The monitor interval for endpoints in this profile. This is the interval at which Traffic Manager will check the health of each endpoint in this profile. Allowed values: 5, 10, or 30 seconds.")
  intervalInSeconds?: int64;

  @doc("The monitor timeout for endpoints in this profile. This is the time that Traffic Manager allows endpoints in this profile to response to the health check.")
  timeoutInSeconds?: int64;

  @doc("The number of consecutive failed health check that Traffic Manager tolerates before declaring an endpoint in this profile Degraded after the next failed health check.")
  toleratedNumberOfFailures?: int64;

  @doc("List of custom headers.")
  @identifiers(#[""])
  customHeaders?: CustomHeader[];

  @doc("List of expected status code ranges.")
  @identifiers(#[])
  expectedStatusCodeRanges?: ExpectedStatusCodeRange[];
}

@doc("Custom header name and value.")
model CustomHeader {
  @doc("Header name.")
  name?: string;

  @doc("Header value.")
  value?: string;
}

@doc("Min and max value of a status code range.")
model ExpectedStatusCodeRange {
  @doc("Min status code.")
  min?: int32;

  @doc("Max status code.")
  max?: int32;
}

@doc("Class representing the health policy for Traffic Manager profile properties.")
@discriminator("kind")
model HealthPolicyProperties {
  ...ResourceKindProperty<HealthPolicyKind>;

  @visibility(Lifecycle.Read)
  @doc("Provisioning state of the resource.")
  provisioningState?: provisioningStateProperties;
}

@doc("Class representing a Traffic Manager health policy of kind Probe.")
model ProbeHealthPolicyProperties extends HealthPolicyProperties {
  @doc("The name of the health policy.")
  name: string;

  @doc("Probe monitoring settings of the Traffic Manager profile.")
  probeConfig?: ProbeConfig;

  @doc("The kind of the Private Traffic Manager health policy.")
  kind: HealthPolicyKind.Probe;
}
