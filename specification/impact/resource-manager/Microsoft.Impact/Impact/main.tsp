// First, import the common Microsoft.Voiceservice definition
import "./impact.tsp";
//

// Then import the resource API definitions
import "./workloadImpacts.tsp";
import "./ImpactCategories.tsp";
import "./commonModels.tsp";
import "./insights.tsp";
//import "./topologyImpacts.tsp";
import "./connectors.tsp";

// Common elements:
// Various tooling enforces (or at least suggests) that all models should have a provisioning State field, as this means something special to ARM.

@doc("Provisioning state of the resource.")
union ProvisioningState {
  string,

  /** Provisioning Succeeded */
  Succeeded: "Succeeded",

  /** Provisioning Failed */
  Failed: "Failed",

  /** Provisioning Canceled */
  Canceled: "Canceled",
}

@doc("General resource properties.")
model ResourceProperties {
  @doc("Resource provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
