// Necessary libraries to build an Azure Service
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./put_response_template.tsp";
import "./job_template.tsp";
import "./job.tsp";
import "./test_result.tsp";

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
@armProviderNamespace
@service({
  title: "Azure Image Testing For Linux Service",
  version: "2023-08-01-preview",
})
@doc("This is the Azure Image Testing For Linux Service")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AzureImageTestingForLinux;

// Common elements:
@doc("General resource properties.")
model ResourceProperties {
  @doc("Resource provisioning state.")
  @visibility("read")
  @lroStatus
  provisioningState?: ProvisioningState;
}

// Extend the provisioning state
@lroStatus
@doc("The extended resource provisioning states.")
enum ProvisioningState {
  ...ResourceProvisioningState, // Succeeded, Failed, and Canceled

  @doc("The resource is queued for provisioning.")
  Queued,

  @doc("The resource is being provisioned.")
  Provisioning,

  @doc("The resource is running.")
  Running,

  @doc("The resource is being canceled.")
  Cancelling,
}

interface Operations extends Azure.ResourceManager.Operations {}
