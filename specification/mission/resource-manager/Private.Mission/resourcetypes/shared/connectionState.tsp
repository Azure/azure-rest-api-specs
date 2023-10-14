@doc("Specifies the state of the connection.")
enum ConnectionState {
  @doc("ConnectionState Type Pending Approval")
  PendingApproval,

  @doc("ConnectionState Type Pending Update")
  PendingUpdate,

  @doc("ConnectionState Type Approved")
  Approved,

  @doc("ConnectionState Type Active")
  Active,

  @doc("ConnectionState Type Failed")
  Failed,
}
