import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

@doc("Device type enum")
union DeviceType {
  @doc("The Server.")
  Server: "Server",

  @doc("The ChassisManager.")
  ChassisManager: "ChassisManager",

  @doc("The EpmsSensor.")
  EpmsSensor: "EpmsSensor",

  @doc("The RackManager.")
  RackManager: "RackManager",

  @doc("The EPMS.")
  EPMS: "EPMS",

  string,
}

@doc("Deployment type enum")
union DeploymentType {
  @doc("Pilotfish deployment.")
  Pilotfish: "Pilotfish",

  @doc("AzureAll deployment.")
  AzureAll: "AzureAll",

  @doc("Exchange deployment.")
  Exchange: "Exchange",

  @doc("Autopilot deployment.")
  Autopilot: "Autopilot",

  @doc("Sharepoint deployment.")
  Sharepoint: "Sharepoint",

  @doc("FOPE deployment.")
  FOPE: "FOPE",

  @doc("DatacenterServices deployment.")
  DatacenterServices: "DatacenterServices",

  @doc("MacCloud deployment.")
  MacCloud: "MacCloud",

  @doc("PreBuild deployment.")
  PreBuild: "PreBuild",

  @doc("AzureDNS deployment.")
  AzureDNS: "AzureDNS",

  @doc("CPS deployment.")
  CPS: "CPS",

  @doc("Tycoon deployment.")
  Tycoon: "Tycoon",

  @doc("AzureEngSys deployment.")
  AzureEngSys: "AzureEngSys",

  @doc("Fabric deployment.")
  Fabric: "Fabric",

  @doc("DCCE deployment.")
  DCCE: "DCCE",

  @doc("AzureKeyVault deployment.")
  AzureKeyVault: "AzureKeyVault",

  @doc("FirstPartyNetwork deployment.")
  FirstPartyNetwork: "FirstPartyNetwork",

  @doc("Unknown deployment.")
  Unknown: "Unknown",

  string,
}

@doc("Workload type enum")
union WorkloadType {
  @doc("Baremetal workload type.")
  Baremetal: "Baremetal",

  @doc("VM workload type.")
  VM: "VM",

  @doc("Unknown workload type.")
  Unknown: "Unknown",

  string,
}
