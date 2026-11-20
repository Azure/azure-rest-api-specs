import "./connectionBase.tsp";
import "./kafkaConnectionDetails.tsp";
import "./microsoftFabricConnectionDetails.tsp";
import "./oracleConnectionDetails.tsp";
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Oracle.Database;

/**
 * Alias for resource.properties: OAS v2 polymorphism is done via discriminator + allOf (not oneOf),
 * so we use base model here.
 */
alias ConnectionProperties = ConnectionBaseProperties;

@added(Versions.v20260301_preview)
@doc("GoldenGate Connection resource model.")
model GoldenGateConnection is TrackedResource<ConnectionProperties> {
  ...ResourceNameParameter<GoldenGateConnection>;
  ...AvailabilityZonesProperty;
}
