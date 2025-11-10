import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./build.tsp";
import "./file.tsp";
import "./package.tsp";
import "./product.tsp";
import "./sbom.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.EngineeringSystem Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.EngineeringSystem management service." })
@versioned(Microsoft.EngineeringSystem.Versions)
namespace Microsoft.EngineeringSystem;

/** The resource provisioning state. */
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  /** The resource is updating */
  Updating: "Updating",

  /** The resource is being deleted */
  Deleting: "Deleting",

  /** The resource create request has been accepted */
  Accepted: "Accepted",

  string,
}

/** The available API versions. */
enum Versions {
  /** 2025-01-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_01_01_preview: "2025-01-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
