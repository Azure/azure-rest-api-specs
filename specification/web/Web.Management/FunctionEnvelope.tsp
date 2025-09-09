import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Function information.
 */
@parentResource(Site)
model FunctionEnvelope
  is Azure.ResourceManager.ProxyResource<FunctionEnvelopeProperties> {
  ...ResourceNameParameter<
    Resource = FunctionEnvelope,
    KeyName = "functionName",
    SegmentName = "functions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface FunctionEnvelopeOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Site name. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** Function name. */
        @path
        @segment("functions")
        @key
        functionName: string,
      }
    > {}

alias FunctionEnvelopesParameters = {
  ...ResourceInstanceParameters<FunctionEnvelope>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" ""
  @path
  @segment("keys")
  @key
  keyName: string;
};

@armResourceOperations
interface FunctionEnvelopeSlotOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" ""
        @path
        @segment("sites")
        @key
        name: string,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" ""
        @path
        @segment("slots")
        @key
        slot: string,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" ""
        @path
        @segment("functions")
        @key
        functionName: string,
      },
      {
        #suppress "@azure-tools/typespec-azure-core/documentation-required" ""
        @path
        @segment("keys")
        @key
        keyName: string,
      }
    > {}

@armResourceOperations
interface FunctionEnvelopeSlotOperationWithoutKeysGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" ""
        @path
        @segment("sites")
        @key
        name: string,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" ""
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        #suppress "@azure-tools/typespec-azure-core/documentation-required" ""
        @path
        @segment("functions")
        @key
        functionName: string,
      }
    > {}
@armResourceOperations
interface FunctionEnvelopes {
  /**
   * Description for Get function information by its ID for web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetFunction")
  getFunction is FunctionEnvelopeOps.Read<
    FunctionEnvelope,
    Response = ArmResponse<FunctionEnvelope> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Create function for web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateFunction")
  createFunction is FunctionEnvelopeOps.CreateOrUpdateAsync<
    FunctionEnvelope,
    Response = ArmResourceCreatedResponse<
      FunctionEnvelope,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    >,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Delete a function for web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" ""
  @operationId("WebApps_DeleteFunction")
  deleteFunction is FunctionEnvelopeOps.DeleteSync<
    FunctionEnvelope,
    Response = ArmDeletedNoContentResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for List the functions for a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListFunctions")
  listFunctions is FunctionEnvelopeOps.List<
    FunctionEnvelope,
    Response = ArmResponse<FunctionEnvelopeCollection> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Add or update a function secret.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" ""
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_CreateOrUpdateFunctionSecret")
  @put
  createOrUpdateFunctionSecret(
    ...FunctionEnvelopesParameters,
    @body key: KeyInfo,
  ): ArmResponse<KeyInfo> | ArmResourceCreatedSyncResponse<KeyInfo> | DefaultErrorResponse;
  /**
   * Description for Delete a function secret.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" ""
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" ""
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_DeleteFunctionSecret")
  @delete
  deleteFunctionSecret(
    ...FunctionEnvelopesParameters,
  ): NoContentResponse | ArmNotFoundResponse | DefaultErrorResponse;

  /**
   * Description for Get function keys for a function in a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListFunctionKeys")
  @action("listkeys")
  listFunctionKeys is FunctionEnvelopeOps.ActionSync<
    FunctionEnvelope,
    void,
    ArmResponse<StringDictionary>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get function secrets for a function in a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListFunctionSecrets")
  @action("listsecrets")
  listFunctionSecrets is FunctionEnvelopeOps.ActionSync<
    FunctionEnvelope,
    void,
    ArmResponse<FunctionSecrets>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface FunctionEnvelopeOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Site name. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the deployment slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** Function name. */
        @path
        @segment("functions")
        @key
        functionName: string,
      }
    > {}

@armResourceOperations
interface FunctionEnvelopeOperationGroup {
  /**
   * Description for Get function information by its ID for web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetInstanceFunctionSlot")
  getInstanceFunctionSlot is FunctionEnvelopeOperationGroupOps.Read<
    FunctionEnvelope,
    Response = ArmResponse<FunctionEnvelope> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Create function for web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateInstanceFunctionSlot")
  createInstanceFunctionSlot is FunctionEnvelopeOperationGroupOps.CreateOrUpdateAsync<
    FunctionEnvelope,
    Response = ArmResourceCreatedResponse<
      FunctionEnvelope,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    >,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Delete a function for web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" ""
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteInstanceFunctionSlot")
  deleteInstanceFunctionSlot is FunctionEnvelopeOperationGroupOps.DeleteSync<
    FunctionEnvelope,
    Response = ArmDeletedNoContentResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for List the functions for a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListInstanceFunctionsSlot")
  listInstanceFunctionsSlot is FunctionEnvelopeOperationGroupOps.List<
    FunctionEnvelope,
    Response = ArmResponse<FunctionEnvelopeCollection> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Add or update a function secret.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" ""
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_CreateOrUpdateFunctionSecretSlot")
  @put
  createOrUpdateFunctionSecretSlot is FunctionEnvelopeSlotOperationGroupOps.CreateOrUpdateAsync<
    FunctionEnvelope,
    Request = KeyInfo,
    Response = ArmResponse<KeyInfo> | ArmResourceCreatedSyncResponse<KeyInfo>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Delete a function secret.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" ""
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" ""
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_DeleteFunctionSecretSlot")
  @delete
  deleteFunctionSecretSlot is FunctionEnvelopeSlotOperationGroupOps.DeleteSync<
    FunctionEnvelope,
    Response = NoContentResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get function keys for a function in a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListFunctionKeysSlot")
  @action("listkeys")
  listFunctionKeysSlot is FunctionEnvelopeSlotOperationWithoutKeysGroupOps.ActionSync<
    FunctionEnvelope,
    void,
    ArmResponse<StringDictionary>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get function secrets for a function in a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListFunctionSecretsSlot")
  @action("listsecrets")
  listFunctionSecretsSlot is FunctionEnvelopeOperationGroupOps.ActionSync<
    FunctionEnvelope,
    void,
    ArmResponse<FunctionSecrets>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(FunctionEnvelope.name, "Function name.");
@@doc(FunctionEnvelope.properties,
  "FunctionEnvelope resource specific properties"
);
@@doc(FunctionEnvelopes.createFunction::parameters.resource,
  "Function details."
);
@@doc(FunctionEnvelopes.createOrUpdateFunctionSecret::parameters.key,
  "The key to create or update"
);
@@doc(FunctionEnvelopeOperationGroup.createInstanceFunctionSlot::parameters.resource,
  "Function details."
);
@@doc(FunctionEnvelopeOperationGroup.createOrUpdateFunctionSecretSlot::parameters.resource,
  "The key to create or update"
);
