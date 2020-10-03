#===============================================================================
# Make your PowerShell env feel like home, when you're on an unfamiliar machine
# Invoke-WebRequest https://raw.githubusercontent.com/tompdavies/utils/main/shell/powershell-temp-config.ps1 | Select-Object -Expand Content | powershell -NoLogo -Command -
# curl b.link/powershellconfig | Select-Object -Expand Content | powershell -NoLogo -Command -
#===============================================================================

$tempsrcfile="$env:TEMP\tempsrcfile.ps1"

echo "# Temp file for bash configuration" > $tempsrcfile
echo "# Can be deleted at any time" >> $tempsrcfile

echo 'function prompt {' >> $tempsrcfile
echo '  $myid = "$env:computername\$env:username"' >> $tempsrcfile
echo '  $basepwd = (split-path ($pwd) -leaf)' >> $tempsrcfile
echo '' >> $tempsrcfile
echo '  if ( $host.name -eq "ConsoleHost" -or $host.name -eq "Windows PowerShell ISE Host" ) {' >> $tempsrcfile
echo '    $host.ui.rawui.windowtitle = "$myid $pwd"' >> $tempsrcfile
echo '    write-host "$myid " -nonewline -foregroundcolor green' >> $tempsrcfile
echo '    write-host "$basepwd >" -nonewline -foregroundcolor cyan' >> $tempsrcfile
echo '    return " "' >> $tempsrcfile
echo '  } else {' >> $tempsrcfile
echo '    "$myid $basepwd > "' >> $tempsrcfile
echo '  }' >> $tempsrcfile
echo '}' >> $tempsrcfile

echo "set-psreadlineoption -bellstyle none" >> $tempsrcfile

echo "set-alias -name grep -value findstr" >> $tempsrcfile
echo "set-alias -name ll -value get-childitem" >> $tempsrcfile
echo "set-alias -name sha256sum -value get-filehash" >> $tempsrcfile

echo "function uptime {(Get-Date) - (Get-CimInstance Win32_operatingSystem).lastbootuptime}" >> $tempsrcfile

#cat $tempsrcfile

echo "Now run the following to set your prompt (and remove the temp file):"
echo ". ${tempsrcfile} ; rm ${tempsrcfile}"
