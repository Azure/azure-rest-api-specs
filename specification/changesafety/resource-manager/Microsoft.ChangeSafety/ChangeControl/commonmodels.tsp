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

  @doc("The resource is being updated.")
  Updating: "Updating",

  @doc("The resource is being deleted.")
  Deleting: "Deleting",

  @doc("The resource operation request has been accepted.")
  Accepted: "Accepted",

  @doc("The resource operation succeeded.")
  Succeeded: "Succeeded",

  @doc("The resource operation failed.")
  Failed: "Failed",

  @doc("The resource operation was canceled.")
  Canceled: "Canceled",
}

@doc("Data type of the parameter. Values use the existing template parameter tokens string, number, array, and object.")
union ParameterType {
  string,

  @doc("String data type. The wire token is string.")
  String: "string",

  @doc("32-bit integer data type. The wire token remains number for compatibility with existing template parameter tokens, and the value is int32.")
  Number: "number",

  @doc("Array data type. The wire token is array.")
  Array: "array",

  @doc("Object data type. The wire token is object.")
  Object: "object",
}

@doc("Base class for the Parameters.")
@discriminator("type")
model Parameter {
  @doc("Data type of the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  type: ParameterType;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Metadata keys are customer-defined; ChangeSafety cannot enumerate them. Each metadata value is a string."
  @doc("Customer-specified metadata for the parameter.")
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
  @TypeSpec.OpenAPI.extension("x-ms-identifiers", #[])
  defaultValue?: unknown[];

  @doc("Allowed list of the values for the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @TypeSpec.OpenAPI.extension("x-ms-identifiers", #[])
  allowedValues?: unknown[];
}

@doc("Object type parameter model")
model ObjectParameter extends Parameter {
  @doc("Data type of the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  type: ParameterType.Object;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Object parameter defaults have customer-defined JSON keys and nested values. A dictionary preserves these values in generated SDK serializers."
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
  @TypeSpec.OpenAPI.extension("x-ms-identifiers", #[])
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
  @doc("Azure Resource Manager resource ID of the nested StageMap.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  resourceId?: StageMapResourceId;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Parameter names come from the referenced StageMap, not fixed properties of this API. Their supplied values may be JSON scalars, arrays, or objects."
  @doc("Key value pairs of parameter names & their values for the stageMap referenced by the resourceId field.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  parameters?: Record<unknown>;
}

@doc("Link model for related resources and references.")
model Link {
  @doc("Human-readable label for the link.")
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
