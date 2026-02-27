import "./versions.tsp";
import "./addressrecord.tsp";
import "./apslbvip.tsp";
import "./canonicalnamerecord.tsp";
import "./ptrrecord.tsp";
import "./servicerecord.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Azure CIS FRP" })
@doc("Dns Service")
@versioned(Microsoft.AzureCis.Versions)
namespace Microsoft.AzureCis;

interface Operations extends Azure.ResourceManager.Operations {}
