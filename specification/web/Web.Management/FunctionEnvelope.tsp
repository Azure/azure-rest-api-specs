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

@armResourceOperations
interface FunctionEnvelopes {
  /**
   * Description for Get function information by its ID for web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetFunction")
  getFunction is FunctionEnvelopeOps.Read<FunctionEnvelope>;

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
    >
  >;

  /**
   * Description for Delete a function for web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteFunction")
  deleteFunction is FunctionEnvelopeOps.DeleteSync<
    FunctionEnvelope,
    Response = ArmDeletedNoContentResponse
  >;

  /**
   * Description for List the functions for a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListFunctions")
  listFunctions is FunctionEnvelopeOps.List<
    FunctionEnvelope,
    Response = ArmResponse<FunctionEnvelopeCollection>
  >;

  /**
   * Description for Add or update a function secret.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_CreateOrUpdateFunctionSecret")
  @put
  @action("{keyName}")
  createOrUpdateFunctionSecret is FunctionEnvelopeOps.ActionSync<
    FunctionEnvelope,
    KeyInfo,
    ArmResponse<KeyInfo> | ArmResourceCreatedSyncResponse<KeyInfo>,
    Parameters = {
      /**
       * The name of the key.
       */
      @path
      keyName: string;
    }
  >;

  /**
   * Description for Delete a function secret.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_DeleteFunctionSecret")
  @delete
  @action("{keyName}")
  deleteFunctionSecret is FunctionEnvelopeOps.ActionSync<
    FunctionEnvelope,
    void,
    NoContentResponse,
    Parameters = {
      /**
       * The name of the key.
       */
      @path
      keyName: string;
    }
  >;

  /**
   * Description for Get function keys for a function in a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListFunctionKeys")
  @action("listkeys")
  listFunctionKeys is FunctionEnvelopeOps.ActionSync<
    FunctionEnvelope,
    void,
    ArmResponse<StringDictionary>
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
    ArmResponse<FunctionSecrets>
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
  getInstanceFunctionSlot is FunctionEnvelopeOperationGroupOps.Read<FunctionEnvelope>;

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
    >
  >;

  /**
   * Description for Delete a function for web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteInstanceFunctionSlot")
  deleteInstanceFunctionSlot is FunctionEnvelopeOperationGroupOps.DeleteSync<
    FunctionEnvelope,
    Response = ArmDeletedNoContentResponse
  >;

  /**
   * Description for List the functions for a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListInstanceFunctionsSlot")
  listInstanceFunctionsSlot is FunctionEnvelopeOperationGroupOps.List<
    FunctionEnvelope,
    Response = ArmResponse<FunctionEnvelopeCollection>
  >;

  /**
   * Description for Add or update a function secret.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_CreateOrUpdateFunctionSecretSlot")
  @put
  @action("{keyName}")
  createOrUpdateFunctionSecretSlot is FunctionEnvelopeOperationGroupOps.ActionSync<
    FunctionEnvelope,
    KeyInfo,
    ArmResponse<KeyInfo> | ArmResourceCreatedSyncResponse<KeyInfo>,
    Parameters = {
      /**
       * The name of the key.
       */
      @path
      keyName: string;
    }
  >;

  /**
   * Description for Delete a function secret.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_DeleteFunctionSecretSlot")
  @delete
  @action("{keyName}")
  deleteFunctionSecretSlot is FunctionEnvelopeOperationGroupOps.ActionSync<
    FunctionEnvelope,
    void,
    NoContentResponse,
    Parameters = {
      /**
       * The name of the key.
       */
      @path
      keyName: string;
    }
  >;

  /**
   * Description for Get function keys for a function in a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListFunctionKeysSlot")
  @action("listkeys")
  listFunctionKeysSlot is FunctionEnvelopeOperationGroupOps.ActionSync<
    FunctionEnvelope,
    void,
    ArmResponse<StringDictionary>
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
    ArmResponse<FunctionSecrets>
  >;
}

@@doc(FunctionEnvelope.name, "Function name.");
@@doc(FunctionEnvelope.properties,
  "FunctionEnvelope resource specific properties"
);
@@doc(FunctionEnvelopes.createFunction::parameters.resource,
  "Function details."
);
@@doc(FunctionEnvelopes.createOrUpdateFunctionSecret::parameters.body,
  "The key to create or update"
);
@@doc(FunctionEnvelopeOperationGroup.createInstanceFunctionSlot::parameters.resource,
  "Function details."
);
@@doc(FunctionEnvelopeOperationGroup.createOrUpdateFunctionSecretSlot::parameters.body,
  "The key to create or update"
);
