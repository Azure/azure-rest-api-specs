import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

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
  ...ManagedServiceIdentityProperty;
  ...etagProperty;
  ...ResourceKindProperty;
  ...ManagedByProperty;
  ...ResourcePlanProperty;
  ...ResourceSkuProperty;
}

@armResourceOperations
interface AppAttachPackageInfo {
  /**
   * Gets information from a package given the path to the package.
   */
  #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Backwards compatibility with existing clients."
  @action("importAppAttachPackageInfo")
  @list
  `import` is ArmResourceActionSync<
    HostPool,
    Request = {
      /**
       * Information to import app attach package
       */
      @bodyRoot importPackageInfoRequest: ImportPackageInfoRequest;
    },
    Response = AppAttachPackageList
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Following old implementation"
@armResourceOperations
interface MSIXImages {
  /**
   * Expands and Lists MSIX packages in an Image, given the Image Path.
   * This action uses incorrect Msix casing intentionally to match the previous APIs.
   */
  #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Backwards compatibility with existing clients."
  @action("expandMsixImage")
  @list
  expand is ArmResourceActionSync<
    HostPool,
    Request = {
      /**
       * Represents URI referring to MSIX Image
       */
      @bodyRoot msixImageURI: MSIXImageURI;
    },
    Response = ExpandMsixImageList
  >;
}

@armResourceOperations
interface PrivateLinkResources {
  /**
   * List the private link resources available for this hostpool.
   */
  @action("privateLinkResources")
  @get
  @list
  listByHostPool is Azure.ResourceManager.ArmResourceActionSync<
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
   * List the private link resources available for this workspace.
   */
  @action("privateLinkResources")
  @get
  @list
  listByWorkspace is Azure.ResourceManager.ArmResourceActionSync<
    Workspace,
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
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    HostPool,
    HostPoolPatch,
    Request = {
      /**
       * The properties to be updated.
       */
      @bodyRoot hostPool?: HostPoolPatch;
    }
  >;

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
   * Operation to list the RegistrationTokens associated with the HostPool.
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
