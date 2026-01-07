import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.HealthcareInterop;

@doc("The resource requirements for the application (CPU, Memory, and Storage).")
model Requirements {
  @doc("The required CPU for the edge connector. The string is Kubernetes Quantity Format (e.g. 100m).")
  cpu?: string;

  @doc("The required Memory for the edge connector. The string is Kubernetes Quantity Format (e.g. 512Mi).")
  memory?: string;

  @doc("The required Storage for the edge connector. The string is Kubernetes Quantity Format (e.g. 10Gi).")
  storage?: string;
}
