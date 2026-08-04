import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-liftr-base";
import "./client.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using LiftrBase;

/* Napster.CompanionAPI Resource Provider management API. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "CompanionAPI is the established product name"
@armProviderNamespace
@service(#{ title: "Napster.CompanionAPI management service" })
@versioned(Napster.CompanionAPI.Versions)
namespace Napster.CompanionAPI {
  interface Operations extends Azure.ResourceManager.Operations {}

  /** The available API versions. */
  enum Versions {
    /** 2025-12-24-preview version */
    @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
    @useDependency(LiftrBase.Versions.v3_preview)
    v2025_12_24_preview: "2025-12-24-preview",
  }

  @doc("Partner's specific Properties")
  model PartnerProperties {
    /** The name of the application. */
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_\\-.: ]*$")
    @doc("Application name")
    @minLength(2)
    @maxLength(40)
    application: string;
  }

  /** These properties will be sent to your endpoints registered with Liftr during CRUD on resource.
   * BaseResourceProperties contains Marketplace, useDetail related properties*/
  @doc("Properties specific to Organization")
  model OrganizationProperties is BaseResourceProperties {
    @doc("partner properties")
    partnerProperties: PartnerProperties;

    @doc("Single sign-on properties")
    singleSignOnProperties?: SingleSignOnPropertiesV2;
  }

  model OrganizationResource
    is Azure.ResourceManager.TrackedResource<OrganizationProperties> {
    @key("organizationname")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_\\-.: ]*$")
    @segment("organizations")
    @minLength(1)
    @maxLength(50)
    @doc("Name of the Organization resource")
    @path
    name: string;

    ...Azure.ResourceManager.ManagedServiceIdentityProperty;
  }

  /**
   * The type used for update operations of the Organization Resource.
   */
  model OrganizationResourceUpdate {
    ...Azure.ResourceManager.Foundations.ArmTagsProperty;

    /** Updatable managed service identity */
    ...Azure.ResourceManager.ManagedServiceIdentityProperty;
  }

  /** SaaS-related data properties */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  model SaaSData {
    /**
     * SaaS resource id
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    saaSResourceId?: string;
  }

  /**
   * SaaS guid & PublishedId for Activate and Validate SaaS Resource
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  model ActivateSaaSParameterRequest {
    /**
     * SaaS guid for Activate and Validate SaaS Resource
     */
    saasGuid: string;

    /**
     * Publisher Id for Napster resource
     */
    publisherId?: string;
  }

  /**
   * Marketplace SaaS resource details.
   */
  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  model SaaSResourceDetailsResponse
    extends Azure.ResourceManager.CommonTypes.ProxyResource {
    /**
     * Id of the Marketplace SaaS Resource
     */
    saasId?: string;
  }

  /**
   * Response of get latest linked SaaS resource operation
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  model LatestLinkedSaaSResponse {
    /**
     * SaaS resource id
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    saaSResourceId?: string;

    /**
     * Flag indicating if the SaaS resource is hidden
     */
    isHiddenSaaS?: boolean;
  }

  @armResourceOperations
  interface Organizations {
    get is ArmResourceRead<OrganizationResource>;
    createOrUpdate is ArmResourceCreateOrReplaceAsync<OrganizationResource>;
    @patch(#{ implicitOptionality: true })
    update is ArmCustomPatchAsync<
      OrganizationResource,
      OrganizationResourceUpdate
    >;
    delete is ArmResourceDeleteWithoutOkAsync<OrganizationResource>;
    @list
    listByResourceGroup is ArmResourceListByParent<OrganizationResource>;
    @list
    listBySubscription is ArmListBySubscription<OrganizationResource>;
    /**
     * Links a new SaaS to the Napster organization of the underlying monitor.
     */
    @summary("Links a new SaaS to the Napster organization of the underlying monitor.")
    @Azure.Core.useFinalStateVia("azure-async-operation")
    linkSaaS is ArmResourceActionAsync<
      OrganizationResource,
      SaaSData,
      ArmResponse<OrganizationResource>,
      LroHeaders = ArmCombinedLroHeaders<FinalResult = OrganizationResource> &
        Azure.Core.Foundations.RetryAfterHeader
    >;

    /**
     * Returns the latest SaaS linked to the Napster organization of the underlying monitor.
     */
    latestLinkedSaaS is ArmResourceActionSync<
      OrganizationResource,
      void,
      ArmResponse<LatestLinkedSaaSResponse>
    >;
  }

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  interface SaaSOperationGroup {
    /**
     * Resolve the token to get the SaaS resource ID and activate the SaaS resource
     */
    @autoRoute
    @action("activateSaaS")
    activateResource is ArmProviderActionAsync<
      Request = ActivateSaaSParameterRequest,
      Response = SaaSResourceDetailsResponse,
      Scope = SubscriptionActionScope,
      Parameters = {}
    >;
  }
}
