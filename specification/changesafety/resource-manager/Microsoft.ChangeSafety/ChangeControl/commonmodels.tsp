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

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Metadata keys are customer-defined; ChangeSafety cannot enumerate them. Each metadata value is a string."
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

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Object parameter keys are customer-defined and values may be nested JSON. A dictionary preserves these values in generated SDK serializers."
  @doc("Default value for the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  defaultValue?: Record<unknown>;

  @doc("Allowed list of the values for the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @Azure.ResourceManager.identifiers(#[])
  allowedValues?: Record<unknown>[];
}

@doc("Partial parameter definition for PATCH requests. Omitted fields are not supplied by the request.")
model ParameterPatch {
  ...OptionalProperties<Parameter>;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "PATCH may omit the type discriminator while updating a customer-provided string, number, array, or object default value. A fixed-kind schema would exclude supported parameter kinds."
  @doc("Default value for the parameter. The value must match the supplied or existing parameter type.")
  defaultValue?: unknown;

  @doc("Allowed values for the parameter. Values must match the supplied or existing parameter type.")
  allowedValues?: unknown[];
}

@doc("Resource properties for PATCH requests with partial parameter definitions.")
model ParameterPatchProperties<Properties extends TypeSpec.Reflection.Model> {
  ...OmitProperties<Properties, "parameters">;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Parameter names are customer-defined; ChangeSafety cannot enumerate the keys. Values use the partial ParameterPatch schema."
  @doc("Parameter definitions supplied by the PATCH request.")
  @visibility(Lifecycle.Update)
  parameters?: Record<ParameterPatch>;
}

@doc("Nested stage map reference.")
model NestedStageMap {
  @doc("ARM resource ID for the nested stagemap resource.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  resourceId?: StageMapResourceId;

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

  @doc("A single URL for this link. Use separate Link entries for multiple URLs.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  uri: url;

  @doc("Description or note about the link.")
  @maxLength(2000)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  description?: string;
}
