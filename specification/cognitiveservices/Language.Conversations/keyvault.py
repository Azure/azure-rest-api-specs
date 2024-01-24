remove = "Remove-AzKeyVaultAccessPolicy -VaultName {vaultName} -ObjectId 0192db63-3cfc-477f-aeb7-e392294893d5"
set = "Set-AzKeyVaultAccessPolicy -VaultName {vaultName} -ObjectId 0192db63-3cfc-477f-aeb7-e392294893d5 -ApplicationId 5b306cba-9c71-49db-96c3-d17ca2379c4d -PermissionsToSecrets Get,Set"

vaultNames = ["ta-vault-ame-sec", "ta-vault-pre-use2", "ta-vault-ame-jpe", "ta-vault-ame-brs", "ta-vault-ame-usw", "ta-vault-ame-sww", "ta-vault-ame-swn", "ta-vault-ame-inc", "ta-vault-ame-aue", "ta-vault-ame-usw3", "ta-vault-ame-use2x", "ta-vault-ame-use", "ta-vault-ame-san", "ta-vault-ame-qac", "ta-vault-ame-noe", "ta-vault-ame-cac", "ta-vault-ame-ae", "ta-vault-ame-weu", "ta-vault-ame-usnc", "ta-vault-ame-jpw", "ta-vault-ame-gwc", "ta-vault-ame-use2", "ta-vault-ame-uscx", "ta-vault-ame-uks", "ta-vault-ame-cae", "ta-vault-ame-fc", "ta-vault-ame-ase", "ta-vault-ame-usc", "ta-vault-ame-uaen", "ta-vault-ame-neu", "ta-vault-ame-usw2", "ta-vault-ame-jinw", "ta-vault-ame-kc", "ta-vault-ame-ussc", "ta-vault-ame-uswc"]



for vaultName in vaultNames:
    print(remove.format(vaultName=vaultName))
    print(set.format(vaultName=vaultName))
    print()