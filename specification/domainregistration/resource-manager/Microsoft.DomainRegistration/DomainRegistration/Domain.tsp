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
model Domain is Azure.ResourceManager.TrackedResource<DomainProperties> {
  ...ResourceNameParameter<
    Resource = Domain,
    KeyName = "domainName",
    SegmentName = "domains",
    NamePattern = "[a-zA-Z0-9][a-zA-Z0-9\\.-]+"
  >;

  /**
   * Kind of resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface Domains {
  /**
   * Description for Get a domain.
   */
  @summary("Get a domain.")
  get is ArmResourceRead<Domain, Error = DefaultErrorResponse>;

  /**
   * Description for Creates or updates a domain.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates or updates a domain.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Domain,
    Response = ArmResourceUpdatedResponse<Domain> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Domain>> & {
      @bodyRoot
      _: Domain;
    }),
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Creates or updates a domain.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  @summary("Creates or updates a domain.")
  update is ArmCustomPatchSync<
    Domain,
    PatchModel = DomainPatchResource,
    Response = ArmResponse<Domain> | (ArmAcceptedResponse & {
      @bodyRoot
      _: Domain;
    }),
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Delete a domain.
   */
  @summary("Delete a domain.")
  delete is ArmResourceDeleteSync<
    Domain,
    Parameters = {
      /**
       * Specify <code>true</code> to delete the domain immediately. The default is <code>false</code> which deletes the domain after 24 hours.
       */
      @query("forceHardDeleteDomain")
      forceHardDeleteDomain?: boolean;
    },
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Get all domains in a resource group.
   */
  @summary("Get all domains in a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    Domain,
    Response = ArmResponse<DomainCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Get all domains in a subscription.
   */
  @summary("Get all domains in a subscription.")
  list is ArmListBySubscription<
    Domain,
    Response = ArmResponse<DomainCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Renew a domain.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Renew a domain.")
  renew is ArmResourceActionSync<
    Domain,
    void,
    OkResponse | ArmAcceptedResponse | NoContentResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Transfer out domain to another registrar
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @put
  @summary("Transfer out domain to another registrar")
  transferOut is ArmResourceActionSync<
    Domain,
    void,
    ArmResponse<Domain> | ArmBadRequestResponse,
    Error = DefaultErrorResponse
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
