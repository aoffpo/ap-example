az login

$azureDevopsResourceId = "*******"
$token = az account get-access–token —resource $azureDevopsResourceId | ConvertFrom-Json
$authValue = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes(":" + $token.accessToken))

$headers = @{
    Authorization = "Basic $authValue";
    'X-VSS-ForceMsaPassThrough' = $true
}

$organization = "myorg"
$pipelineRunUrl = "https://dev.azure.com/$organization/_apis/projects"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-RestMethod –Uri $pipelineRunUrl –Method GET –Headers $headers –ContentType 'application/json' –Verbose