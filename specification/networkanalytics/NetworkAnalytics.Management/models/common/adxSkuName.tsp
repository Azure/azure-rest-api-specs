using TypeSpec.Versioning;

namespace Microsoft.NetworkAnalytics;

@doc("The ADX SKU name options.")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
enum AdxSkuName {
  @doc("The Dev_No_SLA_Standard_D11_v2 SKU")
  Dev_No_SLA_Standard_D11_v2: "Dev(No SLA)_Standard_D11_v2",

  @doc("The Dev_No_SLA_Standard_E2a_v4 SKU")
  Dev_No_SLA_Standard_E2a_v4: "Dev(No SLA)_Standard_E2a_v4",

  @doc("The Standard_D11_v2 SKU")
  Standard_D11_v2: "Standard_D11_v2",

  @doc("The Standard_D12_v2 SKU")
  Standard_D12_v2: "Standard_D12_v2",

  @doc("The Standard_D13_v2 SKU")
  Standard_D13_v2: "Standard_D13_v2",

  @doc("The Standard_D14_v2 SKU")
  Standard_D14_v2: "Standard_D14_v2",

  @doc("The Standard_D32d_v4 SKU")
  Standard_D32d_v4: "Standard_D32d_v4",

  @doc("The Standard_D16d_v5 SKU")
  Standard_D16d_v5: "Standard_D16d_v5",

  @doc("The Standard_D32d_v5 SKU")
  Standard_D32d_v5: "Standard_D32d_v5",

  @doc("The Standard_DS13_v2_1TB_PS SKU")
  Standard_DS13_v2_1TB_PS: "Standard_DS13_v2+1TB_PS",

  @doc("The Standard_DS13_v2_2TB_PS SKU")
  Standard_DS13_v2_2TB_PS: "Standard_DS13_v2+2TB_PS",

  @doc("The Standard_DS14_v2_3TB_PS SKU")
  Standard_DS14_v2_3TB_PS: "Standard_DS14_v2+3TB_PS",

  @doc("The Standard_DS14_v2_4TB_PS SKU")
  Standard_DS14_v2_4TB_PS: "Standard_DS14_v2+4TB_PS",

  @doc("The Standard_L4s SKU")
  Standard_L4s: "Standard_L4s",

  @doc("The Standard_L8s SKU")
  Standard_L8s: "Standard_L8s",

  @doc("The Standard_L16s SKU")
  Standard_L16s: "Standard_L16s",

  @doc("The Standard_L8s_v2 SKU")
  Standard_L8s_v2: "Standard_L8s_v2",

  @doc("The Standard_L16s_v2 SKU")
  Standard_L16s_v2: "Standard_L16s_v2",

  @doc("The Standard_L8s_v3 SKU")
  Standard_L8s_v3: "Standard_L8s_v3",

  @doc("The Standard_L16s_v3 SKU")
  Standard_L16s_v3: "Standard_L16s_v3",

  @doc("The Standard_L32s_v3 SKU")
  Standard_L32s_v3: "Standard_L32s_v3",

  @doc("The Standard_L8as_v3 SKU")
  Standard_L8as_v3: "Standard_L8as_v3",

  @doc("The Standard_L16as_v3 SKU")
  Standard_L16as_v3: "Standard_L16as_v3",

  @doc("The Standard_L32as_v3 SKU")
  Standard_L32as_v3: "Standard_L32as_v3",

  @doc("The Standard_E64i_v3 SKU")
  Standard_E64i_v3: "Standard_E64i_v3",

  @doc("The Standard_E80ids_v4 SKU")
  Standard_E80ids_v4: "Standard_E80ids_v4",

  @doc("The Standard_E2a_v4 SKU")
  Standard_E2a_v4: "Standard_E2a_v4",

  @doc("The Standard_E4a_v4 SKU")
  Standard_E4a_v4: "Standard_E4a_v4",

  @doc("The Standard_E8a_v4 SKU")
  Standard_E8a_v4: "Standard_E8a_v4",

  @doc("The Standard_E16a_v4 SKU")
  Standard_E16a_v4: "Standard_E16a_v4",

  @doc("The Standard_E8as_v4_1TB_PS SKU")
  Standard_E8as_v4_1TB_PS: "Standard_E8as_v4+1TB_PS",

  @doc("The Standard_E8as_v4_2TB_PS SKU")
  Standard_E8as_v4_2TB_PS: "Standard_E8as_v4+2TB_PS",

  @doc("The Standard_E16as_v4_3TB_PS SKU")
  Standard_E16as_v4_3TB_PS: "Standard_E16as_v4+3TB_PS",

  @doc("The Standard_E16as_v4_4TB_PS SKU")
  Standard_E16as_v4_4TB_PS: "Standard_E16as_v4+4TB_PS",

  @doc("The Standard_E8as_v5_1TB_PS SKU")
  Standard_E8as_v5_1TB_PS: "Standard_E8as_v5+1TB_PS",

  @doc("The Standard_E8as_v5_2TB_PS SKU")
  Standard_E8as_v5_2TB_PS: "Standard_E8as_v5+2TB_PS",

  @doc("The Standard_E16as_v5_3TB_PS SKU")
  Standard_E16as_v5_3TB_PS: "Standard_E16as_v5+3TB_PS",

  @doc("The Standard_E16as_v5_4TB_PS SKU")
  Standard_E16as_v5_4TB_PS: "Standard_E16as_v5+4TB_PS",

  @doc("The Standard_E2ads_v5 SKU")
  Standard_E2ads_v5: "Standard_E2ads_v5",

  @doc("The Standard_E4ads_v5 SKU")
  Standard_E4ads_v5: "Standard_E4ads_v5",

  @doc("The Standard_E8ads_v5 SKU")
  Standard_E8ads_v5: "Standard_E8ads_v5",

  @doc("The Standard_E16ads_v5 SKU")
  Standard_E16ads_v5: "Standard_E16ads_v5",

  @doc("The Standard_EC8as_v5_1TB_PS SKU")
  Standard_EC8as_v5_1TB_PS: "Standard_EC8as_v5+1TB_PS",

  @doc("The Standard_EC8as_v5_2TB_PS SKU")
  Standard_EC8as_v5_2TB_PS: "Standard_EC8as_v5+2TB_PS",

  @doc("The Standard_EC16as_v5_3TB_PS SKU")
  Standard_EC16as_v5_3TB_PS: "Standard_EC16as_v5+3TB_PS",

  @doc("The Standard_EC16as_v5_4TB_PS SKU")
  Standard_EC16as_v5_4TB_PS: "Standard_EC16as_v5+4TB_PS",

  @doc("The Standard_EC8ads_v5 SKU")
  Standard_EC8ads_v5: "Standard_EC8ads_v5",

  @doc("The Standard_EC16ads_v5 SKU")
  Standard_EC16ads_v5: "Standard_EC16ads_v5",

  @doc("The Standard_E8s_v4_1TB_PS SKU")
  Standard_E8s_v4_1TB_PS: "Standard_E8s_v4+1TB_PS",

  @doc("The Standard_E8s_v4_2TB_PS SKU")
  Standard_E8s_v4_2TB_PS: "Standard_E8s_v4+2TB_PS",

  @doc("The Standard_E16s_v4_3TB_PS SKU")
  Standard_E16s_v4_3TB_PS: "Standard_E16s_v4+3TB_PS",

  @doc("The Standard_E16s_v4_4TB_PS SKU")
  Standard_E16s_v4_4TB_PS: "Standard_E16s_v4+4TB_PS",

  @doc("The Standard_E8s_v5_1TB_PS SKU")
  Standard_E8s_v5_1TB_PS: "Standard_E8s_v5+1TB_PS",

  @doc("The Standard_E8s_v5_2TB_PS SKU")
  Standard_E8s_v5_2TB_PS: "Standard_E8s_v5+2TB_PS",

  @doc("The Standard_E16s_v5_3TB_PS SKU")
  Standard_E16s_v5_3TB_PS: "Standard_E16s_v5+3TB_PS",

  @doc("The Standard_E16s_v5_4TB_PS SKU")
  Standard_E16s_v5_4TB_PS: "Standard_E16s_v5+4TB_PS",

  @doc("The Standard_E2d_v4 SKU")
  Standard_E2d_v4: "Standard_E2d_v4",

  @doc("The Standard_E4d_v4 SKU")
  Standard_E4d_v4: "Standard_E4d_v4",

  @doc("The Standard_E8d_v4 SKU")
  Standard_E8d_v4: "Standard_E8d_v4",

  @doc("The Standard_E16d_v4 SKU")
  Standard_E16d_v4: "Standard_E16d_v4",

  @doc("The Standard_E2d_v5 SKU")
  Standard_E2d_v5: "Standard_E2d_v5",

  @doc("The Standard_E4d_v5 SKU")
  Standard_E4d_v5: "Standard_E4d_v5",

  @doc("The Standard_E8d_v5 SKU")
  Standard_E8d_v5: "Standard_E8d_v5",

  @doc("The Standard_E16d_v5 SKU")
  Standard_E16d_v5: "Standard_E16d_v5",
}
