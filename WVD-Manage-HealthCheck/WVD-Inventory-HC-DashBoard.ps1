<# Summary:

Script Version: 1.0 
Script created in Powershell Version: v5.0
Powershell Modules required: Microsoft.RDInfra.RDPowerShell 
Time Taken to write this script and test : ~1.5 hours

This Script is written by Surendra D M, You may use this script as you wish. If you wish to contribute to the script, comment, or have suggestions reach out to: 
Https://v-desktops.com vdesktops@gmail.com

#>

function writehtml
{
param($RDSSessionHostData, $appgroupdata, $HostpoolData, $workspacedata, $OutputFilePath, $RDSSessionHostHeaders, $appgroupheaders, $HostpoolHeaders, $workspaceheaders, $title)

$OutputFilePath = $OutputFilePath + "\" + "$title" + ".html"

$date = (Get-Date -format R)
$html ="
<html>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>
<title>$title</title>
<STYLE TYPE=""text/css"">
<!--
td {
font-family: Tahoma;
font-size: 11px;
border-top: 1px solid #999999;
border-right: 1px solid #999999;
border-bottom: 1px solid #999999;
border-left: 1px solid #999999;
padding-top: 0px;
padding-right: 0px;
padding-bottom: 0px;
padding-left: 0px;
overflow: hidden;
}
body {
margin-left: 5px;
margin-top: 5px;
margin-right: 0px;
margin-bottom: 10px;
table {
table-layout:fixed; 
border: thin solid #000000;
}
-->
</style>
</head>
<body>
<table width='1200'>
<tr bgcolor='#CCCCCC'>
<td colspan='7' height='48' align='center' valign=""middle"">
<font face='tahoma' color='#003399' size='4'>
<strong>$title - $date</strong></font>
</td>
</tr>
</table>
<br>
<br>
"


#########################################################

#Start of table creation

#Tenant Table

$html +="
<table width='1200'>
<tr bgcolor='#CCCCCC'>
<td colspan='7' height='48' align='center' valign=""middle"">
<font face='tahoma' color='#003399' size='4'>
<strong>WVD Workspace Info</strong></font>
</td>
</tr>
</table>
<table width='1200'>
<tr bgcolor='#CCCCCC'>
"

foreach ($header in $workspaceheaders)
{
$html+="<td><strong>$header</strong></td>"
}

$html+="</tr>"

foreach($info in $workspacedata)
{
if($info.errors -eq "OK")
{
$html+= "<tr bgcolor='#35ea42'> "
}
elseif($info.errors -eq "Warning")
{
$html+= "<tr bgcolor='#f9a852'> "
}
elseif($info.errors -eq "Error")
{
$html+="<tr bgcolor='#fc483f'>"
}
else
{
$html+="<tr>"
}

foreach($header in $workspaceheaders)
{

$html+="<td>" +  $info.$header +  "</td>"
}
$html+="</tr>"
}

$html += "</table>
<br>
<br>"

############################################################

#Hostpool Table 
$html+="
<table width='1200'>
<tr bgcolor='#CCCCCC'>
<td colspan='7' height='48' align='center' valign=""middle"">
<font face='tahoma' color='#003399' size='4'>
<strong>Hostpool Information</strong></font>
</td>
</tr>
</table>
<table width='1200'>
<tr bgcolor='#CCCCCC'>
"
foreach ($header in $HostpoolHeaders)
{
$html+="<td><strong>$header</strong></td>"
}

$html+="</tr>"

foreach($info in $Hostpooldata)
{
if($info.errors -eq "OK")
{
$html+= "<tr bgcolor='#35ea42'> "
}
elseif($info.errors -eq "Warning")
{
$html+= "<tr bgcolor='#f9a852'> "
}
elseif($info.errors -eq "Error")
{
$html+="<tr bgcolor='#fc483f'>"
}
else
{
$html+="<tr>"
}

foreach($header in $HostpoolHeaders)
{

$html+="<td>" +  $info.$header +  "</td>"
}
$html+="</tr>"
}


$html+="</tr>"

$html += "</table>
<br>
<br>"



#AppGroups Table 

$html+="
<table width='1200'>
<tr bgcolor='#CCCCCC'>
<td colspan='7' height='48' align='center' valign=""middle"">
<font face='tahoma' color='#003399' size='4'>
<strong>AppGroup Information</strong></font>
</td>
</tr>
</table>
<table width='1200'>
<tr bgcolor='#CCCCCC'>
"
foreach ($header in $appgroupheaders)
{

$html+="<td><strong>$header</strong></td>"
}

$html+="</tr>"

foreach($info in $appgroupdata)
{

if($info.errors -eq "OK")
{
$html+= "<tr bgcolor='#35ea42'> "
}
elseif($info.errors -eq "Warning")
{
$html+= "<tr bgcolor='#f9a852'> "
}
elseif($info.errors -eq "Error")
{
$html+="<tr bgcolor='#fc483f'>"
}
else
{
$html+="<tr>"
}

foreach($header in $appgroupheaders)
{

$html+="<td>" +  $info.$header +  "</td>"
}
$html+="</tr>"
}


$html+="</tr>"

$html += "</table>
<br>
<br>"


#RDS Session Host Table
$html+="
<table width='1200'>
<tr bgcolor='#CCCCCC'>
<td colspan='7' height='48' align='center' valign=""middle"">
<font face='tahoma' color='#003399' size='4'>
<strong>RDS Session Host Information</strong></font>
</td>
</tr>
</table>
<table width='1200'>
<tr bgcolor='#CCCCCC'>
"
foreach ($header in $RDSSessionHostHeaders)
{

$html+="<td><strong>$header</strong></td>"
}

$html+="</tr>"

foreach($info in $RDSSessionHostData)
{

if($info.errors -eq "OK")
{
$html+= "<tr bgcolor='#35ea42'> "
}
elseif($info.errors -eq "Warning")
{
$html+= "<tr bgcolor='#f9a852'> "
}
elseif($info.errors -eq "Error")
{
$html+="<tr bgcolor='#fc483f'>"
}
else
{
$html+="<tr>"
}

foreach($header in $RDSSessionHostHeaders)
{

$html+="<td>" +  $info.$header +  "</td>"
}
$html+="</tr>"
}


$html+="</tr>"

$html += "</table>"


$html +="</html>"
$html > $OutputFilePath
}

# Main function - begins
# Connect the powershell client to the Azure Account  
Connect-AzAccount


# Provide Output Path 
# Format: "C:\users\admin\Desktop"
# Update this path before you execute the script!!!!!!!!

$OutPutPath = "C:\WVDOutPuts"

#Collect Data on WVD Workspaces
$WorkSpaces = Get-AzWvdWorkspace 
$workspacedata = @()
$workspaceheaders = "WorkSpaceName","Location"
foreach($WorkSpace in $Workspaces)
{
try
{
write-host "Fetching the WVD Workspaces"
$workspacedata += @{WorkSpaceName = $WorkSpace.Name; Location = $WorkSpace.Location} 
}
catch
{
}
}
$workspacedata

#Capture Hostpool Data and Session Hosts Data together
$hostpoolheaders = "HostPoolName","HostPoolType","LoadBalancerType","CustomRDPProperty","isValidationEnvironment","StartVMOnConnect","MaxSessionlimit"
$RDSSessionHostHeaders = "SessionHostName","LastHeartBeat","Status","ActiveSessions","AllowNewSessions"
$RDSSessionHostData = @()
$hostpooldata = @()
$HostPools = Get-AzWvdHostPool | Select *
foreach($hostpool in $HostPools)
{
$hostpooldata += @{HostPoolName  = $hostpool.Name; HostPoolType = $hostpool.HostPoolType; LoadBalancerType = $hostpool.LoadBalancerType; CustomRDPProperty = $hostpool.CustomRdpProperty; isValidationEnvironment = $hostpool.ValidationEnvironment; StartVMOnConnect = $hostpool.StartVMOnConnect; MaxSessionlimit=$hostpool.MaxSessionLimit}
$resourcegroup = $hostpool.Id.Split("//")[4]
$sessionhosts = Get-AzWvdSessionHost -HostPoolName $hostpool.Name -ResourceGroupName $resourcegroup | select *
foreach($sessionhost in $sessionhosts)
{
if($sessionhost.Status -ne "Available")
{
$RDSSessionHostData += @{SessionHostName=$sessionhost.id.split("//")[-1];LastHeartBeat=$sessionhost.LastHeartBeat;Status=$sessionhost.Status;ActiveSessions=$sessionhost.session;AllowNewSessions=$sessionhost.AllowNewSession;Errors="error"}
}
elseif($sessionhost.AllowNewSession -ne "True")
{
$RDSSessionHostData += @{SessionHostName=$sessionhost.id.split("//")[-1];LastHeartBeat=$sessionhost.LastHeartBeat;Status=$sessionhost.Status;ActiveSessions=$sessionhost.session;AllowNewSessions=$sessionhost.AllowNewSession;Errors="warning"}
}
else
{
$RDSSessionHostData += @{SessionHostName=$sessionhost.id.split("//")[-1];LastHeartBeat=$sessionhost.LastHeartBeat;Status=$sessionhost.Status;ActiveSessions=$sessionhost.session;AllowNewSessions=$sessionhost.AllowNewSession;Errors="OK"}
}
}
$hostpooldata += @{HostPoolName  = $hostpool.Name; HostPoolType = $hostpool.HostPoolType; LoadBalancerType = $hostpool.LoadBalancerType; CustomRDPProperty = $hostpool.CustomRdpProperty; isValidationEnvironment = $hostpool.ValidationEnvironment; StartVMOnConnect = $hostpool.StartVMOnConnect }
}

#Capture Application Group Information
$appgroupheaders = "AppGroupName","AppGroupType","WorkSpace","HostPool"
$appgroupdata = @()
$AppGroups = Get-AzWvdApplicationGroup | Select *
foreach($appgroup in $AppGroups)
{
$workspacename = $appgroup.WorkspaceArmPath.split("//")[-1]
$Hostpoolname = $appgroup.HostPoolArmPath.split("//")[-1]
$appgroupdata += @{AppGroupName  = $appgroup.Name; AppGroupType = $appgroup.ApplicationGroupType; WorkSpace = $workspacename; HostPool = $Hostpoolname}
}

writehtml -workspacedata $workspacedata -workspaceheaders $workspaceheaders -HostpoolData $hostpooldata -OutputFilePath $OutPutPath -HostpoolHeaders $HostPoolHeaders -title "WVD Documentation" -appgroupdata $appgroupdata -appgroupheaders $appgroupheaders -RDSSessionHostData $RDSSessionHostData -RDSSessionHostHeaders $RDSSessionHostHeaders