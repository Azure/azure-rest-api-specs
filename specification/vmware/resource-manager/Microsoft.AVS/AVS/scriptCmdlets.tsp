namespace Microsoft.AVS;

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;

@armResourceOperations
interface ScriptCmdlets {
  list is ArmResourceListByParent<
    ScriptCmdlet,
    Response = ArmResponse<ResourceList<ScriptCmdlet, "{name}sList">>
  >;

  get is ArmResourceRead<ScriptCmdlet>;
}

@doc("Script Parameter types")
union ScriptParameterTypes {
  string,

  @doc("is string")
  String: "String",

  @doc("is secure string")
  SecureString: "SecureString",

  @doc("is credential")
  Credential: "Credential",

  @doc("is int")
  Int: "Int",

  @doc("is bool")
  Bool: "Bool",

  @doc("is float")
  Float: "Float",
}

@doc("Visibility Parameter")
union VisibilityParameterEnum {
  string,

  @doc("is visible")
  Visible: "Visible",

  @doc("is hidden")
  Hidden: "Hidden",
}

@doc("Optional Param")
union OptionalParamEnum {
  string,

  @doc("is optional")
  Optional: "Optional",

  @doc("is required")
  Required: "Required",
}

@doc("A cmdlet available for script execution")
@parentResource(ScriptPackage)
model ScriptCmdlet is ProxyResource<ScriptCmdletProperties> {
  @doc("Name of the script cmdlet.")
  @pattern("^[-\\w\\._]+$")
  @key("scriptCmdletName")
  @path
  @segment("scriptCmdlets")
  name: string;
}

@doc("A script cmdlet provisioning state")
union ScriptCmdletProvisioningState {
  string,
  ResourceProvisioningState,
}

@doc("Properties of a pre-canned script")
model ScriptCmdletProperties {
  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ScriptCmdletProvisioningState;

  @doc("Description of the scripts functionality")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("Recommended time limit for execution")
  @visibility(Lifecycle.Read)
  timeout?: string;

  @doc("Specifies whether a script cmdlet is intended to be invoked only through automation or visible to customers")
  @visibility(Lifecycle.Read)
  audience?: ScriptCmdletAudience;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers"
  @doc("Parameters the script will accept")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  parameters?: ScriptParameter[];
}

@doc("Specifies whether a script cmdlet is intended to be invoked only through automation or visible to customers")
union ScriptCmdletAudience {
  string,

  @doc("is automation")
  Automation: "Automation",

  @doc("is any")
  Any: "Any",
}

@doc("An parameter that the script will accept")
model ScriptParameter {
  @doc("""
    The type of parameter the script is expecting. psCredential is a
    PSCredentialObject
    """)
  @visibility(Lifecycle.Read)
  type?: ScriptParameterTypes;

  @doc("The parameter name that the script will expect a parameter value for")
  name?: string;

  @doc("User friendly description of the parameter")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("""
    Should this parameter be visible to arm and passed in the parameters argument
    when executing
    """)
  @visibility(Lifecycle.Read)
  visibility?: VisibilityParameterEnum;

  @doc("Is this parameter required or optional")
  @visibility(Lifecycle.Read)
  optional?: OptionalParamEnum;
}
