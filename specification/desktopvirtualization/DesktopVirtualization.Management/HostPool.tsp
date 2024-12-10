import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DesktopVirtualization;
/**
 * Represents a HostPool definition.
 */
model HostPool
  is Azure.ResourceManager.TrackedResource<HostPoolProperties, false> {
  ...ResourceNameParameter<
    Resource = HostPool,
    KeyName = "hostPoolName",
    SegmentName = "hostPools",
    NamePattern = "^[A-Za-z0-9@.\\-_ ]*$"
  >;
}

@armResourceOperations
interface HostPools {
  /**
   * Get a host pool.
   */
  get is ArmResourceRead<HostPool>;

  /**
   * Create or update a host pool.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<HostPool>;

  /**
   * Update a host pool.
   */
  @parameterVisibility
  update is ArmCustomPatchSync<HostPool, HostPoolPatch>;

  /**
   * Remove a host pool.
   */
  delete is ArmResourceDeleteSync<
    HostPool,
    Parameters = {
      /**
       * Force flag to delete sessionHost.
       */
      @query("force")
      force?: boolean;
    }
  >;

  /**
   * List hostPools.
   */
  listByResourceGroup is ArmResourceListByParent<
    HostPool,
    Parameters = {
      /**
       * Number of items per page.
       */
      @query("pageSize")
      pageSize?: int32;

      /**
       * Indicates whether the collection is descending.
       */
      @query("isDescending")
      isDescending?: boolean;

      /**
       * Initial number of items to skip.
       */
      @query("initialSkip")
      initialSkip?: int32;
    },
    Response = HostPoolList
  >;

  /**
   * List hostPools in subscription.
   */
  list is ArmListBySubscription<
    HostPool,
    Parameters = {
      /**
       * Number of items per page.
       */
      @query("pageSize")
      pageSize?: int32;

      /**
       * Indicates whether the collection is descending.
       */
      @query("isDescending")
      isDescending?: boolean;

      /**
       * Initial number of items to skip.
       */
      @query("initialSkip")
      initialSkip?: int32;
    },
    Response = HostPoolList
  >;

  /**
   * Operation to list the RegistrationTokens associated with the HostPool
   */
  listRegistrationTokens is ArmResourceActionSync<
    HostPool,
    void,
    RegistrationTokenList
  >;

  /**
   * Registration token of the host pool.
   */
  retrieveRegistrationToken is ArmResourceActionSync<
    HostPool,
    void,
    RegistrationInfo
  >;

  /**
   * List scaling plan associated with hostpool.
   */
  @get
  listByHostPool is ArmResourceActionSync<
    HostPool,
    void,
    ScalingPlanList,
    Parameters = {
      /**
       * Number of items per page.
       */
      @query("pageSize")
      pageSize?: int32;

      /**
       * Indicates whether the collection is descending.
       */
      @query("isDescending")
      isDescending?: boolean;

      /**
       * Initial number of items to skip.
       */
      @query("initialSkip")
      initialSkip?: int32;
    }
  >;

  /**
   * Expands and Lists MSIX packages in an Image, given the Image Path.
   */
  expand is ArmResourceActionSync<HostPool, MsixImageURI, ExpandMsixImageList>;

  /**
   * Gets information from a package given the path to the package.
   */
  importAppAttachPackageInfo is ArmResourceActionSync<
    HostPool,
    ImportPackageInfoRequest,
    AppAttachPackageList
  >;

  /**
   * List the private link resources available for this hostpool.
   */
  @get
  privateLinkResourcesListByHostPool is ArmResourceActionSync<
    HostPool,
    void,
    PrivateLinkResourceListResult,
    Parameters = {
      /**
       * Number of items per page.
       */
      @query("pageSize")
      pageSize?: int32;

      /**
       * Indicates whether the collection is descending.
       */
      @query("isDescending")
      isDescending?: boolean;

      /**
       * Initial number of items to skip.
       */
      @query("initialSkip")
      initialSkip?: int32;
    }
  >;

  /**
   * List userSessions.
   */
  @get
  userSessionsListByHostPool is ArmResourceActionSync<
    HostPool,
    void,
    UserSessionList,
    Parameters = {
      /**
       * OData filter expression. Valid properties for filtering are userprincipalname and sessionstate.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of items per page.
       */
      @query("pageSize")
      pageSize?: int32;

      /**
       * Indicates whether the collection is descending.
       */
      @query("isDescending")
      isDescending?: boolean;

      /**
       * Initial number of items to skip.
       */
      @query("initialSkip")
      initialSkip?: int32;
    }
  >;
}

@@maxLength(HostPool.name, 64);
@@minLength(HostPool.name, 3);
@@doc(HostPool.name,
  "The name of the host pool within the specified resource group"
);
@@doc(HostPool.properties, "Detailed properties for HostPool");
@@doc(HostPools.createOrUpdate::parameters.resource,
  "Object containing HostPool definitions."
);
@@doc(HostPools.update::parameters.properties,
  "Object containing HostPool definitions."
);
@@doc(HostPools.expand::parameters.body, "Object containing URI to MSIX Image");
@@doc(HostPools.importAppAttachPackageInfo::parameters.body,
  "Object containing URI to package image and other optional properties"
);
