```ps1
# npx tsv .
cd C:\Work\azure-rest-api-specs-pr\RPSaaSMaster\specification\liftrcommvault\Commvault.ContentStore.Management\; npx tsv .

# npx oav generate-examples .\commvault.json
cd C:\Work\azure-rest-api-specs-pr\RPSaaSMaster\specification\liftrcommvault\resource-manager\Commvault.ContentStore\preview\2024-10-01-preview\; npx oav generate-examples .\commvault.json

# python .\scripts\updateFromHints.py ..\resource-manager\Commvault.ContentStore\preview\2024-10-01-preview\examples .\scripts\hints.txt
cd C:\Work\azure-rest-api-specs-pr\RPSaaSMaster\specification\liftrcommvault\Commvault.ContentStore.Management\; python .\scripts\updateFromHints.py ..\resource-manager\Commvault.ContentStore\preview\2024-10-01-preview\examples .\scripts\hints.txt

# npx oav validate-example .\commvault.json
cd C:\Work\azure-rest-api-specs-pr\RPSaaSMaster\specification\liftrcommvault\resource-manager\Commvault.ContentStore\preview\2024-10-01-preview\; npx oav validate-example .\commvault.json


```