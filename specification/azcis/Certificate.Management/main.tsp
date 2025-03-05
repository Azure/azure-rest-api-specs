import "../versions.tsp";
import "./dsmsCertificate.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Azure CIS FRP" })
@doc("dscm Certificate Service")
@versioned(Microsoft.AzureCis.Versions)
namespace Microsoft.AzureCis;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the resource.")
union CertificateProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}
