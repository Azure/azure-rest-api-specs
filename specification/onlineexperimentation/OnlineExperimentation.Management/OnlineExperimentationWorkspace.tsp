import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.OnlineExperimentation;

/**
 * An online experimentation workspace resource.
 */
model OnlineExperimentationWorkspace
  is TrackedResource<OnlineExperimentationWorkspaceProperties> {
  ...ResourceNameParameter<
    Resource = OnlineExperimentationWorkspace,
    KeyName = "workspaceName",
    NamePattern = "^[a-z0-9](?!.*---)[a-z0-9-]{1,53}[a-z0-9]",
    SegmentName = "workspaces"
  >;
  ...ManagedServiceIdentityProperty;

  /**
   * The SKU (Stock Keeping Unit) assigned to this resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The common types sku doesn't support Developer tier."
  sku?: OnlineExperimentationWorkspaceSku;
}

/**
 * Partial update of an online experimentation workspace resource.
 */
model OnlineExperimentationWorkspacePatch {
  ...ManagedServiceIdentityProperty;
  ...Azure.ResourceManager.Foundations.TagsUpdateModel<OnlineExperimentationWorkspace>;

  /**
   * The SKU (Stock Keeping Unit) assigned to this resource.
   */
  sku?: OnlineExperimentationWorkspaceSku;

  /**
   * Updatable properties of the online experimentation workspace resource.
   */
  #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Backcompatibility with existing clients"
  properties?: {
    /**
     * The resource identifier of the Log Analytics workspace which online experimentation workspace uses for generating experiment analysis results.
     */
    logAnalyticsWorkspaceResourceId?: LogAnalyticsWorkspaceArmResourceId;

    /**
     * The resource identifier of storage account where logs are exported from Log Analytics workspace. online experimentation workspace uses it generating experiment analysis results.
     */
    logsExporterStorageAccountResourceId?: StorageAccountArmResourceId;

    /**
     * The encryption configuration for the online experimentation workspace resource.
     */
    encryption?: ResourceEncryptionConfiguration;

    /**
     * Public Network Access Control for the online experimentation resource. Defaults to Enabled if set to null.
     * - Enabled: The resource can be accessed from the public internet.
     * - Disabled: The resource can only be accessed from a private endpoint.
     */
    @added(Microsoft.OnlineExperimentation.Versions.v2025_08_01_preview)
    publicNetworkAccess?: PublicNetworkAccessType;
  };
}

@armResourceOperations
interface OnlineExperimentationWorkspaces {
  /**
   * Gets an online experimentation workspace.
   */
  get is ArmResourceRead<OnlineExperimentationWorkspace>;

  /**
   * Create an online experimentation workspace, or update an existing workspace.
   */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<OnlineExperimentationWorkspace>;

  /**
   * Patch an online experimentation workspace.
   */
  update is ArmCustomPatchAsync<
    OnlineExperimentationWorkspace,
    OnlineExperimentationWorkspacePatch
  >;

  /**
   * Deletes an online experimentation workspace.
   */
  delete is ArmResourceDeleteWithoutOkAsync<OnlineExperimentationWorkspace>;

  /**
   * Gets all online experimentation workspaces in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<OnlineExperimentationWorkspace>;

  /**
   * Gets all online experimentation workspaces in the specified subscription.
   */
  listBySubscription is ArmListBySubscription<OnlineExperimentationWorkspace>;
}
