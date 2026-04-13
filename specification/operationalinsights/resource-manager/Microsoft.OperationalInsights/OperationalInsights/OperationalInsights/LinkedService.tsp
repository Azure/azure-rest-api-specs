import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OperationalInsights;
/**
 * The top level Linked service resource container.
 */
@parentResource(Workspace)
model LinkedService
  is Azure.ResourceManager.ProxyResource<LinkedServiceProperties, false> {
  ...ResourceNameParameter<
    Resource = LinkedService,
    KeyName = "linkedServiceName",
    SegmentName = "linkedServices",
    NamePattern = ""
  >;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@armResourceOperations
interface LinkedServices {
  /**
   * Gets a linked service instance.
   */
  get is ArmResourceRead<LinkedService>;

  /**
   * Create or update a linked service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    LinkedService,
    Response = ArmResourceUpdatedResponse<LinkedService> | ArmResourceCreatedResponse<
      LinkedService,
      ArmLroLocationHeader<FinalResult = LinkedService> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Deletes a linked service instance.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    LinkedService,
    Response = ArmResponse<LinkedService> | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets the linked services instances in a workspace.
   */
  listByWorkspace is ArmResourceListByParent<
    LinkedService,
    Response = ArmResponse<LinkedServiceListResult>
  >;
}

@@doc(LinkedService.name, "Name of the linked service.");
@@doc(LinkedService.properties, "The properties of the linked service.");
@@doc(LinkedServices.createOrUpdate::parameters.resource,
  "The parameters required to create or update a linked service."
);
