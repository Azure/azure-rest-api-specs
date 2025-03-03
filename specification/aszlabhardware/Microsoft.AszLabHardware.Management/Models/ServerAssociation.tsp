namespace Microsoft.AszLabHardware;

@doc("Details of the AszLabHw Reservation Server association.")
model ServerAssociation {
  @visibility("read", "create")
  @doc("The Server resource to be used for this constraint.")
  server: ServerResourceId;

  @visibility("read", "create")
  @doc("The serial number of the server to be reserved.")
  serialNumber?: string;

  @visibility("read", "create")
  @doc("The name of the server to be reserved.")
  name?: string;
}
