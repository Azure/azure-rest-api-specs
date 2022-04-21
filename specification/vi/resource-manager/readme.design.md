# VideoIndexer Resource Provider

## Purpose
### Problem statement 

Azure Video Analyzer for Medianalyzer for Media is managed as stand-alone product outside Azure Video Analyzer for Medianalyzer for Mediause Video Indexer today:
  * Customers create a trial Azure Video Analyzer for Media account through the Azure Video Analyzer for Media portal or through API     portal (managed by APIM). 
  * Customers create a paid Azure Video Analyzer for Media account through the Azure Video Analyzer for Media portal. The account is connected to their Media Services account and then they create an APIM subscription to access it through APIs. 
These is a complicated flow and is difficult for customers and partners to manage. 

In addition, Azure Video Analyzer for Media uses AAD application IDs and secrets to connect to customers’ Azure resources such as Custom Vision, Media Services, Key Vault, and more are planned to be introduced. This method of authentication is error prone, requires ongoing maintenance and not a security best practice. 

Finally, for Azure Video Analyzer for Media to meet Azure enterprise promises it must become an Azure resource as a pre-condition  

### Benefit and Impact  

Managing Azure Video Analyzer for Media in the Azure portal using ARM will allow customers and partners to manage their Azure Video Analyzer for Media account same as they manage all their Azure resources and will create a better experience for them. In addition, customers and partners will be able to use ARM templates and CLIs to create and manage a VI account.  

Customers will also gain a more secure solution - Azure Video Analyzer for Media will be able to use a managed identity to connect to other Azure resources in the future, which is the safe and recommended way to work with Azure resources. Managed identities eliminate the need for VI to store customer secrets and eliminate the customer’s need for maintaining and rotating these secrets. In addition, managed identities require less permissions from the customer and allow them to create a Azure Video Analyzer for Media account more easily. 

In addition having Azure Video Analyzer for Media in ARM will enable customers to create private links to secure their calls to Azure Video Analyzer for Media. 

Being a resource in Azure will also allow Azure Video Analyzer for Media to create more integrations required as part of Fulcrum - in the Azure Support Portal (the customer facing portal), and the Azure Support Center (the CSS facing portal). As a resource in Azure, it will also be visible in the Azure Resource Explorer- which is also used by CSS when working on customer cases. 

### Why now?  

To meet enterprise promises Azure Video Analyzer for Media is required to have secured integrations between the resources, which can only be achieved by being a resource in Azure and managed by ARM. 

Private links require VI to be an ARM resource, CMK requires integration with the customer’s Key Vault and the most secure manner is managed identities. In addition, integrations with Custom Vision and Media Services would become more trivial and less error prone with managed identities. Lastly, Face API resource that is CMK enabled do not plan to support authentication means other than MI. 

### Requirements 

The goal is to move the Azure Video Analyzer for Media’s account management and RBAC to Azure portal and ARM API with its own resource provider. This will only be relevant for paid accounts and not for trial account since trial users don’t necessarily have Azure subscriptions. The process of managing users in trial accounts won't change and wont be part of ARM. 

Users will be able to easily create, manage and delete a Azure Video Analyzer for Media account through the Azure portal \ using an ARM template \ using CLI. Account management will not be available via the VI portal anymore.  

## Type Model
Resource provider namespace: Microsoft.VideoIndexer
Resource type: accounts. <b><u>type model is still under develop.</u></b>. The resource type properties can be found [here](./Microsoft.VideoIndexer/preview/2021-11-10-preview/vi.json#L413)