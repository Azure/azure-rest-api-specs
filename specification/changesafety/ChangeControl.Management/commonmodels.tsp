import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;

namespace Microsoft.ChangeSafety;

@doc("Provisioning state of resource.")
@Azure.Core.lroStatus
union ProvisioningState {
  string,

  @doc("The resource is being provisioned.")
  Provisioning: "Provisioning",

  @doc("The resource is being updated")
  Updating: "Updating",

  @doc("The resource is being deleted.")
  Deleting: "Deleting",

  @doc(" The resource create request has been accepted.")
  Accepted: "Accepted",

  @doc("Resource has been created.")
  Succeeded: "Succeeded",

  @doc("Resource creation failed.")
  Failed: "Failed",

  @doc("Resource creation was canceled.")
  Canceled: "Canceled",
}

@doc("Data type of the parameter.")
union ParameterType {
  string,

  @doc("String data type")
  String: "string",

  @doc("Integer data type")
  Number: "number",

  @doc("Array data type")
  @added(Versions.v2025_07_01_preview)
  Array: "array",

  @doc("Object data type")
  @added(Versions.v2025_07_01_preview)
  Object: "object",
}

@doc("Base class for the Parameters.")
@discriminator("type")
model Parameter {
  @doc("Data type of the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  type: ParameterType;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppressing the warning: We need list of parameters in key:value format."
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "Suppressing warning: Metadata does not have a fixed schema as there may be any number of properties. Hence implemented as a Record."
  @doc("user-specified parameter metadata")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  metadata?: Record<string>;
}

@doc("String Type Parameter model.")
model StringParameter extends Parameter {
  @doc("Data type of the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  type: ParameterType.String;

  @doc("Default value for the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @renamedFrom(Versions.v2025_07_01_preview, "defaultValue")
  @removed(Versions.v2025_07_01_preview)
  defaultValueOld?: string;

  @doc("Default value for the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @added(Versions.v2025_07_01_preview)
  defaultValue?: string;

  @doc("Allowed list of the values for the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @renamedFrom(Versions.v2025_07_01_preview, "allowedValues")
  @removed(Versions.v2025_07_01_preview)
  allowedValuesOld: Array<string>;

  @doc("Allowed list of the values for the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @added(Versions.v2025_07_01_preview)
  allowedValues?: Array<string>;
}

@doc("Integer type parameter model")
model NumberParameter extends Parameter {
  @doc("Data type of the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  type: ParameterType.Number;

  @doc("Default value for the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @renamedFrom(Versions.v2025_07_01_preview, "defaultValue")
  @removed(Versions.v2025_07_01_preview)
  defaultValueOld?: int32;

  @doc("Default value for the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @added(Versions.v2025_07_01_preview)
  defaultValue?: int32;

  @doc("Allowed list of the values for the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @renamedFrom(Versions.v2025_07_01_preview, "allowedValues")
  @removed(Versions.v2025_07_01_preview)
  allowedValuesOld: Array<int32>;

  @doc("Allowed list of the values for the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @added(Versions.v2025_07_01_preview)
  allowedValues?: Array<int32>;
}

@doc("Array type parameter model")
@added(Versions.v2025_07_01_preview)
model ArrayParameter extends Parameter {
  @doc("Data type of the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  type: ParameterType.Array;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppressing the warning: We need list of parameters in key:value format of Array types, which can be string, int, or object."
  @doc("Default value for the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @OpenAPI.extension("x-ms-identifiers", #[])
  defaultValue?: unknown[];

  @doc("Allowed list of the values for the parameter.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  allowedValues?: unknown[];
}

@doc("Object type parameter model")
@added(Versions.v2025_07_01_preview)
model ObjectParameter extends Parameter {
  @doc("Data type of the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  type: ParameterType.Object;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Suppressing no-empty-model: Empty object literal required to generate OpenAPI schema with additionalProperties:true for flexible object parameter values that accept arbitrary JSON structures."
  @doc("Default value for the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  defaultValue?: {};

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Suppressing no-empty-model: Empty object literal required to generate OpenAPI schema with additionalProperties:true for flexible object parameter constraint validation."
  @doc("Allowed list of the values for the parameter.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  allowedValues?: Array<{}>;
}

@doc("Nested stage map reference.")
@added(Versions.v2025_07_01_preview)
model NestedStageMap {
  @doc("ARM resource ID for the nested stagemap resource.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  resourceId?: string;
}

@doc("Link model for related resources and references.")
@added(Versions.v2025_07_01_preview)
model Link {
  @doc("URL or comma separated URLs for the link.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  uri: string;

  @doc("Description or note about the link.")
  @maxLength(2000)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  description?: string;

  @visibility(Lifecycle.Read)
  @doc("User who last modified this link.")
  lastModifiedBy?: string;

  @visibility(Lifecycle.Read)
  @doc("The date and time when this link was last modified (ISO 8601 format).")
  lastModifiedAt?: utcDateTime;
}

@doc("Collection of predefined link types for change-related references.")
@added(Versions.v2025_07_01_preview)
model ChangeLinks {
  @doc("Link to work tracking item.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  workTrackingItem?: Link;

  @doc("Link to approval request.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  approvalRequest?: Link;

  @doc("Link to support incident.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  supportIncident?: Link;

  @doc("Link to access elevation request.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  accessElevationRequest?: Link;

  @doc("Link to related change state.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  relatedChangeState?: Link;

  @doc("Link to test results.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  testResults?: Link;

  @doc("Link to service catalog.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  serviceCatalog?: Link;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Intentionally empty model for flexible stage variables storage."
@doc("Stage variables object type that allows flexible key-value pairs")
@added(Versions.v2025_07_01_preview)
model StageVariables {
  // Flexible object model for stage variables - allows any properties
}
