provider "local" {}

resource "null_resource" "install_iis " {
  provisioner "local-exec" {
    command = "powershell.exe Install-WindowsFeature -Name Web-Server -IncludeManagementTools"
  }
}

resource "null_resource" "deploy_website" {
  depends_on = [null_resource.install_iis]
  provisioner "local-exec" {
    command = "xcopy /s /y website C:\\inetpub\\wwwroot\\mywebsite"
  }
}

resource "null_resource" "restart_iis" {
  depends_on = [null_resource.deploy_website]
  provisioner "local-exec" {
    command = "iisreset"
  }
}
