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
  is Azure.ResourceManager.ProxyResource<DomainServiceProperties> {
  ...ResourceNameParameter<
    Resource = DomainService,
    KeyName = "domainServiceName",
    SegmentName = "domainServices",
    NamePattern = "^(?=.{3,255}$)([a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)(\\.([a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?))*$"
  >;

  /** Resource tags. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /** The geo-location where the resource lives */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Resource etag
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

@armResourceOperations
@tag("DomainServices")
interface DomainServices {
  /**
   * The Get Domain Service operation retrieves a json representation of the Domain Service.
   */
  @summary("Get Domain Service")
  get is ArmResourceRead<DomainService, Error = CloudError>;

  /**
   * The Create Domain Service operation creates a new domain service with the specified parameters. If the specific service already exists, then any patchable properties will be updated and any immutable properties will remain unchanged.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create or Update Domain Service (PUT Resource)")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DomainService,
    Response = ArmResourceUpdatedResponse<DomainService> | ArmResourceCreatedResponse<
      DomainService,
      ArmLroLocationHeader<FinalResult = DomainService> &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> & {
      @bodyRoot
      _: DomainService;
    }),
    Error = CloudError
  >;

  /**
   * The Update Domain Service operation can be used to update the existing deployment. The update call only supports the properties listed in the PATCH body.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Update Domain Service (PATCH Resource)")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    DomainService,
    PatchModel = DomainService,
    Response = ArmResponse<DomainService> | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> & {
      @bodyRoot
      _: DomainService;
    }),
    Error = CloudError
  >;

  /**
   * The Delete Domain Service operation deletes an existing Domain Service.
   */
  @summary("Delete Domain Service (DELETE Resource)")
  delete is ArmResourceDeleteWithoutOkAsync<
    DomainService,
    Response = ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * The List Domain Services in Resource Group operation lists all the domain services available under the given resource group.
   */
  @summary("List Domain Services in Resource Group")
  listByResourceGroup is ArmResourceListByParent<
    DomainService,
    Response = ArmResponse<DomainServiceListResult>,
    Error = CloudError
  >;

  /**
   * The List Domain Services in Subscription operation lists all the domain services available under the given subscription (and across all resource groups within that subscription).
   */
  @summary("List Domain Services in Subscription")
  list is ArmListBySubscription<
    DomainService,
    Response = ArmResponse<DomainServiceListResult>,
    Error = CloudError
  >;

  /**
   * Unsuspend a suspended Domain Service resource.
   */
  @summary("Unsuspend Domain Service")
  unsuspend is ArmResourceActionSync<
    DomainService,
    void,
    ArmResponse<UnsuspendDomainServiceResponse>,
    Error = CloudError
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
