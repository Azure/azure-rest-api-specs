using OpenAPI;
using TypeSpec.Versioning;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Oracle.Database;

scalar SubnetId extends ResourceIdentifier<[
  {
    type: "Microsoft.Network/virtualNetworks/subnets"
  }
]>;

scalar VnetId extends ResourceIdentifier<[
  {
    type: "Microsoft.Network/virtualNetworks"
  }
]>;

@doc("Azure Resource Provisioning State enum")
enum AzureResourceProvisioningState {
  ...ResourceProvisioningState,
  @doc("Provisioning value")
  Provisioning
};

@doc("WorkloadType enum")
enum WorkloadType {
  @doc("OLTP - indicates an Autonomous Transaction Processing database")
  OLTP,
  @doc("DW - indicates an Autonomous Data Warehouse database")
  DW,
  @doc("AJD - indicates an Autonomous JSON Database")
  AJD,
  @doc("APEX - indicates an Autonomous Database with the Oracle APEX Application Development workload type.")
  APEX
}

@doc("DayOfWeek resource properties")
model DayOfWeek {
  @doc("Name of the day of the week.")
  name: DayOfWeekName;
}

@doc("The [OCID](/Content/General/Concepts/identifiers.htm) of the resource.")
@minLength(1)
@maxLength(255)
scalar Ocid extends string;

@doc("LicenseModel enum")
enum LicenseModel {
  @doc("LicenseIncluded value")
  LicenseIncluded,
  @doc("BringYourOwnLicense value")
  BringYourOwnLicense,
}

@doc("validation result")
model ValidationResult {
  @doc("validation status")
  status: ValidationStatus;
  @doc("validation error")
  error: ValidationError;
}

@doc("validation status")
enum ValidationStatus {
  @doc("Succeeded value")
  Succeeded,
  @doc("Failed value")
  Failed
}

@doc("validation error")
model ValidationError {
  @doc("error code")
  code: string;
  @doc("error message")
  message: string;
}

@doc("CustomerContact resource properties")
model CustomerContact {
  @doc("The email address used by Oracle to send notifications regarding databases and infrastructure.")
  @minLength(1)
  @maxLength(320)
  email: string;
}

@secret
scalar Password extends string;