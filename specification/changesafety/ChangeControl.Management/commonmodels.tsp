import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

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
  defaultValue?: string;

  @doc("Allowed list of the values for the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  allowedValues: Array<string>;
}

@doc("Integer type parameter model")
model NumberParameter extends Parameter {
  @doc("Data type of the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  type: ParameterType.Number;

  @doc("Default value for the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  defaultValue?: int32;

  @doc("Allowed list of the values for the parameter.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  allowedValues: Array<int32>;
}
