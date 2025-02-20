@discriminator("type")
@doc("The backing data source")
union ExternalReference {
  @doc("OneAsset backing data source")
  oneAssetReference: OneAssetReference,
}

@doc("The OneAsset id backing a resource")
model OneAssetReference {
  @visibility("read")
  @doc("OneAsset type")
  type: "OneAsset";

  @visibility("create", "read")
  @doc("The OneAsset configuration id")
  configId?: string;
}
