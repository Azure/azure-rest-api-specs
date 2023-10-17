import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../shared/resourceid.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Workload Service Template Resource properties")
model WorkloadServiceTemplateProperties {
  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @doc("Virtual Enclave Resource Id.")
  enclaveResourceId?: VirtualEnclaveResourceId;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @doc("Workload Service Template Name")
  serviceName: string;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @doc("Workload Service Template Version")
  version: string;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @doc("Workload Service Template URL")
  url: string;

  @doc("Provisioning State.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}
