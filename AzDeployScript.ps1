New-AzResourceGroup -Name myResourceGroupInbal -Location "Central US" -force
New-AzResourceGroupDeployment -Name createtwotorate -ResourceGroupName myResourceGroupInbal -TemplateFile '.\template1 - 1.2.json' -force
New-AzResourceGroupDeployment -Name NewVM -ResourceGroupName myResourceGroupInbal -TemplateFile '.\VMTemplate.json' -TemplateParameterFile '.\VMTemplate.parameters.json'
