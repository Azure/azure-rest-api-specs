namespace Microsoft.AszLabHardware;

@doc("Details of the AszLabHw Reservation Server association.")
model ServerAssociation {
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("The Server resource to be used for this constraint.")
  server: ServerResourceId;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("The serial number of the server to be reserved.")
  serialNumber?: string;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("The name of the server to be reserved.")
  name?: string;
}
