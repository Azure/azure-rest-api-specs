@doc("Class to represent the Product Support Status.")
model ProductSupportStatus {
  @doc("Gets or sets current version of ServicePack.")
  @visibility(Lifecycle.Read)
  currentVersion?: string;

  @doc("Gets or sets ServicePack of the product.")
  @visibility(Lifecycle.Read)
  servicePackStatus?: string;

  @doc("Gets or sets the Extended Security Update ESU status.")
  @visibility(Lifecycle.Read)
  esuStatus?: string;

  @doc("Gets or sets the support status of the product.")
  @visibility(Lifecycle.Read)
  supportStatus?: string;

  @doc("Gets or sets the ETA.")
  @visibility(Lifecycle.Read)
  eta?: int32;

  @doc("Gets or sets the current ESU support year.")
  @visibility(Lifecycle.Read)
  currentEsuYear?: string;

  @doc("Gets or sets the main stream end date of the product.")
  @visibility(Lifecycle.Read)
  mainstreamEndDate?: utcDateTime;

  @doc("Gets or sets the extended support end date of the product.")
  @visibility(Lifecycle.Read)
  extendedSupportEndDate?: utcDateTime;

  @doc("Gets or sets the extended security update year 1 end date of the product.")
  @visibility(Lifecycle.Read)
  extendedSecurityUpdateYear1EndDate?: utcDateTime;

  @doc("Gets or sets the extended security update year 2 end date of the product.")
  @visibility(Lifecycle.Read)
  extendedSecurityUpdateYear2EndDate?: utcDateTime;

  @doc("Gets or sets the extended security update year 3 end date of the product.")
  @visibility(Lifecycle.Read)
  extendedSecurityUpdateYear3EndDate?: utcDateTime;
}
