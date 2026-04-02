import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AAD;
/**
 * Resource for OuContainer.
 */
model OuContainer
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<OuContainerProperties> {
  ...ResourceNameParameter<
    Resource = OuContainer,
    KeyName = "ouContainerName",
    SegmentName = "ouContainer",
    NamePattern = ""
  >;

  /**
   * Resource etag
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations
interface OuContainers {
  /**
   * Get OuContainer in DomainService instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OuContainer_Get")
  get is ArmResourceRead<OuContainer>;

  /**
   * The Create OuContainer operation creates a new OuContainer under the specified Domain Service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("OuContainer_Create")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    OuContainer,
    Request = ContainerAccount,
    Response = ArmResourceUpdatedResponse<OuContainer> | ArmResourceCreatedResponse<
      OuContainer,
      ArmLroLocationHeader<FinalResult = OuContainer> &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: OuContainer;
    })
  >;

  /**
   * The Update OuContainer operation can be used to update the existing OuContainers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("OuContainer_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    OuContainer,
    PatchModel = ContainerAccount,
    Response = ArmResponse<OuContainer> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: OuContainer;
    })
  >;

  /**
   * The Delete OuContainer operation deletes specified OuContainer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("OuContainer_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    OuContainer,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * The List of OuContainers in DomainService instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OuContainer_List")
  list is ArmResourceListByParent<OuContainer>;
}

@@doc(OuContainer.name, "The name of the OuContainer.");
@@doc(OuContainer.properties, "OuContainer properties");
@@doc(OuContainers.create::parameters.resource,
  "Container Account Description."
);
@@doc(OuContainers.update::parameters.properties,
  "Container Account Description."
);
