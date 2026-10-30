import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Contoso.WidgetOpenPrVerification;
using Azure.ClientGenerator.Core;

@@clientName(Widgets, "ContosoWidgets", "csharp");
