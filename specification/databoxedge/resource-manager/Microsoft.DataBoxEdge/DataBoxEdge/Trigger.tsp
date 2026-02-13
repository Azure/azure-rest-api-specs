import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
// FIXME: Trigger has no properties property
/**
 * Trigger details.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy DiscriminatedProxyResource for back compatibility"
@discriminator("kind")
@parentResource(DataBoxEdgeDevice)
model Trigger
  is Azure.ResourceManager.Legacy.DiscriminatedProxyResource<TriggerEventType> {
  ...ResourceNameParameter<
    Resource = Trigger,
    KeyName = "name",
    SegmentName = "triggers",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Triggers {
  /**
   * Get a specific trigger by name.
   */
  get is ArmResourceRead<Trigger, Error = CloudError>;

  /**
   * Creates or updates a trigger.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Trigger,
    Response = ArmResourceUpdatedResponse<Trigger> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Trigger> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = CloudError
  >;

  /**
   * Deletes the trigger on the gateway device.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Trigger,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all the triggers configured in the device.
   */
  listByDataBoxEdgeDevice is ArmResourceListByParent<
    Trigger,
    Parameters = {
      /**
       * Specify $filter='CustomContextTag eq <tag>' to filter on custom context tag property
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<TriggerList>,
    Error = CloudError
  >;
}

@@doc(Trigger.name, "The trigger name.");
@@doc(Triggers.createOrUpdate::parameters.resource, "The trigger.");
@@doc(Trigger.kind, "Trigger Kind.");
