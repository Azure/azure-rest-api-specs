using OpenAPI;
using TypeSpec.Versioning;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;

namespace Oracle.Database;

scalar SubnetId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets",
    }
  ]>;

scalar VnetId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks",
    }
  ]>;

@doc("Azure Resource Provisioning State enum")
union AzureResourceProvisioningState {
  ResourceProvisioningState,

  @doc("Indicates that resource in Provisioning state")
  Provisioning: "Provisioning",

  string,
}

@doc("WorkloadType enum")
union WorkloadType {
  @doc("OLTP - indicates an Autonomous Transaction Processing database")
  OLTP: "OLTP",

  @doc("DW - indicates an Autonomous Data Warehouse database")
  DW: "DW",

  @doc("AJD - indicates an Autonomous JSON Database")
  AJD: "AJD",

  @doc("APEX - indicates an Autonomous Database with the Oracle APEX Application Development workload type.")
  APEX: "APEX",

  string,
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
union LicenseModel {
  @doc("License included")
  LicenseIncluded: "LicenseIncluded",

  @doc("Bring Your Own License")
  BringYourOwnLicense: "BringYourOwnLicense",

  string,
}

@doc("validation result")
model ValidationResult {
  @doc("validation status")
  status: ValidationStatus;

  @doc("validation error")
  error: ValidationError;
}

@doc("validation status")
union ValidationStatus {
  @doc("Validation succeeded")
  Succeeded: "Succeeded",

  @doc("Validation failed")
  Failed: "Failed",

  string,
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
@doc("Password string.")
scalar Password extends string;

@doc("MonthName enum")
union MonthName {
  @doc("January value")
  January: "January",

  @doc("February value")
  February: "February",

  @doc("March value")
  March: "March",

  @doc("April value")
  April: "April",

  @doc("May value")
  May: "May",

  @doc("June value")
  June: "June",

  @doc("July value")
  July: "July",

  @doc("August value")
  August: "August",

  @doc("September value")
  September: "September",

  @doc("October value")
  October: "October",

  @doc("November value")
  November: "November",

  @doc("December value")
  December: "December",

  string,
}

@doc("DayOfWeekName enum")
union DayOfWeekName {
  @doc("Monday value")
  Monday: "Monday",

  @doc("Tuesday value")
  Tuesday: "Tuesday",

  @doc("Wednesday value")
  Wednesday: "Wednesday",

  @doc("Thursday value")
  Thursday: "Thursday",

  @doc("Friday value")
  Friday: "Friday",

  @doc("Saturday value")
  Saturday: "Saturday",

  @doc("Sunday value")
  Sunday: "Sunday",

  string,
}

@doc("Month resource properties")
model Month {
  @doc("Name of the month of the year.")
  name: MonthName;
}

@doc("Header to distinguish between resource creation or update")
model MsRpaasNewResourceHeader {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "x-default-description is not standard"
  @header("x-ms-rpaas-new-resource")
  @doc("Boolean parameter to distinguish between resource creation or update")
  @extension("x-default-description", true)
  msRpaasNewResource?: boolean;
}

// only properties are passed for Create Validation extension
model CreateValidationDetails<T extends TypeSpec.Reflection.Model> {
  ...MsRpaasNewResourceHeader;
  properties: T;
}

// only properties are passed for Patch Validation extension
model PatchValidationDetails<T extends TypeSpec.Reflection.Model> {
  properties: T;
}
