import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./link.tsp";
import "./nic.tsp";
import "./node.tsp";
import "./port.tsp";
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
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_07_01_preview: "2025-07-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
