namespace ApiCenter.DataApi.Models;

@doc("Export specification")
model ExportSpecification {
  @doc("The result of the specification export.")
  value: string;
  
  @doc("The result format of the specification export.")
  format: string;
}