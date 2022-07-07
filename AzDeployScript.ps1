New-AzResourceGroup -Name myResourceGroupInbal02 -Location "Central US"
New-AzResourceGroupDeployment -Name TwoStorateAccounts01 -ResourceGroupName myResourceGroupInbal02 -TemplateFile '.\template1 - 1.2.json'
New-AzResourceGroupDeployment -Name NewVMTest00 -ResourceGroupName myResourceGroupInbal02 -TemplateFile '.\VMTemplate.json' -TemplateParameterFile '.\VMTemplate.parameters.json'