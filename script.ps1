$currentDir = $(Get-Location).Path
$oDFile = "$($currentDir)\Policy_Definitions_Assignment.csv"

if(Test-Path $oDFile){Remove-Item $oDFile -Force}
"display Name,policy Type,polResId,description,Policy Assignments,Assignment Count" | Out-File $oDFile -append -encoding ASCII
Get-AzPolicyDefinition | ForEach-Object{
	$displayName = $policyType = $action = $description = ""
	$displayName = $_.Properties.displayName
	$policyType = $_.Properties.policyType
	$policyDefinitionID = $_.Properties.policyDefinitionID
	$description = $_.Properties.description.replace(","," ")
    $action = $_.PolicyRule.effect	
"$displayName,$policyType,$polResId,$description" | Out-File $oDFile -append -encoding ASCII

	break
}