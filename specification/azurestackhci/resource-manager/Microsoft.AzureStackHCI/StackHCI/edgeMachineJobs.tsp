import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./edgeMachine.tsp";
import "./hciCommon.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
@doc("Cluster Jobs resource")
@parentResource(EdgeMachine)
model EdgeMachineJob
  is Azure.ResourceManager.ProxyResource<EdgeMachineJobProperties> {
  ...ResourceNameParameter<
    Resource = EdgeMachineJob,
    KeyName = "jobsName",
    SegmentName = "jobs",
    NamePattern = "^[a-zA-Z0-9-_]{3,63}$"
  >;
}

@armResourceOperations
interface EdgeMachineJobs {
  @doc("Get a EdgeMachineJob")
  get is ArmResourceRead<EdgeMachineJob>;

  @doc("Create a EdgeMachineJob")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EdgeMachineJob>;

  @doc("Delete a EdgeMachineJob")
  delete is ArmResourceDeleteWithoutOkAsync<EdgeMachineJob>;

  @doc("List EdgeMachineJob resources by EdgeMachines")
  listByCluster is ArmResourceListByParent<EdgeMachineJob>;
}

@@doc(EdgeMachineJob.name, "Name of EdgeMachineJob");

////////////////////models////////////////////

@doc("EdgeMachine Job properties")
@discriminator("jobType")
model EdgeMachineJobProperties {
  @doc("Job Type to support polymorphic resource.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  jobType: EdgeMachineJobType;

  @doc("Deployment mode to trigger job.")
  deploymentMode?: DeploymentMode;

  @doc("Job provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Unique, immutable job id.")
  @visibility(Lifecycle.Read)
  jobId?: string;

  @doc("The UTC date and time at which the job started.")
  @visibility(Lifecycle.Read)
  startTimeUtc?: utcDateTime;

  @doc("The UTC date and time at which the job completed.")
  @visibility(Lifecycle.Read)
  endTimeUtc?: utcDateTime;

  @doc("Status of Edge device job.")
  @visibility(Lifecycle.Read)
  status?: JobStatus;

  @doc("error details.")
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.Foundations.ErrorDetail;
}

@doc("Job Type supported.")
union EdgeMachineJobType {
  string,

  @doc("Job to collect logs from the device.")
  CollectLog: "CollectLog",

  @doc("Job to provision operating system in the device.")
  ProvisionOs: "ProvisionOs",
}

@doc("Represents the properties of an Azure Linux restricted operating environment Provision Os job.")
model ProvisionOsJobProperties extends EdgeMachineJobProperties {
  @doc("Job Type to support polymorphic resource.")
  jobType: EdgeMachineJobType.ProvisionOs;

  @doc("Os Provisioning request.")
  provisioningRequest: ProvisioningRequest;

  @doc("Reported Properties for Provision Os job")
  reportedProperties?: ProvisionOsReportedProperties;
}

@doc("Represents a provisioning request.")
model ProvisioningRequest {
  @doc("Target operating system to support polymorphic resource.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  target: ProvisioningOsType;

  @doc("Operating system profile.")
  osProfile: OsProvisionProfile;

  @doc("User configuration.")
  @Azure.ResourceManager.identifiers(#["userName"])
  userDetails?: UserDetails[];

  @doc("Onboarding configuration.")
  onboardingConfiguration?: OnboardingConfiguration;

  @doc("Device configuration.")
  deviceConfiguration?: DeviceConfiguration;

  @doc("Base64 encoded custom configuration for CAPI to use")
  customConfiguration?: string;
}

// @doc("Properties for pausing a server in the cluster.")
// model CollectLogJobProperties extends EdgeMachineJobProperties {
//   @doc("ClusterJob Type to support polymorphic resource.")
//   jobType: EdgeMachineJobType.CollectLog;

//   @doc("From date for log collection.")
//   fromDate: utcDateTime;

//   @doc("To date for log collection.")
//   toDate: utcDateTime;

//   @doc("To date for log collection.")
//   @visibility(Lifecycle.Read)
//   lastLogGenerated?: utcDateTime;

//   @doc("log collection job reported properties.")
//   @visibility(Lifecycle.Read)
//   reportedProperties?: LogCollectionReportedProperties;
// }

@doc("Operating system profile.")
model OsProvisionProfile {
  @doc("Name of the operating system.")
  osName?: string;

  @doc("Type of the operating system.")
  osType?: string;

  @doc("Version of the operating system.")
  osVersion?: string;

  @doc("Location of the operating system image.")
  osImageLocation?: string;
}

@doc("User configuration.")
model UserDetails {
  @doc("Name of the user.")
  userName: string;

  @doc("Type of the secret used for authentication. Change it to enum in public preview")
  secretType: string;

  @doc("Location of the secret used for authentication.")
  secretLocation?: string;

  @doc("Location of the secret used for authentication.")
  sshPubKey?: string[];
}

@doc("Onboarding resource type.")
union OnboardingResourceType {
  string,

  @doc("Hybrid Compute Machine.")
  HybridComputeMachine: "HybridComputeMachine",
}

@doc("Onboarding configuration.")
model OnboardingConfiguration {
  @doc("Type of the onboarding resource to support polymorphic resource.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  type?: OnboardingResourceType;

  @doc("Resource ID.")
  resourceId?: Azure.Core.armResourceIdentifier;

  @doc("Location of the resource.")
  location?: string;

  @doc("Tenant ID of the resource.")
  tenantId?: string;

  @doc("Azure Arc virtual machine ID.")
  arcVirtualMachineId?: string;
}
