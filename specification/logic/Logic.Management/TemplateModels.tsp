import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

namespace Microsoft.Logic;

@doc("The flow template connector details.")
model TemplateProperties {

  @doc("The provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkflowProvisioningState;

  @doc("The flow template state.")
  state?: FlowTemplateState;

  @doc("The flow template type.")
  manifest?: FlowTemplateManifest;
}

@doc("The flow template state.")
union FlowTemplateState {
  string,
  @doc("The flow template is in the draft state.")
  NotSpecified: "NotSpecified",
  @doc("The flow template is in the development state.")
  Development: "Development",
  @doc("The flow template is in the testing state.")
  Testing: "Testing",
  @doc("The flow template is in the production state.")
  Production: "Production",
}

@doc("The flow template sku.")
union FlowTemplateSku {
  string,
  @doc("The flow template sku is none.")
  None: "None",
  @doc("The flow template sku is consumption.")
  Consumption: "Consumption",
  @doc("The flow template sku is standard.")
  Standard: "Standard",
}

@doc("The flow template type.")
union FlowTemplateType {
  string,
  @doc("The flow template type is not specified.")
  NotSpecified: "NotSpecified",
  @doc("The flow template type is workflow.")
  Workflow: "Workflow",
  @doc("The flow template type is accelerator.")
  Accelerator: "Accelerator",
}

@doc("The template properties.")
model FlowTemplateConnectorDetails {

  @doc("The identifier.")
  id?: string;

  @doc("The kind.")  
  kind?: string;
}

@doc("The template details.")
model FlowTemplateDetails {
  @doc("The template author.")
  by?: string;

  @doc("The template category.")  
  category?: string;
}

@doc("The flow template manifest.")
model FlowTemplateManifest {
  @doc("The title.")
  title?: string;
  @doc("The description.")
  description?: string;
  @doc("The summary.")
  summary?: string;
  @doc("The flow template type.")
  type?: FlowTemplateType;
  @doc("The flow template supported sku.")
  supportedSku?: FlowTemplateSku;
  @doc("The flow template connector details.")
  featuredConnectors?: FlowTemplateConnectorDetails;
  @doc("The flow template details.")
  details?: FlowTemplateDetails;
}