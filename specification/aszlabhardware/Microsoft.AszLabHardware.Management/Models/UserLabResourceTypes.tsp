@doc("Resource maintenance status.")
union UserLabResourceMaintenanceStatus {
  @doc("The Resource is not requested for maintenance.")
  MaintenanceNotRequested: "MaintenanceNotRequested",

  @doc("The Resource has been requested for maintenance.")
  MaintenanceRequested: "MaintenanceRequested",

  @doc("The Resource is in maintenance.")
  InMaintenance: "InMaintenance",

  @doc("The Resource is in exclusive access mode (not available for reservation).")
  ExclusiveAccess: "ExclusiveAccess",

  string,
}

@doc("Resource association status.")
union UserLabResourceAssociationStatus {
  @doc("The Resource is not associated with hardware in the lab.")
  NotAssociated: "NotAssociated",

  @doc("The Resource is associated with hardware in the lab.")
  Associated: "Associated",

  string,
}
