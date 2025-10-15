import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./link.tsp";
import "./nic.tsp";
import "./node.tsp";
import "./device-logical-port.tsp";
import "./maintenance-request.tsp";
import "./rack.tsp";
import "./supercomputer.tsp";
import "./switch.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

/** Supercomputer Infrastructure Management Plane API */
@armProviderNamespace
@service(#{ title: "Microsoft.SupercomputerInfrastructure" })
@versioned(Microsoft.SupercomputerInfrastructure.Versions)
namespace Microsoft.SupercomputerInfrastructure;

/** The available API versions. */
enum Versions {
  /** The 2025-07-01-preview API version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_07_01_preview: "2025-07-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
