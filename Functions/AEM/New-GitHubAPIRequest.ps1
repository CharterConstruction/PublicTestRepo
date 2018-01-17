Function New-GitHubAPIRequest
    {
        Param(
            [Parameter(Mandatory=$true)]$URL,
            [Parameter(Mandatory=$true)]$Token,
            [Parameter(Mandatory=$false)]$FilePath
        )
        $params = @{
                Uri         =	$URL
		        Method      =	'GET'
		        ContentType	= 	'application/vnd.github.v3+json'
		        Headers     =	@{ 'Authorization'= 'token ' + $Token }
	        }
            
            If($FilePath -eq $null){
                Try{ $Response = Invoke-WebRequest @params }Catch{ "Error with Invoke-WebRequest!" | Write }
                $Content = ConvertFrom-JSON($Response.Content)
                Return $Content
            }
            Else{
                Invoke-WebRequest @params | Out-File -FilePath $FilePath            
                If($?){ $Content = $FilePath + (Test-Path $FilePath).ToString() }
            }            
            Return $Content
        }