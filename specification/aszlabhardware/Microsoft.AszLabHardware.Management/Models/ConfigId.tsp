@discriminator("type")
@doc("The backing data source")
union ConfigId {
	@doc("OneAsset backing data source")
	oneAssetConfigId: OneAssetConfigId;
}

@doc("The OneAsset id backing a resource")
model OneAssetConfigId {
    @visibility("read")
    @doc("OneAsset type")
    type: "OneAsset";

    @visibility("create", "read")
	@doc("The data source id")
    dataSourceId?: string;
}