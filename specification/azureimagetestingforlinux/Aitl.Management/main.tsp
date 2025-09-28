// Necessary libraries to build an Azure Service
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./job_template.tsp";
import "./job.tsp";
import "./test_result.tsp";
import "./put_response_template.tsp";

// Include models, operations, and decorators
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Autorest;
using Azure.Core;
using Azure.Core.Foundations;
using OpenAPI;

/*
Requirements for defining an ARM Service:
- Define the service namespace & decorate with
  - serviceTitle
  - serviceVersion
  - armProviderNamespace
  */
@armProviderNamespace("Microsoft.AzureImageTestingForLinux")
@service(#{ title: "Azure Image Testing For Linux Service" })
@doc("This is the Azure Image Testing For Linux Service")
@versioned(Versions)
namespace Microsoft.AzureImageTestingForLinux;
// Common elements:
@doc("General resource properties.")
model ResourceProperties {
  @doc("Resource provisioning state.")
  @visibility(Lifecycle.Read)
  @lroStatus
  provisioningState?: ProvisioningState;
}

// Extend the provisioning state
@lroStatus
@doc("The extended resource provisioning states.")
union ProvisioningState {
  ResourceProvisioningState, // Succeeded, Failed, and Canceled

  @doc("The resource is queued for provisioning.")
  Queued: "Queued",

  @doc("The resource is being provisioned.")
  Provisioning: "Provisioning",

  @doc("The resource is running.")
  Running: "Running",

  @doc("The resource is being canceled.")
  Cancelling: "Cancelling",

  string,
}

/** The available API versions. */
@doc("The available API versions for Microsoft.AzureImageTestingForLinux")
enum Versions {
  @doc("The 2023-08-01-preview API version.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
  v2023_08_01_preview: "2023-08-01-preview",

  @doc("The 2025-04-01-preview API version.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_04_01_preview: "2025-04-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
