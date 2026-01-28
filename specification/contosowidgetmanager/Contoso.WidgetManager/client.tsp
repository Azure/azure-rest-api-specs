import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Contoso.WidgetManager;
using Azure.ClientGenerator.Core;

@@clientName(Widgets, "ContosoWidgets", "csharp");

// Python-specific customizations

// Rename FakedSharedModel to FakedShared (remove "Model" suffix)
@@clientName(FakedSharedModel, "FakedShared", "python");

// Rename widgetName path parameter to name (remove "widget_" prefix)
// Note: The property is already called 'name', but the @key decorator creates 'widgetName' parameter
// For Python, we want the parameter to be just 'name' without the 'widget_' prefix
@@clientName(WidgetSuite.name, "name", "python");

// Make getWidgetOperationStatus internal (not part of public API)
@@access(Widgets.getWidgetOperationStatus, Access.internal, "python");
