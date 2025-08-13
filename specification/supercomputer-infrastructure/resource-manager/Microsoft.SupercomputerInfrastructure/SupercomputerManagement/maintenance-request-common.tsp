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

/** The types of impact covered by maintenance requests. */
union MaintenanceRequestImpactCategory {
  /** The link is miswired between two devices. */
  LinkMiswire: "LinkMiswire",

  /** The referenced link has unspecified performance issues. */
  LinkUnhealthy: "LinkUnhealthy",

  /** The referenced NIC has incorrect firmware. */
  NicIncorrectFirmware: "NicIncorrectFirmware",

  /** The referenced NIC has unspecified issues. */
  NicUnhealthy: "NicUnhealthy",

  /** The referenced port is completely down. */
  PortDown: "PortDown",

  /** The referenced port is flapping. */
  PortFlap: "PortFlap",

  /** The referenced port is receiving low Rx power. */
  PortRxLowPower: "PortRxLowPower",

  /** The referenced port is receiving low Tx power. */
  PortTxLowPower: "PortTxLowPower",

  /** The referenced port has unspecified performance issues, such as packet drops. */
  PortUnhealthy: "PortUnhealthy",

  /** The referenced switch is completely down. */
  SwitchDown: "SwitchDown",

  /** The referenced switch is misconfigured. */
  SwitchMisconfigured: "SwitchMisconfigured",

  /** The referenced switch has unspecified issues, such as a low buffer. */
  SwitchUnhealthy: "SwitchUnhealthy",

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
