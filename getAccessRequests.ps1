#This script lists all subsites in each site collection. Run as Farm if you get accessed denied on any of the sites. 
[System.Reflection.Assembly]::Load(“Microsoft.SharePoint, Version=12.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c”) | out-null
Start-SPAssignment
cls
$webapp = [Microsoft.SharePoint.Administration.SPWebApplication]::Lookup("http://portal")
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint")
$farm = [Microsoft.SharePoint.Administration.SPFarm]::Local
$websvcs = $farm.Services | where -FilterScript {$_.GetType() -eq [Microsoft.SharePoint.Administration.SPWebService]}
$webapps = @()
foreach ($websvc in $websvcs) {
    foreach ($webapp in $websvc.WebApplications) {
        $webapps = $webapps + $webapp
#		Write-Host "=================================================================================="
#		Write-Host "Web Application: "$webApp.Name
#		Write-Host "=================================================================================="
   			foreach ($site in $webapp.Sites) { 
				Write-Host "Site Collection URL: "$site.Url
#				Write-Host "Site Collection Owner: "$site.Owner
#				Write-Host "Last Security Modified Date: "$site.LastSecurityModifiedDate
#				Write-Host "Last Content Modified Date/Time in this Site Collection: "$site.LastContentModifiedDate
#				Write-Host "Web Application: "$site.WebApplication
#				Write-Host "---------------------------------------------------------------------------"
					foreach ($web in $site.AllWebs) { 
						Write-Host "Subsite Title: "$web.title"`n"
						Write-Host "URL: "$web.url"`n"
#						Write-Host "Is this the root web? "$web.IsRootWeb
#						Write-Host "Parent web (will be blank if this is root web): "$web.ParentWeb
#						Write-Host "Created by: "$web.Author
#						Write-Host "Created on: "$web.Created
#						Write-Host "Last item modified in this subsite: "$web.LastItemModifiedDate
#						Write-Host "Subsites underneath this one: "$web.Webs
						Write-Host "Has unique permissions?" $web.HasUniquePerm"`n"
						Write-Host "Are access requests enabled? "$web.RequestAccessEnabled"`n"
						Write-Host "Access requests sent to:"$web.RequestAccessEmail"`n"
						Write-Host "-------------------------------------------------------------------------""`r`n`r`n"`
#							foreach ($list in $web.Lists) {
#								Write-Host "Library/List: "$list.Title
#								Write-Host "Default View URL: "$list.DefaultViewUrl
#								Write-Host "Created by: "$list.Author
#								Write-Host "Created on: "$list.Created
#								Write-Host "Last Item Modified: "$list.LastItemModifiedDate
#								Write-Host "Total number of items: "$list.ItemCount								
#								}
								}
										
    }
}
}
$webapp.Dispose
$farm.Dispose
$websvcs.Dispose
$websvc.Dispose
Stop-SPAssignment -Global