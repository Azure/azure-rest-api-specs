@doc("Information about the network card")
model ServerHardwareNetworkCard {
  @doc("The manufacturer of the network card")
  manufacturer?: string;

  @doc("The model of the network card")
  `model`?: string;

  @doc("The MAC address of the network card")
  macAddress?: string;

  @doc("The speed of the network card")
  speedMbps?: int32;
}
