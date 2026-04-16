import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./cloud.tsp";
import "./cloudResource.tsp";
import "./computeConfig.tsp";
import "./containerImage.tsp";
import "./job.tsp";
import "./project.tsp";
import "./service.tsp";
import "./versions.tsp";
import "./workspace.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

/** Anyscale.Platform Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Anyscale.Platform management service" })
@versioned(Versions)
namespace Anyscale.Platform;

/** Operations interface */
interface Operations extends Azure.ResourceManager.Operations {}
