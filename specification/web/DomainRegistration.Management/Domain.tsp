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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
model Domain is Azure.ResourceManager.TrackedResource< Properties={
  /**
   * Administrative contact.
   */
  @visibility(Lifecycle.Create)
  contactAdmin: Contact;

  /**
   * Billing contact.
   */
  @visibility(Lifecycle.Create)
  contactBilling: Contact;

  /**
   * Registrant contact.
   */
  @visibility(Lifecycle.Create)
  contactRegistrant: Contact;

  /**
   * Technical contact.
   */
  @visibility(Lifecycle.Create)
  contactTech: Contact;

  /**
   * Domain registration status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @visibility(Lifecycle.Read)
  registrationStatus?: registrationStatus;

  /**
   * Domain provisioning state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: provisioningState;
  /**
   * Name servers.
   */
  @visibility(Lifecycle.Read)
  nameServers?: string[];

  /**
   * <code>true</code> if domain privacy is enabled for this domain; otherwise, <code>false</code>.
   */
  privacy?: boolean;

  /**
   * Domain creation timestamp.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Domain expiration timestamp.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;

  /**
   * Timestamp when the domain was renewed last time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRenewedTime?: utcDateTime;

  /**
   * <code>true</code> if the domain should be automatically renewed; otherwise, <code>false</code>.
   */
  autoRenew?: boolean = true;

  /**
   * <code>true</code> if Azure can assign this domain to App Service apps; otherwise, <code>false</code>. This value will be <code>true</code> if domain registration status is active and \n it is hosted on name servers Azure has programmatic access to.
   */
  @visibility(Lifecycle.Read)
  readyForDnsRecordManagement?: boolean;

  /**
   * All hostnames derived from the domain and assigned to Azure resources.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  managedHostNames?: HostName[];

  /**
   * Legal agreement consent.
   */
  @visibility(Lifecycle.Create)
  consent: DomainPurchaseConsent;

  /**
   * Reasons why domain is not renewable.
   */
  @visibility(Lifecycle.Read)
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  domainNotRenewableReasons?: domainNotRenewableReasonsProperties[];

  /**
   * Current DNS type
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  dnsType?: DnsType;

  /**
   * Azure DNS Zone to use
   */
  dnsZoneId?: string;

  /**
   * Target DNS type (would be used for migration)
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  targetDnsType?: DnsType;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  authCode?: string;
}> {
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
    Response = ArmResourceUpdatedResponse<Domain> | (ArmAcceptedLroResponse & {
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
  transferOut is ArmResourceActionSync<Domain, void, ArmResponse<Domain> | ArmBadRequestResponse>;
}

@@doc(Domain.name, "Name of the domain.");
@@doc(Domain.properties, "Domain resource specific properties");
@@doc(Domains.createOrUpdate::parameters.resource,
  "Domain registration information."
);
@@doc(Domains.update::parameters.properties,
  "Domain registration information."
);
