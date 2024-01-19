import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
@doc("Function information.")
@parentResource(Site)
model FunctionEnvelope is ProxyResource<FunctionEnvelopeProperties> {
  @doc("Function name.")
  @path
  @key("functionName")
  @segment("functions")
  name: string;
}

@armResourceOperations
interface FunctionEnvelopes {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get function information by its ID for web site, or a deployment slot.")
  @operationId("WebApps_GetFunction")
  getFunction is ArmResourceRead<FunctionEnvelope>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Create function for web site, or a deployment slot.")
  @operationId("WebApps_CreateFunction")
  createFunction is ArmResourceCreateOrUpdateAsync<FunctionEnvelope>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Delete a function for web site, or a deployment slot.")
  @operationId("WebApps_DeleteFunction")
  deleteFunction is ArmResourceDeleteSync<FunctionEnvelope>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for List the functions for a web site, or a deployment slot.")
  @operationId("WebApps_ListFunctions")
  listFunctions is ArmResourceListByParent<FunctionEnvelope>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get function keys for a function in a web site, or a deployment slot.")
  @operationId("WebApps_ListFunctionKeys")
  listFunctionKeys is ArmResourceActionSync<
    FunctionEnvelope,
    void,
    StringDictionary
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get function secrets for a function in a web site, or a deployment slot.")
  @operationId("WebApps_ListFunctionSecrets")
  listFunctionSecrets is ArmResourceActionSync<
    FunctionEnvelope,
    void,
    FunctionSecrets
  >;
}

@@projectedName(FunctionEnvelopes.createFunction::parameters.resource,
  "json",
  "function_envelope"
);
@@extension(FunctionEnvelopes.createFunction::parameters.resource,
  "x-ms-client-name",
  "function_envelope"
);
@@doc(FunctionEnvelopes.createFunction::parameters.resource,
  "Function details."
);
