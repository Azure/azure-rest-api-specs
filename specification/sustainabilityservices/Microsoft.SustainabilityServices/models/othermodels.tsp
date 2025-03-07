import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-autorest";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

namespace Microsoft.SustainabilityServices;

@doc("Response headers.")
model ResponseHeaders {
  @doc("Correlation id.")
  @header("correlation-id")
  correlationId: uuid;

  @doc("List of api supported versions.")
  @header("api-supported-versions")
  apiSupportedVersions?: Versions[];

  ...RequestIdResponseHeader;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type"
@doc("Lookup details.")
model LookupField {
  @doc("Unique ID of the referenced field value.")
  id: uuid;

  @doc("Schema name of the referenced table.")
  logicalName: string;

  @doc("Display name of the referenced field value.")
  name: string;

  @doc("Key attributes of the referenced field.")
  keyAttributes: Record<unknown>;

  @doc("Row version.")
  rowVersion: string;
}

@doc("Assessment report version to be used in the calculation.")
union ArVersions {
  @doc("Custom.")
  Custom: "Custom",

  @doc("AR4 version.")
  AR4: "AR4",

  @doc("AR5 version.")
  AR5: "AR5",

  @doc("AR6 version.")
  AR6: "AR6",

  string,
}

@doc("Calculation status.")
union CalculationStatusEnum {
  @doc("Succeeded.")
  Succeeded: "Succeeded",

  @doc("Failed.")
  Failed: "Failed",

  @doc("Calculation completed with errors.")
  CompletedWithErrors: "CompletedWithErrors",

  string,
}
