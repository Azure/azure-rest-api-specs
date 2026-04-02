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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(DomainService)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

@armResourceOperations
@tag("OuContainer")
interface OuContainers {
  /**
   * Get OuContainer in DomainService instance.
   */
  @summary("Get particular OuContainer in DomainService instance")
  get is ArmResourceRead<OuContainer, Error = CloudError>;

  /**
   * The Create OuContainer operation creates a new OuContainer under the specified Domain Service instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create OuContainer")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    OuContainer,
    Request = ContainerAccount,
    Response = ArmResourceUpdatedResponse<OuContainer> | ArmResourceCreatedResponse<
      OuContainer,
      ArmLroLocationHeader<FinalResult = OuContainer> &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = OuContainer> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: OuContainer;
    }),
    Error = CloudError
  >;

  /**
   * The Update OuContainer operation can be used to update the existing OuContainers.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Update OuContainer (PATCH Resource)")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    OuContainer,
    PatchModel = ContainerAccount,
    Response = ArmResponse<OuContainer> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: OuContainer;
    }),
    Error = CloudError
  >;

  /**
   * The Delete OuContainer operation deletes specified OuContainer.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete OuContainer")
  delete is ArmResourceDeleteWithoutOkAsync<
    OuContainer,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * The List of OuContainers in DomainService instance.
   */
  @summary("List of OuContainers in DomainService instance")
  list is ArmResourceListByParent<
    OuContainer,
    Response = ArmResponse<OuContainerListResult>,
    Error = CloudError
  >;
}

@@doc(OuContainer.name, "The name of the OuContainer.");
@@doc(OuContainer.properties, "OuContainer properties");
@@doc(OuContainers.create::parameters.resource,
  "Container Account Description."
);
@@doc(OuContainers.update::parameters.properties,
  "Container Account Description."
);
