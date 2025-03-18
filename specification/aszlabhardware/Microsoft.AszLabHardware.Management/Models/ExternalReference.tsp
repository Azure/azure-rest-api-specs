@discriminated(#{ discriminatorPropertyName: "type", envelope: "none" })
@doc("The backing data source")
union ExternalReference {
  @doc("OneAsset backing data source")
  OneAsset: OneAssetReference,
}

@doc("The OneAsset id backing a resource")
model OneAssetReference {
  @visibility(Lifecycle.Read)
  @doc("OneAsset type")
  type: "OneAsset";

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The OneAsset configuration id")
  configId?: string;
}
