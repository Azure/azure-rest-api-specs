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
    NamePattern = ""
  >;
}

@armResourceOperations
interface Domains {
  /**
   * Description for Get a domain.
   */
  get is ArmResourceRead<Domain>;

  /**
   * Description for Creates or updates a domain.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Domain,
    Response = ArmResourceUpdatedResponse<Domain> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Domain;
    }),
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Description for Creates or updates a domain.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Domain,
    PatchModel = DomainPatchResource,
    Response = ArmResponse<Domain> | (AcceptedResponse & {
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
  renew is ArmResourceActionSync<
    Domain,
    void,
    OkResponse | AcceptedResponse | NoContentResponse
  >;

  /**
   * Transfer out domain to another registrar
   */
  @put
  transferOut is ArmResourceActionSync<Domain, void, ArmResponse<Domain>>;
}

@@doc(Domain.name, "Name of the domain.");
@@doc(Domain.properties, "Domain resource specific properties");
@@doc(Domains.createOrUpdate::parameters.resource,
  "Domain registration information."
);
@@doc(Domains.update::parameters.properties,
  "Domain registration information."
);
