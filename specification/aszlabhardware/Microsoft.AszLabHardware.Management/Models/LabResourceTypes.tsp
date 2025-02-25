@doc("LabResource availability for reservation state.")
union LabResourceAvailableForReservationState {
  @doc("The LabResource is not available for reservation.")
  NotAvailableForReservation: "NotAvailableForReservation",

  @doc("The LabResource is available for reservation.")
  AvailableForReservation: "AvailableForReservation",

  string,
}

@doc("LabResource reservation status.")
union LabResourceReservationStatus {
  @doc("The LabResource is not reserved.")
  NotReserved: "NotReserved",

  @doc("The LabResource is reserved.")
  Reserved: "Reserved",

  string,
}

@doc("LabResource maintenance request state.")
union LabResourceMaintenanceRequestState {
  @doc("The LabResource is not requested for maintenance.")
  MaintenanceNotRequested: "MaintenanceNotRequested",

  @doc("The LabResource is requested for maintenance.")
  MaintenanceRequested: "MaintenanceRequested",

  @doc("The LabResource is required for maintenance.")
  MaintenanceRequired: "MaintenanceRequired",

  string,
}

@doc("LabResource maintenance status.")
union LabResourceMaintenanceStatus {
  @doc("The LabResource is not requested for maintenance.")
  MaintenanceNotRequested: "MaintenanceNotRequested",

  @doc("The LabResource is pending a requested maintenance.")
  MaintenancePending: "MaintenancePending",

  @doc("The LabResource is in maintenance.")
  InMaintenance: "InMaintenance",

  @doc("The LabResource is in exclusive access mode (not available for reservation).")
  ExclusiveAccess: "ExclusiveAccess",

  string,
}
