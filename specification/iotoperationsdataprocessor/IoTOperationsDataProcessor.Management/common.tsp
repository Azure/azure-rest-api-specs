import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.IoTOperationsDataProcessor;

@doc("Extended location is an extension of Azure locations. They provide a way to use their Azure ARC enabled Kubernetes clusters as target locations for deploying Azure services instances.")
model ExtendedLocation {
  @doc("The name of the extended location.")
  name: string;

  @doc("The type of the extended location.")
  type: string;
}

@lroStatus
@doc("The provisioning status of the resource.")
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("The resource is being created.")
  Provisioning,

  @doc("The resource is being updated.")
  Updating,

  @doc("The resource is being deleted.")
  Deleting,

  @doc("The resource was accepted by the server.")
  Accepted,
}

@doc("The Microsoft.IoTOperationsDataProcessor versions.")
enum Versions {
  @doc("Microsoft IoT Operations Data Processor version 2023-10-04-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  Preview20230928: "2023-10-04-preview",

  @doc("Microsoft IoT Operations Data Processor version 2024-02-01-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  Preview20240201: "2024-02-01-preview",
}
