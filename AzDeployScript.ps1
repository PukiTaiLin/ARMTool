New-AzResourceGroup -Name myResourceGroupInbal -Location "Central US"
New-AzResourceGroupDeployment -Name createTwoStorateAccounts -ResourceGroupName myResourceGroupInbal -TemplateFile '.\template1 - 1.2.json'
New-AzResourceGroupDeployment -Name NewVM -ResourceGroupName myResourceGroupInbal -TemplateFile '.\VMTemplate.json' -TemplateParameterFile '.\VMTemplate.parameters.json'
