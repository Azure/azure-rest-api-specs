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
 * Domain service.
 */
model DomainService
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<DomainServiceProperties> {
  ...ResourceNameParameter<
    Resource = DomainService,
    KeyName = "domainServiceName",
    SegmentName = "domainServices",
    NamePattern = "^(?=.{3,255}$)([a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)(\\.([a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?))*$"
  >;

  /**
   * Resource etag
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations
interface DomainServices {
  /**
   * The Get Domain Service operation retrieves a json representation of the Domain Service.
   */
  get is ArmResourceRead<DomainService>;

  /**
   * The Create Domain Service operation creates a new domain service with the specified parameters. If the specific service already exists, then any patchable properties will be updated and any immutable properties will remain unchanged.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DomainService,
    Response = ArmResourceUpdatedResponse<DomainService> | ArmResourceCreatedResponse<
      DomainService,
      ArmLroLocationHeader<FinalResult = DomainService> &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: DomainService;
    })
  >;

  /**
   * The Update Domain Service operation can be used to update the existing deployment. The update call only supports the properties listed in the PATCH body.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    DomainService,
    PatchModel = DomainService,
    Response = ArmResponse<DomainService> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: DomainService;
    })
  >;

  /**
   * The Delete Domain Service operation deletes an existing Domain Service.
   */
  delete is ArmResourceDeleteWithoutOkAsync<DomainService>;

  /**
   * The List Domain Services in Resource Group operation lists all the domain services available under the given resource group.
   */
  listByResourceGroup is ArmResourceListByParent<DomainService>;

  /**
   * The List Domain Services in Subscription operation lists all the domain services available under the given subscription (and across all resource groups within that subscription).
   */
  list is ArmListBySubscription<DomainService>;

  /**
   * Unsuspend a suspended Domain Service resource.
   */
  unsuspend is ArmResourceActionSync<
    DomainService,
    void,
    ArmResponse<UnsuspendDomainServiceResponse>
  >;
}

@@doc(DomainService.name, "The name of the domain service.");
@@doc(DomainService.properties, "Domain service properties");
@@doc(DomainServices.createOrUpdate::parameters.resource,
  "Properties supplied to the Create or Update a Domain Service operation."
);
@@doc(DomainServices.update::parameters.properties,
  "Properties supplied to the Update a Domain Service operation."
);
