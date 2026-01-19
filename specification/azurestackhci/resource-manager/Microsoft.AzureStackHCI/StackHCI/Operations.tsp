import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/casing-style" "HCI itself is a short form."
namespace Microsoft.AzureStackHCI;

<<<<<<< HEAD
@added(Versions.v2025_11_01_preview)
=======
>>>>>>> upstream/main
interface Operations extends Azure.ResourceManager.Operations {}
