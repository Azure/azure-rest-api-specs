import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

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
  Array: "array",

  @doc("Object data type")
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
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  defaultValue?: string;

  @doc("Allowed list of the values for the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  allowedValues?: Array<string>;
}

@doc("Integer type parameter model")
model NumberParameter extends Parameter {
  @doc("Data type of the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  type: ParameterType.Number;

  @doc("Default value for the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  defaultValue?: int32;

  @doc("Allowed list of the values for the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  allowedValues?: Array<int32>;
}

@doc("Array type parameter model")
model ArrayParameter extends Parameter {
  @doc("Data type of the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  type: ParameterType.Array;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppressing the warning: We need list of parameters in key:value format of Array types, which can be string, int, or object."
  @doc("Default value for the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  defaultValue?: unknown[];

  @doc("Allowed list of the values for the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  allowedValues?: unknown[];
}

@doc("Object type parameter model")
model ObjectParameter extends Parameter {
  @doc("Data type of the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  type: ParameterType.Object;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Suppressing no-empty-model: Empty object literal required to generate OpenAPI schema with additionalProperties:true for flexible object parameter values that accept arbitrary JSON structures."
  @doc("Default value for the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  defaultValue?: {};

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Allowed values are arbitrary JSON objects without a stable identifier property."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Suppressing no-empty-model: Empty object literal required to generate OpenAPI schema with additionalProperties:true for flexible object parameter constraint validation."
  @doc("Allowed list of the values for the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  allowedValues?: Array<{}>;
}

@doc("Nested stage map reference.")
model NestedStageMap {
  @doc("ARM resource ID for the nested stagemap resource.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  resourceId?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Key value pairs of parameter names & their values for the stagemap.Value can be any type, hence using Unknown type."
  @doc("Key value pairs of parameter names & their values for the stageMap referenced by the resourceId field.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  parameters?: Record<unknown>;
}

@doc("Link model for related resources and references.")
model Link {
  @doc("name of the link.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  name: string;

  @doc("URL or comma separated URLs for the link.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  uri: string;

  @doc("Description or note about the link.")
  @maxLength(2000)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  description?: string;
}
