import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common-types.tsp";
import "./workbenches.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core.Traits;
using TypeSpec.OpenAPI;

@armProviderNamespace("Microsoft.ModSimWorkbench")
@service({
  title: "ModSimWorkbench Control Plane API",
})
@armProviderNamespace
@versioned(Microsoft.ModSimWorkbench.Versions)
namespace Microsoft.ModSimWorkbench;

@doc("Property to enable or disable")
model EnableProperty {
  @doc("Enabled if true")
  enable: boolean;
}

@doc("Property for assigning FlexNet Licensing Service identifier.")
model LmHostIdProperty {
  @doc("FFLEXlm host identifier of chamber license servers used by FlexNet Licensing Service. (NIC mac address based)")
  lmhostId?: Array<string>;
}

@doc("Property for assigning licensing server.")
model ServerProperty {
  @doc("License Service server. e.g., 5280@primaryHostname for single VM, 5280@primaryHostname:5280@secondaryHostname for redundant VMs.")
  server?: string;
}

@doc("Ansys Common Licensing.")
model Ansys {
  ...ServerProperty;
  ...EnableProperty;
  ...LmHostIdProperty;
}

@doc("Cadence License Manager.")
model Cadence {
  ...ServerProperty;
  ...EnableProperty;
  ...LmHostIdProperty;

  @doc("License server information for Cadence License Manager.")
  mfp?: Array<string>;
}

@doc("Siemens Standard Licensing.")
model Siemens {
  ...ServerProperty;
  ...EnableProperty;
  ...LmHostIdProperty;
}

@doc("Synopsys Common Licensing.")
model Synopsys {
  ...ServerProperty;
  ...EnableProperty;

  @doc("Virtual machine universal unique identifier of chamber license servers used by FlexNet Licensing Service. (SMBIOS UUID based)")
  vmUuid?: Array<string>;
}

@doc("License service settings.")
model LicenseServices {
  @visibility("read")
  @doc("Cadence settings")
  cadence?: Cadence;

  @visibility("read")
  @doc("Ansys settings")
  ansys?: Ansys;

  @visibility("read")
  @doc("Synopsys settings")
  synopsys?: Synopsys;

  @visibility("read")
  @doc("Siemens settings")
  siemens?: Siemens;
}

@doc("License service provider")
union LicenseServiceProvider {
  string,

  @doc("Ansys license service provider")
  ansys: "ansys",

  @doc("Cadence license service provider")
  cadence: "cadence",

  @doc("Siemens license service provider")
  siemens: "siemens",

  @doc("Synopsys license service provider")
  synopsys: "synopsys",
}

@doc("Parameters for restarting license service")
model LicenseServiceRestartParameters {
  @doc("License service provider to restart")
  licenseService: LicenseServiceProvider;
}

@doc("Parameters for updating license service")
model LicenseServiceUpdateParameters {
  ...EnableProperty;

  @doc("License service provider to restart")
  licenseService: LicenseServiceProvider;

  @doc("License key text")
  licenseKey: string;
}

@doc("Chamber properties.")
model ChamberProperties {
  ...ProvisioningStateProperty;
  ...PowerStateProperty;
  ...RestartAtProperty;

  @visibility("read")
  @doc("License service settings.")
  licenseServices?: LicenseServices;

  @visibility("read")
  @doc("Directory for the chamber data pipeline inbound. E.g. /mount/datapipeline/datain")
  dataPipelineInboundPath?: string;

  @visibility("read")
  @doc("Directory for the chamber data pipeline inbound. E.g. /mount/datapipeline/dataout")
  dataPipelineOutboundPath?: string;

  @visibility("read", "create")
  @doc("SKU name.")
  sku?: string = "Standard"; // TODO: Change to enum with default
}

@doc("Chamber tracked resource.")
@parentResource(Workbench)
model Chamber is TrackedResource<ChamberProperties> {
  @doc("The name of the Chamber")
  @segment("chambers")
  @key("chamberName")
  @TypeSpec.Http.path
  @pattern("^(?!-)(?!.*--)[a-zA-Z][A-Za-z0-9-]{0,63}(?<!-)$")
  name: string;
}

@doc("Parameters for getUploadUri")
model FileUploadParameters {
  @doc("Size of the file being uploaded.")
  fileSize: int64;
}

@doc("Response for getUploadUri")
model GetUploadUri {
  @doc("Datasync file upload SAS token")
  result: string;
}

@armResourceOperations
interface Chambers
  extends NestedResourceOperations<Chamber, ChamberProperties>,
    Restartable<Chamber> {
  @doc("Restart license service ")
  licenseRestart is ArmResourceActionAsync<
    Chamber,
    LicenseServiceRestartParameters,
    never
  >;

  @doc("Update license service")
  licenseUpdate is ArmResourceActionAsync<
    Chamber,
    LicenseServiceUpdateParameters,
    never
  >;

  @doc("Get URI for uploading file to chamber")
  getUploadUri is ArmResourceActionAsync<
    Chamber,
    FileUploadParameters,
    GetUploadUri
  >;
}
