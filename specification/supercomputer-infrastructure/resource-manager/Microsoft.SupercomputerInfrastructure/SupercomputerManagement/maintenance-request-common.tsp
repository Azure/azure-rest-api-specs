namespace Microsoft.SupercomputerInfrastructure;

/** The type of maintenance request. */
union MaintenanceRequestType {
  /**
   * It is unknown exactly what the problem is, and Microsoft should investigate
   * and return with action items.
   */
  Investigative: "Investigative",

  /**
   * It is known what action items should be completed and Microsoft should
   * only perform that as directed.
   */
  Unhealthy: "Unhealthy",

  string,
}

/** The states of the maintenance request */
union MaintenanceRequestState {
  /** The maintenance request is being investigated by Microsoft. */
  Investigating: "Investigating",

  /**
   * The maintenance request is a duplicate of another maintenance request
   * that is mentioned in network maintenance ID.
   */
  Duplicate: "Duplicate",

  /** The maintenance request is waiting on customer approval to continue. */
  WaitingOnApproval: "WaitingOnApproval",

  /** The maintenance request is approved by the customer. */
  Approved: "Approved",

  /** The maintenance request is currently underway. */
  InProgress: "InProgress",

  /** The maintenance request is complete. */
  Complete: "Complete",

  /** The maintenance request is cancelled. */
  Cancelled: "Cancelled",

  string,
}
