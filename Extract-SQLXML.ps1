
$cred = Get-Credential

# Source details
$servername = 'DESKTOP-V4ACJJA\SQL19'
$databasename = 'XMLTest'
$tablename = 'tablewithxml'
$col_id = 'id'
$col_xml = 'xmlcol'

# UPDATE THIS WITH SELECT OR STORED PROC NAME
$sqlcmd = "SELECT * FROM " + $tablename

# Target details
$targetfolder = 'C:\Ben\xmlout\'
$targetprefix = 'pre_'
$targetsuffix = '_post'

# ------------------------------------------------
# Establish a connection
$sqlConn = New-Object System.Data.SqlClient.SqlConnection;
$sqlConn.ConnectionString = "Server=" + $servername + ";user id=" + $cred.UserName + ";password="+$cred.GetNetworkCredential().Password+";Initial Catalog=" + $databasename;
$sqlConn.Open();

# Setup the sqlcommand
$sqlCommand = New-Object System.Data.SqlClient.SqlCommand;
$sqlCommand.Connection = $sqlConn;
$sqlCommand.CommandText = $sqlcmd
 
# Get the results
$sqlAdapter = New-object System.Data.SqlClient.SqlDataAdapter 
$sqlAdapter.SelectCommand = $sqlCommand
$dataSet = new-object System.Data.Dataset
$recordCount = $sqlAdapter.Fill($dataSet) 

$data = $dataSet.Tables[0]

foreach ($row in $data)
{
    
    $fullFileName = $targetfolder + $targetprefix + $row.$col_id + $targetsuffix + ".xml"
    $newFile = New-Item $fullFileName -ItemType File -Value $row.$col_xml 
}

#Tidy Up
$sqlConn.Close()

