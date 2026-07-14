import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Solutions;
/**
 * Information about JIT request definition.
 */
// #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
// model JitRequestDefinition
//   is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<JitRequestProperties> {
//   ...ResourceNameParameter<
//     Resource = JitRequestDefinition,
//     KeyName = "jitRequestName",
//     SegmentName = "jitRequests",
//     NamePattern = ""
//   >;
// }
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
model JitRequestDefinition extends Resource {
  @visibility(Lifecycle.Read)
  @path
  @key("jitRequestName")
  @minLength(2)
  @maxLength(10)
  @segment("jitRequests")
  name: string;

  /**
   * The JIT request properties that can be updated.
   */
  properties?: JitRequestProperties;
}

@armResourceOperations(#{ omitTags: true })
@tag("JitRequests")
interface JitRequestDefinitions {
  /**
   * Gets the JIT request.
   */
  get is ArmResourceRead<
    JitRequestDefinition,
    Response = ArmResponse<JitRequestDefinition> | NotFoundResponse
  >;

  /**
   * Creates or updates the JIT request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("jitRequests_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<JitRequestDefinition>;

  /**
   * Updates the JIT request.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    JitRequestDefinition,
    PatchModel = JitRequestPatchable
  >;

  /**
   * Deletes the JIT request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("jitRequests_Delete")
  delete is ArmResourceDeleteSync<JitRequestDefinition>;

  /**
   * Lists all JIT requests within the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("jitRequests_ListByResourceGroup")
  listByResourceGroup is Azure.ResourceManager.Legacy.ArmListSinglePageByParent<JitRequestDefinition>;

  /**
   * Lists all JIT requests within the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("jitRequests_ListBySubscription")
  listBySubscription is Azure.ResourceManager.Legacy.ArmListSinglePageBySubscription<JitRequestDefinition>;
}

@@doc(JitRequestDefinition.name, "The name of the JIT request.");
@@doc(JitRequestDefinition.properties, "The JIT request properties.");
@@doc(
  JitRequestDefinitions.createOrUpdate::parameters.resource,
  "Parameters supplied to the update JIT request."
);
@@doc(
  JitRequestDefinitions.update::parameters.properties,
  "Parameters supplied to the update JIT request."
);
