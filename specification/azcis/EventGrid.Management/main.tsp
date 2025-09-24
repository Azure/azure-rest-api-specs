import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

import "./eventgridtopictypeeventtypes.tsp";
import "./eventgridtopictypepublisherauthentications.tsp";
import "./eventgridtopictypesupportedlocations.tsp";
import "./versions.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@service(#{ title: "Azure CIS FRP" })
@doc("EventGrid Provider")
@versioned(Microsoft.AzureCis.Versions)
namespace Microsoft.AzureCis;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the resource.")
union EventGridProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}
