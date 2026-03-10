import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Discovery.Management.Shared/namespace.tsp";
import "../Discovery.Bookshelf.Management/all.tsp";
import "./agent.tsp";
import "./dataAsset.tsp";
import "./dataContainer.tsp";
import "./model.tsp";
import "./tool.tsp";
import "./workflow.tsp";
import "../Discovery.Workspace.Management/all.tsp";
import "../Discovery.Supercomputer.Management/all.tsp";
import "./storageAsset.tsp";
import "./storageContainer.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.Discovery Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.Discovery management service" })
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

interface Operations extends Azure.ResourceManager.Operations {}
