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
/**
 * Function information.
 */
@parentResource(Site)
model FunctionEnvelope is ProxyResource<FunctionEnvelopeProperties> {
  /**
   * Function name.
   */
  @path
  @key("functionName")
  @segment("functions")
  name: string;
}

@armResourceOperations
interface FunctionEnvelopes {
  /**
   * Description for Get function information by its ID for web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetFunction")
  getFunction is ArmResourceRead<FunctionEnvelope>;

  /**
   * Description for Create function for web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_CreateFunction")
  createFunction is ArmResourceCreateOrReplaceAsync<FunctionEnvelope>;

  /**
   * Description for Delete a function for web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_DeleteFunction")
  deleteFunction is ArmResourceDeleteSync<FunctionEnvelope>;

  /**
   * Description for List the functions for a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListFunctions")
  listFunctions is ArmResourceListByParent<FunctionEnvelope>;

  /**
   * Description for Get function keys for a function in a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListFunctionKeys")
  listFunctionKeys is ArmResourceActionSync<
    FunctionEnvelope,
    void,
    StringDictionary
  >;

  /**
   * Description for Get function secrets for a function in a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
