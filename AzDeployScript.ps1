New-AzResourceGroup -Name myResourceGroupInbal06 -Location "Central US"
New-AzResourceGroupDeployment -Name TwoStorateAccounts01 -ResourceGroupName myResourceGroupInbal06 -TemplateFile '.\template1 - 1.2.json'
New-AzResourceGroupDeployment -Name NewVMTest00 -ResourceGroupName myResourceGroupInbal06 -TemplateFile '.\VMTemplate.json' -TemplateParameterFile '.\VMTemplate.parameters.json'
