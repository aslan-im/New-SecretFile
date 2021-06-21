BeforeAll {
    Import-module .\..\New-SecretFile.psm1
}

Describe "Generating secret file" {
    it 'Shows login as TestLogin' {
        [string]$TestLogin = "TestLogin"
        $TestPassword = ConvertTo-SecureString "SuperStrongPassword" -AsPlainText -Force
        [string]$TestSecretPath = "$TestDrive\Secrets"

        New-SecretFile -SecretName "TestSecret" -Login $TestLogin -SecretPath $TestSecretPath -Password $TestPassword 

        $Credentials = Import-Clixml -Path "$TestSecretPath\TestSecret.xml"
        $Credentials.UserName | Should -be 'TestLogin'
    }
}