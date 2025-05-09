import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using Azure.ResourceManager;

namespace Microsoft.OnlineExperimentation;

/**
 * An online experiment workspace resource.
 */
model OnlineExperimentWorkspace
  is TrackedResource<OnlineExperimentWorkspaceProperties> {
  ...ResourceNameParameter<
    Resource = OnlineExperimentWorkspace,
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
 * Partial update of an online experiment workspace resource.
 */
model OnlineExperimentWorkspacePatch {
  ...ManagedServiceIdentityProperty;
  ...Azure.ResourceManager.Foundations.TagsUpdateModel<OnlineExperimentWorkspace>;

  /**
   * The SKU (Stock Keeping Unit) assigned to this resource.
   */
  sku?: OnlineExperimentationWorkspaceSku;

  /**
   * Updatable properties of the online experiment workspace resource.
   */
  properties?: {
    /**
     * The resource identifier of the Log Analytics workspace which online experiment workspace uses for generating experiment analysis results.
     */
    logAnalyticsWorkspaceResourceId?: LogAnalyticsWorkspaceArmResourceId;

    /**
     * The resource identifier of storage account where logs are exported from Log Analytics workspace. Online Experiment workspace uses it generating experiment analysis results.
     */
    logsExporterStorageAccountResourceId?: StorageAccountArmResourceId;

    /**
     * The encryption configuration for the online experiment workspace resource.
     */
    encryption?: ResourceEncryptionConfiguration;
  };
}

@armResourceOperations
interface OnlineExperimentWorkspaces {
  /**
   * Gets an experiment workspace
   */
  get is ArmResourceRead<OnlineExperimentWorkspace>;

  /**
   * Create an experiment workspace, or update an existing workspace
   */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<OnlineExperimentWorkspace>;

  /**
   * Patch an experiment workspace
   */
  update is ArmCustomPatchAsync<
    OnlineExperimentWorkspace,
    OnlineExperimentWorkspacePatch
  >;

  /**
   * Deletes an experiment workspace
   */
  delete is ArmResourceDeleteWithoutOkAsync<OnlineExperimentWorkspace>;

  /**
   * Gets all experiment workspaces in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<OnlineExperimentWorkspace>;

  /**
   * Gets all experiment workspaces in the specified subscription.
   */
  listBySubscription is ArmListBySubscription<OnlineExperimentWorkspace>;
}
