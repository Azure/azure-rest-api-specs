import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FrontDoor.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * A rules engine configuration containing a list of rules that will run to modify the runtime behavior of the request and response.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(FrontDoor)
@Http.Private.includeInapplicableMetadataInPayload(false)
model RulesEngine extends BasicResource {
  properties?: RulesEngineProperties;

  @visibility(Lifecycle.Read)
  @path
  @key("rulesEngineName")
  @segment("rulesEngines")
  @pattern("^[a-zA-Z0-9]+(-*[a-zA-Z0-9])*$")
  name: string;
}

@armResourceOperations
interface RulesEngines {
  /**
   * Gets a Rules Engine Configuration with the specified name within the specified Front Door.
   */
  get is ArmResourceRead<RulesEngine, Error = ErrorResponse>;

  /**
   * Creates a new Rules Engine Configuration with the specified name within the specified Front Door.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    RulesEngine,
    Response = ArmResourceUpdatedResponse<RulesEngine> | ArmResourceCreatedResponse<
      RulesEngine,
      LroHeaders = ArmAsyncOperationHeader &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: RulesEngine;
    }),
    Error = ErrorResponse
  >;

  /**
   * Deletes an existing Rules Engine Configuration with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    RulesEngine,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorResponse
  >;

  /**
   * Lists all of the Rules Engine Configurations within a Front Door.
   */
  listByFrontDoor is ArmResourceListByParent<
    RulesEngine,
    Error = ErrorResponse,
    Response = RulesEngineListResult
  >;
}

@@maxLength(RulesEngine.name, 90);
@@minLength(RulesEngine.name, 1);
@@doc(RulesEngine.name,
  "Name of the Rules Engine which is unique within the Front Door."
);
@@doc(RulesEngine.properties, "Properties of the Rules Engine Configuration.");
@@doc(RulesEngines.createOrUpdate::parameters.resource,
  "Rules Engine Configuration properties needed to create a new Rules Engine Configuration."
);
