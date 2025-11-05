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
@parentResource(DataBoxEdgeDevice)
model Trigger is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = Trigger,
    KeyName = "name",
    SegmentName = "triggers",
    NamePattern = ""
  >;

  /**
   * Trigger Kind.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: TriggerEventType;
}

@armResourceOperations
interface Triggers {
  /**
   * Get a specific trigger by name.
   */
  get is ArmResourceRead<Trigger>;

  /**
   * Creates or updates a trigger.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Trigger,
    Response = ArmResourceUpdatedResponse<Trigger> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = Trigger> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the trigger on the gateway device.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Trigger,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
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
    Response = ArmResponse<TriggerList>
  >;
}

@@doc(Trigger.name, "The trigger name.");
@@doc(Triggers.createOrUpdate::parameters.resource, "The trigger.");
