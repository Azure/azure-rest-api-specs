/**
 * The ProvisioningState
 */
enum ProvisioningState {
  /**
   * Resource has been created.
   */
  Succeeded,

  /**
   * Resource creation failed.
   */
  Failed,

  /**
   * Resource creation was canceled.
   */
  Canceled,

  /**
   * Resource is in provisioning state.
   */
  Provisioning,

  /**
   * Resource is in updating state.
   */
  Updating,

  /**
   * Resource is in deleting state.
   */
  Deleting,

  /**
   * Resource is in accepted state.
   */
  Accepted,
}
