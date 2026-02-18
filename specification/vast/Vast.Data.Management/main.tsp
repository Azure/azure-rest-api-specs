import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-liftr-base";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using LiftrBase;

/* Vast.Data Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Vast.Data management service" })
@versioned(Vast.Data.Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Vast.Data {
  interface Operations extends Azure.ResourceManager.Operations {}

  /** The available API versions. */
  enum Versions {
    /** 2025-12-11-preview version */
    @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
    @useDependency(LiftrBase.Versions.v2_preview)
    v2025_12_11_preview: "2025-12-11-preview",
  }

  /** These properties will be sent to your endpoints registered with Liftr during CRUD on resource.
   * BaseResourceProperties contains Marketplace, useDetail related properties*/
  @doc("Properties specific to Cluster")
  model ClusterProperties is BaseResourceProperties {
    @doc("Single sign-on properties")
    singleSignOnProperties?: SingleSignOnPropertiesV2;

    @visibility(Lifecycle.Read)
    @doc("Managed On Behalf Of Configuration.")
    managedOnBehalfOfConfiguration?: Azure.ResourceManager.CommonTypes.ManagedOnBehalfOfConfiguration;
  }

  model ClusterResource
    is Azure.ResourceManager.TrackedResource<ClusterProperties> {
    @key("clustername")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_\\-.: ]*$")
    @segment("clusters")
    @minLength(1)
    @maxLength(50)
    @doc("Name of the Cluster resource")
    @path
    name: string;

    ...Azure.ResourceManager.ManagedServiceIdentityProperty;
  }

  /**
   * The type used for update operations of the Cluster Resource.
   */
  model ClusterResourceUpdate {
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
     * Publisher Id for VAST resource
     */
    publisherId: string;
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
  interface Clusters {
    get is ArmResourceRead<ClusterResource>;
    createOrUpdate is ArmResourceCreateOrReplaceAsync<ClusterResource>;
    @patch(#{ implicitOptionality: true })
    update is ArmCustomPatchAsync<ClusterResource, ClusterResourceUpdate>;
    delete is ArmResourceDeleteWithoutOkAsync<ClusterResource>;
    @list
    listByResourceGroup is ArmResourceListByParent<ClusterResource>;
    @list
    listBySubscription is ArmListBySubscription<ClusterResource>;
    /**
     * Links a new SaaS to the VAST Resource.
     */
    #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @summary("Links a new SaaS to the VAST Resource.")
    @Azure.Core.useFinalStateVia("azure-async-operation")
    linkSaaS is ArmResourceActionAsync<
      ClusterResource,
      SaaSData,
      ArmResponse<ClusterResource>,
      LroHeaders = ArmCombinedLroHeaders<FinalResult = ClusterResource> &
        Azure.Core.Foundations.RetryAfterHeader
    >;

    /**
     * Returns the latest SaaS linked to the VAST Resource.
     */
    latestLinkedSaaS is ArmResourceActionSync<
      ClusterResource,
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
    activateResource is ArmProviderActionSync<
      Request = ActivateSaaSParameterRequest,
      Response = SaaSResourceDetailsResponse,
      Scope = SubscriptionActionScope,
      Parameters = {}
    >;
  }
}
