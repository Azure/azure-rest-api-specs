import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./MessagingCatalog.tsp";
import "./PrivateEndpointConnection.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@service(#{ title: "Microsoft.MessagingCatalog" })
@doc("Messaging Catalog management API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.MessagingCatalog;
