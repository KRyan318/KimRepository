# This script will add or remove a named Site Collection Administrator
# to all Site Collections within a Web Application.
#
# Author: Henry Ong
######################## Start Variables ########################
$newSiteCollectionAdminLoginName = "FUSIONSYSTEMS\Kim"
$newSiteCollectionAdminEmail = "kim@fusionconsulting.com"
$newSiteCollectionAdminName = "Kim"
$newSiteCollectionAdminNotes = ""
$siteURL = "https://portal.fusionconsulting.com" #URL to any site in the web application.
$add = 1 # 1 for adding this user, 0 to remove this user
######################## End Variables ########################
Clear-Host
$siteCount = 0
[system.reflection.assembly]::loadwithpartialname("Microsoft.SharePoint")
$site = new-object microsoft.sharepoint.spsite($siteURL)
$webApp = $site.webapplication
$allSites = $webApp.sites
foreach ($site in $allSites)
{
    
    $web = $site.openweb()
    $web.allusers.add($newSiteCollectionAdminLoginName, $newSiteCollectionAdminEmail, $newSiteCollectionAdminName, $newSiteCollectionAdminNotes)
    $user = $web.allUsers[$newSiteCollectionAdminLoginName]
    $user.IsSiteAdmin = $add
    $user.Update()
    $web.Dispose()
    $siteCount++
}
$site.dispose()
write-host "Updated" $siteCount "Site Collections."