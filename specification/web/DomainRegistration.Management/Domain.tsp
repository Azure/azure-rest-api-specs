import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DomainRegistration;
/**
 * Information about a domain.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Domain is Azure.ResourceManager.TrackedResource<DomainProperties> {
  ...ResourceNameParameter<
    Resource = {},
    KeyName = "domainName",
    SegmentName = "domains",
    NamePattern = "[a-zA-Z0-9][a-zA-Z0-9\\.-]+"
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface Domains {
  /**
   * Description for Get a domain.
   */
  get is ArmResourceRead<Domain>;

  /**
   * Description for Creates or updates a domain.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Domain,
    Response = ArmResourceUpdatedResponse<Domain> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Domain>> & {
      @bodyRoot
      _: Domain;
    }),
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Description for Creates or updates a domain.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Domain,
    PatchModel = DomainPatchResource,
    Response = ArmResponse<Domain> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Domain>> & {
      @bodyRoot
      _: Domain;
    })
  >;

  /**
   * Description for Delete a domain.
   */
  delete is ArmResourceDeleteSync<
    Domain,
    Parameters = {
      /**
       * Specify <code>true</code> to delete the domain immediately. The default is <code>false</code> which deletes the domain after 24 hours.
       */
      @query("forceHardDeleteDomain")
      forceHardDeleteDomain?: boolean;
    }
  >;

  /**
   * Description for Get all domains in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Domain,
    Response = ArmResponse<DomainCollection>
  >;

  /**
   * Description for Get all domains in a subscription.
   */
  list is ArmListBySubscription<
    Domain,
    Response = ArmResponse<DomainCollection>
  >;

  /**
   * Description for Renew a domain.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  renew is ArmResourceActionSync<
    Domain,
    void,
    OkResponse | AcceptedResponse | NoContentResponse
  >;

  /**
   * Transfer out domain to another registrar
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @put
  transferOut is ArmResourceActionSync<
    Domain,
    void,
    ArmResponse<Domain> | ArmBadRequestResponse
  >;
}

@@doc(Domain.name, "Name of the domain.");
@@doc(Domain.properties, "Domain resource specific properties");
@@doc(Domains.createOrUpdate::parameters.resource,
  "Domain registration information."
);
@@doc(Domains.update::parameters.properties,
  "Domain registration information."
);
