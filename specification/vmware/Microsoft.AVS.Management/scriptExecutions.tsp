namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface ScriptExecutions {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("ScriptExecutions_List")
  list is ArmResourceListByParent<
    ScriptExecution,
    Response = ArmResponse<ResourceList<ScriptExecution, "{name}sList">>
  >;

  get is ArmResourceRead<ScriptExecution>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ScriptExecution,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<ScriptExecution>;

  @doc("Return the logs for a script execution resource")
  @autoRoute
  @armResourceAction(ScriptExecution)
  @post
  getExecutionLogs(
    ...ResourceInstanceParameters<ScriptExecution>,

    #suppress "@azure-tools/typespec-azure-core/request-body-problem"
    @bodyRoot
    @doc("Name of the desired output stream to return. If not provided, will return all. An empty array will return nothing.")
    scriptOutputStreamType?: ScriptOutputStreamType[],
  ): ArmResponse<ScriptExecution> | ErrorResponse;
}

@@clientName(ScriptExecutions.createOrUpdate::parameters.resource,
  "scriptExecution"
);

@doc("Script Execution provisioning state")
union ScriptExecutionProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("is pending")
  Pending: "Pending",

  @doc("is running")
  Running: "Running",

  @doc("is cancelling")
  Cancelling: "Cancelling",

  @doc("is cancelled")
  Cancelled: "Cancelled",

  @doc("is deleting")
  Deleting: "Deleting",
}

@doc("Script Output Stream type")
union ScriptOutputStreamType {
  string,

  @doc("is information")
  Information: "Information",

  @doc("is warning")
  Warning: "Warning",

  @doc("is output")
  Output: "Output",

  @doc("is error")
  Error: "Error",
}

@doc("An instance of a script executed by a user - custom or AVS")
@parentResource(PrivateCloud)
model ScriptExecution is ProxyResource<ScriptExecutionProperties> {
  @doc("Name of the script cmdlet.")
  @pattern("^[-\\w\\._]+$")
  @key("scriptExecutionName")
  @path
  @segment("scriptExecutions")
  name: string;
}

@doc("Properties of a user-invoked script")
model ScriptExecutionProperties {
  @doc("A reference to the script cmdlet resource if user is running a AVS script")
  scriptCmdletId?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers"
  @doc("Parameters the script will accept")
  parameters?: ScriptExecutionParameter[];

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers"
  @doc("""
    Parameters that will be hidden/not visible to ARM, such as passwords and
    credentials
    """)
  hiddenParameters?: ScriptExecutionParameter[];

  @doc("""
    Error message if the script was able to run, but if the script itself had
    errors or powershell threw an exception
    """)
  failureReason?: string;

  @doc("Time limit for execution")
  timeout: string;

  @doc("Time to live for the resource. If not provided, will be available for 60 days")
  retention?: string;

  @doc("Time the script execution was submitted")
  @visibility("read")
  submittedAt?: utcDateTime;

  @doc("Time the script execution was started")
  @visibility("read")
  startedAt?: utcDateTime;

  @doc("Time the script execution was finished")
  @visibility("read")
  finishedAt?: utcDateTime;

  @doc("The state of the script execution resource")
  @visibility("read")
  provisioningState?: ScriptExecutionProvisioningState;

  @doc("Standard output stream from the powershell execution")
  output?: string[];

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "It is unknown."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "It is unknown."
  @doc("User-defined dictionary.")
  namedOutputs?: Record<{}>;

  @doc("Standard information out stream from the powershell execution")
  @visibility("read")
  information?: string[];

  @doc("Standard warning out stream from the powershell execution")
  @visibility("read")
  warnings?: string[];

  @doc("Standard error output stream from the powershell execution")
  @visibility("read")
  errors?: string[];
}

@doc("script execution parameter type")
union ScriptExecutionParameterType {
  Value: "Value",
  SecureValue: "SecureValue",
  Credential: "Credential",
  string,
}

@doc("The arguments passed in to the execution")
@discriminator("type")
model ScriptExecutionParameter {
  @doc("script execution parameter type")
  type: ScriptExecutionParameterType;

  @doc("The parameter name")
  name: string;
}

@doc("a plain text value execution parameter")
model ScriptSecureStringExecutionParameter extends ScriptExecutionParameter {
  @doc("A secure value for the passed parameter, not to be stored in logs")
  @secret
  secureValue?: string;

  @doc("The type of execution parameter")
  type: ScriptExecutionParameterType.SecureValue;
}

@doc("a plain text value execution parameter")
model ScriptStringExecutionParameter extends ScriptExecutionParameter {
  @doc("The value for the passed parameter")
  value?: string;

  @doc("The type of execution parameter")
  type: ScriptExecutionParameterType.Value;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
@doc("a powershell credential object")
model PSCredentialExecutionParameter extends ScriptExecutionParameter {
  @doc("username for login")
  username?: string;

  @doc("password for login")
  @secret
  password?: string;

  @doc("The type of execution parameter")
  type: "Credential";
}
