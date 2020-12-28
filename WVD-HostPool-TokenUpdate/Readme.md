You May directly use this pipeline into your project.  be sure to edit the following:

$AzureKeyVaultName = <name of your keyvault>

$HostpoolTokenSecretName = <name of the keyvault secret>

$HostpoolName = <Name of your HostPool>

$ResourceGroup = <Name of the resource group where the Hostpool is deployed>

Change the expiration time as per your need (default is set to 6 hours) (Linn 24)


Link to Blog: https://v-desktops.com/2020/12/28/azure-pipeline-import-wvd-hostpool-token-into-azure-secrets/