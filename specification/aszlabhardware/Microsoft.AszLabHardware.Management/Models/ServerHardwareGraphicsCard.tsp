@doc("Information about the graphics card")
model ServerHardwareGraphicsCard {
  @doc("The manufacturer of the GPU")
  manufacturer?: string;

  @doc("The model of the GPU")
  `model`?: string;

  @doc("The total VRAM of the GPU")
  memoryGb?: int32;
}
