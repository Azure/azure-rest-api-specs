import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Custom domain resource payload.
 */
@parentResource(AppResource)
model CustomDomainResource
  is Azure.ResourceManager.ProxyResource<CustomDomainProperties> {
  ...ResourceNameParameter<
    Resource = CustomDomainResource,
    KeyName = "domainName",
    SegmentName = "domains",
    NamePattern = ""
  >;
}

@armResourceOperations
interface CustomDomainResources {
  /**
   * Get the custom domain of one lifecycle application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CustomDomains_Get")
  get is ArmResourceRead<CustomDomainResource>;

  /**
   * Create or update custom domain of one lifecycle application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("CustomDomains_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CustomDomainResource,
    Response = ArmResourceUpdatedResponse<CustomDomainResource> | ArmResourceCreatedResponse<
      CustomDomainResource,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: CustomDomainResource;
    })
  >;

  /**
   * Update custom domain of one lifecycle application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @operationId("CustomDomains_Update")
  update is ArmCustomPatchAsync<
    CustomDomainResource,
    PatchModel = CustomDomainResource,
    Response = ArmResponse<CustomDomainResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: CustomDomainResource;
    })
  >;

  /**
   * Delete the custom domain of one lifecycle application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("CustomDomains_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    CustomDomainResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List the custom domains of one lifecycle application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CustomDomains_List")
  list is ArmResourceListByParent<
    CustomDomainResource,
    Response = ArmResponse<CustomDomainResourceCollection>
  >;
}

@@doc(CustomDomainResource.name, "The name of the custom domain resource.");
@@doc(CustomDomainResource.properties,
  "Properties of the custom domain resource."
);
@@doc(CustomDomainResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@doc(CustomDomainResources.update::parameters.properties,
  "Parameters for the create or update operation"
);
